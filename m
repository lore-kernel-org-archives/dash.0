Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F209C433EF
	for <linux-dash@archiver.kernel.org>; Sun, 28 Nov 2021 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357902AbhK1OXP (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 28 Nov 2021 09:23:15 -0500
Received: from smtpout02-ext4.partage.renater.fr ([194.254.241.31]:41442 "EHLO
        smtpout02-ext4.partage.renater.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237729AbhK1OVO (ORCPT
        <rfc822;dash@vger.kernel.org>); Sun, 28 Nov 2021 09:21:14 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2021 09:21:13 EST
Received: from zmtaauth02.partage.renater.fr (zmtaauth02.partage.renater.fr [194.254.241.25])
        by smtpout20.partage.renater.fr (Postfix) with ESMTP id 1F316BFB0F
        for <dash@vger.kernel.org>; Sun, 28 Nov 2021 15:11:47 +0100 (CET)
Received: from zmtaauth02.partage.renater.fr (localhost [127.0.0.1])
        by zmtaauth02.partage.renater.fr (Postfix) with ESMTPS id 0EF1DA081D
        for <dash@vger.kernel.org>; Sun, 28 Nov 2021 15:11:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaauth02.partage.renater.fr (Postfix) with ESMTP id F3C70A082C
        for <dash@vger.kernel.org>; Sun, 28 Nov 2021 15:11:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth02.partage.renater.fr F3C70A082C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
        s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1638108706;
        bh=Cv7+Uvl0uIzFg1tzeS8mVsCNEvG+a6BX5B64h4p/L0E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=m27Ck/2GQWkRZadk5WHDIz9xLpRmRO0ijKfnek7FjGpHWoTSSLMyjs3F5fMrYqkoM
         +ACoZcQsbJ8QhZmQK5UimeILjyKwtkWnnbW9Inx7bmTvIx5IRVZD/j178R9H28SzKZ
         2pQrwZt0V2fjh2aDQ9iCGO59MimAQOVOQsFyoUk8aihwmWWtBvDl2qs8e45t8hwVnP
         7hsme9U+ee6Hifh29/5vvNUzYzokHcEgNkFfiQkQLP6gieINGuHRmzS3Dt1z77ebFt
         X5xtU4xX764f+xOfcZqUSPd2RBz7YJ5Vouoitd6yE05aKNxvrIl8gwFB3iy0d1W/y9
         N3zhd27RY7iHQ==
X-Virus-Scanned: amavisd-new at zmtaauth02.partage.renater.fr
Received: from zmtaauth02.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaauth02.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XtTitNzLMQXG for <dash@vger.kernel.org>;
        Sun, 28 Nov 2021 15:11:46 +0100 (CET)
Received: from 82.65.50.238 (unknown [194.254.241.249])
        by zmtaauth02.partage.renater.fr (Postfix) with ESMTPA id B6340A081D
        for <dash@vger.kernel.org>; Sun, 28 Nov 2021 15:11:46 +0100 (CET)
Date:   Sun, 28 Nov 2021 15:11:45 +0100
From:   Marc Chantreux <mc@unistra.fr>
To:     dash@vger.kernel.org
Subject: no match should be no string ?
Message-ID: <YaOOIf2d6tLP8xtw@prometheus.u-strasbg.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

hello people,

I'm porting scripts from zsh to dash using version
0.5.11+git20200708+dd9ef66-5 from debian and
surprised to realize that the result of a glob failure is the glob
itself (when i expected an empty string).

    for it in *.txt; do gzip $it; done
    ERR: gzip: *.g: No such file or directory

    note () >&2 echo "$@"
    rm -rf *.g
    set *.g
    case $#
        in (0) echo ok
        ;; (*) echo nope
    esac
    ERR: nope

not only unexpected but it also make it harder to deal
with.  i found nothing about that in the manual
so before i dig into the code and provide a patch,
i would like to know if this is an expected behavior
with a rationale in it (like a bug to bug clone or
POSIX compliance).

regards,
--=20
Marc Chantreux
Direction du num=E9rique de l'Universit=E9 de Strasbourg
P=F4le de Calcul et Services Avanc=E9s =E0 la Recherche (CESAR)
http://annuaire.unistra.fr/p/20200
