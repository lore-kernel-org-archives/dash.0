From: =?UTF-8?Q?Maur=C3=ADcio_Antunes?= <mauricio.antunes@gmail.com>
Subject: Re: --with-libedit as default
Date: Sun, 4 Aug 2013 02:11:25 -0300
Message-ID: <CAA4sSt=7K=GXZFnQ741ZBfcUtj3xZ45ir0TCfg9dtekga-DahQ@mail.gmail.com>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
	<20130804010244.GL2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pd0-f195.google.com ([209.85.192.195]:38386 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab3HDFLZ convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 4 Aug 2013 01:11:25 -0400
Received: by mail-pd0-f195.google.com with SMTP id u10so1407985pdi.10
        for <dash@vger.kernel.org>; Sat, 03 Aug 2013 22:11:25 -0700 (PDT)
In-Reply-To: <20130804010244.GL2893@elie.Belkin>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2013/8/3, Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> Maur=C3=ADcio Antunes wrote:
>
>>                                              The reason why I think
>> it's a good idea is because this is what Posix demands, and many lin=
ux
>> distributions forget to add that option (maybe because they see dash
>> just as an efficient tool for scripts, not as a nice login shell).
>
> If you're thinking of Debian, it's not forgetfulness that causes
> them not to include the option. ;-)
>
> Can you say a little more about why the option should be enabled in
> distributions?  Do you use dash as an interactive shell?  Currently
> the dash package tries to be pretty small for the sake of minimal
> systems.  A build using readline (since that library is already part
> of the base system) might make sense, or it might make sense to bite
> the bullet and use libedit (which is after all only about 150 KiB).

Oh, I didn't know about that. I don't usually deal with system with
minimal resources.

I would like to use dash as an interactive shell. My motivation isn't
anything more serious than the fact that it has a small documentation,
which I can read and understand easily. Maybe my own memory is the limi=
ted
resource with which I have to deal :) My current shell uses tree  or
four initialization files, and I can never remember which one is read
when. Dash has only one (.profile). I like that.

Maur=C3=ADcio
