From: Zando Fardones <bluesun654@gmail.com>
Subject: [BUG] Can't see accented letters with vi/emacs on
Date: Wed, 28 Jun 2017 21:35:45 +0200
Message-ID: <CAPLrsYdCeA=pYyCnpo2u6VcpbnUo+79DK69YM3JGEPit2J87EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38570 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdF1Tfr (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 28 Jun 2017 15:35:47 -0400
Received: by mail-wm0-f52.google.com with SMTP id b184so69473208wme.1
        for <dash@vger.kernel.org>; Wed, 28 Jun 2017 12:35:46 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

> set +o vi
> # =C3=A8
> # ^ OK, as long as vi is off.
> set -o vi
> # \U+00C3\U+00A8
> # ^ this is what I see when I type "=C3=A8", with *vi* on

> set +o emacs
> # =C3=A8
> # ^ OK, as long as emacs is off.
> set -o emacs
> #
> # ^ when I type "=C3=A8" with *emacs* on, I see nothing

Of course you need to compile DASH with "--with-libedit" in order to
reproduce the issue.
