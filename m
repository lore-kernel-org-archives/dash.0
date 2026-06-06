Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B069284B37
	for <dash@vger.kernel.org>; Sat,  6 Jun 2026 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780768123; cv=none; b=nH1QaCCvpjQW0G9hErSi1cjD6bE9re9Pr4Kd7DPCv1s4iQY/3FnCC9hTkFrgo+RQXOX6ajV9hSp8NnNQ9Q7Bk0ctBxbWSHHZgTDnvD+oL5/TfmGYeSvNIlnu4Tf4ZKGUjFoMJ2ZsI8hSL8g3Ln2+tR0SFtqzFg9e/sf06NTgpSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780768123; c=relaxed/simple;
	bh=BKSlL09oBqulKZ+ztd4995oLM72ZEJfKtedEBEOlyAA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tLBVmkdB3SmrC1Xg4DFmCVztnZRM90joPuBk084Vpok2+eVRHl8DiHED3nd7PjYmhEU9SdMfG4XMeg8F6sOYyXHz8Z/jKaqaYaTD6H34PTnN5KGM2Pix17ssMkC2JmAJX4J6GFWxvVV9MgLKo9meuYbyvmBDd1zW+uCPVJgd0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=Jp2HMmvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4QmrU/M; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="Jp2HMmvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4QmrU/M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FC92140009B;
	Sat,  6 Jun 2026 13:48:40 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Sat, 06 Jun 2026 13:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1780768120; x=1780854520; bh=910H23G9RbREr6YIscLcGheZI7TNnzsw
	XJhGqTKPKLI=; b=Jp2HMmvGb2UhMbqUqlZoRMa9Pnvrs/lT6KZL6kK8ctFgmqiM
	jr5O0469tFhn6n4EXPfbZf2zff9vsTMbwBd8Dqa2lx5dwSPOsdsKpOgwgh9jtB7C
	3OKLWCX37D+5PBblrEp35J6GUuLfWjfRkXVb8Nn9290NIWAuW/izUMdBoYMjFWUX
	ySKEGbt5jIqRFZze+2hiB87mgCjeVJKQpGtdmceQ8bz7ABI0piujvC4CPV3Oy4HZ
	jeASBfT0gShI6CZFzWjhpWbn2dvpSzFuEBwJt0A+lzkoPzbx7qikx0UoZ8M6ersZ
	ItvqRCXQbXXoaIDG+EXP+OawfLFMS7xkcjfgfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780768120; x=
	1780854520; bh=910H23G9RbREr6YIscLcGheZI7TNnzswXJhGqTKPKLI=; b=F
	4QmrU/MI/V8A0Q6MJZsAuHLpF1L8pGweVeEMQWb2usbRouW6O/ct+21v+/OH1t0R
	l4bKywTwDlAK+5hU1T/g5AImAzXuFZoqnoNMHzkvKf8VeCyk0pr5uF0MdNXqDj/T
	lVStZ9TfwTVLjdlL5jVcP1gd5z6QfEoMNJNIgfVXPuhSAB2mD7HEfZrMC7CqwLJY
	t8UM4hfqOZCvIXl70LlApCvI8dF3JiuGLraIZQMvuHCCTuARks2hBhTcxYvmPmN6
	4KTz4B3ZFWT1vtZf7wCfOZ+55qu473g7qM+sL3UBPJ/lxQVREQokKdBxWv6898U2
	t6/8bpwQXMC/hbKt4xDxg==
X-ME-Sender: <xms:eF0kalzp9YnHgDGMsk21Y2EbRFne0nOp84iHjD3OSL8AqMOF41ypTQ>
    <xme:eF0kagHYu3HhvTcpjPri2gC3G1sj-lA-b9KGhLr1E9kaLDXEJlv3Oe02NR7Dfj8rS
    ogkGKymWT1oM9rFGjfeRyzi-nc0rXdUC1VFZ2v4uhEf6I7goQky0Q>
