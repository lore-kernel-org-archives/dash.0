From: Oleg Verych <olecom@flower.upol.cz>
Subject: nop a syscall (root hole) on 64-bits
Date: Wed, 26 Mar 2008 15:03:50 +0100
Message-ID: <20080326140350.GZ24008@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:47398 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYCZN65 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 Mar 2008 09:58:57 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: klibc list <klibc@zytor.com>, dash list <dash@vger.kernel.org>

... or buddy userspace.

patching `sys_vmsplice()' with `ret'.

1)# echo -e '\xc3' | dd of=/dev/kmem bs=1 count=1 seek=$((0x`cat
    /proc/kallsyms|grep sys_vmsplice | awk {'print $1'}`))

2)# echo -e '\xc3' | dd of=/dev/kmem bs=1 count=1 seek=$((0x`awk
    '/sys_vmsplice/ { print $1; }' /proc/kallsyms`))


my try:

#
# printf "\xC3"  |  dd bs=1 count=1 of=/dev/kmem conv=notrunc \
  seek=$((0x`sed -n '/vmsplice$/{s; .*;;p;q}' /boot/S*p-$(uname -r) | tee /dev/stderr`))
ffffffff802cc20f
dd: invalid number `-2144550385'
#
# dash -c 'printf "\xC3"  |  dd bs=1 count=1 of=/dev/kmem conv=notrunc \
  seek=$((0x`sed -n "/vmsplice$/{s; .*;;p;q}" /boot/S*p-$(uname -r) | tee /dev/stderr`))'
ffffffff802cc20f
dd: invalid number `-1'
#
# printf "\xC3"  |  dd bs=1 count=1 of=/dev/kmem conv=notrunc \
  seek=$(printf %u 0x`sed -n '/vmsplice$/{s; .*;;p;q}' /boot/S*p-$(uname -r) | tee /dev/stderr`)
ffffffff802cc20f
dd: `/dev/kmem': cannot seek
0+0 records in
0+0 records out
0 bytes (0 B) copied, 8.1e-05 seconds, 0.0 kB/s
#
# printf "\xC3" | /usr/lib/klibc/bin/dd bs=1 count=1 of=/dev/kmem conv=notrunc \
  seek=$(printf %u 0x`sed -n '/vmsplice$/{s; .*;;p;q}' /boot/S*p-$(uname -r) | tee /dev/stderr`)
ffffffff802cc20f
/usr/lib/klibc/bin/dd: bad operand `seek=18446744071565001231'
#

Nothing. So, i need to reboot or build a kernel module, oh well...
______
