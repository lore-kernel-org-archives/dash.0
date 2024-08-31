Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFF320F
	for <dash@vger.kernel.org>; Sat, 31 Aug 2024 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725067965; cv=none; b=K/Kp7X7q52lfyHJpPnuXLBTjqz8ZapZB1a6MP3dZLrOd5bv8nTiC/kq5oBnE2iE4AqpT5vR1en9PvE5Gfr7YqUS8O7l2QVSoPS9pLWzl7l7WnUW3YDcgKlTOUv6KZI1jVsIcqS4BgPYlZcCYM2/BteRzjaOtL+1tPEO0ZRgRoSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725067965; c=relaxed/simple;
	bh=OM3rQ78ex+H5ZDGLsdEII3ey0ykDB4OuUMC0xVyTg0I=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=RpdUu3JxDwfc9O1UgF4aBL7qgCFIrvtAznFKMeiFAzzUYVNoQuYDbV7wuDwvvRhl7k3aWDC+P1hmrF9Gi/C0t/OfV36o9tL7ACuV0hvh3JXg+XbjDa0h8YN1p7gz04YgtXUsxo7VH/qFeiT4QQglpcqrM2diVMPD3sMn4wZ5b98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.179.249] ([46.253.247.94]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MdNse-1sB9D63sJc-00n6XM
 for <dash@vger.kernel.org>; Sat, 31 Aug 2024 03:32:41 +0200
Message-ID: <f13ebec2-f752-4eab-b0a3-06dce2405237@anselmschueler.com>
Date: Sat, 31 Aug 2024 03:32:40 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: Re: Why does the command builtin not circumvent invocation of
 builtins?
Content-Language: en-US, de-DE
References: <74ff2a7c-e973-443c-8006-07a6c17dbec7@anselmschueler.com>
To: dash@vger.kernel.org
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
In-Reply-To: <74ff2a7c-e973-443c-8006-07a6c17dbec7@anselmschueler.com>
X-Forwarded-Message-Id: <74ff2a7c-e973-443c-8006-07a6c17dbec7@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IR2bjIcxFxv3sri7GmyGP4F3BBJ/SHsEqtN7nA8vtyhX0U9mzhO
 go7lqe/ZjSaF3hhppztaOKDZuodj+ehT8LrMvY933cgLv8hjrwsOmQnjKAgMJt0dTwCgj2J
 2U0aBgGPcJbI3Cjr1gWPeoqxF/mtXSh03dxeuMq3MD4mapt5QmJTiPwR55Tpsqe1jWlorUG
 dhTNgF5zx7AZgZUISs4pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lqq/4qV/jzk=;ToNxyvWNLPIkgsrYowuSCl+472M
 JOTWbyq/nb02bmc8wmtU8uGz4FIHSoZo0f1kLkTTC6OhRafTZ6ujmGqwXNGET5kMKeHZBU9LW
 qX8VIUq3dN8iP9ZT3f9SB+/dXtVQL3ARzZoXqSelth2SFugEuEvNP4G2COj2d00W6g+dtHJ8Z
 aQJvu/BO7B9ECTMBq8Wkhyz1Av4vZl1NpjpnP9Rj7TYDVoJLu+WhDPo69C5fPa5GWkBYrAtid
 gPdVVa1J2YzLNdV61427hmVOt8dmdb5SmGf601OQpNvxPZAdOk5YRWk4ekCx3/aUGy144/pZ0
 5cJ3Lc5MKJJCGXnj239xmMVQniLSihwkpou0S6SRxj3wZ28PaRRsTDZF6IPnWox7h4KrFtZA8
 xwYPsBTqINDcwdO6oG3/Dv/hgD0lcI/m3yFr9y2XioVQzxeiyv8Wp0FxmL6iN6uuSgzARNe92
 nVa4eahMnwLGuYDG0NbUQwkbVjelWi4raXRdr6A2yboH/HaIXCIez1EAfnflTjlEmDdQE+tsy
 N5OGji+axpIV7OEpd5+3Icxchs6uGMFWXj6eWl8+NtUnb01L8rqayosfVni1OXAZ5CPI8EjQI
 cMCmT5ujIZT3B46erWEFezk8IviLaYYh8wlNxjfprEhr7z3Vnfgm7IBKgHKWYNtUPAP+l9/dM
 qOqqf5kCvAJ/bkiJ6fzgRM86wDVZMK/FtjZYQTWSDe4rvEbMesmbdv1LGSYXxcxxtwn96dSse
 I3euspKHMoEkBmTYRGunuGul06ZjNL3VQ==

I forward this message as I originally accidentally sent it as a HTML 
message which got bounced.



-------- Forwarded Message --------
Subject: 	Re: Why does the command builtin not circumvent invocation of 
builtins?
Date: 	Fri, 30 Aug 2024 22:17:00 +0200
From: 	Anselm Schüler <mail@anselmschueler.com>
To: 	Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org



I see that I have misinterpreted the text. Thank you.

You wrote “This also matches how "command" works in other shells as 
well.”. I wanted to note that this is not how it works in Fish, where 
e.g. command cd will try to execute a binary named cd from $PATH. I 
believe this is where my incorrect understanding may have stemmed from. 
Of note, Fish also has the builtin builtin, which is used to run 
builtins shadowed by custom functions, although in the handful of cases 
I tried Fish actually outright prevents defining such functions.

Thanks
Anselm

