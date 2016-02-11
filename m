From: Makarius <makarius@sketis.net>
Subject: Re: dash drops exported bash functions
Date: Thu, 11 Feb 2016 14:40:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602111436050.40543@lxbroy10.informatik.tu-muenchen.de>
References: <alpine.LNX.2.00.1602110431550.61314@lxbroy10.informatik.tu-muenchen.de> <alpine.LNX.2.00.1602111309450.33198@lxbroy10.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:48221 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbcBKNkg (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 11 Feb 2016 08:40:36 -0500
Received: from localhost (scan46 [10.46.146.16])
	by mail46.informatik.tu-muenchen.de (Postfix) with ESMTP id 5CC6A885ED15D
	for <dash@vger.kernel.org>; Thu, 11 Feb 2016 14:40:34 +0100 (CET)
Received: from mail46.informatik.tu-muenchen.de ([10.46.146.15])
	by localhost (mail46.informatik.tu-muenchen.de [10.46.146.16]) (amavisd-new, port 10026)
	with ESMTP id RhUPUAbBJ6MM for <dash@vger.kernel.org>;
	Thu, 11 Feb 2016 14:40:34 +0100 (CET)
Received: from lxbroy10.informatik.tu-muenchen.de (lxbroy10.informatik.tu-muenchen.de [131.159.47.103])
	by mail46.informatik.tu-muenchen.de (Postfix) with ESMTPSA id 340AB885ED15A
	for <dash@vger.kernel.org>; Thu, 11 Feb 2016 14:40:34 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1602111309450.33198@lxbroy10.informatik.tu-muenchen.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Thu, 11 Feb 2016, Makarius wrote:

> After reading the official (!) sources of bash-4.3, I've found out the 
> following: Not the bash guys are introducing this ill-formed name 
> decoration "%%", but the Debian guys. See 
> http://sourcesdev.debian.net/patches/bash/4.3-14/bash43-027.diff
>
> This means dash is not working against bash, but against Debian. Or 
> rather: Debian is working against themselves and their users.

Yet another update.

On another mailing list, someone else pointed out that this change might 
be due to the "shell shock" desaster from 2014: 
https://en.wikipedia.org/wiki/Shellshock_%28software_bug%29

If the malformedness of environment variables that are meant to be 
functions is important for bash43-027.diff above, the ball might be back 
on the side of dash.

In any case, the Debian guys need to get involved, but I am myself not a 
member of that society.


 	Makarius
