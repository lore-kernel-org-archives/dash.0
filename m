From: Seb <sbb@tuxfamily.org>
Subject: Re: --with-libedit as default
Date: Sun, 4 Aug 2013 19:09:18 +0200
Message-ID: <20130804190918.7d0b790bf779c431e408f817@tuxfamily.org>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
	<20130804010244.GL2893@elie.Belkin>
	<CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com>
	<20130804114350.fc97c50b21f4a63ad5f089d3@tuxfamily.org>
	<CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:43142 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328Ab3HDRKM (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 4 Aug 2013 13:10:12 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 6B543D1A699
	for <dash@vger.kernel.org>; Sun,  4 Aug 2013 19:10:03 +0200 (CEST)
In-Reply-To: <CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?UTF-8?B?TWF1csOtY2lv?= Antunes <mauricio.antunes@gmail.com>
Cc: dash@vger.kernel.org

Le Sun, 4 Aug 2013 13:21:37 -0300
Maur=C3=ADcio Antunes a =C3=A9crit:

> What would it take to have auto-completion in dash
> (even if disabled by default)?

You'll need to implement it, using the libedit API, I think (there
are some examples in the "examples" directory, at the root of its
source archive). I'm rather a poor C coder, so I can't tell if it
will be difficult or not (probably not trivial, as nobody's ever done
it).

++
Seb.
