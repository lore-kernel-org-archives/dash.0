Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63615193092
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451318; cv=none; b=D5hrNev1FsSocv7igy6BbUYBd/8FKEd0LDsoqclTb+KjLTXSIUQv1X+mvuWqQkmBNYg/EAaudiLqomQHkaDTsaJ62yPNnt6x7QiLljQ+72i+0mav3d3Wqeg08b04ThLu2/uAWA2JX/igbv8OfmbV6Sh2BfnNXTD1YyiA7aJfigY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451318; c=relaxed/simple;
	bh=IB60Y/RImESDUb23rsUC1oBhi8lr46cHSJkGkh2RAtI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ZsP5L0CWNbx8NF2FESxz10pIQK/GubP+0ZFQjXM7gfjZ90gq3COuy5LS2oIaf//6Zc2YzATFgB0IZqeq1gJzxTOI6Cv0Lub8e3n60fxk7dtuwIoeSVZsX0GiqlX8DRvKqzzNR3LO9jzUrwdXbX77LC5vhd7Mo/y6nsl2VdhvsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMei9i4066856
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:40:46 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMehpa077681
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:40:44 +0100
Content-Type: multipart/mixed; boundary="------------TPUtG8eK8Xp1jERkZrgH0ZdF"
Message-ID: <a8fb350a-54c9-47eb-b7e7-756763de93b6@knaff.lu>
Date: Tue, 12 Nov 2024 23:40:43 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 08-vsnprintf
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
--------------TPUtG8eK8Xp1jERkZrgH0ZdF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The 8th patch supplies a replacement "defintion" for vsnprintf.

As vsnprintf is rather complex to re-implement fully, a stripped down
version which does not verify available size is supplied.

Most calls to vsnprintf have predictable size needs, so this is
ok. Except one, in showvars, for which an alternative method is
supplied that doesn't rely on vsnprintf for its variable size part.

Regards,

