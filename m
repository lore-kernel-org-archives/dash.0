From: Alkis Georgopoulos <alkisg@gmail.com>
Subject: Re: The Greek letter "rho" is considered as two letters
Date: Sat, 07 Aug 2010 22:57:12 +0300
Message-ID: <1281211032.6631.45.camel@alkis>
References: <1281209874.6631.37.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52383 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0HGT5S (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 7 Aug 2010 15:57:18 -0400
Received: by fxm14 with SMTP id 14so4420024fxm.19
        for <dash@vger.kernel.org>; Sat, 07 Aug 2010 12:57:17 -0700 (PDT)
In-Reply-To: <1281209874.6631.37.camel@alkis>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Erm actually this problem happens with all utf8 characters, i.e. dash
does not properly take utf8 characters into account when expanding "?".

$ touch app=C3=A9tit             =20
$ ls app?tit
ls: cannot access app?tit: No such file or directory
$ ls app??tit
app=C3=A9tit


I'll send another mail about the greek rho problem which occurs only
with redirections.

