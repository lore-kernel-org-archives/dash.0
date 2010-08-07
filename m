From: Alkis Georgopoulos <alkisg@gmail.com>
Subject: The Greek letter "rho" is considered as two letters
Date: Sat, 07 Aug 2010 22:37:54 +0300
Message-ID: <1281209874.6631.37.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33880 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab0HGTiA (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 7 Aug 2010 15:38:00 -0400
Received: by fxm14 with SMTP id 14so4416632fxm.19
        for <dash@vger.kernel.org>; Sat, 07 Aug 2010 12:37:59 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

$ touch =CF=81
$ ls ?
ls: cannot access ?: No such file or directory
$ ls ??
=CF=81

It happens to some utf-8 characters, but not for all of them.
This might be related:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D532302

Please CC me if possible, I'm not on the list.

Kind regards,
Alkis Georgopoulos

