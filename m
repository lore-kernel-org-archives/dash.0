From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Shell source with relative pathname does not work
Date: Sun, 27 Apr 2008 13:54:18 +0200
Message-ID: <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
References: <1209282837.21826.6.camel@aurora.internal>
Reply-To: dash list <dash@vger.kernel.org>
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:55710 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYD0Lde (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 07:33:34 -0400
In-Reply-To: <1209282837.21826.6.camel@aurora.internal>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bill Maas <bill@stsx.org>
Cc: dash list <dash@vger.kernel.org>

Bill Maas @ Sun, 27 Apr 2008 09:53:57 +0200:
* Organization: STSX DOT ORG

> Hi folks,
[]
> First my compliments for the excellent work you are doing: I used to
> believe that slowness was just another shell feature.

Hallo, Bill. Please see history of the Almquist shell; you will find
interesting info there: http://www.in-ulm.de/~mascheck/various/ash/

As for optimization, IMHO `dash` is in deep bug-fixing mode. However
NetBSD version has some development wrt speed:

http://cvsweb.netbsd.org/bsdweb.cgi/src/bin/sh/var.c?rev=1.35&content-type=text/x-cvsweb-markup

> I possibly found a bug in Dash:
>
> . x.conf
> .: 1: x.conf: not found
>
> The source fails, even though x.conf is definitely there. The following
> variants do succeed:
>
> . /path/to/x.conf
> . ./x.conf

http://www.opengroup.org/onlinepubs/009695399/utilities/dot.html

So, behavior must be as for ordinary binaries -- searching PATH and
not current dir. by default. IMHO quite good decision -- care where
you are, and what you are executing.

`bash` seem to do searching in `.', but this must be its feature.
-- 
sed 'sed && sh + olecom = love' << ''
-o--=O`C
 #oo'L O
<___=E M
