Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E331B838
	for <dash@vger.kernel.org>; Sun, 31 May 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780207756; cv=none; b=MSY0qP7BbSU3d2rUxgFpE3txDexA6qxBIdsKZ2ZK5dYWju2jceQEo7vXEnognk932O73xCHKZEQL52o62k+K98NHWm/z3jLQmOZezV4EgvYXsLXcq69jI4jy/NiCa9L+C5KdLlxp0EN36SIamFhtOleS/Q9AMUn6uHVrjhqimQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780207756; c=relaxed/simple;
	bh=uIZjr34uHzLQI/3Z8YYRUag89ySDiIVNPEAZWLhM3u8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CC39sDDUq0mqzOBuAB7NfkUopIFQNdJsy5MTtZxtPt2DIZkmB64BLKJNRbGfbvIsKortpSK8CDK4zkMEUkRNJblKFtmCFMbKyWE+s6t31sHm3YIiVroWPpkn3t1FllmVTAPqbFUg00SSbZhkBBUe065GROvBDqD7iTFaCa6mIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=B5zd2Gek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdtefTuq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="B5zd2Gek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdtefTuq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B2A981D00041;
	Sun, 31 May 2026 02:09:13 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 02:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1780207753; x=1780294153; bh=ZWGaQ+MbZ4ZBAvE+3K8FBI8B6XfNCH1N
	walgTSvHCgc=; b=B5zd2Gekh7lr/SvTCfZAVgn0UA7BFfFuXvAQ8pI1T/4JFTFk
	Eobt6vvbQ9/hEl+W47TlF8xPUkCZwux729NL3vCcehF5c5kJe/q+sqeaBKRQ/EVo
	6tufK0+olPQZEckw2K8Uy5TeFFALxls7Ztfy3i0d/MZZS67OrxyL7H4ZlQ0ZgJos
	aOo8TDOhJH1XDxPa0rotRX5EoJ0VUCAWwKI1khiH4MV5JT839mMGWc28qRYOUX0x
	167ej6ITnI+zqadbtS1nEgBEj1ivErKOnrtPwnE+FilBR0v7tgYnN0HibDlgs1Qw
	irn2mKUkobZ+pSm045e6nH9coMpUb80/jwQbMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780207753; x=
	1780294153; bh=ZWGaQ+MbZ4ZBAvE+3K8FBI8B6XfNCH1NwalgTSvHCgc=; b=Y
	dtefTuqL9cZUYNrNaVpjPzrrgilb5w0GQzd0LLV8j6XdjIFGeVeOFtrPEolKvfex
	nbdqNNev5d2ypi4Qr4kXjbfpV4CvaJz8JTLBR5UItKypvJsxTw5c5rFuhDKQ2WLp
	YuD03u/PbVxUz6z3nscZTiG0RO4H21rWPcFbgYP3k+Qio8Z0oB0igpF3/rEqZ8VS
	S32azjOhUzJnu7wI/T4il7agZrK/1YvFf4WSzxLg+DFbFJpySJ//1rPXq9RgM7ra
	ef27G76Q7mPVwVnVVwfQfnOlHrb4zy7hnMCvR21QvTFiSovj4Qljc3n9EBAjNOFK
	7bJngkpZNDkUYEFb36MwA==
X-ME-Sender: <xms:idAbakaNZvnLAnTSHUcNauv_H1x8F5CnsE1Pt7UfhX6yMmzh0jTSOg>
    <xme:idAbaqPerR9VByTAh_4hQTsl3ShKyZzVSPXqf0Ob3MepuAgIvtbofQgzzHxgauNI-
    3GbLvZOh-lOPEMjboO9gY89V-dDZ_Rt9OcrbNROpnev5rpTuTMB>
X-ME-Proxy-Cause: dmFkZTEPZCjCm6tnmUl/Qfyy5AxstKk6Ww/31dzJkFoTP6ueWMjr9TiKXLBVlIyPa6u8aQ
    jCZ5OKAtbwrLwL9tUa48ukinMkU7l7nOESEpYAt8GgEAPhaEtIvmK902YsRWOLAi/EG6nt
    k8cbAtaJUU4YaK34p+pEymFuQGFjyJ5tSMYq4VRmJ+NcLA0r9jiA7gZx62UmPYeTwccS+T
    v6vU7w8/7WQVG6ECqsd8VPeJj3n2Md0eSF9ZsgoQ0Fzlc/iPHIsuOHevOPc3Gr6zpJ6nRP
    z6QnNX90kf+wuCT/QDfzv5sw+6dDhIjj/mpRnCr0tc+AQv8GiQf5Vvmw+jn8+dSJ5jS0kz
    rHRNhWy21uJU/cGilDefh9JlLTIcRgYmSTr3rsngvAWmUDF3pnwvrlBbeMu8aEtPuLY6IS
    EBq7gX9PZsg5AfQlANm/3KqoISplAnvMXOZyqSX7EVcOSUChXM+pVnvS8zNeRDX4PAK5i7
    2iX0gDg6B1eb9FggN7TMwr7CUlLAnT9xBENC7j+rstKLLApuT5UdugjRaRcs8kTLiIrpxZ
    iExLgOopcMC9//9cKP1RSlUFuF+BH5Q7PSQ89iHBpbimDBewx+jFcVihGuRbdbx/TrSeK0
    apyqjks9+3sSwxQ63tRmCtptVO0VDH4RBOio8V5sk/hNEAddCtQ0lBHq9L7w
