Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC33A8C1
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967446; cv=none; b=gOenSE0MyBwSPquWXp6UoS3RTUB0OBz9Z5PR6ueh+OToI0MPbSr7/pAz+B2S1KAnRLqB03SZCl+U8XOf9wm1njMKEKxgJmUi0SA/jdjjykwkkrjIZvd/vuDRsTQDgOWAt44NyA0k3BkZkXfHtlOfPZIEb7Pi1Um/U7oidJ9kMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967446; c=relaxed/simple;
	bh=fo010n1yXi9HtG0cD0QUMwlGLzpdvy4fTJrxHkxmOkA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hC9qU5dHF/pXqsiD64uGHCzDfZgMHy1mg52vhEsFPYr/lGOTPv++HEHlGuQCB9dBm6LuTB7YaTlwcx9ckPSafn8hibjnXuBV4lE2FdIbRWnBUY+GLBEBbEqFe6zduZXCspCykRSWYBAPoB+O26oGyrfByKnek1yzCJYbFHP+TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=UJ+Q6HqK; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="UJ+Q6HqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753967434;
	bh=fo010n1yXi9HtG0cD0QUMwlGLzpdvy4fTJrxHkxmOkA=;
	h=Date:To:From:Subject:From;
	b=UJ+Q6HqKWmz/T0eAndTpoKebxHdoy+q6xEz7J/jliLZ7+AA3gkcecI+uu2uLlaOgf
	 AurN/l6Kle9dtfbPDm7Je8xo3vhnoVR/3r28mGJLG+Ub12+TQUvjP0UosHifVHiCL7
	 uTWcyJXK8cbPVMVEZx8Vlu+/hlLxdk56ttLcGKnnodkIgy0nmQ9d+0f4Diac1mBYDy
	 iic+UjYPUVroR89Iy1tf79Y6ICdeq1XUsdzqV2YlzFob1jCg9ONpjvRy6a9I3Nq5sH
	 TxTFriUKlZ7YMqCK21McQTvH97SyEbhvl2Y3OunAWIsqSzYixsHs/Pm596+hMFDAfD
	 S8gQ5kfp+rkLA==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 11B541F955
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 16:10:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 16:10:33 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4bt8Zx1zP2z16Hnq;
	Thu, 31 Jul 2025 16:10:32 +0300 (MSK)
