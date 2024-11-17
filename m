Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754A23AD
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731864142; cv=none; b=uxbO68G2ejmZKULq+R541Ukb5t5ZdZDgOXlh07j+7B57yhL+K4wmQIvoA+x9himEbXb6cxkfy72cLFGHJl/aW3ePx6iKdsK96Q0WJFkVE1GeVZeT9C58rdS1+Qy2RTW8SWOr1BYxkdf+XIllSEJNDjT3pyKoc1tmtxrfpfg9T3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731864142; c=relaxed/simple;
	bh=ZDG8sSR7+CuxEWmXYo5u+tAwDjH1Gs9nKK2ERov7LMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FQiNGQPx51le1Je3++SsYW4FJ0M7DHiXhoy3ITyHnGCiwYaV3O2CSgsKXVZc+TGjJ5fhwdhxYAhk9EK79MhzlozfpgUM3D1M1ftQrVjzOl7WtD5V6XV0hz4zhLo9CEuL7JjSt2RorJF9ZVWPvr34596RXawfyXxi51Qd+le4STc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHHLxOA231143
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 18:22:00 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHHLwra438611
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 18:21:59 +0100
Message-ID: <3b5cd0a2-a3da-4013-ad20-f77dbeaa6b72@knaff.lu>
Date: Sun, 17 Nov 2024 18:21:57 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 09-type-sizes
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

The 9th patch supplies auto-detection of size of various integer and
other types

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+08-vsnprintf/configure.ac dash-0.5.12+09-type-sizes/configure.ac
--- dash-0.5.12+08-vsnprintf/configure.ac	2024-11-10 17:29:04.521055631 +0000
+++ dash-0.5.12+09-type-sizes/configure.ac	2024-11-10 17:06:37.153028629 +0000
@@ -68,17 +68,30 @@
 AC_CHECK_DECLS([isblank],,,[#include <ctype.h>])
 
 AC_DECL_SYS_SIGLIST
+AC_TYPE_PID_T
+AC_TYPE_UID_T
+AC_TYPE_SSIZE_T
+AC_TYPE_UINT32_T
+
+AC_CHECK_TYPE([intmax_t],,AC_DEFINE_UNQUOTED([intmax_t],long,[Define intmax_t type, must also be supported by printf]))
+
+AC_CHECK_TYPE([uintmax_t],,AC_DEFINE_UNQUOTED([uintmax_t],unsigned long,[Define uintmax_t type, must also be supported by printf]))
 
 dnl Check for sizes of types
+AC_SYS_LARGEFILE
 AC_CHECK_SIZEOF([intmax_t])
 AC_CHECK_SIZEOF([long long int])
+AC_CHECK_SIZEOF([long int])
 
 dnl Select a fallback format string for intmax_t in case we don't find PRIdMAX
 if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_long_int"; then
   intmax_fstr="lld"
+else if test "x$ac_cv_sizeof_intmax_t" = "x$ac_cv_sizeof_long_int"; then
+  intmax_fstr="ld"
 else
   intmax_fstr="jd"
 fi
+fi
 
 dnl Check for PRIdMAX and define it to a fallback if not found
 AC_CHECK_DECL([PRIdMAX],,
