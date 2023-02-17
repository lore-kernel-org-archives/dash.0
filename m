Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4298FC05027
	for <linux-dash@archiver.kernel.org>; Fri, 17 Feb 2023 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBQNgj (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 17 Feb 2023 08:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBQNgi (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 17 Feb 2023 08:36:38 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A81E9F4
        for <dash@vger.kernel.org>; Fri, 17 Feb 2023 05:36:35 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5288A240143
        for <dash@vger.kernel.org>; Fri, 17 Feb 2023 14:36:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1676640994; bh=BM6/erzjHAJmI53tMoZFALm7LCLPXTK53UKno4wUZvc=;
        h=Date:Subject:From:To:From;
        b=p1I+z3mVE7kbzo29l20qKDSlZvd7pyJT1tRQRcuvK5vyspWC80aB57UiSDdLOfQPb
         Fk1CfY2/bqAITTnSvbHwl8q1ha2zMcRkyKJ9xO0ovUkjGQyEQb9yr5aLzSS8Pin4Je
         VRcn1uiOHlRI1ecjjUT7nBzg6GkFeSntloiKoc+vaLaM0f7u2cLxf095SiJStR6Wpy
         N57dHL35KIvcCFXY7qntPqgof/V7MDKp+W4CGnpez+xRCGQeVRCAi0udb88MWFhcJc
         M2JZp36l0CHa4Yc6z0uz7ziYytHb0hVShDAMuaoY5833CW8RdQ5ZD3VCA18SYXeYaM
         8eatpivCEccnQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PJCX209Ykz6tmg
        for <dash@vger.kernel.org>; Fri, 17 Feb 2023 14:36:33 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 17 Feb 2023 13:35:37 +0000
Message-Id: <CQKVLXJRDK3X.124XXVEY9RH6K@morphine>
Subject: STATIC vs static
From:   "Tom Schwindl" <schwindl@posteo.de>
To:     <dash@vger.kernel.org>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi all,

as I was skimming through the codebase, I noticed that sometimes there is a
macro, STATIC, used to represent the normal static. Is there a reason for t=
hat
or would a s/STATIC/static/g be welcome? Now that we are revising the proto=
types
anyway I think it's the right time to bring this up.

--=20
Best Regards,
Tom Schwindl
