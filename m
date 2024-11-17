Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3619BA6
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869706; cv=none; b=MufzmbjIZh1oAg50+kuAjYvGPtryuTb1cqPlujRDeqjNwm18ZvOl4PciG8OQQmjA46/usLFUBD1MeezM5NI6Y845cKRjmf3yJYhkO/B+0DYe2lJ4VXyM/wjW7QgDKAAZWjX4y6geRyWsmdxBIB7befmjMQJitEFzuz/etyrz+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869706; c=relaxed/simple;
	bh=GqZerflcLylV4UxZpdgtpr8orNI0OIs/jQWqjVkxhbI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NRLP5O39zkoGZTtnal+HBxiifXZ5K8Gmk3NMHQjPSf84nINXsdkYBk3PcCN2mgNM0GWNlS2pv/QAlwMpIyp9s3ZrTBITEwl3LEb1b833fqS1Gs0+jZFicBllN7YtuCgW/UDGdu2uQFZK+VySLgny/5nxdFuqdZfKEP46544oz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHIssfM235850
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 19:54:55 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHIsqZx443257
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 19:54:54 +0100
Message-ID: <2312702e-faff-45f2-a29b-35578d853502@knaff.lu>
Date: Sun, 17 Nov 2024 19:54:52 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 18-glibc-stdio
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Language: en-US
Autocrypt: addr=alain@knaff.lu; keydata=
 xsDiBEk9qFcRBADO4trPtib39qvAEBlkAIcBGnZ137EmmNLU1pFZC5acLyJ4wYhVdcol97lC
 4ZkD0DJek6DVidQfz4hA7JbZy2W8l6O/o2k/Ja2bWkb8qtrcUNVDJzdJjNqXmmxdsyLd5QVt
 uCHgi3Zz0kq9aJnRCVuAyfrjMdaUsOThi07u1EyEywCgjxVKODAifumqfdjVxS5NoV7x7TkD
 /0k2F3/5/NYchgLz6Qu3As5MVtPs7NkJ0Mpal4Gy8CaKefHcynY+zCziM/oBw0+PIFxyFud0
 uT9HRIdEp1DlaTTUYlt95HeDYmCUh0Wt1PwNNRWcm+vTUuK7tOxzYadUqbzO+F6C+WN8msxA
 hcxzUgsL/YyXVilvL8XqB+RlS5bBA/9OxXc2mJs01nWu5khvVFNwUCDS8FRYyoHeodVZFGLC
 UG1PrV9nHva5vYJk1QlZP3qEotnK+6l4708X9yhdw2+UCtxvseTQ6JWBtIdJyo+Qv7apSQA3
 kkau6Om7SOyW1i/2LcCZU84SC923uBH7VNeUzCnzelVFubk6eRwzjNvrj80cQUxBSU4gS05B
 RkYgPGFsYWluQGtuYWZmLmx1PsJgBBMRAgAgBQJJPahXAhsDBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQyAYxsm9DGWFEsgCeOSavzyOp8Bj3nOP8hC6XeCX/3k4Anj0KegsyeIVxuj5X
 TUnh535vXfZvzsFNBEk9qFoQCACt2vctXYAr+ndRbaeR4ygJ8rKH8ARu68nDuQuxOKCasaQr
 xm8+/RxvmTfriP00tYZAca2tmCjwntKVsK4eNSivvo6c7BwziCnQx/vW+kJK4ctckMHSZPqe
 4a1HWYURg5oxaqGo4f06YAn9O0yDo6xdGGNUMpYHv2O1/jsAEgAM/c/US+gNctzsNKQ4lVwp
 HH4NEabev+zlisnTO3V39iXijZbe9AYlD4qZH/0nFBDCCt9EDTe+/6IFfvIrnVx7o367U9XL
 SCLVQt4k7xqCIow7RP5BlOYLDV50yMva8c62yhWpDYKSyJsQGn/nGiiv6P4Ye/monfkQD+PC
 nKPXDYCjAAMFB/9D2FSYHyikvOoXXMTfjGHUyIQK6FCtKINTFfBPuwlWOWCukrQrzH0BmTVC
 /WuMOrrmxl0IFHGtOV2Zp+bdsjhlzgZ4kXAmqw1Qiphb/YLD6VY5TQ59Tkl7+nCQ0wjcRim1
 Sg6OzmoNttHpTt9eAvLZMz7yi9Nq40yKXh+zXZtzHIgdsXG+tO9+LEWojdbXgIdZin2yUKYt
 KxbpwyM0qCN9oGtKTAi0GX+tuHdAqWwYEgVnd27LcBGLTs6QJPsjQKHiAtYJwu6MWiF7bvCr
 iBNyVG3yU3inZcQvIdYxO0VUN3wVSEIbRHcNzG2u1UD6ZuF+3bv39dh54m1CQzbzzRepwkkE
 GBECAAkFAkk9qFoCGwwACgkQyAYxsm9DGWHNLwCfWr4DLrBZMktv9RTGbcIZ+/NgTswAn3aG
 LBuTFPDEO0bfA+7PlpCctCJT
