From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: --with-libedit as default
Date: Sat, 3 Aug 2013 18:02:44 -0700
Message-ID: <20130804010244.GL2893@elie.Belkin>
References: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60949 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3HDBCt convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 3 Aug 2013 21:02:49 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1989990pab.15
        for <dash@vger.kernel.org>; Sat, 03 Aug 2013 18:02:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?utf-8?B?TWF1csOtY2lv?= Antunes <mauricio.antunes@gmail.com>
Cc: dash@vger.kernel.org, 524839@bugs.debian.org

Hi,

Maur=C3=ADcio Antunes wrote:

>                                              The reason why I think
> it's a good idea is because this is what Posix demands, and many linu=
x
> distributions forget to add that option (maybe because they see dash
> just as an efficient tool for scripts, not as a nice login shell).

If you're thinking of Debian, it's not forgetfulness that causes
them not to include the option. ;-)

Can you say a little more about why the option should be enabled in
distributions?  Do you use dash as an interactive shell?  Currently
the dash package tries to be pretty small for the sake of minimal
systems.  A build using readline (since that library is already part
of the base system) might make sense, or it might make sense to bite
the bullet and use libedit (which is after all only about 150 KiB).

Thanks and hope that helps,
Jonathan
