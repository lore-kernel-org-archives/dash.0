Received: from mta-outp-ksl-1.case.edu (mta-outp-ksl-1.case.edu [129.22.103.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131EE1B3F20
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651433; cv=pass; b=PjEMpoLu1Q3BKLgB5vJlqpaHHm/UqgH0n3HR/MfcY+ME/Nq1Rwnhrz+A2iUkcGsqk7pA0vw8XSxWK2e43NEaLVg0fgRaH2WofYUyq7/s1h9+YUepyqpsgpZw4IFtpS+YocI+ut+WFY9LpgEDbzKPBvqfKQWmP1Xo2U4P9kJgHPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651433; c=relaxed/simple;
	bh=/Sl09tlIIFbVv8kARZ4vV/ThC/5SKk92Mc04zgzqk+o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=htJtV2If7Y2bMUMZmcUijRApjcKiiRuqM457kn7Wnhzqn4IBTyvQg8Ctwekdwp4f1zpzStXH/CsXMUGBiqk/hxcYe42vYFNc3SOt+dBEtunFZZd/ZG3/LzTeNqfZcGQHgQHqo7DJhRV8wPuJY0rMobHjzxqZ1CIqALgZ5Xde9RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=RWU0+kTm; arc=pass smtp.client-ip=129.22.103.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="RWU0+kTm"
Authentication-Results: mta-outp-ksl-1;
       spf=pass (mta-outp-ksl-1.case.edu: domain of case.edu designates 209.85.128.198 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-ksl-1.case.edu 2E645136B
Authentication-Results: mta-outp-ksl-1; arc=none smtp.remote-ip=129.22.103.228
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1723651054; cv=none;
	b=l2H7sadZw8JL0lotwbKwUKPde3g6/qMYfRgCEA0FxtjIjVuSb31hmUyOyhWQe/vzF2Ay0IXp8S2nf1jgHCAQPnH8pcbCCHMsS980iKj1RFQoLHRMR50Wr87WeosBj8npMoPScr3SbXcrsGWVVpBb3QKsR+3KN9gUXtQohtlXF/vR+HNceFr0UWgcspD4iB16MjcXRdOrnEB64X7AmEXAV8vLR+J9HAIm2omDUUDlP+YUZ9s7637gux3cXc9y/2ump6tVexsMIP+2megbGdZB+3NP+/nO51EyzL0C2aASCQBS3UpPm01ynsPLIRJOdT34n6zR94kL1+8bwzICYZyzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1723651054; c=relaxed/simple;
	bh=/Sl09tlIIFbVv8kARZ4vV/ThC/5SKk92Mc04zgzqk+o=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=3wKJ/QOiUiZUT/7fSa+Bfv7owt4+aslTyFRZRSQzxRHfHTYrz0ADcWBLe5/IkYjAtTVewbjVPTbMg+/uk9Qt1ac9Ptarl5Itmx54UPTi5KaFIrqPYaVDI0EmiOFydL03tvbclJ11bQo9xpCmWDhtfbOiEsfdrom7Jbc6vo5DoNKHUizys+XWCrlWA2sB/nTngKFse3qjVHfq0PVAeWExHsmqzCVr1xNsRNZqFyiEfTFz6VygktbY589U/JpGKh/cEd8OTMujdUi7a7EnG0oW6yyXExeTE/FbTnNDTFl1uqf7grNuRKIyq7AjPolg99P+mDare4/yPE/Aq+F71FFLTA==
ARC-Authentication-Results: i=1; mta-outp-ksl-1; spf=pass (mta-outp-ksl-1.case.edu: domain of case.edu designates 209.85.128.198 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-ksl-1.case.edu: domain of case.edu designates 209.85.128.198 as permitted sender) client-ip=209.85.128.198
Received: from mpv-out-ksl-1.case.edu (mpv-out-ksl-1.CWRU.Edu [129.22.103.228])
	by mta-outp-ksl-1.case.edu (Postfix) with ESMTPS id 2E645136B
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 11:57:34 -0400 (EDT)
Received: from mpv-local-cfd-1.CWRU.Edu (EHLO mpv-local-cfd-1.case.edu) ([129.22.103.203])
	by mpv-out-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id CMC36694;
	Wed, 14 Aug 2024 11:57:33 -0400 (EDT)
Received: from mail-yw1-f198.google.com (EHLO mail-yw1-f198.google.com) ([209.85.128.198])
	by mpv-local-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DTG61206;
	Wed, 14 Aug 2024 11:57:33 -0400 (EDT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6ad9ffa0d77so1301987b3.2
        for <dash@vger.kernel.org>; Wed, 14 Aug 2024 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1723651051; x=1724255851; darn=vger.kernel.org;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ejGjDOKaXhwPY/S4G0BhHwBcwfSQYYm7CwUSNK+9f+Q=;
        b=RWU0+kTmafljrg/F4t7d5cdBRoeCe5fFbc+L4AZvomQBu3DvPz8GutaPIgIO4lkadZ
         ztRsUbeJsOTIZ9IAYP8dIwxSa0S0MUD1o/Uccyk77QOF1XJPa5xXYxrxG7Tqk+Xlzre2
         7/1Tz4rrY8bpMIUAhCICdjOtFWyhu+fFoUMxfRhin7vcPonlIkdh2NCfc14jp5jqb0yq
         Bak8ygahYTf2Dvt5paz4ZVVKMPng0OxvStVjafKVpvODURzYL2LMilUr2Q/CTcbhbwB6
         gnwYIJrmPApzxjaxUbNO1qRzLakaI6+6R8gjyCyRF4AUmmIZ2lvgByu338W4l3lbR4jw
         ID1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651051; x=1724255851;
        h=in-reply-to:organization:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejGjDOKaXhwPY/S4G0BhHwBcwfSQYYm7CwUSNK+9f+Q=;
        b=l2NR/IFKUQ8mwCX+RXWQQj9Zh4/lvQhSIEjZ0q2oPLiE2E+s8MdwwYNeSfso7uGwLq
         t7tDRn6ZUC0T47WeovNzaW9QQGkpSlJp8kfx3p/4TlI/beRJktwDi9Hin+RLYcciuuoL
         KP5xaWNlJgHiCtAI2W3lJF5O5Hc5ud4KyU84EQu7n3rqU7ZoGaderTEyTxik6OuXlduE
         WDN3o2vD+8Ml9fRiNqzlVsyDPeNd+cMiCY46RKvqik4Y8MUnHN3zNm/isT9Prk0jzz11
         pB6IhjDB1cRxAlrbQ9dBYz3OrTqTinBefRb+W2IsKl0nqFTPXGWJDp6JMULg+ZsFIkRI
         aUsw==
X-Gm-Message-State: AOJu0YzuRsZ8o5hHbcBjyQA9H4EfwlYpSHEy2w+trZynMBAHDdP4JKz0
	DjqQ5ABZRk78SiUY6SAWLZNPZqdhsZ6T0/ObMt3yqqXFZHurK+BzAcZrp3F9Dwq9VDcLhURaquM
	Tp8nDf915GyHRnCx25WOpKwqIXss0mGkd2KpWF4H7J1NL75xCu5LuvlguJcrd
X-Received: by 2002:a05:6902:90d:b0:e11:6348:5d86 with SMTP id 3f1490d57ef6-e11634860a6mr1881785276.11.1723651051425;
        Wed, 14 Aug 2024 08:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD+UVMJ0Sg7kd95BfdmA/TbX4L+s36pJgw6ZQIpOtmcU0wt66lMCG4sX93h+nnQzosh3Kqog==
X-Received: by 2002:a05:6902:90d:b0:e11:6348:5d86 with SMTP id 3f1490d57ef6-e11634860a6mr1881752276.11.1723651050994;
        Wed, 14 Aug 2024 08:57:30 -0700 (PDT)
Received: from [192.168.0.244] (syn-098-027-227-244.res.spectrum.com. [98.27.227.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e31802sm45058196d6.82.2024.08.14.08.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:57:30 -0700 (PDT)
Message-ID: <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>
Date: Wed, 14 Aug 2024 11:57:28 -0400
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu
Subject: Re: Question on $@ vs $@$@
Content-Language: en-US
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
        Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
From: Chet Ramey <chet.ramey@case.edu>
Autocrypt: addr=chet.ramey@case.edu; keydata=
 xsDiBEEOsGwRBACFa0A1oa71HSZLWxAx0svXzhOZNQZOzqHmSuGOG92jIpQpr8DpvgRh40Yp
 AwdcXb8QG1J5yGAKeevNE1zCFaA725vGSdHUyypHouV0xoWwukYO6qlyyX+2BZU+okBUqoWQ
 koWxiYaCSfzB2Ln7pmdys1fJhcgBKf3VjWCjd2XJTwCgoFJOwyBFJdugjfwjSoRSwDOIMf0D
 /iQKqlWhIO1LGpMrGX0il0/x4zj0NAcSwAk7LaPZbN4UPjn5pqGEHBlf1+xDDQCkAoZ/VqES
 GZragl4VqJfxBr29Ag0UDvNbUbXoxQsARdero1M8GiAIRc50hj7HXFoERwenbNDJL86GPLAQ
 OTGOCa4W2o29nFfFjQrsrrYHzVtyA/9oyKvTeEMJ7NA3VJdWcmn7gOu0FxEmSNhSoV1T4vP2
 1Wf7f5niCCRKQLNyUy0wEApQi4tSysdz+AbgAc0b/bHYVzIf2uO2lIEZQNNt+3g2bmXgloWm
 W5fsm/di50Gm1l1Na63d3RZ00SeFQos6WEwLUHEB0yp6KXluXLLIZitEJM0wQ2hldCBSYW1l
 eSAoQ2FzZSBzdGFuZGFyZCkgPGNoZXQucmFtZXlAY2FzZS5lZHU+wl8EExECAB8FAkPi19EC
 GwMHCwkIBwMCAQMVAgMDFgIBAh4BAheAAAoJELtYafBk6nSrelkAn31Gsuib7GcCZHbv5L5t
 VKYR9LklAJ4hzUHKA49Z0QXR+qCb80osIcmPSc7ATQRBDrBvEAQAkK6TAOKBEM+EC4j6V/7o
 /riVZqcgU5cid2qG9TXdwNtD9a3kvA/ObZBO93sX59wc6Bnwo4VJxsOmMlpGrAjJsxNwg3QH
 akEtf8LXRbVpj5xStdmBdQZUhIQyalo/2/TZq5OijtddUQcL5cs70hTv/FpT3wUvr2Xr8rjF
 41IFEz8AAwcD/A0CZEGlzIrT5WCBnl6xBog/8vKiUCbarByat3d1mL6DbizvKNXQRTC9E/vE
 dENAWCQCjr75Bu55xT8n3SXGtWdDC5xmZ/P3OBYORP8yl8H8I1FIosWOFirbIeYdZPq8SPD1
 HL+EXo9zSiHVrrZRJ19ooCKKbSdXHFCY+aJG+0KZwkkEGBECAAkFAkEOsG8CGwwACgkQu1hp
 8GTqdKvjcACfZlkVCDwaz/NTO9cy3t69oWpVPNwAnRwe0qk/WL/gfhH346xh5B3HFbFN
Organization: ITS, Case Western Reserve University
In-Reply-To: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------88NwXXxa9HPpxXk3i0YeDSVt"
X-Mirapoint-Received-SPF: 209.85.128.198 mail-yw1-f198.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.203 mpv-local-cfd-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=8/90, host=mpv-out-ksl-1.case.edu
X-Junkmail-PrAS-Raw: score=8/90,
	refid=2.7.2:2023.6.26.145126:17:8.707,
	ip=,
	rules=__YOUTUBE_RCVD,
		DKIM_SIGNATURE,
		__X_GOOGLE_DKIM_SIGNATURE,
		__X_GM_MESSAGE_STATE,
		__X_GOOGLE_SMTP_SOURCE,
		__HAS_MSGID,
		__SANE_MSGID,
		__MSGID_HEX_844412,
		DATE_TZ_NA,
		__MIME_VERSION,
		__USER_AGENT,
		__MOZILLA_USER_AGENT,
		__HAS_REPLYTO,
		__HAS_CC_HDR,
		__SUBJ_REPLY,
		__BOUNCE_CHALLENGE_SUBJ,
		__BOUNCE_NDR_SUBJ_EXEMPT,
		__TO_MALFORMED_2,
		__TO_NO_NAME,
		__MULTIPLE_RCPTS_TO_X2,
		__TO_NAME,
		__TO_NAME_DIFF_FROM_ACC,
		__HAS_REFERENCES,
		__HAS_FROM,
		FROM_EDU_TLD,
		__IN_REP_TO,
		__CT,
		__CTYPE_HAS_BOUNDARY,
		__CTYPE_MULTIPART,
		__BAT_BOUNDARY,
		__REPLYTO_SAMEAS_FROM_ADDY,
		__REPLYTO_SAMEAS_FROM_ACC,
		__FROM_DOMAIN_IN_ANY_CC1,
		__FROM_DOMAIN_IN_ANY_CC2,
		__HEADER_ORDER_FROM,
		__RCPT_DOMAIN_NOT_TO,
		__REPLYTO_SAMEAS_FROM_DOMAIN,
		__DKIM_ALIGNS_1,
		__DKIM_ALIGNS_2,
		__FUR_HEADER,
		__MIME_TEXT_P2,
		__HAS_ATTACHMENT1,
		__ATTACHMENT_NOT_IMG,
		__ANY_URI,
		__URI_MAILTO,
		__URI_WITH_PATH,
		__URI_ENDS_IN_SLASH,
		[TRUNCATED],
	so=2010-03-03 19:42:08,
	dmn=2016-08-03-0138

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------88NwXXxa9HPpxXk3i0YeDSVt
Content-Type: multipart/mixed; boundary="------------hZ2cGNtkTxUqwrwH1uOWdT9a";
 protected-headers="v1"
From: Chet Ramey <chet.ramey@case.edu>
Reply-To: chet.ramey@case.edu
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: chet.ramey@case.edu
Message-ID: <1bba673e-5ab9-4263-9d88-124854793b4b@case.edu>
Subject: Re: Question on $@ vs $@$@
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
In-Reply-To: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>

--------------hZ2cGNtkTxUqwrwH1uOWdT9a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 8:45 PM, Steffen Nurpmeso wrote:
> Hello.
> 
> I include bug-bash even though i think bash is correct, but there
> lots of people of expertise are listening, so, thus.
> Sorry for cross-posting, nonetheless.
> Given this snippet (twox() without argument it is)
> 
>    one() { echo "$# 1<$1>"; }
>    two() { one "$@"; }
>    twox() { one "$@$@"; }
>    two
>    two x
>    twox
>    twox x
> 
> i get
> 
>    $ dash shbug.sh
>    0 1<>
>    1 1<x>
>    1 1<>
>    1 1<xx>
> 
>    #?0|kent:tmp$ busybox.static sh shbug.sh
>    0 1<>
>    1 1<x>
>    1 1<>
>    1 1<xx>
> 
>    #?0|kent:tmp$ bash shbug.sh
>    0 1<>
>    1 1<x>
>    0 1<>
>    1 1<xx>

When, as in this case, the result would be split if the double quotes
weren't there, $@ within double quotes expands to nothing if there are
no positional parameters, no matter how many times it appears.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/

--------------hZ2cGNtkTxUqwrwH1uOWdT9a--

--------------88NwXXxa9HPpxXk3i0YeDSVt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQR8ATX7CIqvbGbGULm7WGnwZOp0qwUCZrzT6AUDAAAAAAAKCRC7WGnwZOp0qxGM
AJ9xI8awcWnrdeTK/uxk0d1W3YWxnQCgkU5bZQDD3lfp9iYH/JsCR1ERTYs=
=84CG
-----END PGP SIGNATURE-----

--------------88NwXXxa9HPpxXk3i0YeDSVt--