X-ME-Proxy: <xmx:idAbau93OigMsc8d98bnNamcJ3WbsZTnO2R6vw2cjHkCOLWKrXvYBQ>
    <xmx:idAbaluLKN7ujvm2wDC4Du6gsUjsUUuOkAVXBnGzMsSgqCpYx7xD6w>
    <xmx:idAbapAlRdS4J8QlAX0eXu2lskmrhwpwkd0hZWMNdJifkAV2aAq4-A>
    <xmx:idAbalVsENvWf7apADShqrGPTN3iYb9LOeqqLvJX9n6qckagkxnXNg>
    <xmx:idAbas77TYtQAlpi-3MPYFDJ1aN3F8shTVHsnkKAJVQHLFqPQK4HEFci>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3852E216008A; Sun, 31 May 2026 02:09:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ0hmDZD3yyk
Date: Sun, 31 May 2026 07:08:51 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, "Sam James" <sam@gentoo.org>
Message-Id: <c0440c70-87ee-4ac1-9c1a-52afa8530985@app.fastmail.com>
In-Reply-To: <ahvIyXWD_5RQk0eT@gondor.apana.org.au>
References: <ahvIyXWD_5RQk0eT@gondor.apana.org.au>
Subject: Re: [v2 PATCH] builtin: Fix octal escapes in dollar-single-quotes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026, at 6:36 AM, Herbert Xu wrote:
> Kerin Millar <kfm@plushkava.net> wrote:
>> 
>> The test suite of the gentoo-functions project recently uncovered a bug whereby octal sequences within dollar-single-quotes are evaluated as internal control characters, resulting in faulty decoding at best, and segmentation faults at worse. The attached patch rectifies this bug.
>
> Thanks for the patch.
>
> While looking at this I found out that the logic for \x is broken
> as it always produces a multi-byte character even for the value of
> \x81.
>
> So here is a rolled-up patch which fixes both problems.
>
> ---8<---
> From: Kerin Millar <kfm@plushkava.net>
>
> The test suite of gentoo-functions recently uncovered a bug concerning
> the handling of octal escape sequences within dollar-single-quotes.
> Here is a reproducer:
>
>     $ dash -c "x=\$'\\201'; printf '%s' \"\$x\"" | od -An -tx1
>     88
>
> That is, despite the input being 0x81, the output is 0x88. Indeed, any
> input between 0x81..0x88 is adversely affected and some - such as 0x82 -
> induce a segfault.
>
> I noticed the following macros in src/parser.h:
>
>     #define CTL_FIRST -127 /* first 'special' character */
>     #define CTLESC    -127 /* escape next character */
>     #define CTL_LAST  -120 /* last 'special' character */
>
> Reinterpreted as unsigned char, the CTL_FIRST..CTL_LAST range maps
> exactly to 0x81..0x88:
>
>     $ perl -e 'printf "%x\0", $_ & 0xFF for -127..-120' | xargs -0
>     81 82 83 84 85 86 87 88
>
> From this, I was able to deduce that all of these bytes must be preceded
> by CTLESC in order to be taken literally. Make it so.
>
> Link: 
> https://gitweb.gentoo.org/proj/gentoo-functions.git/commit/?id=947090fb7704
> Signed-off-by: Kerin Millar <kfm@plushkava.net>
>
> The escape should also be applied to \x sequences.  In fact \x81
> was totally broken as it produced a multi-byte character.  Fix this
> by merging these two code paths.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/src/bltin/printf.c b/src/bltin/printf.c
> index 106aecd..671e781 100644
> --- a/src/bltin/printf.c
> +++ b/src/bltin/printf.c
> @@ -332,6 +332,7 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
>  	char *out = out0;
>  	char *str = str0;
>  	unsigned value;
> +	int och;
>  	int ch;
> 
>  	ch = *str;
> @@ -359,12 +360,18 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
>  		}
> 
>  		str--;
> +
> +check_value:
> +		if (mbchar && (signed char)value >= CTL_FIRST &&
> +		    (signed char)value <= CTL_LAST)
> +			USTPUTC(CTLESC, out);
>  		break;
> 
>  	case 'x':
>  		ch = 2;
> 
>  hex:
> +		och = ch;
>  		value = 0;
>  		do {
>  			int c = *++str;
> @@ -391,6 +398,9 @@ hex:
>  		if (value < 0x80)
>  			break;
> 
> +		if (och <= 2)
> +			goto check_value;
> +
>  		if (value < 0x110000) {
>  			int mboff = (mbchar - 1) * 2;
>  			unsigned uni = value;

Thank you, that looks great. It occurs to me that I should be able to incorporate some sort of test case for this because, without the revised patch, this happens:

$ printf %s $'\x81' | wc -c
2

-- 
Kerin Millar
