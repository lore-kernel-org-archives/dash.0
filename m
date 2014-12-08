From: "solsTiCe d'Hiver" <solstice.dhiver@gmail.com>
Subject: "if [ s1 > s2 ]" broken, writing a s2 file
Date: Mon, 8 Dec 2014 18:32:21 +0100
Message-ID: <CAE4vF2dip455tXT4K3XwJy1Pp_qrw0fupd3xoAKUgbCG7vcFzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:45801 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbaLHRcW (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Dec 2014 12:32:22 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so4086692lbv.26
        for <dash@vger.kernel.org>; Mon, 08 Dec 2014 09:32:21 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

hello,
folowing that bug
https://bugs.launchpad.net/ubuntu/+source/update-notifier/+bug/1400357,
I follow through to investigate and I found out
that whatever I try, when comparing 2 strings I always end up with a
file written to disk

From the man page
test expression
     [ expression ]
[...]
s1 > s2       True if string s1 comes after s2 based on the ASCII
value of their characters.

when I try to use it:
a="ert"
b="aze"
if [ $a > $b ] ; then
echo yes
fi
if [ "aer" > "azer" ] ;then
echo yes
fi

I got 2 yes printed on screen whereas only one should and most
importantly I got 2 empty files written to disk: one called "aze", and
another one "azer"

so this "if syntax" is broken or I don't knwo how to use it.

Also it is really dangerous  to use a syntax similar to file
redirection and this is exactly what is happening here.

this is happening with 0.5.8 too
