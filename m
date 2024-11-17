Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746F634
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731835916; cv=none; b=liOVk5B7QUglZsgQyIkFkIgEEu0sck9Exk5azzT2PMsCMiIrFZwZf2sX5oLNzoUfogS79MC11wSMtxFCHizIU95koNe2gnxk1wRPYtBMyPDPn4rpB7xHhNCb0AeF9s9RZ3GtIE+8zmsLlIEzCXk0rAWAEuOQcjm1HdyV9O0I4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731835916; c=relaxed/simple;
	bh=czhAV2EoS4f37Be46GjN/JXe8/AVsYD+3BwaRYnPjyA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=J+FKf9h5tHv4TKhjuL0iC3fxGlofIEElp73c6eICmHk0Ao9BGxz91LHih5bzomq0zhQzx6AjkdO/Ptb4D+WG00LxaPWS51xuBzX/ld95Z/wSs7yfAokOEYnLUjZbnPidkyHhYaM6Bhz06z1wgc+lo9sr5qrHyJIEdG5ZQ5y6KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AH9VjtG206883
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 10:31:46 +0100
X-Envelope-To: <dash@vger.kernel.org>
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AH9Vhw3413763
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 10:31:45 +0100
Message-ID: <936c6eb0-4044-4478-b052-ed1ca47af0b7@knaff.lu>
Date: Sun, 17 Nov 2024 10:31:43 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: P*rtability of dash to legacy systems, such as AT&T Unix PC :
 02-stat64
To: dash@vger.kernel.org
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

The second element of the patch set fixes the stat64 redefinition so
that it can compile on Solaris.

Indeed, rather than supplying stat64 etc. as a normal library
function, Solaris uses a #define, which means that AC_CHECK_FUNCTION
won't detect it, resulting in a compilation where struct stat and
struct stat64 conflict with each other.

This patch replaces the AC_CHECK_FUNCTION calls with AC_CHECK_DECL,
and adds includes where needed.

Checking for declarations rather than functions would miss a
hypothetical situation where a library function stat64 would exists
which lacks a prototype declaration. However, this is very unlikely to
happen in practice, because general availability of prototypes of
system function predates availability of 64 bit file offset by years.

This patch is not strictly needed for UnixPC compatibility, and may be
skipped if it causes problems elsewhere.

All this being said, while studying what happens on Solaris, I
wondered about three alternative solutions:
 1. the problem happens because the #define statements for stat64
    happen in config.h *before* inclusion of system includes such as
    sys/stat.h
    If the #define happened *after* inclusion of system includes, the
    problem would result in a mere warning when it happens. So why not
    move those defines to system.h?

 2. similarly, rather than defining stat64, why not make up a new name,
    such as statw, and #define statw to be stat or stat64 depending on
    what is available?

 3. and finally, is the whole shebang actually needed if we use
    AC_SYS_LARGEFILE? This autoconf directive adds an appropriate
    #define before inclusion of system files to instruct them to make
    the relevant system calls "64-bit clean". That way we wouldn't need
    to mess around with redefining stat64 our-self.

Regards,

Alain


diff -X ../exclude.txt -urN dash-0.5.12+01-remove-extraneous/configure.ac dash-0.5.12+02-stat64/configure.ac
--- dash-0.5.12+01-remove-extraneous/configure.ac	2024-11-10 10:14:41.608305106 +0000
+++ dash-0.5.12+02-stat64/configure.ac	2024-11-10 16:04:42.792587032 +0000
@@ -140,28 +140,29 @@
 fi
 
 dnl Check for stat64 (dietlibc/klibc).
-AC_CHECK_DECL(stat64, AC_CHECK_FUNC(stat64))
-if test "$ac_cv_func_stat64" != yes; then
+AC_CHECK_DECL(stat64,, [
 	AC_DEFINE(fstat64, fstat, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(lstat64, lstat, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(stat64, stat, [64-bit operations are the same as 32-bit])
-fi
+])
 
-AC_CHECK_FUNC(glob64,, [
+AC_CHECK_DECL(glob64,, [
 	AC_DEFINE(glob64_t, glob_t, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(glob64, glob, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(globfree64, globfree,
 		  [64-bit operations are the same as 32-bit])
-])
+],[#ifdef HAVE_GLOB
+#include <glob.h>
+#endif])
 
 dnl OS X apparently has stat64 but not open64.
-AC_CHECK_FUNC(open64,, [
+AC_CHECK_DECL(open64,, [
 	AC_DEFINE(open64, open, [64-bit operations are the same as 32-bit])
 	AC_DEFINE(readdir64, readdir,
 		  [64-bit operations are the same as 32-bit])
 	AC_DEFINE(dirent64, dirent,
 		  [64-bit operations are the same as 32-bit])
-])
+],[#include <fcntl.h>])
 
 dnl Check if struct stat has st_mtim.
 AC_MSG_CHECKING(for stat::st_mtim)
