From: Sven Mascheck <mascheck@in-ulm.de>
Subject: Re: if then elif then else fi -- Problem report
Date: Sun, 4 Jul 2010 23:50:16 +0200
Message-ID: <20100704215016.GA27297@lisa.in-ulm.de>
References: <201006282226.22001.malcolm.kay@internode.on.net> <4C28A1FA.1090306@redhat.com> <201006291038.31206.malcolm.kay@internode.on.net>
Reply-To: mascheck@in-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.in-ulm.de ([217.10.8.10]:53837 "HELO mail.in-ulm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754456Ab0GDV46 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 4 Jul 2010 17:56:58 -0400
Content-Disposition: inline
In-Reply-To: <201006291038.31206.malcolm.kay@internode.on.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Tue, Jun 29, 2010 at 10:38:31AM +0930, Malcolm Kay wrote:

> I had assumed that 'dash' aimed to be a faster replacement for 
> the classical Bourne shell 'sh' as implemented in BSD systems,
> and this seemed to be confirmed when all the man pages I've been 
> able to find were more or less direct copies of BSD 'sh' pages.

The original ash (at the time of 4.3BSD-Net2) was such a replacement
of the SVR4 Bourne shell.  But with the next "traditional" BSD release,
4.4BSD alpha, the shell was already aiming at POSIX; and so were the
shells on NetBSD (1.0 ff) and FreeBSD, soon.

However, there is a relation from 4.3BSD-Net2, 386BSD, earlyNetBSD to
a Linux port, and thus a Bourne-like ash interestingly survived with
Slackware until 2007 (8.1).

dash in contrast was an independent, later port from NetBSD to Linux
and was a modern variant from the start.
