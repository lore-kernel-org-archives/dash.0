Received: from mta-outp-ksl-2.case.edu (mta-outp-ksl-2.case.edu [129.22.103.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9F3164D6
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=129.22.103.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129494; cv=pass; b=TAFl7pcLDyHMbJWfxA7R8i1gqHB9pxqdqRCc3mZZZhvOkWqki2eMwEnnC7V9KIqdkOpi1Bswt66BoNfl/HEM9k+YpEM7mNTzYrZC+13bh0fMw3V1LFznC/V+WQXbk/A3490QYB38kfyOB0mYdhsi7RNnkJ8mI0qnbwHqd7tpP0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129494; c=relaxed/simple;
	bh=33X3xwj+f2cqxNSAtjQCdbP8O+i1+gDBi8WXgQbZ3v4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k+/nQoHwAgK9+5vcA+EcKJ7G1MC9V5KTyhlCpljs2Tb8LyCWFuOOm7paqqLWy7Wv+dU4CLZ9bpIkLS5uRD4AXIzpwU2qEVYNWEeJ063zziZbnp7zpMQarFsjqfQ30uifXadkGxMH3JK1Oz2oWXiujg0N+skQ9xCodJXW5JXg/XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu; spf=pass smtp.mailfrom=case.edu; dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b=OXU2goCd; arc=pass smtp.client-ip=129.22.103.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=case.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=case.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=case.edu header.i=@case.edu header.b="OXU2goCd"
Authentication-Results: mta-outp-ksl-2;
       spf=pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.219.70 as permitted sender) smtp.mailfrom=case.edu ;
       dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case;
       dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu;
ARC-Filter: OpenARC Filter v1.0.0 mta-outp-ksl-2.case.edu 418353101C64
Authentication-Results: mta-outp-ksl-2; arc=none smtp.remote-ip=129.22.103.196
ARC-Seal: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta; t=1770129156; cv=none;
	b=IP1ZdRi2CK/c3GpBj+7oa++r5U6UXhQnUQdc7VUSOw4JktNOnj4uUEpQvSGrD/asoR8a2UFLdpM9PpLG7xYS8baRGYIgSSxiCk7O8NyM+7R+uQGKkMjrqbbuCnQF5rSLV0WWxKtSmTRyvhlh3pcP+RKwt2fJoV8+8OQLee1DKykjLrljRH8KBlzNLoetjmraFqC44izRC7Uby8vQ92Dba3ngdLPz+eBtAzbgfG2lx1s6kbGp5X2hyLPhbFCFxp2H+DVnLTttZMXuXnb6Wmjkx3cFJo0Kd9c7Z2rvzbigD4XBUB5Jgi/fbKxbDqLSkAV8+dU+J9X0jIPpCGjcOs5E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=case.edu; s=cwru-mta;
	t=1770129156; c=relaxed/simple;
	bh=33X3xwj+f2cqxNSAtjQCdbP8O+i1+gDBi8WXgQbZ3v4=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From:to:
	 subject:message-id:date:from:mime-version:dkim-signature; b=UnYLlz8Ss7/N+zZEzg2QoloD61xcTI4jcLiAt91XSHobPeXwxo0Fdqra+lTWJxCe7XSQwmXVA2n77O49jNmxHTjPshx4fRNztg98ok5YVhLMASW6pFAI2YdcC2DwvjGec4RiluOdAZubeRRdv+AhnZk7bQCYmdBcyEMkQVye4b9ja+Ff1+VWpzVEz950uZMcMMYRy+Zx7ulRo0QKqhI9KXxTCvU5m7goo6NJ52YjtNtFyfke+FzmWFZFFfBRInw0mAm8ctOUTBChaS1qvnLIpcBBFPh9isXW6BVKZbuUXRuZgFvwr1ZnS83LsGh/owc6/qok8S3a/NEwa03lGH1VVw==
ARC-Authentication-Results: i=1; mta-outp-ksl-2; spf=pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.219.70 as permitted sender) smtp.mailfrom=case.edu; dkim=pass (Good 2048 bit rsa-sha256 signature) header.d=case.edu header.i=None header.s=g-case; dmarc=pass (p=REJECT sp=Undefined pct=100 dis=NONE) header.from=case.edu
Received-SPF: Pass (mta-outp-ksl-2.case.edu: domain of case.edu designates 209.85.219.70 as permitted sender) client-ip=209.85.219.70
Received: from mpv-out-cfd-1.case.edu (mpv-out-cfd-1.case.edu [129.22.103.196])
	by mta-outp-ksl-2.case.edu (Postfix) with ESMTPS id 418353101C64
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 09:32:36 -0500 (EST)
Received: from mpv-local-ksl-1.case.edu (EHLO mpv-local-ksl-1.case.edu) ([129.22.103.235])
	by mpv-out-cfd-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id DTN57931;
	Tue, 03 Feb 2026 09:32:35 -0500 (EST)
