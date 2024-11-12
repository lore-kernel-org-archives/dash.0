Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB882185AD
	for <dash@vger.kernel.org>; Tue, 12 Nov 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450594; cv=none; b=ZFeHWbIvZ8KiYUMPXUjx5dHSxzj6wse/bIxIvUkJUl8hpIdWYlOy3KZGLqpZbDBxa3O/EQPsiEUg8Lge5nDQBfJ9dd1dY+KGOURAZEXHzYEDJnJiA/xTtI9K75PwRA5AWkY5j9MS5J17wAQuWq75yPlegRqpPkNFz5kGZzc97uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450594; c=relaxed/simple;
	bh=fgB3DeZnsPR7nMJ5hTD949UV7lJDDoIU2Yh1boE+8G0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:Cc:In-Reply-To; b=hThHSSqAsRrMJyPTkOe0V67TW588KQpqDCTzJamQwkTnXuPA6OwtFMXCUbu9zwHDp3/lwcBBdKl5OCPnQivmSRxpZ8xQJmip3/sSqJCGHGzKWM+Rk8lT873GDoFUqC1rNUgcJyDb7FIHos56JQZCZ2yV2UuPWRlLbiwx2z2VPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4ACMQPMo4065890
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 23:26:26 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4ACMQNS1076800
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 Nov 2024 23:26:24 +0100
Content-Type: multipart/mixed; boundary="------------fVwHqv0YjKWPFSh2ILr3hh0E"
Message-ID: <73d307f8-7769-4a73-b4d0-467800010252@knaff.lu>
Date: Tue, 12 Nov 2024 23:26:23 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 01-remove-extraneous
To: Herbert Xu <herbert@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
From: Alain Knaff <alain@knaff.lu>
Content-Language: en-US
Cc: dash@vger.kernel.org
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
--------------fVwHqv0YjKWPFSh2ILr3hh0E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 06/04/2024 08:25, Herbert Xu wrote:
[...]
> Thanks but this needs to be split up into smaller patches so
> that each patch fixes just one problem.

I've now split up the patch into parts. In addition to just the
splitting, the patch set contains the following changes/improvements:
 - adapted it to dash 0.5.12 which has been released in the meantime,
 - some cleanup,
 - it now also compiles & works on Solaris 10 & 11

The patches only list the changes to the primary sources (such as
Makefile.am) Derived files, such as Makefile.in are not included, even
though they would be part of the source tarball.

For simplicity, I attached the patches as text files rather than
pasting them into the mail. Indeed, I no longer trust thunderbird not
to munge them if pasted. I hope this is ok.

Here comes the first part: 01-remove-extraneous

This simply removes declarations from dash that are not used anyways,
and that might needlessly clash with system definitions later on.

Regards,

Alain
--------------fVwHqv0YjKWPFSh2ILr3hh0E
Content-Type: text/x-patch; charset=UTF-8;
 name="dash-0.5.12+01-remove-extraneous.diff"
Content-Disposition: attachment;
 filename="dash-0.5.12+01-remove-extraneous.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtWCAuLi9leGNsdWRlLnR4dCAtdXJOIGRhc2gtMC41LjEyL3NyYy9ibHRpbi9ibHRp
