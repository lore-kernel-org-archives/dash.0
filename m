From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: euidaccess() vs non suid /bin/sh (Re: dash test -w oddities)
Date: Wed, 30 Apr 2008 15:52:25 -0700
Message-ID: <4818F829.60601@zytor.com>
References: <4818DF03.3090003@nexopia.com> <20080430223853.GQ24008@flower.upol.cz> <20080430230109.GR24008@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51495 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765869AbYD3Wwa (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 18:52:30 -0400
In-Reply-To: <20080430230109.GR24008@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@flower.upol.cz>
Cc: dash list <dash@vger.kernel.org>

Oleg Verych wrote:
>> I've asked why it's needed and why euidaccess() from glibc
>> wasn't used, especially in case of selinux stuff.
> 
> I wonder even more why access() syscall isn't a solution, because
> /bin/sh isn't set-uid by definition.
> 
> #/bin/cc glibc/sysdeps/posix/euidaccess.c
> [...]
>     /* If we are not set-uid or set-gid, access does the same.  */
>     return access (path, mode);
> [...]
> #end_cc

It might be run from a setuid program.

	-hpa
