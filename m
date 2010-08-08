From: Alkis Georgopoulos <alkisg@gmail.com>
Subject: Re: ? doesn't match non-ascii characters
Date: Sun, 08 Aug 2010 15:55:51 +0300
Message-ID: <1281272151.1611.12.camel@alkis>
References: <1281209874.6631.37.camel@alkis>
	 <1281211032.6631.45.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57123 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab0HHMzz (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Aug 2010 08:55:55 -0400
Received: by fxm14 with SMTP id 14so4566904fxm.19
        for <dash@vger.kernel.org>; Sun, 08 Aug 2010 05:55:54 -0700 (PDT)
In-Reply-To: <1281211032.6631.45.camel@alkis>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I've changed the title because it was misleading
(was: "The Greek letter "rho" is considered as two letters").

Repeating the problem,

$ touch app=C3=A9tit             =20
$ ls app?tit
ls: cannot access app?tit: No such file or directory
$ ls app??tit
app=C3=A9tit

I.e. double-byte utf-8 characters need two "?" to be matched.,
triple-byte utf-8 characters (e.g. =E1=BC=80) need three "?" to be matc=
hed etc.