bi5oIGRhc2gtMC41LjEyKzAxLXJlbW92ZS1leHRyYW5lb3VzL3NyYy9ibHRpbi9ibHRpbi5o
Ci0tLSBkYXNoLTAuNS4xMi9zcmMvYmx0aW4vYmx0aW4uaAkyMDIwLTA2LTAzIDAxOjE5OjIz
LjAwMDAwMDAwMCArMDAwMAorKysgZGFzaC0wLjUuMTIrMDEtcmVtb3ZlLWV4dHJhbmVvdXMv
c3JjL2JsdGluL2JsdGluLmgJMjAyNC0xMC0yMCAxODoyNjo0Ni45NjA1OTg2MzggKzAwMDAK
QEAgLTYzLDcgKzYzLDYgQEAKICNkZWZpbmUgZnB1dHMgb3V0c3RyCiAjZGVmaW5lIGZmbHVz
aCBmbHVzaG91dAogI2RlZmluZSBmaWxlbm8oZikgKChmKS0+ZmQpCi0jZGVmaW5lIGZlcnJv
ciBvdXRlcnIKICNlbmRpZgogI2RlZmluZSBJTklUQVJHUyhhcmd2KQogI2RlZmluZQllcnJv
ciBzaF9lcnJvcgpkaWZmIC1YIC4uL2V4Y2x1ZGUudHh0IC11ck4gZGFzaC0wLjUuMTIvc3Jj
L2pvYnMuYyBkYXNoLTAuNS4xMiswMS1yZW1vdmUtZXh0cmFuZW91cy9zcmMvam9icy5jCi0t
LSBkYXNoLTAuNS4xMi9zcmMvam9icy5jCTIwMjItMDEtMjAgMDU6NTQ6MTMuMDAwMDAwMDAw
ICswMDAwCisrKyBkYXNoLTAuNS4xMiswMS1yZW1vdmUtZXh0cmFuZW91cy9zcmMvam9icy5j
CTIwMjQtMTAtMjcgMTk6NTM6NDIuOTEyNjc1NjExICswMDAwCkBAIC0xMTIsOSArMTEyLDYg
QEAKIFNUQVRJQyB2b2lkIGZvcmtjaGlsZChzdHJ1Y3Qgam9iICosIHVuaW9uIG5vZGUgKiwg
aW50KTsKIFNUQVRJQyB2b2lkIGZvcmtwYXJlbnQoc3RydWN0IGpvYiAqLCB1bmlvbiBub2Rl
ICosIGludCwgcGlkX3QpOwogU1RBVElDIGludCBkb3dhaXQoaW50LCBzdHJ1Y3Qgam9iICop
OwotI2lmZGVmIFNZU1YKLVNUQVRJQyBpbnQgb25zaWdjaGlsZCh2b2lkKTsKLSNlbmRpZgog
U1RBVElDIGludCB3YWl0cHJvYyhpbnQsIGludCAqKTsKIFNUQVRJQyBjaGFyICpjb21tYW5k
dGV4dCh1bmlvbiBub2RlICopOwogU1RBVElDIHZvaWQgY21kdHh0KHVuaW9uIG5vZGUgKik7
CmRpZmYgLVggLi4vZXhjbHVkZS50eHQgLXVyTiBkYXNoLTAuNS4xMi9zcmMvbXlzdHJpbmcu
YyBkYXNoLTAuNS4xMiswMS1yZW1vdmUtZXh0cmFuZW91cy9zcmMvbXlzdHJpbmcuYwotLS0g
ZGFzaC0wLjUuMTIvc3JjL215c3RyaW5nLmMJMjAyMi0xMi0xMSAwNjoyOToyMS4wMDAwMDAw
MDAgKzAwMDAKKysrIGRhc2gtMC41LjEyKzAxLXJlbW92ZS1leHRyYW5lb3VzL3NyYy9teXN0
cmluZy5jCTIwMjQtMTAtMjAgMTg6Mjc6NTYuNjM0MjQ1NDk5ICswMDAwCkBAIC00Niw3ICs0
Niw2IEBACiAjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNsdWRlIDxpbnR0eXBlcy5oPgogI2lu
Y2x1ZGUgPGxpbWl0cy5oPgotI2luY2x1ZGUgPGludHR5cGVzLmg+CiAjaW5jbHVkZSA8c3Rk
bGliLmg+CiAjaW5jbHVkZSAic2hlbGwuaCIKICNpbmNsdWRlICJzeW50YXguaCIK

--------------fVwHqv0YjKWPFSh2ILr3hh0E--
