From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Set SA_RESTART flag on SIGCHLD handler
Date: Sat, 21 Jul 2012 19:14:35 -0400
Message-ID: <500B37DB.5090800@mit.edu>
References: <4F665E77.3060102@mit.edu> <20120319025201.GA24778@burratino> <4F66A6CA.4010002@mit.edu> <20120319033751.GA25237@burratino> <alpine.DEB.2.00.1206210345050.3236@dr-wily.mit.edu> <20120622003628.GD4730@burratino> <4FE43C8C.2040809@mit.edu> <4FE98907.4040507@mit.edu> <alpine.DEB.2.00.1206260816430.3236@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:42880 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751808Ab2GUXOl (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 21 Jul 2012 19:14:41 -0400
In-Reply-To: <alpine.DEB.2.00.1206260816430.3236@dr-wily.mit.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, dash@vger.kernel.org, git@packages.debian.org, 678852@bugs.debian.org

On 06/26/2012 08:19 AM, Anders Kaseorg wrote:
>> But if that=E2=80=99s what happened, it seems like a kernel bug to m=
e!
>> Shouldn=E2=80=99t an open() call only be restarted or return EINTR i=
n the case
>> that it hasn=E2=80=99t had any side effects yet and can safely be re=
started?
>
> I submitted a kernel patch:
> http://marc.info/?l=3Dlinux-kernel&m=3D134071285509470

That=E2=80=99s now merged as v3.5~31, v3.4.6~25, and v3.0.38~17.

Anders

