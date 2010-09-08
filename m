From: maximilian attems <max@stro.at>
Subject: Re: dash klibc DEBUG more compile trouble
Date: Wed, 8 Sep 2010 18:20:17 +0200
Message-ID: <20100908162017.GB27278@stro.at>
References: <20100709144330.GA23188@stro.at>
 <20100710221518.GA9154@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:48930 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab0IHQUk (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Sep 2010 12:20:40 -0400
Content-Disposition: inline
In-Reply-To: <20100710221518.GA9154@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, klibc@zytor.com

On Sun, 11 Jul 2010, Herbert Xu wrote:

> maximilian attems <max@stro.at> wrote:
> > once taken that stat/stat64 appart, histedit appears to be a minefield:
> 
> Unless you have libedit, you're supposed to define SMALL.

indeed we do define it, but it was due to my poor Kconfig foo
that it gets undefined again on debug compile run.
thanks Herbert for aboves comment, helped out.

so compiling klibc with
 make   KLIBCKERNELSRC=`pwd`/../linux-2.6 EXTRA_KLIBCCFLAGS="-DDEBUG=1 " V=1

is either wrong or the klibc Kbuild is buggy as it undefines the Kbuild
specific entries in the subdirs.
so in usr/dash/Kbuild the config-cppflags are no longer used on build.

Sam any opinon?


thanks

-- 
maks
