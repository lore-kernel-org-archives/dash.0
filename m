From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Set SA_RESTART flag on SIGCHLD handler
Date: Tue, 26 Jun 2012 08:19:36 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1206260816430.3236@dr-wily.mit.edu>
References: <4F665E77.3060102@mit.edu> <20120319025201.GA24778@burratino> <4F66A6CA.4010002@mit.edu> <20120319033751.GA25237@burratino> <alpine.DEB.2.00.1206210345050.3236@dr-wily.mit.edu> <20120622003628.GD4730@burratino> <4FE43C8C.2040809@mit.edu>
 <4FE98907.4040507@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:46640 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754872Ab2FZMTk convert rfc822-to-8bit
	(ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 26 Jun 2012 08:19:40 -0400
In-Reply-To: <4FE98907.4040507@mit.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, git@packages.debian.org

On Tue, 26 Jun 2012, Anders Kaseorg wrote:
> But if that=E2=80=99s what happened, it seems like a kernel bug to me=
!
> Shouldn=E2=80=99t an open() call only be restarted or return EINTR in=
 the case
> that it hasn=E2=80=99t had any side effects yet and can safely be res=
tarted?

I submitted a kernel patch:
http://marc.info/?l=3Dlinux-kernel&m=3D134071285509470

Anders
