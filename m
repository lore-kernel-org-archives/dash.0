Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461333AD88
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339810; cv=none; b=qDLmQwTKaZhaQTDtv1RFsY9wF55tBnJ0C0oYawetztz6Hxb+7iYnlF6Md58KJYiS5/Y1+G6wBrZhryacidB9B9Swfbxrg0XRSLEdKh+o0Ls7DXQtcFNoKnO8er6Ti62Pj3K5EqjT1vfVBg5Msl/BwyZGCGueElr8M8RdCP4vRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339810; c=relaxed/simple;
	bh=3hcnfd+ivy/G8N99ubk/SjROKc0pD6YBb/czcjqokvM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j+47TOP73NG67G18eVXOLnloyNlKap+Pz2DdaZLfZmyTZtmTd2W7mj3mT1h4AA50EiD3MdRWHFuSc08qjxAEuyEVrZJq0CULgqdHmvfpPRcRF4jcORFLBiMVkKAjHLpzeoeYjKKppOa4ISgISRn3CdMkJPchmVXi/EekfO9LWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=AGf3XfED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UoR18T2W; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="AGf3XfED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UoR18T2W"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B5BC1D000D7;
	Sat, 13 Jun 2026 04:36:46 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Sat, 13 Jun 2026 04:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781339806; x=1781426206; bh=K6kpX6UwXWMujj3FBcPq6ytP01J3QhfG
	sqo1D+pMqdY=; b=AGf3XfEDLGIC1VGk8HPswZ1s1xADidfwS5ntMqQBPK0fCnzi
	k1NAtyubSSnL9Qgn1OSnG0wxyNHxanhAyC9+Ar2QuBt6De3Kzp+QarHorRkfMBdB
	b3xXBuhPjdJgJp9UsVt+fDroKJfx0L7QBnz1msAQcLNBt3k1xFrcnFVlENeREZhP
	OtiXN/uguZuMk82A3VoobS7pWj7g2wnc4bm++Be9NYGicTOCgwqZrizUNaZBrOdp
	KylKjH6ECWOu9vE43Jv1Hsir1Da0A29lHiMBWxcD5de4dewbDUNrKDdqO0Ev7Nz0
	a/lU6NKLSwTCe1BYWP858uvJeCBfoLwa7RNB/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781339806; x=
	1781426206; bh=K6kpX6UwXWMujj3FBcPq6ytP01J3QhfGsqo1D+pMqdY=; b=U
	oR18T2W1noHAdumso1SwKD8Bi29WvjRSuHi/5k0PzaCrNrFoQlAw5qqPmdYBUS8/
	kb6UG1u/cW2zUeKf+oMuJM5AcGFE7SV4Wc87xMPGUMZft75q02TenXBgkuOLT8Ci
	EwFy8CQObXTPW+DufZlyZRUJvhViivnPTgceY5OuFppSE0/o27kgFTygudbINIZB
	w7AManiWzFn6K6GmK9PT+jd8+giyZAC1sXzmmOSjlviWSRK4IGessSYXvYVFbeAr
	aBAZm613kBAc8rJZRktzdlIoQdl0t34ex39fe11fzulfPG7lYOsazULh266IJRhd
	qmWARa1QNj7evHTE2Tltg==
X-ME-Sender: <xms:nRYtaq8qoY5glWEJgPvd49zMT6yEyClzGzkkbB93g2oiwZb-TVFBRg>
    <xme:nRYtalg6233gPJF6tiShrnkEtmcMY9BsntIjR0OOQRG8la1kfiogS_CnCHQ71LmB-
    m141JlTbcOOdhEqGZUgG1p9RdpcnesPPTteiWO5JpI5_foNV4FV>
