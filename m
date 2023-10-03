Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1959E8FDB0
	for <linux-dash@archiver.kernel.org>; Tue,  3 Oct 2023 19:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbjJCThm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Oct 2023 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjJCThl (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Oct 2023 15:37:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E917AB
        for <dash@vger.kernel.org>; Tue,  3 Oct 2023 12:37:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CFEFE5C02DF;
        Tue,  3 Oct 2023 15:37:31 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Tue, 03 Oct 2023 15:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1696361851; x=1696448251; bh=YB4U3l7B9T/gmQm23CIvY4/q01zBHQmeYcV
        iNV6Hwyk=; b=BbpNCazXFUV/sEcdx/Yx6PzMIset7HO9PqPkh3HUb/Id74b8VWC
        FJuPVmBuv00yLZEsoZ6trL6ZUeIgMMdk75UhYeU2ME5UWgSw1ktS3cPc0PQDiM64
        mQ40uA5HzqqahpfBwYy77Hhyt0SYKKcfNE1kcosNDmIrv3QVKid9EzcUqMSHQoKp
        tSoY58RaiZryBuEf+uRwjwJ/gNix3Iai0GeRIShCTAYSQ4ft6B0Z8QXEWaqRZu9J
        LAPF02dOAbpz6WA/rcE0sBY0ihrOpXjmEvnIL0jcOBCVJe4dzbjaEzzQTyVdlme4
        bgHPYwGaqZXtt/6XWD+S8SaaaOoBoagxcww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696361851; x=1696448251; bh=YB4U3l7B9T/gmQm23CIvY4/q01zBHQmeYcV
        iNV6Hwyk=; b=PCCAJRCqWDMI/xh62Jn7nnq2IkDvaBGVL4efqiA7cj5b+kcAPbq
        WGz7LAdEA4pLJQ44wJ2/uwCSzyyqp3ieluPF0IdU0LWCXVUocJM06aa/z5k7NULX
        n/otkIlU7lRMAmcxaETDnv4/B7xNISW5e/3EdkUJ08W4Y2o7Fh0VGzHcP2RYUrgY
        lu612yDOi+UI15CTzUWZWD2OGtjT+qQ/Fy39zF2ArkNaKFue09YKvnNhNzRv0T5u
        jWJzbXWiRnVDe/i5cFUlj6Afb26ARktCYMjhKIH8p8X4/SfxjUN9YrQZY0TZLALv
        4aCMtrSTB15CXJYSftyhDObiXnTwGagHLlg==
X-ME-Sender: <xms:e20cZRH0lXlXn_untq6MEayIv9Lyy28oXH5EkpOwI6fg-oR9bIU-3Q>
    <xme:e20cZWVNwoP09wnKpcql_TK-lUmiHlQtGswXeXEdsodLkGdEXH-zaoKotGyBkOK2R
    _NQp5ASTolfbJTSdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepnfgrfihrvghntggvucggvghljoiiqhhuvgiiuceovhhq
    sehlrghrrhihvhdrmhgvqeenucggtffrrghtthgvrhhnpeegveeuteekvdehkeeivdejgf
    dttdeljedvteekleejteehtdeufeduheeghfdvhfenucffohhmrghinhepohhpvghnghhr
    ohhuphdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehvqheslhgrrhhrhihvrdhmvg
X-ME-Proxy: <xmx:e20cZTIKwJFclLfgr_8XbaB_qY-fxZ_5Ugjt8aGTCJgKu8aRdYeIfA>
    <xmx:e20cZXGv6J5uX-STO77ZILP2lkZB5DOg8ZDbvFD-E1b8F5O8T_vntQ>
    <xmx:e20cZXX9Ia2ztfheRk3BzRp7TX_4mD__rQEx_AtQwXCL0PXd3Cfdxw>
    <xmx:e20cZYd7nb8RvSokKo52z8ARULfM_JOz6LTeNp8x2q1k3mcNWCepdA>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4DE3331A0064; Tue,  3 Oct 2023 15:37:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <d2bd1d90-9743-4261-b2f9-4363165e69d7@app.fastmail.com>
In-Reply-To: <0d627a69d4a68302a86801817751a84e@aegee.org>
References: <0d627a69d4a68302a86801817751a84e@aegee.org>
Date:   Tue, 03 Oct 2023 15:36:03 -0400
From:   =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To:     =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_=D0=9F=D0=B0=D0=BB=D0=B0=D1=83?=
         =?UTF-8?Q?=D0=B7=D0=BE=D0=B2?= <dilyan.palauzov@aegee.org>
Cc:     dash@vger.kernel.org, 1053394@bugs.debian.org
Subject: Re: dash should not propagate aliases to subshells
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Oct 3, 2023, at 5:54 AM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=
=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2 wrote:
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#tag_18_03_01=20
> says:
>
> 2.3.1 Alias Substitution
>
> When used as specified by this volume of POSIX.1-2017, alias definitio=
ns=20
> shall not be inherited by separate invocations of the shell or by the=20
> utility execution environments invoked by the shell.
>
>
> So a subshell shall have no knowledge about the aliases from the=20
> supershell

You are mistaken; subshells are not "separate invocations".  See
section 2.12:

	A subshell environment shall be created as a duplicate of
	the shell environment, except that signal traps that are
	not being ignored shall be set to the default action.

> These programs
>
> #!/bin/bash
> alias wslpath=3Decho
> find `wslpath /tmp`
>
> and
>
> #!/bin/dash
> alias wslpath=3Decho
> find `wslpath /tmp`
>
> produce different results (bash 5.2.15-3.fc38,  dash 0.5.12-1.fc38) wh=
en=20
> executed on a WSL2 system.  The former program shows the content of th=
e=20
> current directory, the latter program shows the content of /tmp .

That is because aliases are not expanded at all in noninteractive
bash "native mode" shells.  If you were to run bash as "sh" or with
its "--posix" option, then you would see the same behavior as with
dash.

--=20
vq
