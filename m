From: Makarius <makarius@sketis.net>
Subject: Re: dash drops exported bash functions
Date: Thu, 11 Feb 2016 15:30:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602111526570.44882@lxbroy10.informatik.tu-muenchen.de>
References: <alpine.LNX.2.00.1602110431550.61314@lxbroy10.informatik.tu-muenchen.de> <alpine.LNX.2.00.1602111309450.33198@lxbroy10.informatik.tu-muenchen.de> <alpine.LNX.2.00.1602111436050.40543@lxbroy10.informatik.tu-muenchen.de>
 <20160211141936.GC17349@brutus.ethup.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:55562 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751366AbcBKObB (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 11 Feb 2016 09:31:01 -0500
In-Reply-To: <20160211141936.GC17349@brutus.ethup.se>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Olof Johansson <olof@ethup.se>
Cc: dash@vger.kernel.org

On Thu, 11 Feb 2016, Olof Johansson wrote:

> On 2016-02-11 14:40 +0100, Makarius wrote:
>> In any case, the Debian guys need to get involved, but I am myself
>> not a member of that society.
>
> Why? It's an upstream patch, it's not Debian specific.
>
> https://ftp.gnu.org/gnu/bash/bash-4.3-patches/bash43-027

Correct. It is also in bash-4.4-beta, where I should have looked first.


> Adapt your software instead?

I can certainly make evasive maneuvers.

The problem is a deeper one, though: export -f in bash no longer works for 
systems that have /bin/sh -> dash (i.e. Debian and Ubuntu).


 	Makarius