X-ME-Proxy-Cause: dmFkZTER99Qy73iA/mZm1G7h4RakCBAGd+3twH1i+xnKB0Wo5k8nkSCeprbjpBoF98xMKa
    68v4Sy5rcvgYDCwurqAW1tWZKnMbqihUBrKzaldoRq/61K0fvnEUiMx6CQsjekhioc2chv
    qN0xJdUsnzZwZYjgDn1kFU/YInzxSOJlkkB0U5hpjH3zsXh39R/q7EC4Z1Cs8ehIFPgdek
    wc1da5/NnXju8f513O9Hen9y+r4DXG5PpPzd3R5dWiEQI2F8eg1ng3Suqe/GZ8zfb+X5AY
    2DvLNrVPYgfTGymFXcensnfJPGhB4CvctumuBO/tT0ioce0gniOtAihpDBb4m3hIKlNapW
    3HNL7lQXGTiXrbPu4d8ufI/Ea2wAs+FAy0pWDWKsZkF6U3iG/KPC8YwRJCjBSlx5G69B1v
    WVLMaaU7PoNadVGK8DGE8ZdZ1DulpOevy5MX5jFWDsfH+VAHPDWucl2sZEcrojZf/fYCjA
    Mq5yY0Ge2oyjOhpEUrzsgbUQZH18ukaQgXyuz6VY4p4ZYGXoFl0l9YHM/O7kAudBkc00+e
    SUpyS8GYwHS+/Uvz/BVK9ENfMipDT0+MJFnixnFx6dhjYRLzjVu9nrjJ9RTXPIER1Pqhfa
    1HJUh/TRMglOTdzayo+fqn3XBaP+Zr3SDx3qJvd+skuVDFwqo8zdb6EMO10Q
X-ME-Proxy: <xmx:nRYtaspI1w9y-lXAFNIPAUIcT9v_bFJdavYIpETkLJw1XbePp3ua6A>
    <xmx:nRYtaphgdIuktvhAdPNenfpQ-HZJ3EZ3mlzkbJHoc8gTDAh5hDK_1g>
    <xmx:nRYtaphDiG6de73eZhe7vNgaf85LxNUzilzpvdEkr5gxpdpGtZQo8A>
    <xmx:nRYtaviBgCIzwn5C5LLtn-mMxlI7Z3mgbYiBnQdElVbG8jUb85RogA>
    <xmx:nhYtakL2SRiheDU63ztEimhKQc2EkYNgSmeJS8wP_-pzd1TBvFIHwweD>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 69F73216008A; Sat, 13 Jun 2026 04:36:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKuBAax-c3uF
Date: Sat, 13 Jun 2026 09:35:51 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: "Harald van Dijk" <harald@gigawatt.nl>,
 "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: "Christoph Anton Mitterer" <calestyo@scientia.org>, dash@vger.kernel.org
Message-Id: <58a10adf-6642-430b-af4b-63f2643fccf9@app.fastmail.com>
In-Reply-To: <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
 <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
Subject: Re: [PATCH v2] exec: Print absolute paths for command location queries
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026, at 2:52 AM, Harald van Dijk wrote:
> On 6/13/26 02:47, Herbert Xu wrote:
>> Kerin Millar <kfm@plushkava.net> wrote:
>>> POSIX requires that, when reporting the location of a utility found by
>>> searching PATH (or one named with a slash), the pathname written by
>>> type, command -v and command -V be absolute:
>>>
>>>     Executable utilities, regular built-in utilities, command_names
>>>     including a <slash> character, and any implementation-provided
>>>     functions that are found using the PATH variable [...] shall be
>>>     written as absolute pathnames.
>>>
>>> Presently, dash fails to conform in this regard. Address this issue by
>>> prefixing relative pathnames with the logical current working directory,
>>> provided that it still resolves to the current directory, and with the
>>> physical current working directory otherwise. If the current working
>>> directory cannot be determined, print the relative pathname instead.
>>>
>>> Link: https://lore.kernel.org/dash/2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org/
>>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>>> Suggested-by: Harald van Dijk <harald@gigawatt.nl>
>>> Signed-off-by: Kerin Millar <kfm@plushkava.net>
>>> ---
>>> src/cd.c   | 40 ++++++++++++++++++++++++++++++++++++----
>>> src/cd.h   |  1 +
>>> src/exec.c | 30 ++++++++++++++++++++++++++----
>>> 3 files changed, 63 insertions(+), 8 deletions(-)
>> 
>> Even bash doesn't do this:
>> 
>> $ bash -o posix -c 'cd /; command -v bin/bash'
>> bin/bash
>> $
>
> You're overlooking the "that are found using the PATH variable" from the 
> spec. Because you included a / in the command, it is not looked up from 
> PATH. Modifying your test to make sure PATH is used, we can see that 
> bash does do this in POSIX mode:
>
> $ bash -c 'cd /; PATH=bin command -v bash'
> bin/bash
> $ bash -o posix -c 'cd /; PATH=bin command -v bash'
> /bin/bash

Adjacently, bash willfully supports / in function names.

$ bash -c 'bin/bash() { echo 1; }; bin/bash'
1
$ bash --posix -c 'bin/bash() { echo 1; }; bin/bash'
bash: line 1: bin/bash: No such file or directory

--
Kerin Millar