In-Reply-To: <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

This fixed USE_GLIBC_STDIO mode.

This also concludes this patch series for UnixPC support.

Thanks for reading.

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+17-signed-size-t/src/eval.c dash-0.5.12+18-glibc-stdio/src/eval.c
--- dash-0.5.12+17-signed-size-t/src/eval.c	2024-10-20 08:37:55.802683032 +0000
+++ dash-0.5.12+18-glibc-stdio/src/eval.c	2024-09-01 07:04:06.960988580 +0000
@@ -833,7 +833,11 @@
 	if (iflag && funcline == 0 && argc > 0)
 		lastarg = nargv[-1];
 
+#ifdef USE_GLIBC_STDIO
+	preverrout.stream = stderr;
+#else
 	preverrout.fd = 2;
+#endif
 	expredir(cmd->ncmd.redirect);
 	redir_stop = pushredir(cmd->ncmd.redirect);
 	status = redirectsafe(cmd->ncmd.redirect, REDIR_PUSH|REDIR_SAVEFD2);
diff -X ../exclude.txt -urN dash-0.5.12+17-signed-size-t/src/output.c dash-0.5.12+18-glibc-stdio/src/output.c
--- dash-0.5.12+17-signed-size-t/src/output.c	2024-10-20 08:37:55.814683315 +0000
+++ dash-0.5.12+18-glibc-stdio/src/output.c	2024-09-01 07:04:06.960988580 +0000
@@ -77,7 +77,7 @@
 };
 struct output errout = {
 	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 2, .flags = 0
-}
+};
 #ifdef notyet
 struct output memout = {
 	.stream = 0, .nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = MEM_OUT, .flags = 0
@@ -90,13 +90,13 @@
 struct output errout = {
 	.nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = 2, .flags = 0
 };
-struct output preverrout;
 #ifdef notyet
 struct output memout = {
 	.nextc = 0, .end = 0, .buf = 0, .bufsize = 0, .fd = MEM_OUT, .flags = 0
 };
 #endif
 #endif
+struct output preverrout;
 struct output *out1 = &output;
 struct output *out2 = &errout;
 
@@ -215,7 +215,6 @@
 }
 
 
-#ifndef USE_GLIBC_STDIO
 
 
 void
@@ -224,7 +223,6 @@
 	char buf = c;
 	outmem(&buf, 1, dest);
 }
-#endif
 
 
 void
@@ -378,7 +376,6 @@
 }
 
 
-#ifdef notyet
 #ifdef USE_GLIBC_STDIO
 void initstreams() {
 	output.stream = stdout;
@@ -386,6 +383,7 @@
 }
 
 
+#ifdef notyet
 void
 openmemout(void) {
 	INTOFF;
diff -X ../exclude.txt -urN dash-0.5.12+17-signed-size-t/src/output.h dash-0.5.12+18-glibc-stdio/src/output.h
--- dash-0.5.12+17-signed-size-t/src/output.h	2024-10-19 22:16:41.624247695 +0000
+++ dash-0.5.12+18-glibc-stdio/src/output.h	2024-11-10 21:55:48.781059156 +0000
@@ -65,9 +65,7 @@
 
 void outmem(const char *, size_t, struct output *);
 void outstr(const char *, struct output *);
-#ifndef USE_GLIBC_STDIO
 void outcslow(int, struct output *);
-#endif
 void flushall(void);
 void flushout(struct output *);
 void outfmt(struct output *, const char *, ...)
@@ -81,13 +79,11 @@
 void doformat(struct output *, const char *, va_list);
 #endif
 int xwrite(int, const void *, size_t);
-#ifdef notyet
 #ifdef USE_GLIBC_STDIO
 void initstreams(void);
 void openmemout(void);
 int __closememout(void);
 #endif
-#endif
 
 static inline void
 freestdout()
diff -X ../exclude.txt -urN dash-0.5.12+17-signed-size-t/src/redir.c dash-0.5.12+18-glibc-stdio/src/redir.c
--- dash-0.5.12+17-signed-size-t/src/redir.c	2024-10-21 10:44:12.732533133 +0000
+++ dash-0.5.12+18-glibc-stdio/src/redir.c	2024-10-20 22:07:35.390055840 +0000
@@ -180,7 +180,11 @@
 		out2 = &memout;
 #endif
 	if (flags & REDIR_SAVEFD2 && sv->renamed[2] >= 0)
+#ifdef USE_GLIBC_STDIO
+		preverrout.stream = fdopen(sv->renamed[2],"a");
+#else
 		preverrout.fd = sv->renamed[2];
+#endif
 }
