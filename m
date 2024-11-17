Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA13FBA7
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731836765; cv=none; b=Oh+XXMVuf0f0QHJFDS/lL10nxAI9rfOS5pNmlzXo/KqikHpzouEeXKj6TlFNTYE2z6BrhU3+NMmUmiusyuW3pjBRRmzyxtfAsRtXB56ZPUtdpXR5Gbzp6BuJ7jBVjlJrnZ/KI4IxGSOs0foNxdEsnNTtpN7gW05gg3h/NUfW/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731836765; c=relaxed/simple;
	bh=fJ3wXWVew+D0bzUWkz5NKktZ4MI9jhzlmT8ggtFe5fw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cR34Vj4Gx25oB66zLPms4LL7qNsu+/QF6ylMKqItn5TLU03Re39+Fu1Ce4sxPiyoo+O34my0ZJsPl3pg+wTPgtOtJdIJ3jUN3kqnkcH5SZqthzvOeQd7v5H+OGyGKS5rSwZ/Jdya/nUCIgxWiI5Rqpn8+YtSf01MwwG+fHhreYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AH9jtpg207700
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 10:45:56 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AH9jrG8414675
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 10:45:55 +0100
Message-ID: <06330e5c-4d1d-48c2-95fe-ebba32bd46e6@knaff.lu>
Date: Sun, 17 Nov 2024 10:45:53 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: Portability of dash to legacy systems, such as AT&T Unix PC :
 08-vsnprintf
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

The 8th patch supplies a replacement "defintion" for vsnprintf.

As vsnprintf is rather complex to re-implement fully, a stripped down
version which does not verify available size is supplied.

Most calls to vsnprintf have predictable size needs, so this is
ok. Except one, in showvars, for which an alternative method is
supplied that doesn't rely on vsnprintf for its variable size part.

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+07-sys-functions/configure.ac dash-0.5.12+08-vsnprintf/configure.ac
--- dash-0.5.12+07-sys-functions/configure.ac	2024-11-10 17:29:12.073235300 +0000
+++ dash-0.5.12+08-vsnprintf/configure.ac	2024-11-10 17:29:04.521055631 +0000
@@ -94,7 +94,7 @@
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf \
 	       vfork lstat dup2 getgroups \
-	       strstr stpncpy strcasecmp strerror strdup strtoul \
+	       strstr stpncpy strcasecmp strerror strdup strtoul vsnprintf \
 	       readdir)
 
 dnl Checks for prototypes
diff -X ../exclude.txt -urN dash-0.5.12+07-sys-functions/src/system.c dash-0.5.12+08-vsnprintf/src/system.c
--- dash-0.5.12+07-sys-functions/src/system.c	2024-11-10 16:54:50.528225292 +0000
+++ dash-0.5.12+08-vsnprintf/src/system.c	2024-11-10 16:54:50.536225482 +0000
@@ -313,6 +313,22 @@
 }
 #endif
 
+#ifndef HAVE_VSNPRINTF
+int vsnprintf(char *str, size_t size, const char *format, va_list ap)
+{
+	char buffer[4096];
+	int ret;
+	int n;
+	ret = vsprintf(buffer, format, ap);
+	if(ret < 0 || size == 0)
+		return ret;
+	n = (ret >= size) ? size - 1 : ret;
+	strncpy(str, buffer, n);
+	str[n]='\0';
+	return ret;
+}
+#endif
+
 #ifndef HAVE_MEMMOVE
 /* memmove.c -- copy memory.
    This snippet is in the public domain.  */
diff -X ../exclude.txt -urN dash-0.5.12+07-sys-functions/src/var.c dash-0.5.12+08-vsnprintf/src/var.c
--- dash-0.5.12+07-sys-functions/src/var.c	2024-10-20 08:37:55.818683409 +0000
+++ dash-0.5.12+08-vsnprintf/src/var.c	2024-10-21 10:44:55.909560254 +0000
@@ -392,7 +392,13 @@
 		if (*p)
 			q = single_quote(++p);
 
+#ifdef HAVE_VSNPRINTF
 		out1fmt("%s%s%.*s%s\n", prefix, sep, (int)(p - *ep), *ep, q);
+#else
+		out1fmt("%s%s%.*s", prefix, sep, (int)(p - *ep), *ep);
+		outstr(q, out1);
+		outcslow('\n', out1);
+#endif
 	}
 
 	return 0;
