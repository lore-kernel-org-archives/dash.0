From: =?UTF-8?Q?Maur=C3=ADcio_Antunes?= <mauricio.antunes@gmail.com>
Subject: --with-libedit as default
Date: Sat, 3 Aug 2013 21:39:33 -0300
Message-ID: <CAA4sStkyXjKCfZ8O47r6V-aLPXZ5TiTRJDmys92n5W_N6TFnPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:54664 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3HDAje convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 3 Aug 2013 20:39:34 -0400
Received: by mail-pa0-f65.google.com with SMTP id fb10so1396371pad.0
        for <dash@vger.kernel.org>; Sat, 03 Aug 2013 17:39:33 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I would like to suggest this: do you think in its next version dash cou=
ld
enable libedit by default, instead of requiring it to be explicitly
requested when running the configure script? The reason why I think
it's a good idea is because this is what Posix demands, and many linux
distributions forget to add that option (maybe because they see dash
just as an efficient tool for scripts, not as a nice login shell).

Thanks. Best,
Maur=C3=ADcio