Message-ID: <d8cc15e4-7efc-422e-8e5d-e42e8d74dca7@astralinux.ru>
Date: Thu, 31 Jul 2025 16:10:32 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Content-Language: ru
To: dash@vger.kernel.org
From: Aleksander Ushakov <aushakov@astralinux.ru>
Subject: [BUG] heap-buffer-overflow(read) padvance_magic() exec.c:232:8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 195253 [Jul 31 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/07/31 11:55:00 #27636526
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Hello Dash maintainers,

I encountered a bug in Dash in commit b4ef25d7 and would like to report
it. The details are provided below.
=================================================================
==19628==ERROR: AddressSanitizer: heap-buffer-overflow on address 
0x5020000001f6 at pc 0x653a8d802916 bp 0x7ffd57f3d590 sp 0x7ffd57f3cd50
READ of size 2 at 0x5020000001f6 thread T0
     #0 0x653a8d802915 in strcspn (/upstream/dash/src/dash+0x55915) 
(BuildId: 82ec7cbb990c5349f280ce0bf016a1bca211dffd)
     #1 0x653a8d8d01af in padvance_magic /upstream/dash/src/exec.c:232:8
     #2 0x653a8d8d0081 in padvance /upstream/dash/src/./exec.h:88:9
     #3 0x653a8d8d1d05 in find_command /upstream/dash/src/exec.c:439:16
     #4 0x653a8d8cc013 in evalcommand /upstream/dash/src/eval.c:896:3
     #5 0x653a8d8ca925 in evaltree /upstream/dash/src/eval.c:305:12
     #6 0x653a8d8e7762 in cmdloop /upstream/dash/src/main.c:246:8
     #7 0x653a8d8e736f in main /upstream/dash/src/main.c:180:3
     #8 0x7dd5c0958249 in __libc_start_call_main 
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
     #9 0x7dd5c0958304 in __libc_start_main csu/../csu/libc-start.c:360:3
     #10 0x653a8d7e65d0 in _start (/upstream/dash/src/dash+0x395d0) 
(BuildId: 82ec7cbb990c5349f280ce0bf016a1bca211dffd)
0x5020000001f6 is located 0 bytes after 6-byte region 
[0x5020000001f0,0x5020000001f6)
allocated by thread T0 here:
     #0 0x653a8d88586f in malloc (/upstream/dash/src/dash+0xd886f) 
(BuildId: 82ec7cbb990c5349f280ce0bf016a1bca211dffd)
     #1 0x653a8d8e7e64 in ckmalloc /upstream/dash/src/memalloc.c:66:6
     #2 0x653a8d90123d in setvar /upstream/dash/src/var.c:213:23
     #3 0x653a8d9035ba in unsetvar /upstream/dash/src/var.c:613:2
     #4 0x653a8d903547 in unsetcmd /upstream/dash/src/var.c:597:4
     #5 0x653a8d8cee10 in evalbltin /upstream/dash/src/eval.c:975:12
     #6 0x653a8d8cc183 in evalcommand /upstream/dash/src/eval.c:923:7
     #7 0x653a8d8ca925 in evaltree /upstream/dash/src/eval.c:305:12
     #8 0x653a8d8e7762 in cmdloop /upstream/dash/src/main.c:246:8
     #9 0x653a8d8e736f in main /upstream/dash/src/main.c:180:3
     #10 0x7dd5c0958249 in __libc_start_call_main 
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: heap-buffer-overflow 
(/upstream/dash/src/dash+0x55915) (BuildId: 
82ec7cbb990c5349f280ce0bf016a1bca211dffd) in strcspn
Shadow bytes around the buggy address:
   0x501fffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x501fffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x502000000000: fa fa fd fa fa fa 00 04 fa fa 00 04 fa fa 00 04
   0x502000000080: fa fa 00 04 fa fa 00 04 fa fa 00 04 fa fa 00 04
   0x502000000100: fa fa 00 04 fa fa 00 04 fa fa 00 04 fa fa 00 04
=>0x502000000180: fa fa 00 04 fa fa 00 04 fa fa 00 04 fa fa[06]fa
   0x502000000200: fa fa 00 00 fa fa fa fa fa fa fa fa fa fa fa fa
   0x502000000280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x502000000300: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x502000000380: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x502000000400: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
   Addressable:           00
   Partially addressable: 01 02 03 04 05 06 07
   Heap left redzone:       fa
   Freed heap region:       fd
   Stack left redzone:      f1
   Stack mid redzone:       f2
   Stack right redzone:     f3
   Stack after return:      f5
   Stack use after scope:   f8
   Global redzone:          f9
   Global init order:       f6
   Poisoned by user:        f7
   Container overflow:      fc
   Array cookie:            ac
   Intra object redzone:    bb
   ASan internal:           fe
   Left alloca redzone:     ca
   Right alloca redzone:    cb
==19628==ABORTING

Environment:
Debian-12, x86-64
clang-19 compiler

Steps to reproduce:

./autogen.sh
CC=clang CFLAGS=" -fsanitize=address -g " ./configure --disable-fnmatch
--disable-lineno --disable-glob
make
cd src
echo -e 'unset PATH\n0' | ./dash

Also I think I should show my env:

root@ecf61be3acf6:/upstream/dash/src# env
HOSTNAME=ecf61be3acf6
PWD=/upstream/dash/src
SRC=/dash
LLVM_CONFIG=/usr/bin/llvm-config-19
TZ=Europe/Moscow
HOME=/root
LANG=ru_RU.UTF-8
https_proxy=
TERM=xterm
SHLVL=1
http_proxy=
SHARED=/shared
PATH=/root/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
OUT=/out
OLDPWD=/upstream/dash
_=/usr/bin/env
