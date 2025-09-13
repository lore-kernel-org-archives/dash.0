Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77417A306
	for <dash@vger.kernel.org>; Sat, 13 Sep 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757769534; cv=none; b=cEFtRczQOOVe0XjdUJj+JyTZZBeWQOGMCAzfmrNC+8dusxxxxOQC1B4enbgamJk2BDKkHKI/rE6u1phK0IJFnhfzTKhApkmBSq0MYIJYBmZbsX0QPmOWWW+V410Oj3f6qdYKte7b9EGgF4T4uA1vAzMnBHefud3IZBlI3Qu87/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757769534; c=relaxed/simple;
	bh=o60nS2LnHHV9mCYNjSTe4LO6Wz8v9urP3mtxtmJ7EeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbT7najDcvEJbO/KQudp5dPwMSmIMa7o47CnMkNAbrDlwOzzAqdJNrFiSYIaks2IsgXx887vnvVW63PXfCRXjZ0+Q5otJgEu5ESiRYkAw1heSjNxamZXJk5XUS1PK2gmxh556h/Z4TDnxLIEujGYIprHbGdm0chbZcv7OZQWQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=lV9TFysu; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="lV9TFysu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cUwP13PpH8WPzqOnG+z/YG6LQ2CcF29SyMr3qGdh6go=; b=lV9TFysu6PffjY4AJ3uofodm2S
	O/YN81O+hjNrvRi55umpdHH6JEc/3FX8EpM2T6oy+gBYcz0g2DqeP9dq1lnX2sspLoSzctNIWEzTD
	yN13cAlFQOsLfXfRQyok34sUuDUF9v4aIPFEkRJx7c2roFxKaOv+wQo0jwifLy/aQoRYXBQPtJx5l
	V73sLclgmz5NGWucVBb2lVqtUDXquEe9eudNvM3R5A0508kY3eY60hI6PItb9jOSzUCFGUtxut4LX
	6OqtwgOSeSo6Umk/ajXvJAbDHrQGzt25X5Y+oK95gh7FTKT0sznXpAAqFDEcqTDWiTf5Ku+Eu0X6m
	oFP3p0ow==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxPtx-0057qq-2i;
	Sat, 13 Sep 2025 21:18:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Sep 2025 21:18:46 +0800
Date: Sat, 13 Sep 2025 21:18:46 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>,
	Robert Elz <kre@munnari.oz.au>
Subject: [PATCH] expand: Check for NUL before parsing range expression in
 pmatch
Message-ID: <aMVvNj-VbF8J6OTe@gondor.apana.org.au>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:40:16PM -0700, Nathan Mills wrote:
>
> * Crashes #1 to 5 is a heap-buffer-overflow - finds hyphen instead of
> closing bracket
>
> ** Crash #1 heap-buffer-overflow finds hyphen instead of closing bracket **
> 
> Base64'd:
> W/ktJ0VFRUVFRUUgAAAARUVFAIAqWxgtLScAgCpbAS0AgAABLQ==
> 
> `src/dash -c "[''*-"`
> 
> Fix for crashes #1 to 5:
> diff --git a/src/expand.c b/src/expand.c
> index 25df03c..ff86d53 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -1986,6 +1986,7 @@ static int pmatch(char *pattern, const char *string)
>                                         p += mbp;
>                                 }
>                                 if (*p == '-' && p[1] != ']') {
> +                                       if (!p[1]) continue;
>                                         p++;
>                                         if (*p == (char)CTLESC)
>                                                 p++;

Thanks for the report.

This bug seems to go all the way back to NetBSD.

---8<---
Check for NUL before parsing range expression in pmatch.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 35481d6..d57373c 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -1982,7 +1982,7 @@ static int pmatch(char *pattern, const char *string)
 					mbp >>= 8;
 					p += mbp;
 				}
-				if (*p == '-' && p[1] != ']') {
+				if (*p == '-' && p[1] && p[1] != ']') {
 					p++;
 					if (*p == (char)CTLESC)
 						p++;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
