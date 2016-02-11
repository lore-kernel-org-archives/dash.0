From: Makarius <makarius@sketis.net>
Subject: Re: dash drops exported bash functions
Date: Thu, 11 Feb 2016 04:53:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602110431550.61314@lxbroy10.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1618778321-1437632775-1455162828=:61314"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:59272 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750801AbcBKEBR (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 10 Feb 2016 23:01:17 -0500
Received: from localhost (scan46 [10.46.146.16])
	by mail46.informatik.tu-muenchen.de (Postfix) with ESMTP id C1A8F885ED168
	for <dash@vger.kernel.org>; Thu, 11 Feb 2016 04:53:48 +0100 (CET)
Received: from mail46.informatik.tu-muenchen.de ([10.46.146.15])
	by localhost (mail46.informatik.tu-muenchen.de [10.46.146.16]) (amavisd-new, port 10026)
	with ESMTP id 2ANw4RRka5Y1 for <dash@vger.kernel.org>;
	Thu, 11 Feb 2016 04:53:48 +0100 (CET)
Received: from lxbroy10.informatik.tu-muenchen.de (lxbroy10.informatik.tu-muenchen.de [131.159.47.103])
	by mail46.informatik.tu-muenchen.de (Postfix) with ESMTPSA id 914F9885ED15D
	for <dash@vger.kernel.org>; Thu, 11 Feb 2016 04:53:48 +0100 (CET)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1618778321-1437632775-1455162828=:61314
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On 02/10/2016 08:54:40 Eric Blake wrote:

> That said, preserving any unusable environment variables unchanged,
> rather than scrubbing them, may be slightly nicer behavior, but I'm not
> sure it's worth the bloat to dash to do so.

> > Exporting bash functions via the environment might be a rarely used 
> > feature, but it is used in practice, unfortunately (otherwise I 
> > wouldn¢t have noticed this).
>
> Exporting bash functions is only usable if you plan on directly invoking 
> bash.  Don't drag dash into the mess.  Inserting a dash child in between 
> a bash parent and grandchild means all bets are off for whether the 
> grandparent can export anything to the grandchild.

Eric,

I am a long-term user of GNU bash who is depending on the "export -f" 
feature of that shell (in an application that is on the free market for 
decades). The bash guys turn a shell function "foo" into the environment 
variable "BASH_FUNC_foo%%" and hope to be able to pick it up later on.

Dash gets into this game, because Ubuntu and Debian have chosen to make it 
the default for /bin/sh some years ago. This means that typical "system" 
invocations of Unix tools and libraries are now going through dash: 
/bin/sh -c is often seen in practice instead of more delicate execve 
invocations.

This means with /bin/sh -> dash users have no proper chance to avoid it. 
Sitting right there in the center /bin/sh, dash acquires special 
responsibilities to play nice with other shells.


Note that the issue has come up now due to this recent change in 
Debian-testing: https://tracker.debian.org/news/744916

Thus a the following change from 2012 became exposed to testers/users of 
Debian: 
http://git.kernel.org/cgit/utils/dash/dash.git/commit/?id=46d3c1a614f11f0d40a7e73376359618ff07abcd

In that change 46d3c1a614f, the original motivation was to make "export 
-p" work more robustly in dash, and not to cripple export -f in bash 
because of POSIX violations.


 	Makarius
---1618778321-1437632775-1455162828=:61314--
