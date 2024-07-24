Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10D14375C
	for <dash@vger.kernel.org>; Wed, 24 Jul 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816444; cv=none; b=nL1CQoYQ9yfKXN+nq5SFomc0ngg6fRH3+/dfLUCzrFuHHVJemY6vEY60zIpwE/iLIZ4nmjnlNvqwutayeGtO1S988X1cNFRPwxYxC6NBNyY3bI95cSCNFFJbyDHlbU/TzeBuQvDtKFmdq6Y1sSRb4zIHl2vdifZSjRO2IQBPEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816444; c=relaxed/simple;
	bh=UobhApjRL0JHA4xeVyVzg80CDU1pDjYCBqnfnCZxOOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOmIYl8l03YsRHXkHWmSln3I2rDmPAif2wRE49OAwtWVO9EiIwcWZgndDxjPpEEocxKJHSvUgcgYC/EkjpDDBBovMhum596/clGfobkob6QiAiHie96Corld8aio67Amw9qOmcNFeNOLeCvE9ROBV0jxsgefWukUAehqGg/MVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sWYzi-000dOj-2I;
	Wed, 24 Jul 2024 18:20:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jul 2024 18:13:17 +0800
Date: Wed, 24 Jul 2024 18:13:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: herbertx/dash <reply+AAIFISJPS5QVB4UFBTTL5WWEVSI6PEVBNHHJBCZC6I@reply.github.com>
Cc: herbertx/dash <dash@noreply.github.com>,
	Assign <assign@noreply.github.com>,
	DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] eval: Reset input for pipelines
Message-ID: <ZqDTvavJpDXPeorl@gondor.apana.org.au>
References: <herbertx/dash/issues/8@github.com>
 <herbertx/dash/issues/8/2247128547@github.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <herbertx/dash/issues/8/2247128547@github.com>

On Wed, Jul 24, 2024 at 12:44:39AM -0700, arĉi wrote:
>
> I'm on Arch Linux.
> <details><summary>strace</summary>

Oops, this has nothing to do with the other bug report.  Indeed
I could reproduce this.  The issue is a missing reset_input call
for pipelines.

Thanks,

---8<---
For everything but the first component of a pipeline, the input
needs to be reset because it is no longer equal to that of the
parent shell.

Reported-by: arĉi <arcxi@dismail.de>
Fixes: b1864ee9f241 ("input: Use lseek on stdin when possible")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 src/eval.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/eval.c b/src/eval.c
index ad2aa03..0f2a7ba 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -595,6 +595,7 @@ evalpipe(union node *n, int flags)
 				close(pip[0]);
 			}
 			if (prevfd > 0) {
+				reset_input();
 				dup2(prevfd, 0);
 				close(prevfd);
 			}
-- 
2.39.2

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
