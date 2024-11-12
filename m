Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D221A717
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452205; cv=none; b=A0HNM2q/BSELNc1bFYqGE0X35v3zJjRlknNrExYoQHZRuMGORPrsRC/5l7qLHeSNwu8RKSUFOhTk2Ybtudy3kvZQJmjucRrotYRKByMsvnUJNBh0vaRA6U5C3RfZsHPFDYWtgf6fB+s6DlJNxhvqv8esJboIPVNmDMCBqYR28w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452205; c=relaxed/simple;
	bh=n2kFsPmDSLyy3+cy1DKgdWGA2joPhRBbLuts5Ji0dkE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=MkHVaUSrOQhtdKQPcfoZsNSsQWFjwE3ZUsuWjuRM5bXj1KWZmOi946x5gBxAfHnkRYL1WKfPxTqv1olTTjzHszK2lKdNrpgi2cus9jJvKLj9V1dGL5/3ujoUhINjdzddX28PH3aNtyB/o3/w3rEeYdlIgdU2sOEvQCgnPe+QGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMtXC54067774
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:55:35 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMtWp6078301
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:55:33 +0100
Content-Type: multipart/mixed; boundary="------------gmXEJhhH0mMWNaGOFCmYuyyy"
Message-ID: <71a800ed-33b3-4158-b1ea-f75f80e3d892@knaff.lu>
Date: Tue, 12 Nov 2024 23:55:31 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 16-signed-size-t
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
--------------gmXEJhhH0mMWNaGOFCmYuyyy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On UnixPC, size_t is a *signed* type, unlike on all other platforms.

Thus the SSIZE_MAX macro doesn't work on UnixPC as on other platforms
(because right-shift of signed quantities pad with value of leftmost
bit, rather than always shifting a zero in)

This replacement works ok (and obviously works for unsigned size_t
too)

After having applied this one, dash should work on UnixPC for basic
tasks, the next 2 are optional features.

Regards,

Alain
--------------gmXEJhhH0mMWNaGOFCmYuyyy
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+16-signed-size-t.diff"
Content-Disposition: attachment; filename="dash-0.5.12+16-signed-size-t.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzE2LW1vbml0b3ItbW9k
ZS9zcmMvc3lzdGVtLmggZGFzaC0wLjUuMTIrMTctc2lnbmVkLXNpemUtdC9zcmMvc3lzdGVt
LmgKLS0tIGRhc2gtMC41LjEyKzE2LW1vbml0b3ItbW9kZS9zcmMvc3lzdGVtLmgJMjAyNC0x
MS0xMCAxNDo1MzowOC40Mzg2MTg1NjIgKzAwMDAKKysrIGRhc2gtMC41LjEyKzE3LXNpZ25l
ZC1zaXplLXQvc3JjL3N5c3RlbS5oCTIwMjQtMTEtMTAgMTQ6NTM6MDguNDQ2NjE4NzUxICsw
MDAwCkBAIC0zMSw3ICszMSw3IEBACiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAKICNpZm5k
ZWYgU1NJWkVfTUFYCi0jZGVmaW5lIFNTSVpFX01BWCAoKHNzaXplX3QpKChzaXplX3QpLTEg
Pj4gMSkpCisjZGVmaW5lIFNTSVpFX01BWCAoKCgoMUwgPDwgKHNpemVvZihzc2l6ZV90KSo4
LTIpKS0xKTw8MSkrMSkKICNlbmRpZgogCiBzdGF0aWMgaW5saW5lIHZvaWQgc2lnY2xlYXJt
YXNrKHZvaWQpCg==

--------------gmXEJhhH0mMWNaGOFCmYuyyy--
