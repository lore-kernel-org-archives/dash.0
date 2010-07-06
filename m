From: Malcolm Kay <malcolm.kay@internode.on.net>
Subject: Re: if then elif then else fi -- Problem report
Date: Tue, 6 Jul 2010 17:18:54 +0930
Message-ID: <201007061718.54673.malcolm.kay@internode.on.net>
References: <201006282226.22001.malcolm.kay@internode.on.net> <201006291038.31206.malcolm.kay@internode.on.net> <20100704215016.GA27297@lisa.in-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:46871 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754021Ab0GFHs5 (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 6 Jul 2010 03:48:57 -0400
In-Reply-To: <20100704215016.GA27297@lisa.in-ulm.de>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: mascheck@in-ulm.de
Cc: dash@vger.kernel.org

On Mon, 5 Jul 2010 07:20 am, Sven Mascheck wrote:
> On Tue, Jun 29, 2010 at 10:38:31AM +0930, Malcolm Kay wrote:
> > I had assumed that 'dash' aimed to be a faster replacement
> > for the classical Bourne shell 'sh' as implemented in BSD
> > systems, and this seemed to be confirmed when all the man
> > pages I've been able to find were more or less direct copies
> > of BSD 'sh' pages.
>
> The original ash (at the time of 4.3BSD-Net2) was such a
> replacement of the SVR4 Bourne shell.  But with the next
> "traditional" BSD release, 4.4BSD alpha, the shell was already
> aiming at POSIX; and so were the shells on NetBSD (1.0 ff) and
> FreeBSD, soon.

I recall seeing and even playing with an implementation of 
the Almquist shell 'ash' in the mid 1980's but as it was running 
on an unimpressive/unsuitable operating system (DRDOS/TOS) it
was not really very inspiring. 

Later I picked up a microVAX with Ultrix 4, I still have the 
manuals. The man pages reference sh(1) as "the standard Bourne 
shell interpreter" and sh5(1) as a "version of the shell from 
System V version 2". In general the sh(1) pages has seemed to 
conform fairly closely to 'sh' as found on modern BSD operating 
systems. But now that I look more closely I find that both the 
Ultrix man pages define a list as "one or more ..." ,
rather the "zero or more ..." as in later man pages -- so it 
would seem at least in that respect the Ultrix corresponds more 
closely to what was then a not yet existing POSIX standard. 

In a way I do find this rather surprising as POSIX appeared
in an era when languages such as fortran and basic which started
counting at one were becoming displaced (admittedly rather 
slowly) by languages that incorporated zero, C, pascal and 
virtually all the modern OOP languages.

>
> However, there is a relation from 4.3BSD-Net2, 386BSD,
> earlyNetBSD to a Linux port, and thus a Bourne-like ash
> interestingly survived with Slackware until 2007 (8.1).
>
> dash in contrast was an independent, later port from NetBSD to
> Linux and was a modern variant from the start.

History can be interesting and sometimes somewhat surpising.

Malcolm

