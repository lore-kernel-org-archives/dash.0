Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12708205AD9
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451172; cv=none; b=Mp23mKepg4fIKOB5awiU3EFCtMDI3K/8uamLeFbDKQASOXX6BlXwy13/XVkkB4kt2i1dKDgC/ZsdyafW1l99KWacTb682m8O0KNQX9h5stEPFhfkOoCL1HCGzjj6UhC/03MYeigdPz4ES9j23ZAnKfW4QexQ+CzmmkXby8z+jfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451172; c=relaxed/simple;
	bh=e0ypLFtX9b8/XV6en16Vf2P6yB9epcBpFmFYpMWuAUM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FYh+kffesLP4SU2vcotPZmuq2zTu/U2dxleqnGzHlxx66fSx38XKs3KiHyE+73ifPdqsgeNuhd8ihtFiEDTfVYnxo8Xe55ruXvBtJucd36MbBzzCPRTKpQY0Rvd8VFM6juoYd/QKNUukMzmTFT2pW91V9lThAkbb1aj4tOMz3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMcJWq4066624
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:38:21 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMcI44077371
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:38:19 +0100
Content-Type: multipart/mixed; boundary="------------DIdLOqoz9HNvjf8alqFpNnAD"
Message-ID: <6183219a-f28f-473d-9432-5fb8c33ece0d@knaff.lu>
Date: Tue, 12 Nov 2024 23:38:18 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 06-stdbool
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
--------------DIdLOqoz9HNvjf8alqFpNnAD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The 6th patch is dedicated to the stdbool.h header file. If it doesn't
exist, it cannot be simply dropped, as it contains definitions
absolutely needed by the application, which need to be replaced.

So:
 - a simple definition for the bool type is supplied
 - return of strchr() is explicitly compared with NULL rather than
 relying on an implicit conversion to boolean. Would cause a warning
 without this

Regards,

Alain
--------------DIdLOqoz9HNvjf8alqFpNnAD
Content-Type: text/x-patch; charset=UTF-8; name="dash-0.5.12+06-stdbool.diff"
Content-Disposition: attachment; filename="dash-0.5.12+06-stdbool.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzA1LXN5cy1oZWFkZXJz
L2NvbmZpZ3VyZS5hYyBkYXNoLTAuNS4xMiswNi1zdGRib29sL2NvbmZpZ3VyZS5hYwotLS0g
ZGFzaC0wLjUuMTIrMDUtc3lzLWhlYWRlcnMvY29uZmlndXJlLmFjCTIwMjQtMTEtMTAgMTc6
MDY6MTAuMzA4MzkwMzU2ICswMDAwCisrKyBkYXNoLTAuNS4xMiswNi1zdGRib29sL2NvbmZp
Z3VyZS5hYwkyMDI0LTExLTEwIDE3OjA2OjE4LjQ0MDU4MzcxNCArMDAwMApAQCAtNDQsNyAr
NDQsNyBAQAogZG5sIENoZWNrcyBmb3IgbGlicmFyaWVzLgogCiBkbmwgQ2hlY2tzIGZvciBo
ZWFkZXIgZmlsZXMuCi1BQ19DSEVDS19IRUFERVJTKGFsbG9jYS5oIHBhdGhzLmggcHdkLmgg
ZGlyZW50LmggXAorQUNfQ0hFQ0tfSEVBREVSUyhhbGxvY2EuaCBwYXRocy5oIHB3ZC5oIHN0
ZGJvb2wuaCBkaXJlbnQuaCBcCiAJCWdldG9wdC5oIHN5cy9yZXNvdXJjZS5oIHRlcm1pb3Mu
aCBzeXMvdGltZS5oKQogCiBkbmwgQ2hlY2sgZm9yIGRlY2xhcmF0aW9ucwpkaWZmIC1YIC4u
L2V4Y2x1ZGUudHh0IC11ck4gZGFzaC0wLjUuMTIrMDUtc3lzLWhlYWRlcnMvc3JjL2V4cGFu
ZC5jIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2V4cGFuZC5jCi0tLSBkYXNoLTAuNS4x
MiswNS1zeXMtaGVhZGVycy9zcmMvZXhwYW5kLmMJMjAyNC0xMS0xMCAxNTozMDoxNi4yNzEz
NjExNTAgKzAwMDAKKysrIGRhc2gtMC41LjEyKzA2LXN0ZGJvb2wvc3JjL2V4cGFuZC5jCTIw
MjQtMTAtMjAgMjE6MDM6MTcuMTIyNTg4ODgzICswMDAwCkBAIC03Myw3ICs3MywxMiBAQAog
I2luY2x1ZGUgPGdsb2IuaD4KICNlbmRpZgogI2luY2x1ZGUgPGN0eXBlLmg+CisjaWZkZWYg
SEFWRV9TVERCT09MX0gKICNpbmNsdWRlIDxzdGRib29sLmg+CisjZWxzZQordHlwZWRlZiBp
bnQgYm9vbDsKK2NvbnN0IGludCBmYWxzZSA9IDA7CisjZW5kaWYKIAogLyoKICAqIFJvdXRp
bmVzIHRvIGV4cGFuZCBhcmd1bWVudHMgdG8gY29tbWFuZHMuICBXZSBoYXZlIHRvIGRlYWwg
d2l0aApAQCAtMTA1NywxMCArMTA2MiwxMCBAQAogCQkJCWlmIChjID09IChjaGFyKUNUTEVT
QykKIAkJCQkJYyA9ICpwKys7CiAKLQkJCQlpc2lmcyA9IHN0cmNocihpZnMsIGMpOworCQkJ
CWlzaWZzID0gc3RyY2hyKGlmcywgYykgIT0gTlVMTDsKIAkJCQlpc2RlZmlmcyA9IGZhbHNl
OwogCQkJCWlmIChpc2lmcykKLQkJCQkJaXNkZWZpZnMgPSBzdHJjaHIoZGVmaWZzLCBjKTsK
KwkJCQkJaXNkZWZpZnMgPSBzdHJjaHIoZGVmaWZzLCBjKSAhPSBOVUxMOwogCiAJCQkJLyog
SWYgb25seSByZWFkaW5nIG9uZSBtb3JlIGFyZ3VtZW50OgogCQkJCSAqIElmIHdlIGhhdmUg
ZXhhY3RseSBvbmUgZmllbGQsCg==

--------------DIdLOqoz9HNvjf8alqFpNnAD--
