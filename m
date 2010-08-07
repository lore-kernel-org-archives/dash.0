From: Alkis Georgopoulos <alkisg@gmail.com>
Subject: Some utf-8 characters are cut in the middle on redirections
Date: Sat, 07 Aug 2010 23:05:42 +0300
Message-ID: <1281211542.6631.49.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38246 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0HGUFs (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 7 Aug 2010 16:05:48 -0400
Received: by fxm14 with SMTP id 14so4421476fxm.19
        for <dash@vger.kernel.org>; Sat, 07 Aug 2010 13:05:47 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

$ touch =CF=81
$ echo 1 > =CF=81
$ ls
?  =CF=81
$ ls | hexdump -C
00000000  cf 0a cf 81 0a

dash "cut" the "0x81" from the "0xcf81" representation of the Greek
character rho, and so it created another file named "0xcf".

This only happens for a few utf-8 characters, not for all of them.
Relevant bug report:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D532302

Please CC me if possible, I'm not on the list.

Kind regards,
Alkis Georgopoulos

