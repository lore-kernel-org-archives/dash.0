From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: dash test -w oddities
Date: Thu, 1 May 2008 00:38:53 +0200
Message-ID: <20080430223853.GQ24008@flower.upol.cz>
References: <4818DF03.3090003@nexopia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:51621 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762645AbYD3WSD (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 18:18:03 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id B5ACB12266E
	for <dash@vger.kernel.org>; Thu,  1 May 2008 00:17:50 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id UK5kHHRA3gOd4bWs for <dash@vger.kernel.org>; Thu, 01 May 2008 00:17:50 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JrKwv-00044U-VS
	for dash@vger.kernel.org; Thu, 01 May 2008 00:38:53 +0200
Content-Disposition: inline
In-Reply-To: <4818DF03.3090003@nexopia.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "Remi Broemeling (dash list)" <dash@vger.kernel.org>

> Today I encountered some oddities using `test -w` as well as `[ -w`.  
> The machine in question is an NFS-root (exported and mounted read-only) 
> server running Ubuntu 8.04 LTS.

important: you *are* root, right?

Some time ago i wanted to rewrite `test`, but due to "`dash` is in
Ubuntu upstream" answer. i've stopped.

So, here it is, naive replacement of access() syscall (with crutches from
GPLed `bash`). I've asked why it's needed and why euidaccess() from glibc
wasn't used, especially in case of selinux stuff. But it seems, like
`dash` fork of `ash` is just in bug-fixing mode.

#/bin/cc
/*
 * Similar to what access(2) does, but uses the effective uid and gid.
 * Doesn't make the mistake of telling root that any file is executable.
 * Returns non-zero if the file is accessible.
 */
static int
test_st_mode(const struct stat64 *st, int mode)
{
        int euid = geteuid();

        if (euid == 0) {
	/* Root can read or write any file. */
                if (mode != X_OK)
                        return 1;
[....]
#cc_end

In case you have no `man` page:
olecom@flower:~$ grep euidaccess </usr/include/unistd.h
extern int euidaccess (__const char *__name, int __type)
olecom@flower:~$

[]
> There are two major products that come out of Berkeley: LSD and UNIX. We 
> don't believe this to be a coincidence.
> Jeremy S. Anderson

LSD && BSD actually :)
____
