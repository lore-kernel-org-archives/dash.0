Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37333A1CD
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731864239; cv=none; b=FJqQNbDMraoLnCAkPR8nRJ7vTKVS5uXWhWV7ybFPwAdMn1rTSFvjxpYGiAuWsQI4DHgWpc2FR6fSxI4UmSfMub7z7ZJm+e3i3sxHkDk1WOfrGHu9l10gqmVGL1cZlTQrnuIGxPdNAoA4OjObx6DkYKVNR/qYsqqg3o/3tSquEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731864239; c=relaxed/simple;
	bh=ninp6gU6rSX1KKxHl+G0iqSr7O1cGT28G4ji20ejxe4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WIEa3M7k4s4n/Rmjl5FX5xP3z37Dan/OFsWWLTkFInhk3QSLzJMYnZQkVF+1LqJe2sdmgZFEMVhj0ERXeimR4G4+XyQcphtLpMO6ArzP60pd75a6XV5xAsD2Dskk7ew+49EmtxWP50kuDWV0lmdGdnlQDqIju5Vi388ggLW4kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHHNmWa231248
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 18:23:49 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHHNkoC438672
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 18:23:47 +0100
Message-ID: <8f418d92-faa7-467f-bcc2-441f188b0ee4@knaff.lu>
Date: Sun, 17 Nov 2024 18:23:46 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 10-ctype
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

The 10th patch fixes the handling of the "functions" supplied by
ctype.h

On many older platforms, those are not real functions but preprocessor
macros, so it is not possible to take a function pointer of them.

Dash's current approach of wrapping them into real functions would
work if prototypes for these functions were available somewhere.

I took a different approach, which is to replace the table of names
and function pointers with a cascade of ifs, makes for shorter code as
well.

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+09-type-sizes/src/expand.c dash-0.5.12+10-ctype/src/expand.c
--- dash-0.5.12+09-type-sizes/src/expand.c	2024-10-20 21:19:22.613459913 +0000
+++ dash-0.5.12+10-ctype/src/expand.c	2024-11-09 23:08:05.018189584 +0000
@@ -1568,37 +1568,18 @@
 #ifndef HAVE_FNMATCH
 STATIC int ccmatch(const char *p, int chr, const char **r)
 {
-	static const struct class {
-		char name[10];
-		int (*fn)(int);
-	} classes[] = {
-		{ .name = ":alnum:]", .fn = isalnum },
-		{ .name = ":cntrl:]", .fn = iscntrl },
-		{ .name = ":lower:]", .fn = islower },
-		{ .name = ":space:]", .fn = isspace },
-		{ .name = ":alpha:]", .fn = isalpha },
-		{ .name = ":digit:]", .fn = isdigit },
-		{ .name = ":print:]", .fn = isprint },
-		{ .name = ":upper:]", .fn = isupper },
-		{ .name = ":blank:]", .fn = isblank },
-		{ .name = ":graph:]", .fn = isgraph },
-		{ .name = ":punct:]", .fn = ispunct },
-		{ .name = ":xdigit:]", .fn = isxdigit },
-	};
-	const struct class *class, *end;
-
-	end = classes + sizeof(classes) / sizeof(classes[0]);
-	for (class = classes; class < end; class++) {
-		const char *q;
-
-		q = prefix(p, class->name);
-		if (!q)
-			continue;
-		*r = q;
-		return class->fn(chr);
-	}
-
-	*r = 0;
+	if(( *r=prefix(p, ":alnum:]") )) return isalnum(chr); else
+	if(( *r=prefix(p, ":cntrl:]") )) return iscntrl(chr); else
+	if(( *r=prefix(p, ":lower:]") )) return islower(chr); else
+	if(( *r=prefix(p, ":space:]") )) return isspace(chr); else
+	if(( *r=prefix(p, ":alpha:]") )) return isalpha(chr); else
+	if(( *r=prefix(p, ":digit:]") )) return isdigit(chr); else
+	if(( *r=prefix(p, ":print:]") )) return isprint(chr); else
+	if(( *r=prefix(p, ":upper:]") )) return isupper(chr); else
+	if(( *r=prefix(p, ":blank:]") )) return isblank(chr); else
+	if(( *r=prefix(p, ":graph:]") )) return isgraph(chr); else
+	if(( *r=prefix(p, ":punct:]") )) return ispunct(chr); else
+	if(( *r=prefix(p, ":xdigit:]") )) return isxdigit(chr); else
 	return 0;
 }
 
diff -X ../exclude.txt -urN dash-0.5.12+09-type-sizes/src/system.c dash-0.5.12+10-ctype/src/system.c
--- dash-0.5.12+09-type-sizes/src/system.c	2024-11-10 16:54:50.548225768 +0000
+++ dash-0.5.12+10-ctype/src/system.c	2024-11-10 16:56:47.395004664 +0000
@@ -27,31 +27,7 @@
  */
 
 #ifndef HAVE_ISALPHA
-#define isalnum _isalnum
-#define iscntrl _iscntrl
-#define islower _islower
-#define isspace _isspace
-#define isalpha _isalpha
-#define isdigit _isdigit
-#define isprint _isprint
-#define isupper _isupper
-#define isblank _isblank
-#define isgraph _isgraph
-#define ispunct _ispunct
-#define isxdigit _isxdigit
 #include <ctype.h>
-#undef isalnum
-#undef iscntrl
-#undef islower
-#undef isspace
-#undef isalpha
-#undef isdigit
-#undef isprint
-#undef isupper
-#undef isblank
-#undef isgraph
-#undef ispunct
-#undef isxdigit
 #endif
 
 #include <signal.h>
@@ -157,69 +133,6 @@
 }
 #endif
 
-#ifndef HAVE_ISALPHA
-int isalnum(int c) {
-	return _isalnum(c);
-}
-
-
-int iscntrl(int c) {
-	return _iscntrl(c);
-}
-
-
-int islower(int c) {
-	return _islower(c);
-}
-
-
-int isspace(int c) {
-	return _isspace(c);
-}
-
-
-int isalpha(int c) {
-	return _isalpha(c);
-}
-
-
-int isdigit(int c) {
-	return _isdigit(c);
-}
-
-
-int isprint(int c) {
-	return _isprint(c);
-}
-
-
-int isupper(int c) {
-	return _isupper(c);
-}
-
-
-#if HAVE_DECL_ISBLANK
-int isblank(int c) {
-	return _isblank(c);
-}
-#endif
-
-
-int isgraph(int c) {
-	return _isgraph(c);
-}
-
-
-int ispunct(int c) {
-	return _ispunct(c);
-}
-
-
-int isxdigit(int c) {
-	return _isxdigit(c);
-}
-#endif
-
 #if !HAVE_DECL_ISBLANK
 int isblank(int c) {
 	return c == ' ' || c == '\t';