Received: from mail-qv1-f70.google.com (EHLO mail-qv1-f70.google.com) ([209.85.219.70])
	by mpv-local-ksl-1.case.edu (MOS 4.4.8-GA FastPath queued)
	with ESMTP id EYE75706;
	Tue, 03 Feb 2026 09:32:35 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8947d477a09so167703606d6.2
        for <dash@vger.kernel.org>; Tue, 03 Feb 2026 06:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=case.edu; s=g-case; t=1770129155; x=1770733955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=67ATeO2jzU3xmGTESTT0t7U4Jgg1atLrzenpUgnfU/o=;
        b=OXU2goCdnPqsaGNQuBO3Jz8b30fVc8PpTYWbFC6ueVobr0gmDxt78/5CVU7rNJnWfg
         n0UE/Xr/8N62eBqMV7LzZxMCZAuZ3L6uKfyGnF5ZSSQyiiYeDdxWKoo/iMYBi/YkXV2D
         pOVdjtmHrxenl5YOaFbK8KCNwiZX/16FGSLhNQs6NjeoJpib6N6KlfryYaO13+uIopg6
         S0AxvjJQsYtUr9kc+RKi+zgCiP6xNXl8hd2PfwvFJMTR+9zlwhnqcmRgzG126ghADoVm
         iiYh/dBeH/G4I6EZgnmwuvlgP+0DMG17LlI690oPR2436vRNhY/E1JmaSwkm2g2QT9d1
         AXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129155; x=1770733955;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:cc:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67ATeO2jzU3xmGTESTT0t7U4Jgg1atLrzenpUgnfU/o=;
        b=AYU4eAF9TQAgOF8LW6DHt0bs/pqroGbnQub79a5OiwTAQg5CVDo6GvDJYqgKHkzKet
         L5lIwJN82VuwWIcEcnf+nK0d/mQlolAIaziHOqrTRZT924D8Jrc0ZaUpe8IcSv8z6rA9
         mxoICJQU+qhHFjT/j+QeUGMTezWUCzJlKFIqtH6hFqQBgzJcXytincVReuwndP/oMmf5
         tcui/mEtGn77+gMugORYSmF7Yna0Px2LvCLXqot3CLQvAyPs8TTdnLP0f5vNFlexkghi
         /dFqxL/kcHI+A4AqFjdCW4pZ4nWB/9SfJsmB4g2r89szU4QdEj74H201G0c7Tr7QnW/1
         vymA==
X-Forwarded-Encrypted: i=1; AJvYcCVqatEtaHiVgg+G1hcongGoilE9I13f0deImujBd6kp7Sm+SlSpz1/sEqr+EKgX2R5arhxj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6y6LgshxB+iYfwCntujkgMWLlKM3+i+TTGU1poBDcFu2rKoM+
	7BPtz9VChh+gFZOSwlL8NoYV96AuTOwdhckfN6BYTabUWNpB/+81cBuShbJkBrw2r+vrN3Mq3Ob
	elMdylXFcLX99fJLlr5/bvjb5T9hamB3aDyW48CZMU2+AZjEF49B51BBq