Alain
--------------TPUtG8eK8Xp1jERkZrgH0ZdF
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+08-vsnprintf.diff"
Content-Disposition: attachment; filename="dash-0.5.12+08-vsnprintf.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyKzA3LXN5cy1mdW5jdGlv
bnMvY29uZmlndXJlLmFjIGRhc2gtMC41LjEyKzA4LXZzbnByaW50Zi9jb25maWd1cmUuYWMK
LS0tIGRhc2gtMC41LjEyKzA3LXN5cy1mdW5jdGlvbnMvY29uZmlndXJlLmFjCTIwMjQtMTEt
MTAgMTc6Mjk6MTIuMDczMjM1MzAwICswMDAwCisrKyBkYXNoLTAuNS4xMiswOC12c25wcmlu
dGYvY29uZmlndXJlLmFjCTIwMjQtMTEtMTAgMTc6Mjk6MDQuNTIxMDU1NjMxICswMDAwCkBA
IC05NCw3ICs5NCw3IEBACiAJICAgICAgIHNpZ3NldG1hc2sgc3RwY3B5IHN0cmNocm51bCBz
dHJzaWduYWwgc3RydG9kIHN0cnRvaW1heCBcCiAJICAgICAgIHN0cnRvdW1heCBzeXNjb25m
IFwKIAkgICAgICAgdmZvcmsgbHN0YXQgZHVwMiBnZXRncm91cHMgXAotCSAgICAgICBzdHJz
dHIgc3RwbmNweSBzdHJjYXNlY21wIHN0cmVycm9yIHN0cmR1cCBzdHJ0b3VsIFwKKwkgICAg
ICAgc3Ryc3RyIHN0cG5jcHkgc3RyY2FzZWNtcCBzdHJlcnJvciBzdHJkdXAgc3RydG91bCB2
c25wcmludGYgXAogCSAgICAgICByZWFkZGlyKQogCiBkbmwgQ2hlY2tzIGZvciBwcm90b3R5
cGVzCmRpZmYgLVggLi4vZXhjbHVkZS50eHQgLXVyTiBkYXNoLTAuNS4xMiswNy1zeXMtZnVu
Y3Rpb25zL3NyYy9zeXN0ZW0uYyBkYXNoLTAuNS4xMiswOC12c25wcmludGYvc3JjL3N5c3Rl
bS5jCi0tLSBkYXNoLTAuNS4xMiswNy1zeXMtZnVuY3Rpb25zL3NyYy9zeXN0ZW0uYwkyMDI0
LTExLTEwIDE2OjU0OjUwLjUyODIyNTI5MiArMDAwMAorKysgZGFzaC0wLjUuMTIrMDgtdnNu
cHJpbnRmL3NyYy9zeXN0ZW0uYwkyMDI0LTExLTEwIDE2OjU0OjUwLjUzNjIyNTQ4MiArMDAw
MApAQCAtMzEzLDYgKzMxMywyMiBAQAogfQogI2VuZGlmCiAKKyNpZm5kZWYgSEFWRV9WU05Q
UklOVEYKK2ludCB2c25wcmludGYoY2hhciAqc3RyLCBzaXplX3Qgc2l6ZSwgY29uc3QgY2hh
ciAqZm9ybWF0LCB2YV9saXN0IGFwKQoreworCWNoYXIgYnVmZmVyWzQwOTZdOworCWludCBy
ZXQ7CisJaW50IG47CisJcmV0ID0gdnNwcmludGYoYnVmZmVyLCBmb3JtYXQsIGFwKTsKKwlp
ZihyZXQgPCAwIHx8IHNpemUgPT0gMCkKKwkJcmV0dXJuIHJldDsKKwluID0gKHJldCA+PSBz
aXplKSA/IHNpemUgLSAxIDogcmV0OworCXN0cm5jcHkoc3RyLCBidWZmZXIsIG4pOworCXN0
cltuXT0nXDAnOworCXJldHVybiByZXQ7Cit9CisjZW5kaWYKKwogI2lmbmRlZiBIQVZFX01F
TU1PVkUKIC8qIG1lbW1vdmUuYyAtLSBjb3B5IG1lbW9yeS4KICAgIFRoaXMgc25pcHBldCBp
cyBpbiB0aGUgcHVibGljIGRvbWFpbi4gICovCmRpZmYgLVggLi4vZXhjbHVkZS50eHQgLXVy
TiBkYXNoLTAuNS4xMiswNy1zeXMtZnVuY3Rpb25zL3NyYy92YXIuYyBkYXNoLTAuNS4xMisw
OC12c25wcmludGYvc3JjL3Zhci5jCi0tLSBkYXNoLTAuNS4xMiswNy1zeXMtZnVuY3Rpb25z
L3NyYy92YXIuYwkyMDI0LTEwLTIwIDA4OjM3OjU1LjgxODY4MzQwOSArMDAwMAorKysgZGFz
aC0wLjUuMTIrMDgtdnNucHJpbnRmL3NyYy92YXIuYwkyMDI0LTEwLTIxIDEwOjQ0OjU1Ljkw
OTU2MDI1NCArMDAwMApAQCAtMzkyLDcgKzM5MiwxMyBAQAogCQlpZiAoKnApCiAJCQlxID0g
c2luZ2xlX3F1b3RlKCsrcCk7CiAKKyNpZmRlZiBIQVZFX1ZTTlBSSU5URgogCQlvdXQxZm10
KCIlcyVzJS4qcyVzXG4iLCBwcmVmaXgsIHNlcCwgKGludCkocCAtICplcCksICplcCwgcSk7
CisjZWxzZQorCQlvdXQxZm10KCIlcyVzJS4qcyIsIHByZWZpeCwgc2VwLCAoaW50KShwIC0g
KmVwKSwgKmVwKTsKKwkJb3V0c3RyKHEsIG91dDEpOworCQlvdXRjc2xvdygnXG4nLCBvdXQx
KTsKKyNlbmRpZgogCX0KIAogCXJldHVybiAwOwo=

--------------TPUtG8eK8Xp1jERkZrgH0ZdF--
