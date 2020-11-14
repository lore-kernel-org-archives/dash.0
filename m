Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_A1,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50632C5519F
	for <linux-dash@archiver.kernel.org>; Sat, 14 Nov 2020 13:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA7C22252
	for <linux-dash@archiver.kernel.org>; Sat, 14 Nov 2020 13:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="KLIs4ob/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKNNiY (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Nov 2020 08:38:24 -0500
Received: from mout.web.de ([212.227.17.12]:33105 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNNiW (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Nov 2020 08:38:22 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2020 08:38:22 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605361101;
        bh=kuKhvItR/8xzzpYrbMcH90Fn+z5H2egM2I4FILw4pWA=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=KLIs4ob/1Q4zWcNBzcYB1ViRjloAKrnlz5UN+HNVO8s4XeN/W4D3J9xXbpy1wps+x
         +Jljm9TgBjWpVgl/VaPNCG2H2TjOhS1FS8Inso62HOBtmDcWtA6r50fBw4eWZNIzFK
         kBiEyzXy820tP7RnvEuaZHJ7aZuK9Fsp73l6fPu4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lqleo-1k8Qbk0Tju-00eMHz for
 <dash@vger.kernel.org>; Sat, 14 Nov 2020 14:33:18 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     dash@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] shell: Enable fnmatch/glob by default
Message-ID: <b8881007-eb6d-17b4-a023-31275ef28b94@web.de>
Date:   Sat, 14 Nov 2020 14:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OcaNJjuvUxGvBienbKi9dVPpBlcrbBf/Wj5God7vrciTN1t3SvI
 nNN5qWI6/aR5DpUKBpvQDmg+zXP8Lc/sHZlaGmZvRBQSl2GGUw9x/6J0hqf5v9cwj3rUJQH
 PlPHJWUGr3kUJJziuINpTaldqvlP1moK1FivKRduNl2I9D/7ANoP0D8c4iru1kX1HReaIkF
 C/SB5OkDhya0jBRml4e2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5LAxC0VBFO4=:8NF7AFp+CFT/p/QGYVKlOE
 plQPJ/4RGKppWwkSKuV9YX16/kkWErMeF6PXWapnF41rHcNpSDgCk/Ehf4Gmlp92Dlrn1nZTI
 gUgq4kwhjXF4NW0D+1TyTC0mlkdMffWc9pCJ9koLdGvEjstMF9MHCX6UkQTGlX4MrqeJYlmfj
 ChDLJlKpLj6cBJ3R14AriNwGt8kdauVvYzaJ5StkOrVmrqiwy55b9+1VkXByyTmBi5j/nwSc3
 20sxaPW3XtYGMeCiDgVY8fPTCMkqjbCg1EZWKAu/4cTBuVf2QL4zRdyMs3hiFJN+DQyXydOi9
 wC7s2MvTPwJhSeuP0LZwDD5yd6cNWoGK0NIlOtkAvdy0GdwwXw33k5V1+ycKPk6Lb89lDqQn+
 i4JjBXucEh01UrS6WWs/TdcUpcpjdMEnvuv9Nqr+PLbtvW9suaWWdywLa1TIXv2UFjid5rs/d
 AwdmrF11rDOFL72NU4Z/YBJiqMJqAuSVQI1GOcx2v+9RGcrRdOX2zUH/jqRLdY0s5Dc/NCU2A
 YNGADm/DDUz7K1ErS7m8+C/YjkaLDK9GuGsexp2f080D/+Y1hfHh8/XImMlQKfIvEnr/i0GY6
 fPXnyIRJlIZbDrtDSjsZ6FAKjI12dbjP5Uv37vX3WpBy+/+qcGd1IvCupVfpKDG9WcC2sKU7H
 +BZ82KYYKpnSSCXmYR6tL21tVP0HP8O1J1joJ8g99QBsBulD0QN00LUp6tKU0a79bDhlb0+Ka
 3iEZiJfMdQYM3LZfz2BQrSOqq3bXoGSaN3+71a6357os+ZCVC367Cu1ZRlxvnbhVLb4wXFCmW
 3d5p1ASwUMyCR0cS9sRjrllJ0DzZ6OBpCFuPFrx0SXYxbidgd/xpLcPzfE/3g9TdjV0TVDVx7
 Df+zaHeCWszeqJU077sA==
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

on Debian testing dash eats trailing slashes of parameters that happen
to be regular files when expanding "$@".  Example:

   $ rm -f foo bar
   $ touch foo
   $ dash -c 'echo "$0" "$@"' baz foo/ bar/ ./
   baz foo bar/ ./

So slashes after non-existing files and directories are kept.

This behavior was introduced by 7638476 (shell: Enable fnmatch/glob by
default, 2020-05-28).  Before this commit trailing slashes were kept
also for regular files:

   $ dash -c 'echo "$0" "$@"' baz foo/ bar/ ./
   baz foo/ bar/ ./

This feels like a bug to me: Intuitively, foo/ should not match a
regular file foo, so such a string should be kept as-is.

I noticed it today because Debian testing imported the current version
of dash and some tests of Git's internal test suite rely on trailing
slashes to be retained.

Ren=C3=A9
