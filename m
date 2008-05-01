From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: euidaccess() vs non suid /bin/sh (Re: dash test -w oddities)
Date: Thu, 1 May 2008 02:19:23 +0200
Message-ID: <20080501001923.GS24008@flower.upol.cz>
References: <4818DF03.3090003@nexopia.com> <20080430223853.GQ24008@flower.upol.cz> <20080430230109.GR24008@flower.upol.cz> <4818F829.60601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:52190 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933808AbYD3X6d (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 19:58:33 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 6F0DB1226FD
	for <dash@vger.kernel.org>; Thu,  1 May 2008 01:58:20 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id GtcNDqBjWafFqMFN for <dash@vger.kernel.org>; Thu, 01 May 2008 01:58:20 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JrMWB-0005ig-S5
	for dash@vger.kernel.org; Thu, 01 May 2008 02:19:23 +0200
Content-Disposition: inline
In-Reply-To: <4818F829.60601@zytor.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin (dash list)" <dash@vger.kernel.org>

> >I wonder even more why access() syscall isn't a solution, because
> >/bin/sh isn't set-uid by definition.
> >
> >#/bin/cc glibc/sysdeps/posix/euidaccess.c
> >[...]
> >    /* If we are not set-uid or set-gid, access does the same.  */
> >    return access (path, mode);
> >[...]
> >#end_cc
> 
> It might be run from a setuid program.

Scripts with '#!/bin/sh' cannot be set-uid,

#man system (debian):

       Do  not  use  system()  from a program with set-user-ID or set-group-ID
       privileges, because strange values for some environment variables might
       be  used  to subvert system integrity.  Use the exec(3) family of func-
       tions instead, but not execlp(3) or execvp(3).  system() will  not,  in
       fact,  work  properly  from  programs  with set-user-ID or set-group-ID
       privileges on systems on which /bin/sh is bash version 2, since bash  2
       drops  privileges  on startup.  (Debian uses a modified bash which does
       not do this when invoked as sh.)

#end

Programs being designed to be set-uid should have proper setup for
proper running any external command. No?

The call euidaccess() makes sense now, just asking to make clear this
mess a bit.
____
