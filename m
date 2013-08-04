From: Roy Tam <roytam@gmail.com>
Subject: Re: --with-libedit as default
Date: Mon, 5 Aug 2013 06:46:44 +0800
Message-ID: <CAA=zYJZ8V6YYScpA=eD9rYrVeDdN1L=kPk7X_4Qh3yCXsm710g@mail.gmail.com>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
 <20130804010244.GL2893@elie.Belkin> <CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com>
 <20130804114350.fc97c50b21f4a63ad5f089d3@tuxfamily.org> <CAA4sStnUN0gQD0anxuTyqGrpa3nUAY2zndJBkVUkqa4=x8N=qA@mail.gmail.com>
 <20130804190918.7d0b790bf779c431e408f817@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:40928 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab3HDWrH convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 4 Aug 2013 18:47:07 -0400
Received: by mail-la0-f45.google.com with SMTP id fj20so1604457lab.4
        for <dash@vger.kernel.org>; Sun, 04 Aug 2013 15:47:05 -0700 (PDT)
In-Reply-To: <20130804190918.7d0b790bf779c431e408f817@tuxfamily.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Seb <sbb@tuxfamily.org>
Cc: =?ISO-8859-1?Q?Maur=EDcio_Antunes?= <mauricio.antunes@gmail.com>, dash@vger.kernel.org

2013/8/5 Seb <sbb@tuxfamily.org>:
> Le Sun, 4 Aug 2013 13:21:37 -0300
> Maur=EDcio Antunes a =E9crit:
>
>> What would it take to have auto-completion in dash
>> (even if disabled by default)?
>
> You'll need to implement it, using the libedit API, I think (there
> are some examples in the "examples" directory, at the root of its
> source archive). I'm rather a poor C coder, so I can't tell if it
> will be difficult or not (probably not trivial, as nobody's ever done
> it).
>

Or try porting function from NetBSD libedit and /bin/sh.

> ++
> Seb.
> --
> To unsubscribe from this list: send the line "unsubscribe dash" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
