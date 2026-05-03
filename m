Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065481D7E41
	for <dash@vger.kernel.org>; Sun,  3 May 2026 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777781964; cv=none; b=ZywK19mblyNyKrV5f/sKKuPwuaDr+OxJW9l2iXRnBYvl/BXpYzYYjHLmL8Mg4dnPdRSkj06N1bO6LD8c1r9Fp+mOOZLZdVHx8hVLrObnWGw0ngILcH6b1CVOE/L0jw7THBayrJM5/gRh/0brgWRjLFaOwdi5Gl8jo6fMZV+i3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777781964; c=relaxed/simple;
	bh=BPx9YokJH+48LMwZ5aH/oCl1EabWhCpFt+1xQcKtAlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dp8ZlXHGofmch0V42DJQbHfKnpb3GMShyZzL71n5xwccBqnke+ns6l5lCxGt7Fd17AiHgsFMmrEAS42njPNTXzks9+SC3viDXJ7933ewvInbJ26guu3QvUDYJK2PUHfJYuvWYw1FaeczbnkAE+x1HRe/ea5ZEAnqTrqS3d0j/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=BJbPsJnZ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="BJbPsJnZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=PAggk7vlqR7DQNIVQ/+D5mmBVAhmeS5I18tG9l7XjLA=; b=BJbPsJnZIkMsCOxCf85eKUQbk1
	44JBlS32k3q9+cuWeidDKjWj1ULFAb3DZDPyVtw/eGzSc+h3gV1CGPU+7kwgqS/T+TzXVtnOF4aOw
	VIqX5qE+IqEGLxfI3TftRXFYP7QEI3miFTNKPESPHGGypiI7lkAlIoh/jr2fleGEf16YWtUJ1181z
	1oPFWeX/Ape5avZx8YhBfhRfsHyDx5g7Rx5JuFUAn2pw2pLJoBYaAiBQn2ygLycEnRx7ba+qqheIQ
	1tqdL7fSp0mKWbV9rff9mU/xP0Ibq1zc6wTf9fzIyJh+NNLoDeuAdW4YY1fmfc583uF3Ux+fRFblV
	+nLBlY3w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wJOIW-00AmVU-1c;
	Sun, 03 May 2026 12:19:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 May 2026 12:19:16 +0800
Date: Sun, 3 May 2026 12:19:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Matt Whitlock <kernel@mattwhitlock.name>
Cc: dash@vger.kernel.org
Subject: [PATCH] input: Fix tee(2) error handling
Message-ID: <afbMxGe7k033TvqA@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377dcdcd-68dd-48b0-a23e-5ede49e4af02@mattwhitlock.name>
X-Newsgroups: apana.lists.os.linux.dash

Matt Whitlock <kernel@mattwhitlock.name> wrote:
> Dash 0.5.13.3:
> 
> $ /bin/dash -c '{ echo 1; sleep 1; echo 2; } | while read -r line; do echo "${line}" & done'
> 1
> ^C

Thanks, this is a regression in the tee error handling code:

---8<---
The variable fd should only switch to the tee pipe if the tee(2)
call succeeded, otherwise the retry will read the wrong file
descriptor.

Also remove the stdin_istty check in stdin_tee as the fallback
path now requries setting errno to EINVAL.  Instead of optimising
for the rare case of a non-canonical input tty, just let the
tee(2) call fail instead.

Finally switch from pipe to sh_pipe.  The pipe(2) call should never
fail, and if it does, just abort the shell.

Fixes: 41457be81fa7 ("input: Fix EINTR handling when reading from a pipe")
Reported-by: Matt Whitlock <kernel@mattwhitlock.name>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 4e30010..591f28a 100644
--- a/src/input.c
+++ b/src/input.c
@@ -166,13 +166,8 @@ static int stdin_tee(void *buf, int nr)
 {
 	int err;
 
-	if (stdin_istty)
-		return 0;
-
 	if (!stdin_state.pip[0]) {
-		err = pipe(stdin_state.pip);
-		if (err < 0)
-			return err;
+		sh_pipe(stdin_state.pip, 0);
 		if (stdin_state.pip[0] < 10)
 			stdin_state.pip[0] = savefd(stdin_state.pip[0],
 						    stdin_state.pip[0]);
@@ -276,6 +271,7 @@ preadfd(void)
 {
 	char *buf = parsefile->buf;
 	int fd = parsefile->fd;
+	bool use_tee;
 	int unget;
 	int pnr;
 	int nr;
@@ -295,6 +291,12 @@ preadfd(void)
 	if (!IS_DEFINED_SMALL && !nr)
 		return nr;
 
+	use_tee = likely(!fd) &&
+#ifndef SMALL
+		  !el &&
+#endif
+		  !stdin_bufferable();
+
 	pnr = nr;
 retry:
 	nr = pnr;
@@ -326,12 +328,13 @@ retry:
 	}
 #endif
 
-	if (!fd && !stdin_bufferable()) {
+	if (likely(use_tee)) {
 		nr = stdin_tee(buf, nr);
-		fd = stdin_state.pip[0];
-		if (nr < 0 && errno == EINVAL) {
-			fd = 0;
-			nr = 1;
+		if (nr >= 0)
+			fd = stdin_state.pip[0];
+		else if (errno == EINVAL) {
+			use_tee = false;
+			nr = pnr = 1;
 		}
 	}
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
