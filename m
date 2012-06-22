From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Set SA_RESTART flag on SIGCHLD handler
Date: Fri, 22 Jun 2012 05:36:12 -0400
Message-ID: <4FE43C8C.2040809@mit.edu>
References: <4F665E77.3060102@mit.edu> <20120319025201.GA24778@burratino> <4F66A6CA.4010002@mit.edu> <20120319033751.GA25237@burratino> <alpine.DEB.2.00.1206210345050.3236@dr-wily.mit.edu> <20120622003628.GD4730@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:59889 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761916Ab2FVJlQ (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 22 Jun 2012 05:41:16 -0400
In-Reply-To: <20120622003628.GD4730@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org, git@packages.debian.org

On 06/21/2012 08:36 PM, Jonathan Nieder wrote:
> Thanks.  Here's a less invasive patch to experiment with.

Hmm.  I=E2=80=99ve kicked off several builds in the git-core PPA, first=
 under=20
dash with the original patch, now under dash with the less invasive=20
patch.  Under either dash, almost all of the builds end up trapped in=20
what looks like a deadlock, at various parts of t9010-svn-fe.sh.

https://launchpad.net/~git-core/+archive/ppa/+build/3596228
https://launchpad.net/~git-core/+archive/ppa/+build/3596229
https://launchpad.net/~git-core/+archive/ppa/+build/3597370
https://launchpad.net/~git-core/+archive/ppa/+build/3597371

I=E2=80=99ll try to debug this later by hacking up the package to run t=
hat=20
script through strace -fiv during build (since I still can=E2=80=99t re=
produce=20
locally), unless you have anything more clever to try.

Anders

