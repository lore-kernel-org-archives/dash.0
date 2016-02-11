From: Makarius <makarius@sketis.net>
Subject: Re: dash drops exported bash functions
Date: Thu, 11 Feb 2016 13:15:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602111309450.33198@lxbroy10.informatik.tu-muenchen.de>
References: <alpine.LNX.2.00.1602110431550.61314@lxbroy10.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:57419 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751779AbcBKMPO (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 11 Feb 2016 07:15:14 -0500
Received: from localhost (scan46 [10.46.146.16])
	by mail46.informatik.tu-muenchen.de (Postfix) with ESMTP id 31E9E885ED15A
	for <dash@vger.kernel.org>; Thu, 11 Feb 2016 13:15:12 +0100 (CET)
Received: from mail46.informatik.tu-muenchen.de ([10.46.146.15])
	by localhost (mail46.informatik.tu-muenchen.de [10.46.146.16]) (amavisd-new, port 10026)
	with ESMTP id etxBdZwKnAlz for <dash@vger.kernel.org>;
	Thu, 11 Feb 2016 13:15:12 +0100 (CET)
Received: from lxbroy10.informatik.tu-muenchen.de (lxbroy10.informatik.tu-muenchen.de [131.159.47.103])
	by mail46.informatik.tu-muenchen.de (Postfix) with ESMTPSA id 14592885ED159
	for <dash@vger.kernel.org>; Thu, 11 Feb 2016 13:15:12 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1602110431550.61314@lxbroy10.informatik.tu-muenchen.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Thu, 11 Feb 2016, Makarius wrote:

> I am a long-term user of GNU bash who is depending on the "export -f" feature 
> of that shell (in an application that is on the free market for decades). The 
> bash guys turn a shell function "foo" into the environment variable 
> "BASH_FUNC_foo%%" and hope to be able to pick it up later on.
>
> Dash gets into this game, because Ubuntu and Debian have chosen to make it 
> the default for /bin/sh some years ago. This means that typical "system" 
> invocations of Unix tools and libraries are now going through dash: /bin/sh 
> -c is often seen in practice instead of more delicate execve invocations.
>
> This means with /bin/sh -> dash users have no proper chance to avoid it. 
> Sitting right there in the center /bin/sh, dash acquires special 
> responsibilities to play nice with other shells.

After reading the official (!) sources of bash-4.3, I've found out the 
following: Not the bash guys are introducing this ill-formed name 
decoration "%%", but the Debian guys. See 
http://sourcesdev.debian.net/patches/bash/4.3-14/bash43-027.diff

This means dash is not working against bash, but against Debian. Or 
rather: Debian is working against themselves and their users.


 	Makarius

