From: Oleg Verych <olecom@flower.upol.cz>
Subject: euidaccess() vs non suid /bin/sh (Re: dash test -w oddities)
Date: Thu, 1 May 2008 01:01:09 +0200
Message-ID: <20080430230109.GR24008@flower.upol.cz>
References: <4818DF03.3090003@nexopia.com> <20080430223853.GQ24008@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:51753 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764949AbYD3WkT (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 18:40:19 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id B4816122521
	for <dash@vger.kernel.org>; Thu,  1 May 2008 00:40:06 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id 8Gl95j1XPdkk3KZi for <dash@vger.kernel.org>; Thu, 01 May 2008 00:40:06 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JrLIU-0003L0-2d
	for dash@vger.kernel.org; Thu, 01 May 2008 01:01:10 +0200
Content-Disposition: inline
In-Reply-To: <20080430223853.GQ24008@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> I've asked why it's needed and why euidaccess() from glibc
> wasn't used, especially in case of selinux stuff.

I wonder even more why access() syscall isn't a solution, because
/bin/sh isn't set-uid by definition.

#/bin/cc glibc/sysdeps/posix/euidaccess.c
[...]
    /* If we are not set-uid or set-gid, access does the same.  */
    return access (path, mode);
[...]
#end_cc
____
