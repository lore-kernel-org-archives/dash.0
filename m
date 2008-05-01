From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: euidaccess() vs non suid /bin/sh (Re: dash test -w oddities)
Date: Wed, 30 Apr 2008 23:03:58 -0700
Message-ID: <48195D4E.4020504@zytor.com>
References: <4818DF03.3090003@nexopia.com> <20080430223853.GQ24008@flower.upol.cz> <20080430230109.GR24008@flower.upol.cz> <4818F829.60601@zytor.com> <20080501001923.GS24008@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41385 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYEAGEH (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 1 May 2008 02:04:07 -0400
In-Reply-To: <20080501001923.GS24008@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: "H. Peter Anvin (dash list)" <dash@vger.kernel.org>

Oleg Verych wrote:
> 
> Scripts with '#!/bin/sh' cannot be set-uid,
> 
> #man system (debian):
> 
>        Do  not  use  system()  from a program with set-user-ID or set-group-ID
>        privileges, because strange values for some environment variables might
>        be  used  to subvert system integrity.  Use the exec(3) family of func-
>        tions instead, but not execlp(3) or execvp(3).  system() will  not,  in
>        fact,  work  properly  from  programs  with set-user-ID or set-group-ID
>        privileges on systems on which /bin/sh is bash version 2, since bash  2
>        drops  privileges  on startup.  (Debian uses a modified bash which does
>        not do this when invoked as sh.)

This is largely considered a bug in bash, at least when invoked as /bin/sh.

	-hpa
