Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE852D248E
	for <dash@vger.kernel.org>; Fri, 31 Oct 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889174; cv=none; b=VwwmGmshwQu9Ys/F8tSLGmTcUNpmsIkRFHZFZ4W4LVbz0T+v4lRqtYzQtyYABZ2cBGqqoxSvm6iAB4/V4nOcwMRw4hSBsIqqWeDXXnGHkShSwUQh4FPe//ydtfMzBnRZanW3pan+TwPAeR6zx7/dZALzw5Eyw6eLx7QAtZZiduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889174; c=relaxed/simple;
	bh=+d47pTW7KnHmfdvKVBet3fjgRf6tTml35BPHMDq989I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZmOcbr4j0dBdPafn9/EHIacd9MNVeArox2Upfu15Kb9oQnX2/+WmBDWJn7v6PWjJFetZ0rDmceD4WMcrGrpUXTfjgSF2lA6GVvi4mq6C/RxObH7CHm/YOVOLDCHL2BvkKJK+Sws2bUlFSLafz0TrJc3XageNfDWPaDNU7Mz+EPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=MQOgyp5o; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="MQOgyp5o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=K4e0DiNmUHYyASLBeVV7VE/B0NI6ocuTsE7scn1YBCw=; b=MQOgyp5ouLLJ7ZPux3YhTn7ZSV
	wATwkIvQpHc9vBvEVvjKYJhuCiMvcpSLihKOKMtTmLjqh1OdlXNAQq1GE9FYj5N5sfA8lN00shAV5
	ewMMgrnI/Jn/EpQAbKxWpvLRrLo61K+z5oEgON7mn1KXGf2tMBrxziTyMDJcbAaIB9yJP4apc0LNa
	WlW7F/1n5SbQCkzCsZna0riCD5bnjjAZ+E0sWw0gcb7thtubsPukqmXGjfxogpelyvA4MdllvT8Aq
	cGlhqe/hZ/eqdgKG1U15gdEk5ogfNEQGx5P3b/GBm1bz03Q5p+r/KcOu+fuH/MxMDMCUH2vaEZXFs
	MGUd698g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vEhOi-00GySq-09;
	Fri, 31 Oct 2025 13:10:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Oct 2025 13:10:00 +0800
Date: Fri, 31 Oct 2025 13:10:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: j.daubert@posteo.de
Cc: dash@vger.kernel.org
Subject: [PATCH] options: Call input_init before using stdin_istty
Message-ID: <aQREqBcMzzW1_Blw@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118bb4c89dfd2b3e1f44cf2b4b831812@posteo.de>
X-Newsgroups: apana.lists.os.linux.dash

j.daubert@posteo.de wrote:
> With dash 0.5.13.1 together with your latest patch I got this:
> 
> $:~> echo date | /bin/sh
> $:\w> Do 30. Okt 12:21:36 CET 2025
> $:\w>
> /bin/sh: 1: Cannot set tty process group (No such process)
> $:~>
> 
> with dash 0.5.12 and bash this works:
> 
> $:~> echo date | /bin/bash
> Do 30. Okt 12:22:52 CET 2025
> $:~>

Oh yes, the input_init optimisation went a bit over the top:

---8<---
Call input_init before using stdin_istty as otherwise it will
always be true.

Reported-by: Juergen Daubert <j.daubert@posteo.de>
Fixes: 6abb589582c6 ("input: Call input_init on first use")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index c36d120..c7236d0 100644
--- a/src/input.c
+++ b/src/input.c
@@ -79,8 +79,6 @@ struct parsefile *parsefile = &basepf;	/* current input file */
 int whichprompt;		/* 1 == PS1, 2 == PS2 */
 int stdin_istty = -1;
 
-MKINIT void input_init(void);
-
 STATIC void pushfile(void);
 static void popstring(void);
 static int preadfd(void);
diff --git a/src/input.h b/src/input.h
index 706ac73..59dc5a1 100644
--- a/src/input.h
+++ b/src/input.h
@@ -119,6 +119,7 @@ void unwindfiles(struct parsefile *);
 void popallfiles(void);
 void flush_input(void);
 void reset_input(void);
+void input_init(void);
 
 static inline int input_get_lleft(struct parsefile *pf)
 {
diff --git a/src/options.c b/src/options.c
index c318e0f..c4eedeb 100644
--- a/src/options.c
+++ b/src/options.c
@@ -138,8 +138,11 @@ procargs(char **xargv)
 			sh_error("-c requires an argument");
 		sflag = 1;
 	}
-	if (iflag == 2 && sflag == 1 && stdin_istty && isatty(2))
-		iflag = 1;
+	if (iflag == 2 && sflag == 1) {
+		input_init();
+		if (stdin_istty && isatty(2))
+			iflag = 1;
+	}
 	if (mflag == 2)
 		mflag = iflag;
 	for (i = 0; i < NOPTS; i++)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
