Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F512219E5C
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451954; cv=none; b=mMVgrLtr0Z6fkx6Lwqe7eZacMJo4COUyz8tzxmXkCw9/S/YqLFr4z/b0AlsyeKUEvuTzpwRd+Iy11aLU+vu6z5Iw6tGeefFI/LXphoV83IQv3d+OjPPU4to4hfwC46fag2L/jSsYG+8bX4tfwlH5yQIt3M6rqY4f/GJe52CmgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451954; c=relaxed/simple;
	bh=cpc+Q0youS4GGpbu0cNh0jdT2HkE4WVTC2LlWrdEzJc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aQXJNXfBhJtALuStY8WgKhJkve+zwidBYzZZWdyHXeyeVqTUBaxSjbK4cFG85uRPyBB4xTYvNoPC2aYjc6TdsMNIgEYl2DFdvcaU3fqW23v1FLpHUF5t02ckBV9VZlVGWz+oElWX3lYhhYGqnpWqh0aUXlM+5Z0bdEXVwDrBt9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMpLjd4067500
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:51:22 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMpKYi078134
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:51:21 +0100
Content-Type: multipart/mixed; boundary="------------fi3kMBGP0wmoz2zPw1S0zTX9"
Message-ID: <a2adfde2-f470-4486-9938-230a21b057e5@knaff.lu>
Date: Tue, 12 Nov 2024 23:51:20 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 14-broken-wait-h
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
--------------fi3kMBGP0wmoz2zPw1S0zTX9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

UnixPC ships with a wait.h for the wrong endianness.

This patch provides a local replacement (triggered by absence
WEXITSTATUS flag)

After having applied the patches until and including this one, it should
compile for UnixPC, but not yet work. The next couple of patches address
issues that only become apparent at runtime or optional features.

Regards,

Alain
--------------fi3kMBGP0wmoz2zPw1S0zTX9
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+14-broken-wait-h.diff"
Content-Disposition: attachment; filename="dash-0.5.12+14-broken-wait-h.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzEzLXdhaXQzLXJlcGxh
Y2VtZW50L3NyYy9zeXN0ZW0uaCBkYXNoLTAuNS4xMisxNC1icm9rZW4td2FpdC1oL3NyYy9z
eXN0ZW0uaAotLS0gZGFzaC0wLjUuMTIrMTMtd2FpdDMtcmVwbGFjZW1lbnQvc3JjL3N5c3Rl
bS5oCTIwMjQtMTEtMTAgMTQ6NTM6MDguNDE4NjE4MDkwICswMDAwCisrKyBkYXNoLTAuNS4x
MisxNC1icm9rZW4td2FpdC1oL3NyYy9zeXN0ZW0uaAkyMDI0LTExLTEwIDE0OjUzOjA4LjQy
MjYxODE4MyArMDAwMApAQCAtMTY3LDYgKzE2Nyw0MiBAQAogIyBkZWZpbmUgRkRfQ0xPRVhF
QyAxCiAjZW5kaWYKIAorI2lmbmRlZiBXRVhJVFNUQVRVUworCisvKiBJZiBXSUZFWElURUQo
U1RBVFVTKSwgdGhlIGxvdy1vcmRlciA4IGJpdHMgb2YgdGhlIHN0YXR1cy4gICovCisjdW5k
ZWYgV0VYSVRTVEFUVVMKKyNkZWZpbmUJV0VYSVRTVEFUVVMoc3RhdHVzKQkoKChzdGF0dXMp
ICYgMHhmZjAwKSA+PiA4KQorCisvKiBJZiBXSUZTSUdOQUxFRChTVEFUVVMpLCB0aGUgdGVy
bWluYXRpbmcgc2lnbmFsLiAgKi8KKyN1bmRlZiBXVEVSTVNJRworI2RlZmluZQlXVEVSTVNJ
RyhzdGF0dXMpCSgoc3RhdHVzKSAmIDB4N2YpCisKKy8qIElmIFdJRlNUT1BQRUQoU1RBVFVT
KSwgdGhlIHNpZ25hbCB0aGF0IHN0b3BwZWQgdGhlIGNoaWxkLiAgKi8KKyN1bmRlZiBXU1RP
UFNJRworI2RlZmluZQlXU1RPUFNJRyhzdGF0dXMpCVdFWElUU1RBVFVTKHN0YXR1cykKKwor
LyogTm9uemVybyBpZiBTVEFUVVMgaW5kaWNhdGVzIG5vcm1hbCB0ZXJtaW5hdGlvbi4gICov
CisjdW5kZWYgV0lGRVhJVEVECisjZGVmaW5lCVdJRkVYSVRFRChzdGF0dXMpCShXVEVSTVNJ
RyhzdGF0dXMpID09IDApCisKKy8qIE5vbnplcm8gaWYgU1RBVFVTIGluZGljYXRlcyB0ZXJt
aW5hdGlvbiBieSBhIHNpZ25hbC4gICovCisjdW5kZWYgV0lGU0lHTkFMRUQKKyNkZWZpbmUg
V0lGU0lHTkFMRUQoc3RhdHVzKSBcCisgICgoKHNpZ25lZCBjaGFyKSAoKChzdGF0dXMpICYg
MHg3ZikgKyAxKSA+PiAxKSA+IDApCisKKy8qIE5vbnplcm8gaWYgU1RBVFVTIGluZGljYXRl
cyB0aGUgY2hpbGQgaXMgc3RvcHBlZC4gICovCisjdW5kZWYgV0lGU1RPUFBFRAorI2RlZmlu
ZQlXSUZTVE9QUEVEKHN0YXR1cykJKCgoc3RhdHVzKSAmIDB4ZmYpID09IDB4N2YpCisKKy8q
IE5vbnplcm8gaWYgU1RBVFVTIGluZGljYXRlcyB0aGUgY2hpbGQgZHVtcGVkIGNvcmUuICAq
LworI3VuZGVmIFdDT1JFRFVNUAorI2lmbmRlZiBXQ09SRUZMQUcKKyMgZGVmaW5lCVdDT1JF
RkxBRwkJMHg4MAorI2VuZGlmCisjZGVmaW5lCVdDT1JFRFVNUChzdGF0dXMpCSgoc3RhdHVz
KSAmIFdDT1JFRkxBRykKKworI2VuZGlmCisKICNpZm5kZWYgSEFWRV9TVFJTVFIKIGV4dGVy
biBjaGFyICogc3Ryc3RyIChjb25zdCBjaGFyKiBoYXlzdGFjaywgY29uc3QgY2hhciAqbmVl
ZGxlKTsKICNlbmRpZgo=

--------------fi3kMBGP0wmoz2zPw1S0zTX9--
