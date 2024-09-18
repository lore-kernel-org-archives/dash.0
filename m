Received: from mta-outp-ksl-1.case.edu (mta-outp-ksl-1.case.edu [129.22.103.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A441C245A
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671374; cv=pass; b=gpaK58+2BrSB6Rq75tczMVccZy1LIHS+PHbda1wV3sD+yOex1yUhDzrBuM2zR5QpKXe4RBgyLvjc84csMKJy1UDk9DCvEK2EhwYFq/D4uxtzHQ19Yh1v2BvQmSQczvUGo2W06xlN25v8829chak0opzQougJ7T8NEgqe23EYBrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671374; c=relaxed/simple;
	bh=ti1UcDAP2oR8GQWHqvTHoBLj38TEN/ZmJfcW3RsxZWo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=exgaDLwbN1VE7V1/ZpIVmuffWUDB3sm8POPD6jmm+btrYVri4gcLRhOhdWoIeYOwZzXpp/LGKHuJzF9c8K4QRd8uwsSyLIW35itbY9YGwabajItBdR3oTsQv6Xp+b8Vh/sOqMaP+lq+psqtWyyR5UeXHESLNzuc61jrdWwP6e40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=AyyVkN6/; arc=pass smtp.client-ip=129.22.103.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="AyyVkN6/"
Authentication-Results: mta-outp-ksl-1;
       spf=pass (mta-outp-ksl-1.case.edu: domain of case.edu designates 209.85.166.199 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-ksl-1.case.edu C9FF0529
Authentication-Results: mta-outp-ksl-1; arc=none smtp.remote-ip=129.22.103.228
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1726670919; cv=none;
	b=jw32TzjqjapXI6RVInGDYFSP+DD7/kGGhLwjXcg1V38CvJzKKK5Lw7dMq6oIG4xJpO1C+2mGTMxiG12SFfXA3MvWBxYg6ro+GMP/m7Qr8/f6d8v7qxKH03SlpmGyxJAGdigl02b8U0SLgOGrGGBgmE+8GyHvEfNc4xKTEWKceVqR+EO1/qlZAW9JZlb5V1qlFPdJQdWEZjyzPTr5GvSu12KAtnud62/hs7NM2yU7N44CM1pdpQAxvu79ippnEWtdXYZe9WZFDDcySzEF0XZtvq2Kytqf49BIX8b+yjZm2xavPf3oGMr+aYAf39+5WGqP8+fnQmE2m1gNROCG7CVKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1726670919; c=relaxed/simple;
	bh=ti1UcDAP2oR8GQWHqvTHoBLj38TEN/ZmJfcW3RsxZWo=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=EUNnm2IH74SUaErXgNQVIxe7ypmV4faXgSJpn03YA68bX3xlQvo/1vsrRIElA/oqWXiJbCzA+fYS2U3YOeV8XLLLGbo0PFliaTHdvQ1OOdWerneQkDyv5pN7yxKajr4xylpdwQq2jJFFwH6GaYsVsmbKFaQuCX9yZ0idfUNSQJYLv2qqntmNNY1UxQEszdJE6gpDSzaGy3G9Q8JDs+bsQ29MNWEC20XorE0/cITKFZBXyDD2lKp3X576x/Fg08HnE8wt9vkVe9B1q9JQoO5vyXn+TrSVYY+jsM3YiPGOp4A038WLKbBwSG5G1koor0RNmContZfjnLZwLpejyo3rGg==
ARC-Authentication-Results: i=1; mta-outp-ksl-1; spf=pass (mta-outp-ksl-1.case.edu: domain of case.edu designates 209.85.166.199 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-ksl-1.case.edu: domain of case.edu designates 209.85.166.199 as permitted sender) client-ip=209.85.166.199
Received: from mpv-out-ksl-1.case.edu (mpv-out-ksl-1.case.edu [129.22.103.228])
	by mta-outp-ksl-1.case.edu (Postfix) with ESMTPS id C9FF0529
	for <dash@vger.kernel.org>; Wed, 18 Sep 2024 10:48:39 -0400 (EDT)
Received: from mpv-local-cfd-1.case.edu (EHLO mpv-local-cfd-1.case.edu) ([129.22.103.203])
	by mpv-out-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id COB56259;
	Wed, 18 Sep 2024 10:48:39 -0400 (EDT)
Received: from mail-il1-f199.google.com (EHLO mail-il1-f199.google.com) ([209.85.166.199])
	by mpv-local-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DVB45955;
	Wed, 18 Sep 2024 10:48:38 -0400 (EDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f510b3f81so8597475ab.0
        for <dash@vger.kernel.org>; Wed, 18 Sep 2024 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1726670915; x=1727275715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p10qzXtblVlM803o9Vcm2XPYVmc2+qmwshu0IqnFI+I=;
        b=AyyVkN6/aGRknImw6yiDpNk3PMdsl7EHSaRz4/bkvYEqPoPQKac2cClfING7gCgtlX
         BCMUxo41lv56tzjSxJq55FUxVj/qcrkq4B/gdSU0fANGByvBsqUw0yUTXL0V3lBNYUAA
         czHIeRDdTgptb5GUdc0qqNHvCrzdMMOzMuibBnd7u4duLAftPiudQf0grErfyFCC8Scc
         B0KGi+1XVOWjOr3+BEqri2J9jsuytTOQzCf8mvvKcU3y3bdpXggTUz6xc2MO/3CCO+QS
         TgLsikn5C30IG1lhdvv2l271L3n7avEmFMGnQ493tFjKNw9yXfOEiirFrLDv4p5ztpa8
         Nb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726670915; x=1727275715;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p10qzXtblVlM803o9Vcm2XPYVmc2+qmwshu0IqnFI+I=;
        b=qX5qnyYfDZ+kcGwDa8d0pVe5gYHzK3xcDHhfjTB8pq768YMqRhTj9IKeJK6XUNUBSc
         acxIPh2qTAvgeQHhuAVF47UkPUJQ1Xv7t2HkwZtxSA6cXl3AbvKnXtpnk1MVZgrlBgpS
         hMu5x/00I+pAGyQ7PthFkdsSMUk20EI1XNKC2ualPoBpeTOvcvHBeJs3UMQsq+Ecl5dn
         6uE2Bcb/YDXQ64GNBXFHGIL3r0R7ss9Iiq4iF6C+h/kJI94ElgVRUodt+KuStPz5My+g
         j06M172c0/aqYsPgUDmEXgM+HTMdfugy1F2EH2Mic3RpVZRV5reOObi1f5GMR2JgVBY3
         aKMg==
X-Forwarded-Encrypted: i=1; AJvYcCVhSVSJ+yBkVZu3KW0fjpn3yMoyTCDA6YBLR0QBk2k2nuvWnhP6Qy/YI18hyWux5M18ccCo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl6Xx9ZvfztiunVdly6WieCQLZIgtVcy3wl2J5IdIdjQAe+d21
	GMstr0dEqvw/tDde1dCtNR2pQf0ZfOr5Fqn4pQ8DnN4HhCKAJzFD4Fv1twKD4t1mjHjE7HqZ2R0
	Vvwc0TMelKKt+RIOUeuwtI7PwnHJcIo+KkQDIgAOCXA4ek/+TrmoL
X-Received: by 2002:a05:6e02:12cc:b0:3a0:a4ac:ee2b with SMTP id e9e14a558f8ab-3a0a4acef90mr79879465ab.7.1726670915133;
        Wed, 18 Sep 2024 07:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6AI6GJy2dOYRegTZ85deiP0yfot90td4SEywbA7odj1Hl9OXBMCasckubCSRwYCyJSU7yyA==
X-Received: by 2002:a05:6e02:12cc:b0:3a0:a4ac:ee2b with SMTP id e9e14a558f8ab-3a0a4acef90mr79879385ab.7.1726670914826;
        Wed, 18 Sep 2024 07:48:34 -0700 (PDT)
Received: from [129.22.8.211] (caleb.INS.CWRU.Edu. [129.22.8.211])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed34d40sm2475875173.145.2024.09.18.07.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 07:48:34 -0700 (PDT)
Message-ID: <b72edbc9-d336-4391-98a9-37c670afa435@case.edu>
Date: Wed, 18 Sep 2024 10:48:32 -0400
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu
Subject: Re: Question on $IFS related differences (Was: Question on $@ vs
 $@$@)
Content-Language: en-US
To: =?UTF-8?B?T8SfdXo=?= <oguzismailuysal@gmail.com>, dash@vger.kernel.org,
        busybox@busybox.net, bug-bash@gnu.org,
        Steffen Nurpmeso <steffen@sdaoden.eu>
References: <20240918011443.AVR6sOQ3@steffen%sdaoden.eu>
 <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
From: Chet Ramey <chet.ramey@case.edu>
Autocrypt: addr=chet.ramey@case.edu; keydata=
 xsDiBEEOsGwRBACFa0A1oa71HSZLWxAx0svXzhOZNQZOzqHmSuGOG92jIpQpr8DpvgRh40Yp
 AwdcXb8QG1J5yGAKeevNE1zCFaA725vGSdHUyypHouV0xoWwukYO6qlyyX+2BZU+okBUqoWQ
 koWxiYaCSfzB2Ln7pmdys1fJhcgBKf3VjWCjd2XJTwCgoFJOwyBFJdugjfwjSoRSwDOIMf0D
 /iQKqlWhIO1LGpMrGX0il0/x4zj0NAcSwAk7LaPZbN4UPjn5pqGEHBlf1+xDDQCkAoZ/VqES
 GZragl4VqJfxBr29Ag0UDvNbUbXoxQsARdero1M8GiAIRc50hj7HXFoERwenbNDJL86GPLAQ
 OTGOCa4W2o29nFfFjQrsrrYHzVtyA/9oyKvTeEMJ7NA3VJdWcmn7gOu0FxEmSNhSoV1T4vP2
 1Wf7f5niCCRKQLNyUy0wEApQi4tSysdz+AbgAc0b/bHYVzIf2uO2lIEZQNNt+3g2bmXgloWm
 W5fsm/di50Gm1l1Na63d3RZ00SeFQos6WEwLUHEB0yp6KXluXLLIZitEJM0gQ2hldCBSYW1l
 eSA8Y2hldC5yYW1leUBjYXNlLmVkdT7CYQQTEQIAIQIbAwYLCQgHAwIDFQIDAxYCAQIeAQIX
 gAUCRX3FIgIZAQAKCRC7WGnwZOp0q069AKCNDRn+zzN/AHbaynls/Lvq1kH/RQCgkLvF8bDs
 maUHSxSIPqzlGuKWDxbOwE0EQQ6wbxAEAJCukwDigRDPhAuI+lf+6P64lWanIFOXIndqhvU1
 3cDbQ/Wt5LwPzm2QTvd7F+fcHOgZ8KOFScbDpjJaRqwIybMTcIN0B2pBLX/C10W1aY+cUrXZ
 gXUGVISEMmpaP9v02auToo7XXVEHC+XLO9IU7/xaU98FL69l6/K4xeNSBRM/AAMHA/wNAmRB
 pcyK0+VggZ5esQaIP/LyolAm2qwcmrd3dZi+g24s7yjV0EUwvRP7xHRDQFgkAo6++QbuecU/
 J90lxrVnQwucZmfz9zgWDkT/MpfB/CNRSKLFjhYq2yHmHWT6vEjw9Ry/hF6Pc0oh1a62USdf
 aKAiim0nVxxQmPmiRvtCmcJJBBgRAgAJBQJBDrBvAhsMAAoJELtYafBk6nSr43AAn2ZZFQg8
 Gs/zUzvXMt7evaFqVTzcAJ0cHtKpP1i/4H4R9+OsYeQdxxWxTQ==
In-Reply-To: <CAH7i3Lq9xQnnkAO7cd5XZEsV4jY+Va6uWqjw3yaMi=A3mdh83g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mirapoint-Received-SPF: 209.85.166.199 mail-il1-f199.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.203 mpv-local-cfd-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=9/90, host=mpv-out-ksl-1.case.edu
X-Junkmail-PrAS-Raw: score=9/90,
	refid=2.7.2:2023.6.26.145126:17:9.112,
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
		__MULTIPLE_RCPTS_TO_X2,
		__TO_NAME,
		__TO_NAME_DIFF_FROM_ACC,
		__MULTIPLE_RCPTS_TO_X5,
		__HAS_REFERENCES,
		__HAS_FROM,
		FROM_EDU_TLD,
		__IN_REP_TO,
		__CT,
		__CT_TEXT_PLAIN,
		__MIME_BOUND_CHARSET,
		__CTE,
		CTE_8BIT,
		__REPLYTO_SAMEAS_FROM_ADDY,
		__REPLYTO_SAMEAS_FROM_ACC,
		__RCVD_FROM_DOMAIN,
		__FROM_DOMAIN_IN_ANY_CC1,
		__FROM_DOMAIN_IN_ANY_CC2,
		__HEADER_ORDER_FROM,
		__RCPT_DOMAIN_NOT_TO,
		__REPLYTO_SAMEAS_FROM_DOMAIN,
		__DKIM_ALIGNS_1,
		__DKIM_ALIGNS_2,
		__FUR_HEADER,
		__ANY_URI,
		__URI_MAILTO,
		__HTTPS_URI,
		__URI_WITH_PATH,
		EU_TLD,
		__URI_ENDS_IN_SLASH,
		[TRUNCATED],
	so=2010-03-03 19:42:08,
	dmn=2016-08-03-0138

On 9/18/24 1:05 AM, Oğuz wrote:
> On Wed, Sep 18, 2024 at 4:19 AM Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
>>
> 
> It boils down to this:
> 
>    f(){ echo $#;}; set "" "" ""; IFS=x; f $*
> 
> bash, NetBSD and FreeBSD sh, and ksh88 all agree and print 2. pdksh
> prints 3 but mksh and oksh print 1. dash, ksh93, yash, and zsh print
> 0.

It's an implementation difference.

The shells that print `0' treat the `may' as `shall' in this sentence from

https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_05_02

"When the expansion occurs in a context where field splitting will be
performed, any empty fields may be discarded and each of the non-empty
fields shall be further split as described in 2.6.5 Field Splitting."

So they immediately expand the $* to nothing.

The shells that print `2' don't immediately discard the empty fields and
separate them with the first character of IFS. After quote removal and
removing the empty fields, since the individual words in $* are subject
to additional expansion, you're left with `xx'. When you split that,
you get two empty fields.

I'm not sure what's going on with the shells that print `1' unless they
somehow don't use the first character of IFS to separate the arguments
and let multiple sequential delimiters terminate the first field.

I assume that pdksh just expands each positional parameter to a quoted
empty string and passes them all to f.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/