X-ME-Proxy-Cause: dmFkZTFxWzmbnSGAQgTzrY8zGkFetk8b0VsJCqpIMz8OQu52m6NxNy4iUacHpknsgPVYOA
    WqMZcePaSpSeOQywqdXFRyeLaCPMFpUqkbH3JZ1LPQcXpGmt96T9Gnts2jEozaNLBrNhpw
    GWUoi8MIRm0prMsxcVvhDk0L8AmHT3YnRLRDLwhu3nKnt0IWcB12wcttAu8F9VwVLXhUgw
    wOoUgl03I7kTuT6RdLXtSG9A7iDA2gTgdAROXPwMAB5xjUg6JeRg+oiF02F0s1MRtLu+L+
    xHpXPNXLV0LJXgvDXFz7vpbMCa7tV3mnykZneqopRI5XepA1Wdo9Eh6aU5KGpAtzpXSCIn
    60+RVls5rljZkQsOKon1S0FqHWiVefN0sV7/El5s9zSqR3i0cjcxuQBMrmuvVW0kOktya7
    jJzdcMgu1rWZ6Ui+kdb9uqB5aeXJoX3plhMV/LDtpqfcl9zUFsnRWz1axwYX2NZyGJXw3Y
    Zqrf18Lc3Q6YZGARiLbnFX9ik7yqcSItbVDx3SBl8ioVfX6k2HLAE6X3UuAY3bX5VDL54l
    CchmxNWkWGSYgy3NZHcoETRYUpWNgFLkwm19hrGjkMroHEFUHfwF5lP/5hAsHnFBDZLnZA
    1ccxqI2KAlE/i4kqxN8BWrgXs8/mZCgMUua8waXP92oQ1GA7GF7Chmd9D5GA
X-ME-Proxy: <xmx:eF0katMC-Ls2Xou20GgkN8VFD-LDm6aHqao2cv2J7rOjwl4xCElNsg>
    <xmx:eF0kantJcVggyduehOKS_1nHwthP6fkQ3huIUjW5ZO-mAr8tTVioCA>
    <xmx:eF0kavVGBkI71F9DVGLBeI6HHG02JeOpyRxnu02DuGbmr5Y41X0yBg>
    <xmx:eF0kanvV2ap85rw4lg5WRvLGGHNGhdcCvZB-70XDucB_vd5MLuJrng>
    <xmx:eF0kakHSB5Ay1rZzWo_8OuZ73t8UCbltbTRAHl2VbMcniYcgDn_rXOWi>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16F2F216008A; Sat,  6 Jun 2026 13:48:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKuBAax-c3uF
Date: Sat, 06 Jun 2026 18:48:19 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: "Harald van Dijk" <harald@gigawatt.nl>, calestyo@scientia.org
Cc: dash@vger.kernel.org
Message-Id: <e9b50e6f-7b82-43f0-a1ac-3bd40e0653c8@app.fastmail.com>
In-Reply-To: <7dc9a5c3-7c50-4d52-b46d-7ad4477a24ae@gigawatt.nl>
References: <2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org>
 <20260606153634.119074-1-kfm@plushkava.net>
 <7dc9a5c3-7c50-4d52-b46d-7ad4477a24ae@gigawatt.nl>
Subject: Re: [PATCH] exec: Print absolute paths for command location queries
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Harald,

On Sat, 6 Jun 2026, at 6:27 PM, Harald van Dijk wrote:
> On 06/06/2026 16:36, Kerin Millar wrote:
>> POSIX requires that, when reporting the location of a utility found by
>> searching PATH (or one named with a slash), the pathname written by
>> type, command -v and command -V be absolute:
>> 
>>      Executable utilities, regular built-in utilities, command_names
>>      including a <slash> character, and any implementation-provided
>>      functions that are found using the PATH variable [...] shall be
>>      written as absolute pathnames.
>> 
>> Presently, dash fails to conform in this regard. Address this issue by
>> incorporating a helper function that prefixes relative pathnames with
>> the shell's cached current working directory.
>
> Hi,
>
> Although this ensures that the written path is absolute whenever 
> possible, it does not ensure that the written path corresponds to the 
> command that would be executed. Although curdir cannot be altered by the 
> user, that does not mean it should be trusted for this purpose, because 
> the file system may have changed after the current directory was set.
>
> Consider:
>
>    cd /tmp
>    mkdir a
>    cd a
>    ln -s /bin/ls
>    PATH=. command -v ls # should print /tmp/a/ls or /tmp/a/./ls
>    mv /tmp/a /tmp/b
>    PATH=. command -v ls # must not print /tmp/a/ls or /tmp/a/./ls
>
> Printing /tmp/a/ls for that last line is worse than printing ./ls: ./ls 
> may not be absolute but at least resolves to the command that would be 
> executed.
>
> bash does not appear to consider this requirement useful, so in 
> non-POSIX mode just prints ./ls. In POSIX mode it prints /tmp/a/./ls twice.
>
> ksh prints /tmp/a/ls twice, regardless of POSIX mode.
>
> zsh prints ./ls twice, regardless of sh mode.
>
> yash correctly prints /tmp/a/./ls, followed by /tmp/b/./ls.
>
> My shell, gwsh, also prints /tmp/a/./ls, followed by /tmp/b/./ls.
>
> I think leaving it as printing a correct relative path is better than 
> printing a possibly wrong absolute path, personally. A change to print a 
> correct absolute path would have my support though, for whatever that is 
> worth.

It's a good point. How about using getcwd() and printing the relative path upon failure, even if to do so would not be strictly conforming?

-- 
Kerin Millar