X-Gm-Gg: AZuq6aIhcgNo2KN0BiCg38F5n2gWY8TyI8RE2KNA6U2veEPEf5i8BSbOaPAlRBylgAu
	+mAB6Hd11Vi3pGLgdW2JSQmvVigqYHdULK12nCMc5/G+WpWCpTreXt5YhtGbDIS2g0TD9lekfvR
	L6nCobJInFUCiV0S5FJuoH/5U08u7njBKENS11cih6j4/9k0vjUV0DeDSk9hOnEYG1uJGesAlBn
	UWwSsgOYhwEARYN+Sdha5bKVUHKFUMUlHtjCpg5a/rvFflHnVEOK5jv0jhwtPNW3+kn0xvUtIYZ
	c1wgswc7XkKlMHWmw6nqj5KWxpcYshaiYhPfoTEZ742c1wVSfFaEitSzDm+5bMF9tAZdz3XOmog
	alnmNOkXnxpDY3t4X+yxAqM/g3Zdp3tiyZ5B7
X-Received: by 2002:a05:6214:c8f:b0:890:7e6d:432d with SMTP id 6a1803df08f44-894ea178edemr208230596d6.67.1770129154933;
        Tue, 03 Feb 2026 06:32:34 -0800 (PST)
X-Received: by 2002:a05:6214:c8f:b0:890:7e6d:432d with SMTP id 6a1803df08f44-894ea178edemr208230056d6.67.1770129154317;
        Tue, 03 Feb 2026 06:32:34 -0800 (PST)
Received: from [129.22.8.211] (caleb.INS.CWRU.Edu. [129.22.8.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d6365esm1472267485a.52.2026.02.03.06.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:32:33 -0800 (PST)
Message-ID: <6cfa6084-dc11-4e45-9304-621e5b071c93@case.edu>
Date: Tue, 3 Feb 2026 09:32:32 -0500
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chet.ramey@case.edu
Cc: chet.ramey@case.edu, Martijn Dekker <martijn@inlv.org>,
        dash@vger.kernel.org
Subject: =?UTF-8?B?UmU6IHlvdXIgJCgj4oCmKSBidWdyZXBvcnQ=?=
Content-Language: en-US
To: Jari Aalto <jari.aalto.fi@gmail.com>, mirabilos <mirabilos@mag-kekse.de>
References: <Pine.BSM.4.64L.2601262052451.32136@herc.mirbsd.org>
 <CAOU7HicmTfdNgsJEZM8xE51KNg+-kkGBtf_Lh6V7XY-pM804bg@mail.gmail.com>
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
In-Reply-To: <CAOU7HicmTfdNgsJEZM8xE51KNg+-kkGBtf_Lh6V7XY-pM804bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mirapoint-Received-SPF: 209.85.219.70 mail-qv1-f70.google.com chet.ramey@case.edu 5 none
X-Mirapoint-Received-SPF: 129.22.103.235 mpv-local-ksl-1.case.edu chet.ramey@case.edu 5 none
X-Junkmail-Status: score=10/90, host=mpv-out-cfd-1.case.edu
X-Junkmail-Signature-Raw: score=unknown,
	refid=str=0001.0A2D0343.69820704.001D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0,
	ip=0.0.0.0,
	so=2016-11-06 16:00:04,
	dmn=2013-03-21 17:37:32,
	mode=single engine
X-Junkmail-IWF: false

On 2/3/26 4:00 AM, Jari Aalto wrote:

>> [...]
>> So, writing “`#comment`”, even if it works, is actually undefined, too.
> 
> Ouch, too bad POSIX didn't define them to be exact equivalents.
>  From user's perspective, I wouöd have expected the statements to
> exhibit the same behavior.

To define them as identical would have been inconsistent with the
historical behavior, and defeats the purpose of the standard.

Bourne implemented `` the way he did, I presume, because it was easier
and took less code (many Bourne shell implementation decisions come
down to "is it shorter and faster?"). Korn chose different syntax so he
could implement different semantics, without changing ``. POSIX
standardized the historical behavior.

-- 
``The lyf so short, the craft so long to lerne.'' - Chaucer
		 ``Ars longa, vita brevis'' - Hippocrates
Chet Ramey, UTech, CWRU    chet@case.edu    http://tiswww.cwru.edu/~chet/
