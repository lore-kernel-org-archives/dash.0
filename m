Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F48C46467
	for <linux-dash@archiver.kernel.org>; Sat, 14 Jan 2023 09:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjANJtW (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Jan 2023 04:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjANJtS (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Jan 2023 04:49:18 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 01:49:15 PST
Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266047A9F
        for <dash@vger.kernel.org>; Sat, 14 Jan 2023 01:49:14 -0800 (PST)
Received: from zmtaauth01.partage.renater.fr (zmtaauth01.partage.renater.fr [194.254.240.25])
        by smtpout10.partage.renater.fr (Postfix) with ESMTP id 6E5B664E88;
        Sat, 14 Jan 2023 10:39:11 +0100 (CET)
Received: from zmtaauth01.partage.renater.fr (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPS id 6603E140108;
        Sat, 14 Jan 2023 10:39:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTP id 52A9A140123;
        Sat, 14 Jan 2023 10:39:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth01.partage.renater.fr 52A9A140123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
        s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1673689151;
        bh=pNr/P7p3VwG5jHrV2s2KEUXnvf9Sp7TS1nf/pXvK1gQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jatQHf4BYu3JpNGoSA8gN5NG9dbLpDg4m9S9uC4IpvfIWQ8axzmsWcoQClER1NmMx
         1CBUlTIch1oAS/T1JOHVxGnfKssEWTMKcUyDMgmtSycOREhOqiAZj0bvMKOvfN2VAr
         gIA6FkQtYisC+qFX1ONesUjxesDwdNd2YjZxhm/Wz/GHlEAi1rJr8WFU2e4aS/inuj
         4RIDN/kOYRdmqfYSzBFCqtQ4c52Kg/C6CH8sJpE1pdn+BJNXtp2GDxcdrCtiDtWKWI
         n2wu6ptKJllL9zklWt1syEulYN5Lo69rWQlbPgHHksC9elhIcB2CJmNel31sGJnFE+
         YYIidKr9QrxzQ==
Received: from zmtaauth01.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaauth01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g4OM5JrimR9w; Sat, 14 Jan 2023 10:39:11 +0100 (CET)
Received: from 82.65.50.238 (unknown [194.254.241.250])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPA id 176AF140108;
        Sat, 14 Jan 2023 10:39:11 +0100 (CET)
Date:   Sat, 14 Jan 2023 10:39:10 +0100
From:   Marc Chantreux <mc@unistra.fr>
To:     "anonymous4feedback@outlook.com" <anonymous4feedback@outlook.com>
Cc:     "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: Bug in dash: Incorrect behaviour of $LINENO in function
Message-ID: <Y8J4PmYwjp9fE7/y@prometheus.u-strasbg.fr>
References: <PS2PR03MB38309A4880282F1C60C3094092C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2PR03MB38309A4880282F1C60C3094092C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.103.6 at clamav04
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedruddttddgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforghrtgcuvehhrghnthhrvghugicuoehmtgesuhhnihhsthhrrgdrfhhrqeenucggtffrrghtthgvrhhnpeekgefhveekkeeltefgjeegtefhtdegudffveelueffuddtjeehleehieejuddvueenucfkphepudelgedrvdehgedrvdeguddrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvhedtpdhhvghlohepkedvrdeihedrhedtrddvfeekpdhmrghilhhfrhhomhepofgrrhgtucevhhgrnhhtrhgvuhiguceomhgtsehunhhishhtrhgrrdhfrheqpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprghnohhnhihmohhushegfhgvvggusggrtghksehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepuggrshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

hello,

> It seems dash stores the line number of the parameter substitution and the line number of the function definition

which is what we expect from a variable expansion. what you need here
is an alias because it works like a minimal but dynamic preprocessor

those are the tricks about aliases:

* they really act as a preprocessor so

	alias warn='>&2 echo here at $LINENO'
	f() warn first
	alias warn='>&2 echo another message at $LINENO'
	g() warn last
	f;g

	# does

	here at 1 first
	another message at 1 last

* interpolation comes first so 

	entering() {
		echo entering "$@"
		"$@"
	}
	f() echo doing things in functions
	alias damn='echo oops ...'
	entering f
	entering damn

	entering f
	doing things in functions
	entering damn
	/home/mc/src/vendor/dash/src/dash: 3: damn: not found

conclusion:

* use functions as long as you can
* in this case, you can't. your solution is

	alias warn='>&2 echo here at $LINENO'

HTH,
Marc Chantreux
