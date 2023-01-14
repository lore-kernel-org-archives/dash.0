Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BB2C46467
	for <linux-dash@archiver.kernel.org>; Sat, 14 Jan 2023 13:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjANNwf (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Jan 2023 08:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjANNwe (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Jan 2023 08:52:34 -0500
Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D45276
        for <dash@vger.kernel.org>; Sat, 14 Jan 2023 05:52:31 -0800 (PST)
Received: from zmtaauth01.partage.renater.fr (zmtaauth01.partage.renater.fr [194.254.240.25])
        by smtpout10.partage.renater.fr (Postfix) with ESMTP id 9A87A63DF5;
        Sat, 14 Jan 2023 14:52:26 +0100 (CET)
Received: from zmtaauth01.partage.renater.fr (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPS id 90C64140078;
        Sat, 14 Jan 2023 14:52:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTP id 7BB3E14010F;
        Sat, 14 Jan 2023 14:52:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth01.partage.renater.fr 7BB3E14010F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
        s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1673704346;
        bh=ypdFAo2rUqDvGJwoK+N4zmZNeoIdYBj+DUAHLLb9HK0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=T14zDl01hheusoIFVXH8iUh5swz8ytexAh2WTOLnBN8Pz2SJb2fKE5+y/SlqBJuZe
         88MbCUHoy2BiY9qZTGMs9jjTMmR/MisZVQpvSTybOs2VJuS2z0QdvHjBMiHj7ZnYde
         ohZBfwb2vFqZX3dnS/8LWFBYDkzdoJMdQZiTYquOJvqm9/h6zMC9dexecOuxqbfLoQ
         chA/J4VOC+d7nqZcUKj2N/2eYC7e99gKffySGWCAlG/pxc4+u9kEG9Gyv6A6EUlq04
         2Y4ixIjeCzrk9f9sXXeBlUaViZ85QGxuVndvbeXRZ1ii2d80OLowgVL9DuOVa4og0w
         PFhQEdi+FwZdg==
Received: from zmtaauth01.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaauth01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SP_-7VlPvMC8; Sat, 14 Jan 2023 14:52:26 +0100 (CET)
Received: from 82.65.50.238 (unknown [194.254.241.249])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPA id 2EE0A14010E;
        Sat, 14 Jan 2023 14:52:26 +0100 (CET)
Date:   Sat, 14 Jan 2023 14:52:25 +0100
From:   Marc Chantreux <mc@unistra.fr>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     "anonymous4feedback@outlook.com" <anonymous4feedback@outlook.com>,
        "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= Bug in dash: Incorrect
 behaviour of $LINENO in function
Message-ID: <Y8KzmQYZKHc+0Mxv@prometheus.u-strasbg.fr>
References: <PS2PR03MB38309A4880282F1C60C3094092C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
 <Y8J4PmYwjp9fE7/y@prometheus.u-strasbg.fr>
 <PS2PR03MB3830467E11C8D6047363FCA392C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
 <6469ba41-e905-c873-f239-21448af0d853@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6469ba41-e905-c873-f239-21448af0d853@gigawatt.nl>
X-Virus-Scanned: clamav-milter 0.103.6 at clamav04
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedruddttddgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrrhgtucevhhgrnhhtrhgvuhiguceomhgtsehunhhishhtrhgrrdhfrheqnecuggftrfgrthhtvghrnhepgfelueduueelleehteegveejjeejleekveefueelkedtheffjeevgfevudduledunecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdhmrghrtgdrihhnfhhonecukfhppeduleegrddvheegrddvgedurddvgeelnecuuegrugftvghpuhhtkfhppeduleegrddvheegrddvgedurddvgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdegledphhgvlhhopeekvddrieehrdehtddrvdefkedpmhgrihhlfhhrohhmpeforghrtgcuvehhrghnthhrvghugicuoehmtgesuhhnihhsthhrrgdrfhhrqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehhrghrrghlugesghhighgrfigrthhtrdhnlhdprhgtphhtthhopegrnhhonhihmhhouhhsgehfvggvuggsrggtkhesohhuthhlohhokhdrtghomhdprhgtphhtthhopegurghshhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Sat, Jan 14, 2023 at 11:10:45AM +0000, Harald van Dijk wrote:
> On 14/01/2023 10:57, anonymous4feedback@outlook.com wrote:
> > Sorry I didn't explain this clearly, and I made some wrong assumption in the first email.

don't be: maybe at just misread you :)

> > dash prints 2, (line number in function, counting from 1)
> > bash and ksh prints 4, (line number in whole script)
> > and zsh prints 1 (line number in function, counting from 0)

to me, $LINENO should be read as "number of lines from $0" so you can
write 

	echo error at $0 line $LINE

none of them break this rule AFAIK:

	<<\% cat -- > /tmp/pa
	S=$1
	f() {
		echo $S: . $LINENO
	}
	f
	%
	<<% xargs -IS sh -c 'S /tmp/a S'
	zsh
	yash
	bash
	mksh
	$HOME/src/vendor/dash/src/dash

gives

	zsh: e . 1
	yash: /tmp/a . 3
	bash: /tmp/a . 3
	mksh: /tmp/a . 3
	/home/mc/src/vendor/dash/src/dash: /tmp/a . 2

to me, is the only one problematic here (there is no line 0)

> There is a standard about this, but it, in my opinion, is unclear what the
> correct behaviour is.

as I find the opengroup site (intentionaly?) hard to read, there is the link:

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html

> There are a few more cases with LINENO that prove problematic, see also my
> response to an earlier bug report at
> <https://marc.info/?l=dash&m=153725795810101>.

Sometimes, function overwrite and aliases leads to really simple
and powerful script designs. So after 25 years of shell scripting,
what I think should be standard is:

	when inside a function, $0 and $LINENO correspond to
	the filename and line number in that file starting from 1
	and without any alias expansion.

But I like your conclusion too:

	"As for the rest, unless there are strong reasons to go after a
	particular result, since POSIX says the results are unspecified,
	I would suggest going with whatever is the simplest to implement."

regards
marc
