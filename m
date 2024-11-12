Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823C205AD9
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451383; cv=none; b=nyhzvCPyK2kdX+IOMAm9v0MBYr0st9IV91lRn8iLQckipZOpAcjDohgFi/rQIsXOIyIdAf1v4NrMLnUliek2EwFOYsl1XGAWJ9Q/L11qSZyKqfMpdq5QggCAFda7F27H10yuEomXm6anryybIdWnq3S5n/PsSX36HoiEW8Ju0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451383; c=relaxed/simple;
	bh=XXSKuJaA/B7mU4VGZ+F2esntUIWPgrzJrcpzYl4p1tY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=DA9tKYllHTT0a5Nwabxht7NA2rMBSJzBuPE0AhKvC78yMuP/zvi6wQ9nES9k2XSW8NIAaUZdnKjL2A0wxe2Y7Uzh5NxGE5+fGFuDR54u7OeW/uxTtXrHrCbKmXilWLIbmUgkgT09paED7SIRPor6I7OJpxtMR1rSCrudl97UoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMfoqx4066904
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:41:52 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMfnXN077711
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:41:50 +0100
Content-Type: multipart/mixed; boundary="------------xllulzX5z0zEUYj84ijQPNMw"
Message-ID: <6984fb0c-5b02-4016-8052-778d19cbc3af@knaff.lu>
Date: Tue, 12 Nov 2024 23:41:49 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 09-type-sizes
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
--------------xllulzX5z0zEUYj84ijQPNMw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The 9th patch supplies auto-detection of size of various integer and
other types

Regards,

Alain
--------------xllulzX5z0zEUYj84ijQPNMw
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+09-type-sizes.diff"
Content-Disposition: attachment; filename="dash-0.5.12+09-type-sizes.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzA4LXZzbnByaW50Zi9j
b25maWd1cmUuYWMgZGFzaC0wLjUuMTIrMDktdHlwZS1zaXplcy9jb25maWd1cmUuYWMKLS0t
IGRhc2gtMC41LjEyKzA4LXZzbnByaW50Zi9jb25maWd1cmUuYWMJMjAyNC0xMS0xMCAxNzoy
OTowNC41MjEwNTU2MzEgKzAwMDAKKysrIGRhc2gtMC41LjEyKzA5LXR5cGUtc2l6ZXMvY29u
ZmlndXJlLmFjCTIwMjQtMTEtMTAgMTc6MDY6MzcuMTUzMDI4NjI5ICswMDAwCkBAIC02OCwx
NyArNjgsMzAgQEAKIEFDX0NIRUNLX0RFQ0xTKFtpc2JsYW5rXSwsLFsjaW5jbHVkZSA8Y3R5
cGUuaD5dKQogCiBBQ19ERUNMX1NZU19TSUdMSVNUCitBQ19UWVBFX1BJRF9UCitBQ19UWVBF
X1VJRF9UCitBQ19UWVBFX1NTSVpFX1QKK0FDX1RZUEVfVUlOVDMyX1QKKworQUNfQ0hFQ0tf
VFlQRShbaW50bWF4X3RdLCxBQ19ERUZJTkVfVU5RVU9URUQoW2ludG1heF90XSxsb25nLFtE
ZWZpbmUgaW50bWF4X3QgdHlwZSwgbXVzdCBhbHNvIGJlIHN1cHBvcnRlZCBieSBwcmludGZd
KSkKKworQUNfQ0hFQ0tfVFlQRShbdWludG1heF90XSwsQUNfREVGSU5FX1VOUVVPVEVEKFt1
aW50bWF4X3RdLHVuc2lnbmVkIGxvbmcsW0RlZmluZSB1aW50bWF4X3QgdHlwZSwgbXVzdCBh
bHNvIGJlIHN1cHBvcnRlZCBieSBwcmludGZdKSkKIAogZG5sIENoZWNrIGZvciBzaXplcyBv
ZiB0eXBlcworQUNfU1lTX0xBUkdFRklMRQogQUNfQ0hFQ0tfU0laRU9GKFtpbnRtYXhfdF0p
CiBBQ19DSEVDS19TSVpFT0YoW2xvbmcgbG9uZyBpbnRdKQorQUNfQ0hFQ0tfU0laRU9GKFts
b25nIGludF0pCiAKIGRubCBTZWxlY3QgYSBmYWxsYmFjayBmb3JtYXQgc3RyaW5nIGZvciBp
bnRtYXhfdCBpbiBjYXNlIHdlIGRvbid0IGZpbmQgUFJJZE1BWAogaWYgdGVzdCAieCRhY19j
dl9zaXplb2ZfaW50bWF4X3QiID0gIngkYWNfY3Zfc2l6ZW9mX2xvbmdfbG9uZ19pbnQiOyB0
aGVuCiAgIGludG1heF9mc3RyPSJsbGQiCitlbHNlIGlmIHRlc3QgIngkYWNfY3Zfc2l6ZW9m
X2ludG1heF90IiA9ICJ4JGFjX2N2X3NpemVvZl9sb25nX2ludCI7IHRoZW4KKyAgaW50bWF4
X2ZzdHI9ImxkIgogZWxzZQogICBpbnRtYXhfZnN0cj0iamQiCiBmaQorZmkKIAogZG5sIENo
ZWNrIGZvciBQUklkTUFYIGFuZCBkZWZpbmUgaXQgdG8gYSBmYWxsYmFjayBpZiBub3QgZm91
bmQKIEFDX0NIRUNLX0RFQ0woW1BSSWRNQVhdLCwK

--------------xllulzX5z0zEUYj84ijQPNMw--
