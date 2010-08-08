From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: The Greek letter "rho" is considered as two letters
Date: Sun, 8 Aug 2010 14:56:25 +0200
Message-ID: <20100808125625.GA83966@stack.nl>
References: <1281209874.6631.37.camel@alkis>
 <1281211032.6631.45.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:56877 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753980Ab0HHM40 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 8 Aug 2010 08:56:26 -0400
Content-Disposition: inline
In-Reply-To: <1281211032.6631.45.camel@alkis>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: dash@vger.kernel.org

On Sat, Aug 07, 2010 at 10:57:12PM +0300, Alkis Georgopoulos wrote:
> Erm actually this problem happens with all utf8 characters, i.e. dash
> does not properly take utf8 characters into account when expanding "?=
".

> $ touch app=E9tit             =20
> $ ls app?tit
> ls: cannot access app?tit: No such file or directory
> $ ls app??tit
> app=E9tit

Yes, it seems that dash has zero support for locales. In some ways this
is an advantage, as locale support can make things considerably slower
and configure/startup scripts don't need it. However, it leads to
inconsistent behaviour with other utilities that do support locales.

=46or FreeBSD's /bin/sh, which is another ash variant, I think some deg=
ree
of locale support (at least for utf-8) is desirable at some point. This
would include changing pattern matching and ${#var}.

I don't know what Herbert Xu thinks about this.

--=20
Jilles Tjoelker
