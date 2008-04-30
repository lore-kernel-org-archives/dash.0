From: Remi Broemeling <remi@nexopia.com>
Subject: dash test -w oddities
Date: Wed, 30 Apr 2008 15:05:07 -0600
Message-ID: <4818DF03.3090003@nexopia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.nexopia.com ([216.234.161.191]:51998 "EHLO
	mail.nexopia.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761648AbYD3Va3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 17:30:29 -0400
Received: from [192.168.10.60] (office.lan.nexopia.com [68.148.124.243])
	(Authenticated sender: remi@nexopia.com)
	by mail.nexopia.com (Postfix) with ESMTP id 147D3E749
	for <dash@vger.kernel.org>; Wed, 30 Apr 2008 15:05:25 -0600 (MDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Today I encountered some oddities using `test -w` as well as `[ -w`.  
The machine in question is an NFS-root (exported and mounted read-only) 
server running Ubuntu 8.04 LTS.

------
root@nexhost:~# mount
rootfs on / type rootfs (rw)
<snip non-relevant mounts>
192.168.10.60:/var/lib/tftpboot/netboot/default.r14599-amd64 on / type 
nfs 
(ro,relatime,vers=3,rsize=524288,wsize=524288,hard,nointr,nolock,proto=tcp,timeo=7,retrans=3,sec=sys,addr=192.168.10.60)
<snip non-relevant mounts>
------

If I try using -w in bash, things work as expected:
------
root@nexhost:~# bash
root@nexhost:~# [ -w / ] && echo Writable Root
root@nexhost:~# test -w / && echo Writable Root
root@nexhost:~# /usr/bin/[ -w / ] && echo Writable Root
root@nexhost:~# /usr/bin/test -w / && echo Writable Root
------

However, if I try using -w in dash, the builtin does not seem to work as 
I would expect:
------
# [ -w / ] && echo Writable Root
Writable Root
# test -w / && echo Writable Root
Writable Root
# /usr/bin/[ -w / ] && echo Writable Root
# /usr/bin/test -w / && echo Writable Root
------

I'm not sure if I am misunderstanding what is supposed to be happening 
with test/[, or if this is a bug in the dash built-ins, but I thought 
that I should at least mention it in case it is a bug.

Thanks.
-- 
Remi Broemeling

Sr System Administrator
Nexopia.com Inc.
P: 780.444.1250 X435
F: 780.487.0376
E: remi@nexopia.com
N: rbroemeling


There are two major products that come out of Berkeley: LSD and UNIX. We 
don't believe this to be a coincidence.
Jeremy S. Anderson
