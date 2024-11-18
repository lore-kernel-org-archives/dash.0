Received: from sdaoden.eu (sdaoden.eu [217.144.132.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B32126C02
	for <dash@vger.kernel.org>; Mon, 18 Nov 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.132.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954876; cv=none; b=SBXnnEa0NJ3OjIqPCWIEn6YSE2NUlxw7ROFLPNVmnj8WPyJn0zr46AXaLvWJK5PbWIPys9YxIlVMNLB35q5KJfcK2LDNX5e+9jpQPiJjdQA8/5Nht3e64RoGnbG1fclPfWFJ/PYeQIif0EM/9kaAy2zQZKgR9fPozhoeYJBcsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954876; c=relaxed/simple;
	bh=EqpTwT0bx0OHaEZtUA1ANBQfKsoTfjo736uF70CbEpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References; b=LX+iBNmiZMm4oBFreP/pub8nU3fJnr7nB6oj6z2GZWp6qiui50NFZUh8nRDcvPRhZB+k7PqZ0wHB6FXA9buk7hSKTOrYmmx51C3Z8+cgHWbVnmmgOZ40BHgWUoM+r/LOoSNJ2lDl/4/0OWZgH9hm/bUQRw79g1ZLObURDK7AxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu; spf=pass smtp.mailfrom=sdaoden.eu; dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=MDTTP8La; dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b=oAfNhBvI; arc=none smtp.client-ip=217.144.132.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdaoden.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="MDTTP8La";
	dkim=permerror (0-bit key) header.d=sdaoden.eu header.i=@sdaoden.eu header.b="oAfNhBvI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=citron; t=1731954531; x=1732621197; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=rF4eA73qtS1zzsQRv1ukV3kzBoEYNi87gtzbALnldps=;
 b=MDTTP8LaFRqwhD7tB2DVZGtVCKDoQpYueD5xRMSqUmasC3wcVc6E04/XRgrMpCaBgWwjCbWw
  RKqSxXjJUeleR1oBQBsA1YEj6juPFYBBPxdHWpt2vMdXcskon9f5Lr4LZcbel7LKVSHmbWBq6X
  GEKoJY7OmprS9cJWyVs/G5BnOFE6iGemNWoSAt7LT0xQRWQtLb35TWOovoLT49dsJX0tDVmsGu
  hcSdcQ739/mgF06r1JERfc0r0o2Ht+Ykjs0HjggvkTWSJVhkil5+ZlHvrOUHbhrqF6sbW2n24p
  NwRabhT0h4CRVwXeavk/J9Z4vL9fIkPiBW2UhVl89vwTsCvg==
DKIM-Signature: v=1; a=adaed25519-sha256; c=relaxed/relaxed; d=sdaoden.eu;
 s=orange; t=1731954531; x=1732621197; h=date:author:from:to:cc:subject:
  message-id:in-reply-to:references:openpgp:blahblahblah:author:from:
  subject:date:to:cc:resent-author:resent-date:resent-from:resent-sender:
  resent-to:resent-cc:resent-reply-to:resent-message-id:in-reply-to:
  references:mime-version:content-type:content-transfer-encoding:
  content-disposition:content-id:content-description:message-id:
  mail-followup-to:openpgp:blahblahblah;
 bh=rF4eA73qtS1zzsQRv1ukV3kzBoEYNi87gtzbALnldps=;
 b=oAfNhBvI7D/XZycnuSJmQwkDrV1w61Bs3Q2KSgEBusnZ0xWgcb9DyIV3xBJkkcgfBPtyAUFJ
  Up8KcIO72W8fAg==
Date: Mon, 18 Nov 2024 19:28:50 +0100
Author: Steffen Nurpmeso <steffen@sdaoden.eu>
From: Steffen Nurpmeso <steffen@sdaoden.eu>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: P*rtability of dash to legacy systems, such as AT&T Unix
 PC : 03-name-max
Message-ID: <20241118182850.iBiGRmVD@steffen%sdaoden.eu>
In-Reply-To: <60f962f7-1834-45da-bee9-c245c6797f9e@knaff.lu>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
 <60f962f7-1834-45da-bee9-c245c6797f9e@knaff.lu>
User-Agent: s-nail v14.9.25-628-g13af0798b7
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

Hello,

for your possible interest..

Alain Knaff wrote in
 <60f962f7-1834-45da-bee9-c245c6797f9e@knaff.lu>:
 |The third part of the patch set supplies a definition of NAME_MAX
 |where one is lacking.
 ...
 |+#ifndef NAME_MAX
 |+/* NAME_MAX is only used in expand.c to make sure that we have a
 |+   buffer big enough to append the next local file part into during
 |+   globbing. So, in case of doubt, we need NAME_MAX to be bigger
 |+   rather than smaller, in order to prevent buffer overflow */
 |+# define NAME_MAX PATH_MAX
 |+#endif

i have for reasons i have forgotten otherwise

/* POSIX 2008/Cor 1-2013 defines for
 * - _POSIX_PATH_MAX a minimum of 256
 * - _XOPEN_PATH_MAX a minimum of 1024
 * NFS RFC 1094 from March 1989 defines a MAXPATHLEN of 1024, so we really
 * should avoid anything smaller than that! */
#ifndef PATH_MAX
# ifdef MAXPATHLEN
#  define PATH_MAX MAXPATHLEN
# else
#  define PATH_MAX 1024
# endif
#endif
#if PATH_MAX + 0 < 1024
# undef PATH_MAX
# define PATH_MAX 1024
#endif

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
|
|And in Fall, feel "The Dropbear Bard"s ball(s).
|
|The banded bear
|without a care,
|Banged on himself fore'er and e'er
|
|Farewell, dear collar bear
