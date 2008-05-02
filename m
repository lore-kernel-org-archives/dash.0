From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: euidaccess() vs non suid /bin/sh (Re: dash test -w oddities)
Date: Fri, 2 May 2008 18:48:28 +0200
Message-ID: <20080502164828.GY24008@flower.upol.cz>
References: <4818DF03.3090003@nexopia.com> <20080430223853.GQ24008@flower.upol.cz> <20080430230109.GR24008@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:45174 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758247AbYEBQ1e (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 12:27:34 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 74012223075
	for <dash@vger.kernel.org>; Fri,  2 May 2008 18:27:20 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id OT4TukS57ky28cVf for <dash@vger.kernel.org>; Fri, 02 May 2008 18:27:20 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JryQu-0002Fw-T5
	for dash@vger.kernel.org; Fri, 02 May 2008 18:48:28 +0200
Content-Disposition: inline
In-Reply-To: <20080430230109.GR24008@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> I wonder even more why access() syscall isn't a solution, because
> /bin/sh isn't set-uid by definition.
> 
> #/bin/cc glibc/sysdeps/posix/euidaccess.c

Also why there's no such syscall, i wouldn't require all uid shuffling,
isn't it?

#fs/open.c:sys_faccessat()

        old_fsuid = current->fsuid;
        old_fsgid = current->fsgid;
        old_cap = current->cap_effective;

        current->fsuid = current->uid;
        current->fsgid = current->gid;

#end
____
