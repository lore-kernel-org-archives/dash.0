Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21CC2D0267
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969770; cv=none; b=KjHmWVUpCbc5J7pnQdBoZ3Sj5gproD5SoTeWtXarv/C+d8c+AiwGE0eIL+P76Cc+HEhpxescwOHYrJ38LTVhEaNEtZk72t7s58ST/Ged0GxtKkNkpcCql60MmR5pbEui+xKo1EFFv3mtp83aF3oYIiROLOCIwGF8jM9mFS+4Jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969770; c=relaxed/simple;
	bh=r5N4rEFiEOM4ZS3YaoTn8BBH94kWeDOmzePJ+WWJzMA=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=JuHK/Zu4j/KsimVpSNI/YzfPvLao5xXJKGSHG3sxko2cPr7m885Nx3TL2kCXvlv9PL2AQNdlICl53hJLBOD3kbK9FpFTxcD9wMFWT9fvQ2iqxsPlGFLtjpwHL6LG/HxDEoShX6V8GiJRsZCHXQNkLveCbJ3bJANngNfQbNuoRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=nwaIcC3M; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="nwaIcC3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753969760;
	bh=r5N4rEFiEOM4ZS3YaoTn8BBH94kWeDOmzePJ+WWJzMA=;
	h=Date:From:To:Subject:From;
	b=nwaIcC3MWphvk/Z9h132Y4WF8sUPPhmXopmNI7rx5ppmn6GG9aF8GqBad6CxjEFd1
	 mSGX4M8gzZwk2rBh2tG8D8TcQrGA1D6jTop7gH8Kdq6fw3Q/vrT3ZIGcbm/xcyRpor
	 Vizc3NTdirAMHmlC7PKbF5z/7+VuSzg0BXmgXMSpd197PYLr9GEOrgeMNT8XkwRKGc
	 A8VESMYDVdqxnPplCSf89Mi1FoB3R6ETB8TOUf2J+gguAJvEShG0nOdRUZ6sFURjPV
	 JJ/GFurgLCiUAiWsYANCb+99P5V0n7VxJJ+Qf2GvCYPhj1PgGGxXCqH2bAn7MQ3wlE
	 +scpM1Ve2XaFA==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id DDAE71F9D6
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 16:49:20 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 16:49:20 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4bt9Rh0w2jzNkHF;
	Thu, 31 Jul 2025 16:49:18 +0300 (MSK)
Message-ID: <fc8ed5da-3024-4d22-b6da-83dccabafe99@astralinux.ru>
Date: Thu, 31 Jul 2025 16:49:18 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Content-Language: ru
From: Aleksander Ushakov <aushakov@astralinux.ru>
To: dash@vger.kernel.org
Subject: [BUG] heap-buffer-overflow(read) _rmescapes() src/expand.c:2088:9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 195257 [Jul 31 2025]
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
==19757==ERROR: AddressSanitizer: heap-buffer-overflow on address 
0x515000000500 at pc 0x6187826bab84 bp 0x7ffff71dca90 sp 0x7ffff71dca88
READ of size 1 at 0x515000000500 thread T0
     #0 0x6187826bab83 in _rmescapes /upstream/dash/src/expand.c:2088:9
     #1 0x6187826bc389 in expari /upstream/dash/src/expand.c:517:3
     #2 0x6187826b850a in argstr /upstream/dash/src/expand.c:397:8
     #3 0x6187826b7c57 in expandarg /upstream/dash/src/expand.c:232:2
     #4 0x6187826af73b in evalcommand /upstream/dash/src/eval.c:819:4
     #5 0x6187826ae925 in evaltree /upstream/dash/src/eval.c:305:12
     #6 0x6187826b352c in evalfun /upstream/dash/src/eval.c:1017:2
     #7 0x6187826b024c in evalcommand /upstream/dash/src/eval.c:931:7
     #8 0x6187826ae925 in evaltree /upstream/dash/src/eval.c:305:12
     #9 0x6187826ae925 in evaltree /upstream/dash/src/eval.c:305:12
     #10 0x6187826cb762 in cmdloop /upstream/dash/src/main.c:246:8
     #11 0x6187826cb36f in main /upstream/dash/src/main.c:180:3
     #12 0x78cf309b3249 in __libc_start_call_main 
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
     #13 0x78cf309b3304 in __libc_start_main csu/../csu/libc-start.c:360:3
     #14 0x6187825ca5d0 in _start (/upstream/dash/src/dash+0x395d0) 
(BuildId: 82ec7cbb990c5349f280ce0bf016a1bca211dffd)
0x515000000500 is located 0 bytes after 512-byte region 
[0x515000000300,0x515000000500)
allocated by thread T0 here:
     #0 0x61878266986f in malloc (/upstream/dash/src/dash+0xd886f) 
(BuildId: 82ec7cbb990c5349f280ce0bf016a1bca211dffd)
     #1 0x6187826cbe64 in ckmalloc /upstream/dash/src/memalloc.c:66:6
     #2 0x6187826cbfde in stalloc /upstream/dash/src/memalloc.c:134:8
     #3 0x6187826cc7cd in growstackblock /upstream/dash/src/memalloc.c:238:7
     #4 0x6187826cc831 in growstackto /upstream/dash/src/memalloc.c:277:10
     #5 0x6187826cc87e in makestrspace /upstream/dash/src/memalloc.c:289:9
     #6 0x6187826cc8b0 in stnputs /upstream/dash/src/memalloc.c:294:6
     #7 0x6187826b809c in argstr /upstream/dash/src/expand.c:326:8
     #8 0x6187826b7c57 in expandarg /upstream/dash/src/expand.c:232:2
     #9 0x6187826b2621 in fill_arglist /upstream/dash/src/eval.c:680:3
     #10 0x6187826af401 in evalcommand /upstream/dash/src/eval.c:788:13
     #11 0x6187826ae925 in evaltree /upstream/dash/src/eval.c:305:12
     #12 0x6187826b352c in evalfun /upstream/dash/src/eval.c:1017:2
     #13 0x6187826b024c in evalcommand /upstream/dash/src/eval.c:931:7
     #14 0x6187826ae925 in evaltree /upstream/dash/src/eval.c:305:12
     #15 0x6187826ae925 in evaltree /upstream/dash/src/eval.c:305:12
     #16 0x6187826cb762 in cmdloop /upstream/dash/src/main.c:246:8
     #17 0x6187826cb36f in main /upstream/dash/src/main.c:180:3
     #18 0x78cf309b3249 in __libc_start_call_main 
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
SUMMARY: AddressSanitizer: heap-buffer-overflow 
/upstream/dash/src/expand.c:2088:9 in _rmescapes

Shadow bytes around the buggy address:

   0x515000000280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x515000000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x515000000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x515000000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   0x515000000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x515000000500:[fa]fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x515000000580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x515000000600: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x515000000680: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x515000000700: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
   0x515000000780: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa

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
==19757==ABORTING

Environment:

Debian-12, x86-64
clang-19 compiler

Steps to reproduce:

./autogen.sh
CC=clang CFLAGS=" -fsanitize=address -g " ./configure --disable-fnmatch
--disable-lineno --disable-glob
make
cd src
echo -ne 'testfail()\n{\nt   exitval=$((exitval + \x81))\n}\n\ntest 
"${empty:-ok}" = ok || testfail "empty var colon"\ntest "${empty-bad}" = 
"" || testfail "got \"${empty-bad}\": empty var nocolon"' | ./dash
