Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57AACA64
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869428; cv=none; b=q7rfpIESMjGkneKF0f9FkfXw6s2P9NBwAx/JFJH9b0eGSJ9Jc0DcoMVFLIuemgypAOdy58I+BrmWwMbmj0oh1IwVIwERjMADesVj4mEY5V+I2ai68ZDL92+idvsWsisLVFcUR+GtfgvtGaP+IaeOTiLvT+1rS09KPIoo4k0toeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869428; c=relaxed/simple;
	bh=A/LriwlM7jQUgbiiPvsF22DSTEfCCFAKNkPGJhor4Sc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IsTiMcP4eaKgTIY4T9PCRIEsgqiBJYV+cRECNgtIjcDJQLWlWncWhyuYSZFpcRsmAPc8c7k4lS85Q5SNjTYNyLuMwcwGQ+dxwRuf4Hzrf20+bui2n6GAOk3UK0e05q2d78sefS/mjQhVkd1zP+CbI3jl1Zg1d+KjbKFDLayUHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHIoGBc235644
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 19:50:17 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHIoDr1443095
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 19:50:15 +0100
Message-ID: <acdd690e-77fb-4a90-9471-4f165d5a0ad6@knaff.lu>
Date: Sun, 17 Nov 2024 19:50:13 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 14-broken-wait-h (amended)
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

UnixPC ships with a wait.h for the wrong endianness.

This patch provides a local replacement (triggered by absence
WEXITSTATUS flag)

After having applied the patches until and including this one, it should
compile for UnixPC, but not yet work. The next couple of patches address
issues that only become apparent at runtime or optional features.

Edit: but there is an amendment *here*. The "bad" sys/wait.h problem is 
apparently more general than just AT&T Unix PC, and autoconf has a 
specific test for this condition (and simply ignores sys/wait.h if it is 
bad). This new version of the patch follows the approach given in 
https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Particular-Headers.html

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+13-wait3-replacement/configure.ac dash-0.5.12+14-broken-wait-h/configure.ac
--- dash-0.5.12+13-wait3-replacement/configure.ac	2024-11-10 20:26:19.105474215 +0000
+++ dash-0.5.12+14-broken-wait-h/configure.ac	2024-11-17 18:36:24.270333145 +0000
@@ -46,6 +46,7 @@
 dnl Checks for header files.
 AC_CHECK_HEADERS(alloca.h paths.h pwd.h stdbool.h dirent.h \
 		getopt.h sys/resource.h termios.h sys/time.h)
+AC_HEADER_SYS_WAIT
 
 dnl Check for declarations
 AC_CHECK_DECL([_PATH_BSHELL],,AC_DEFINE_UNQUOTED([_PATH_BSHELL], "/bin/sh", [Define to system shell path]),[
diff -X ../exclude.txt -urN dash-0.5.12+13-wait3-replacement/src/jobs.c dash-0.5.12+14-broken-wait-h/src/jobs.c
--- dash-0.5.12+13-wait3-replacement/src/jobs.c	2024-11-10 21:51:55.911519696 +0000
+++ dash-0.5.12+14-broken-wait-h/src/jobs.c	2024-11-17 18:36:24.270333145 +0000
@@ -43,8 +43,12 @@
 #endif
 #include <sys/types.h>
 #include <sys/param.h>
+
+#ifdef HAVE_SYS_WAIT_H
+# include <sys/wait.h>
+#endif
+
 #ifdef BSD
-#include <sys/wait.h>
 #ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
 #endif
diff -X ../exclude.txt -urN dash-0.5.12+13-wait3-replacement/src/system.h dash-0.5.12+14-broken-wait-h/src/system.h
--- dash-0.5.12+13-wait3-replacement/src/system.h	2024-11-10 14:53:08.418618090 +0000
+++ dash-0.5.12+14-broken-wait-h/src/system.h	2024-11-17 18:36:24.274333237 +0000
@@ -220,3 +220,14 @@
 #ifndef HAVE_LSTAT
 #define lstat stat
 #endif
+
+/* As recommended by https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Particular-Headers.html */
+#ifndef WEXITSTATUS
+# define WEXITSTATUS(stat_val) ((unsigned int) (stat_val) >> 8)
+#endif
+#ifndef WIFEXITED
+# define WIFEXITED(stat_val) (((stat_val) & 255) == 0)
+#endif
+#ifndef WTERMSIG
+#define	WTERMSIG(stat_val) ((stat_val) & 127)
+#endif
