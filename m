Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3E1FEFD9
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450846; cv=none; b=FeduE8cNYnFSin4VN2sufm5iMJ/gh3XQmeaaB0zavApcr4yhHtAMwfUasnchhtwo65Es+M/cVfHmsYWwJNq0tZf0C/x7XLBpzAsLnMzy6fdxIPmErU9PY3lF6OOVyKaYoPQM7/Whp7xLwwG91+yyQmmWmt7yyDP8Njl7CuvTdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450846; c=relaxed/simple;
	bh=FoXstaGsJ1a8kpPv5J9+NZeFfy4ZobsP1J3G74tWPaU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FFj9K0pfgssZyzMk8wcd72G8nBZTxHg6U/O9iDbwm3S9dHMOGLzR3/H3pyylT5P6eWQbjDThycJBJMNyMWHQid6ejpegw401b/nQraUJxf6v+me9MFe9BJPXgzyRDSTYvWAxe1M/fvPszpay3boOroYaH6pT8nLo1wJ/FNxqgDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMWna34066269
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:32:50 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMWm8i077128
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:32:49 +0100
Content-Type: multipart/mixed; boundary="------------SoYVfvAKc12GM6aHpUnUi836"
Message-ID: <327cf9fa-b1b0-4740-b4a5-5f7fdb34da23@knaff.lu>
Date: Tue, 12 Nov 2024 23:32:47 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 02-stat64
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Language: en-US
From: Alain Knaff <alain@knaff.lu>
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

This is a multi-part message in MIME format.
--------------SoYVfvAKc12GM6aHpUnUi836
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
--------------SoYVfvAKc12GM6aHpUnUi836
Content-Type: text/x-patch; charset=UTF-8; name="dash-0.5.12+02-stat64.diff"
Content-Disposition: attachment; filename="dash-0.5.12+02-stat64.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzAxLXJlbW92ZS1leHRy
YW5lb3VzL2NvbmZpZ3VyZS5hYyBkYXNoLTAuNS4xMiswMi1zdGF0NjQvY29uZmlndXJlLmFj
Ci0tLSBkYXNoLTAuNS4xMiswMS1yZW1vdmUtZXh0cmFuZW91cy9jb25maWd1cmUuYWMJMjAy
NC0xMS0xMCAxMDoxNDo0MS42MDgzMDUxMDYgKzAwMDAKKysrIGRhc2gtMC41LjEyKzAyLXN0
YXQ2NC9jb25maWd1cmUuYWMJMjAyNC0xMS0xMCAxNjowNDo0Mi43OTI1ODcwMzIgKzAwMDAK
QEAgLTE0MCwyOCArMTQwLDI5IEBACiBmaQogCiBkbmwgQ2hlY2sgZm9yIHN0YXQ2NCAoZGll
dGxpYmMva2xpYmMpLgotQUNfQ0hFQ0tfREVDTChzdGF0NjQsIEFDX0NIRUNLX0ZVTkMoc3Rh
dDY0KSkKLWlmIHRlc3QgIiRhY19jdl9mdW5jX3N0YXQ2NCIgIT0geWVzOyB0aGVuCitBQ19D
SEVDS19ERUNMKHN0YXQ2NCwsIFsKIAlBQ19ERUZJTkUoZnN0YXQ2NCwgZnN0YXQsIFs2NC1i
aXQgb3BlcmF0aW9ucyBhcmUgdGhlIHNhbWUgYXMgMzItYml0XSkKIAlBQ19ERUZJTkUobHN0
YXQ2NCwgbHN0YXQsIFs2NC1iaXQgb3BlcmF0aW9ucyBhcmUgdGhlIHNhbWUgYXMgMzItYml0
XSkKIAlBQ19ERUZJTkUoc3RhdDY0LCBzdGF0LCBbNjQtYml0IG9wZXJhdGlvbnMgYXJlIHRo
ZSBzYW1lIGFzIDMyLWJpdF0pCi1maQorXSkKIAotQUNfQ0hFQ0tfRlVOQyhnbG9iNjQsLCBb
CitBQ19DSEVDS19ERUNMKGdsb2I2NCwsIFsKIAlBQ19ERUZJTkUoZ2xvYjY0X3QsIGdsb2Jf
dCwgWzY0LWJpdCBvcGVyYXRpb25zIGFyZSB0aGUgc2FtZSBhcyAzMi1iaXRdKQogCUFDX0RF
RklORShnbG9iNjQsIGdsb2IsIFs2NC1iaXQgb3BlcmF0aW9ucyBhcmUgdGhlIHNhbWUgYXMg
MzItYml0XSkKIAlBQ19ERUZJTkUoZ2xvYmZyZWU2NCwgZ2xvYmZyZWUsCiAJCSAgWzY0LWJp
dCBvcGVyYXRpb25zIGFyZSB0aGUgc2FtZSBhcyAzMi1iaXRdKQotXSkKK10sWyNpZmRlZiBI
QVZFX0dMT0IKKyNpbmNsdWRlIDxnbG9iLmg+CisjZW5kaWZdKQogCiBkbmwgT1MgWCBhcHBh
cmVudGx5IGhhcyBzdGF0NjQgYnV0IG5vdCBvcGVuNjQuCi1BQ19DSEVDS19GVU5DKG9wZW42
NCwsIFsKK0FDX0NIRUNLX0RFQ0wob3BlbjY0LCwgWwogCUFDX0RFRklORShvcGVuNjQsIG9w
ZW4sIFs2NC1iaXQgb3BlcmF0aW9ucyBhcmUgdGhlIHNhbWUgYXMgMzItYml0XSkKIAlBQ19E
RUZJTkUocmVhZGRpcjY0LCByZWFkZGlyLAogCQkgIFs2NC1iaXQgb3BlcmF0aW9ucyBhcmUg
dGhlIHNhbWUgYXMgMzItYml0XSkKIAlBQ19ERUZJTkUoZGlyZW50NjQsIGRpcmVudCwKIAkJ
ICBbNjQtYml0IG9wZXJhdGlvbnMgYXJlIHRoZSBzYW1lIGFzIDMyLWJpdF0pCi1dKQorXSxb
I2luY2x1ZGUgPGZjbnRsLmg+XSkKIAogZG5sIENoZWNrIGlmIHN0cnVjdCBzdGF0IGhhcyBz
dF9tdGltLgogQUNfTVNHX0NIRUNLSU5HKGZvciBzdGF0OjpzdF9tdGltKQo=

--------------SoYVfvAKc12GM6aHpUnUi836--
