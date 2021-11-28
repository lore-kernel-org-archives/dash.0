Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DFFC433EF
	for <linux-dash@archiver.kernel.org>; Sun, 28 Nov 2021 18:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhK1TAv (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 28 Nov 2021 14:00:51 -0500
Received: from smtpout01-ext2.partage.renater.fr ([194.254.240.33]:43644 "EHLO
        smtpout01-ext2.partage.renater.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234495AbhK1S6v (ORCPT
        <rfc822;dash@vger.kernel.org>); Sun, 28 Nov 2021 13:58:51 -0500
Received: from zmtaauth01.partage.renater.fr (zmtaauth01.partage.renater.fr [194.254.240.25])
        by smtpout10.partage.renater.fr (Postfix) with ESMTP id ABB0F61FF4;
        Sun, 28 Nov 2021 19:55:31 +0100 (CET)
Received: from zmtaauth01.partage.renater.fr (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPS id 9F6FB140322;
        Sun, 28 Nov 2021 19:55:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTP id 8BCCA14034A;
        Sun, 28 Nov 2021 19:55:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth01.partage.renater.fr 8BCCA14034A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
        s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1638125731;
        bh=rDAOOcAvR9tF+PvTJEUfHgR0zhlqKGc83WzF5aEdgYY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=elWLNp6tYoLVpNHXNuIIftT6i5VY1RLtcL2iy7EbAwUimkfOSrLec8bwtOFYHsHnc
         7T6vUhqbg4/kK6MrJd4QHxagFKYcMcvX/Vk9Wpikh7rf1f0ua0FvT/lQqprAfdOsS/
         6fafYrxNFjmttfIIUhzEzWZSArDqIU03qLVmn1uQiCUgJo5k3GBj3+eXW9dF6ozMbp
         lFLYmQhif+wdc3VRapyBevTNS18NifFeaBRJaaqMTZG6xDdp4jXqepGLkl4+pJDS8Q
         OHLYq8MsBYzVRgD3839NNzHlCe2nntPtTF3AvhRlEkwfM2iXCxT9QJITfh7X2nrAwF
         fCb6Qr0uCM1sg==
X-Virus-Scanned: amavisd-new at zmtaauth01.partage.renater.fr
Received: from zmtaauth01.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaauth01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 74-uzsDBwA9y; Sun, 28 Nov 2021 19:55:31 +0100 (CET)
Received: from 82.65.50.238 (unknown [194.254.241.249])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPA id 57DCC140322;
        Sun, 28 Nov 2021 19:55:31 +0100 (CET)
Date:   Sun, 28 Nov 2021 19:55:25 +0100
From:   Marc Chantreux <mc@unistra.fr>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Subject: Re: no match should be no string ?
Message-ID: <YaPQnegQol71nnvd@prometheus.u-strasbg.fr>
References: <YaOOIf2d6tLP8xtw@prometheus.u-strasbg.fr>
 <65da119f-ad21-ff18-11cd-3157b02cb22d@gigawatt.nl>
 <YaOwJ9TVHsDrnIbM@prometheus.u-strasbg.fr>
 <da2913f2-b675-7bc0-9f8b-f2bfddedb9ca@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <da2913f2-b675-7bc0-9f8b-f2bfddedb9ca@gigawatt.nl>
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

hello Harald,

> If you get back exactly '*[n]o_way_this_glob_matches*', that is because=
 the
> glob did not match anything. A file by that name would not be picked up=
 by
> the glob. If you get back anything else, it was found by the glob.

correct but still: this behavior isn't "intellectually correct" to me so
i'll bet on find|xargs (which is great for many other reasons anyway).

thanks for trying so hard :)

regards
--=20
Marc Chantreux
Direction du num=E9rique de l'Universit=E9 de Strasbourg
P=F4le de Calcul et Services Avanc=E9s =E0 la Recherche (CESAR)
http://annuaire.unistra.fr/p/20200
