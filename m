Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389FDC433F5
	for <linux-dash@archiver.kernel.org>; Sun, 28 Nov 2021 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhK1Qur (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:50:47 -0500
Received: from smtpout01-ext2.partage.renater.fr ([194.254.240.33]:55070 "EHLO
        smtpout01-ext2.partage.renater.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238229AbhK1Qsr (ORCPT
        <rfc822;dash@vger.kernel.org>); Sun, 28 Nov 2021 11:48:47 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2021 11:48:47 EST
Received: from zmtaauth01.partage.renater.fr (zmtaauth01.partage.renater.fr [194.254.240.25])
        by smtpout10.partage.renater.fr (Postfix) with ESMTP id 4CC526217D;
        Sun, 28 Nov 2021 17:36:57 +0100 (CET)
Received: from zmtaauth01.partage.renater.fr (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPS id 4077E140861;
        Sun, 28 Nov 2021 17:36:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTP id 2C5EA140860;
        Sun, 28 Nov 2021 17:36:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth01.partage.renater.fr 2C5EA140860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
        s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1638117417;
        bh=S4d8il/DaNVkUUf/jq7O3x6Pr7As6RG3Iv5fRN1mXq4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CCKei7RRqK+UU2HfEq20msEc0XcN1p5652q8bH+B2r8rHH0k/E4KI8edbHq6BW/mz
         kR8rsSkawsUSTjNOsx+j/CSCvZM2MHp41x1HPyqkmbTTfB4AP6VidPMIIT77hfWIa/
         xR7KiVfKrErVIH/7xKJxpKChFfuDEQlP/swduKZyE3Eaj9Rk9J0f8f97Q9/FgyZBIV
         gxcI+XZRHq6jdT2l7O+PXhNqUyuyYxLqezp+7EJWNGBkxKaeLkV4IQ8fQSP4p3FzME
         DTx796GSOHUyXHFk9J7sJQ8nA6VqqWMn3JWrcb+r4EalFeLJb5RpjpJPtmC5DIe7ZO
         coyzBjiB2Uf7Q==
X-Virus-Scanned: amavisd-new at zmtaauth01.partage.renater.fr
Received: from zmtaauth01.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaauth01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PBVWepetsTvG; Sun, 28 Nov 2021 17:36:57 +0100 (CET)
Received: from 82.65.50.238 (unknown [194.254.241.250])
        by zmtaauth01.partage.renater.fr (Postfix) with ESMTPA id DA7CE140867;
        Sun, 28 Nov 2021 17:36:56 +0100 (CET)
Date:   Sun, 28 Nov 2021 17:36:55 +0100
From:   Marc Chantreux <mc@unistra.fr>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     dash@vger.kernel.org
Subject: Re: no match should be no string ?
Message-ID: <YaOwJ9TVHsDrnIbM@prometheus.u-strasbg.fr>
References: <YaOOIf2d6tLP8xtw@prometheus.u-strasbg.fr>
 <65da119f-ad21-ff18-11cd-3157b02cb22d@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <65da119f-ad21-ff18-11cd-3157b02cb22d@gigawatt.nl>
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

hello,

> Hi, yes, this is expected, this is standard POSIX sh behaviour and
> implemented by all POSIX sh-compatible shells. It should even be what z=
sh
> does when running in POSIX mode, but I do not have it installed right n=
ow to
> check.

You're right!

emulate sh
set *no_way_this_glob_matches*
echo $@

outputs *no_way_this_glob_matches*

> In bash, it is optional, you get the glob itself by default, but there =
is a
> "nullglob" shell option you can set to get what you are asking for.

emulate zsh
set *no_way_this_glob_matches*
echo $@
ERR: zsh: no matches found: *no_way_this_glob_matches*

emulate zsh
set -- *no_way_this_glob_matches*(N)
echo $#
OUT: 0

> In ksh, it is optional, you get the glob itself by default, but there i=
s a
> special thing where you can start a glob with ~(N) to change only that =
glob
> only to expand to nothing if there is no match.

ok so (N) is a ksh inspired! thanks for the fish.

> I personally suspect dash will not want to implement either extension u=
ntil
> POSIX decides which extension, if either/any, to standardise at some po=
int.

which is understandable but not usable because of

* the ambiguity when $# is 1: there is no way to know if i have no match
  or if a very bad person named its file \*no_way_this_glob_matches\*.
* i can't trust a loop like
    for it in \*no_way_this_glob_matches\*; do gzip "$it"; done

fortunately, this POSIX problem will not affect my daily life as

* i use zsh when i want a QND script or need an interactive shell
* for anything else, i use find . -name \*no_way_this_glob_matches\* -max=
depth 1 -print0

thank you so much for your help.

--=20
Marc Chantreux
Direction du num=E9rique de l'Universit=E9 de Strasbourg
P=F4le de Calcul et Services Avanc=E9s =E0 la Recherche (CESAR)
http://annuaire.unistra.fr/p/20200
