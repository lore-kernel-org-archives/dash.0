Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95ACA64
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869470; cv=none; b=BLjInSM/YQRoumwQB6g7TGwNZas4KLXfCu6egXzkr3Hi13ONVoeM9RjazcLSs4G8PbcbPN+RjQ576v9JBvvUpetrWU9QfnArWv+HWn8stBRSazRjEZYszrX5IGm7dcjnhjxHAH7G1WeNERGXJ6BwMkFxmJSa3f66GGvUsYfBI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869470; c=relaxed/simple;
	bh=XPOJz69vK60mJ+t79I7AXZOrtKG8v4VXPFtzQLjV04Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iUbbCHkfu5JvunzZFySy+c7Y3lVNHCn9/hUtn/3xsROiMWoiPpQw9CgzLpuvBNsT/qFK+ywio+/8pqwWHnPKIna/an5thc9dohY+NjmNgg846N2Xh8I+rd9jNRXDcMrn+b8w8s6JMAaebVQDnR++pWok23tX7yR96wGL8+hyuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHIp0hd235684
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 19:51:01 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHIowbk443118
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 19:50:59 +0100
Message-ID: <69f0a5dd-cd31-48c3-a633-9d26ab93714f@knaff.lu>
Date: Sun, 17 Nov 2024 19:50:58 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 15-realloc-null
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

On UnixPC, realloc of a NULL pointer returns NULL, whereas on most
today's architectures it behaves the same way as malloc.

So we just wrap it.

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+14-broken-wait-h/src/memalloc.c dash-0.5.12+15-realloc-null/src/memalloc.c
--- dash-0.5.12+14-broken-wait-h/src/memalloc.c	2024-10-27 20:32:54.604833876 +0000
+++ dash-0.5.12+15-realloc-null/src/memalloc.c	2024-10-27 20:32:44.700597405 +0000
@@ -68,7 +68,10 @@
 pointer
 ckrealloc(pointer p, size_t nbytes)
 {
-	p = realloc(p, nbytes);
+	if(p == NULL)
+		p = malloc(nbytes);
+	else
+		p = realloc(p, nbytes);
 	if (p == NULL)
 		sh_error("Out of space");
 	return p;
