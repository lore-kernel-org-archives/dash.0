Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928CA22F74D
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962056; cv=none; b=I7mI4htU/T9kmIGopKL39GOH6Du2GWx8ICuaVpeFCgSq30y9xg7i9yPP2RqNKZDl4JTwCKmwoWJMSpqqNSaz5IRBuUqhj2ug8gkqR4r9rbBZME5VLh1/gu6uQq9lmrR8otMKUAuf7zLWRfIgMzK4SoHmoV9TjE/HypvYz0L5M6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962056; c=relaxed/simple;
	bh=Jf9FX3t1eoQJHeGpYjNAvZ8TnYwem7PXfg76D/5NbSE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=r80h+/vpQXfc7gXszs7PfYuY0IdQ80TDxl0Ahj6XqMqXtadQHwTgyjsj+pmlyhbHTxA91TVfXXvxGkwK1us1tKVgY3LDDu6X8s1QeMICR70jCXHvgOiaLM217q+4s/rAuicGeiLf79BukDac6O1cG4sOX1DHqGmnsMJ7oiy+Sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=ZTQDjqk/; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="ZTQDjqk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753961437;
	bh=Jf9FX3t1eoQJHeGpYjNAvZ8TnYwem7PXfg76D/5NbSE=;
	h=Date:To:From:Subject:From;
	b=ZTQDjqk/ftoddNN3V3z/fF/1wBDjvVUOqqPDe0SVulXZruBtSBr1UcHDoaC1mAG97
	 0PAoNS5sAlliqqjGeyekKz2d1Y7fv+plJYEPHZhVAZCr8sdUNLqKo9kYm/8+KJw9xN
	 6lmTzUsIUzzdC33WvCNJl+MYpQ/UJQ7jQMpoB/jBYn6uSxA4joOezU8LQvSrnn4S9y
	 DdM55wweq9vDnM/TUmoYUVLXP3a9el/HCAPrl3NsCgvDo7aElE8m4e1sbfksrmSAqU
	 A5s+ebGaM0K0rM011A+doW6VDnd8hKwsGlcFEd1OnRz5QDgffcZAhPTDNpt/5dMUM3
	 aY3SdbSk3j0Gw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 4D76B1FA22
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 14:30:37 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 14:30:36 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4bt6M23mYrz2xCf;
	Thu, 31 Jul 2025 14:30:06 +0300 (MSK)
Message-ID: <52d97ed4-7c78-44ec-8c1b-60569491aa31@astralinux.ru>
Date: Thu, 31 Jul 2025 14:30:00 +0300
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
Subject: [BUG] SEGV getop() src/bltin/test.c:171:7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_all_Bitcoin}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 195246 [Jul 31 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/07/31 06:51:00 #27638292
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

Hello Dash maintainers,

I encountered a bug in Dash in commit b4ef25d7 and would like to report
it. The details are provided below.

AddressSanitizer:DEADLYSIGNAL

=================================================================
==18517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000a09
(pc 0x58db5c62ec40 bp 0x7ffe4f593610 sp 0x7ffe4f592db0 T0)
==18517==The signal is caused by a READ memory access.
==18517==Hint: address points to the zero page.
       #0 0x58db5c62ec40 in strcmp (/upstream/test/dash/src/dash+0x51c40)
(BuildId: 535a280f2cc73be57729926bfac9fbc4801d63be)
       #1 0x58db5c72ef74 in getop
/upstream/test/dash/src/bltin/test.c:171:7
       #2 0x58db5c72f022 in t_lex
/upstream/test/dash/src/bltin/test.c:444:7
       #3 0x58db5c72f535 in aexpr
/upstream/test/dash/src/bltin/test.c:269:7
       #4 0x58db5c72f199 in oexpr
/upstream/test/dash/src/bltin/test.c:252:10
       #5 0x58db5c72ee30 in testcmd
/upstream/test/dash/src/bltin/test.c:228:9
       #6 0x58db5c6fee10 in evalbltin
/upstream/test/dash/src/eval.c:975:12
       #7 0x58db5c6fc183 in evalcommand
/upstream/test/dash/src/eval.c:923:7
       #8 0x58db5c6fa925 in evaltree /upstream/test/dash/src/eval.c:305:12
       #9 0x58db5c717762 in cmdloop /upstream/test/dash/src/main.c:246:8
       #10 0x58db5c71736f in main /upstream/test/dash/src/main.c:180:3
       #11 0x76be525ad249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
       #12 0x76be525ad304 in __libc_start_main
csu/../csu/libc-start.c:360:3
       #13 0x58db5c6165d0 in _start (/upstream/test/dash/src/dash+0x395d0)
(BuildId: 535a280f2cc73be57729926bfac9fbc4801d63be)
==18517==Register values:
rax = 0x000000005c74e201  rbx = 0x000058db5c74e260  rcx =
0x0000000000000000  rdx = 0x000058db5c74e6a0
rdi = 0x0000000000000a09  rsi = 0x000058db5c74e260  rbp =
0x00007ffe4f593610  rsp = 0x00007ffe4f592db0
    r8 = 0xf9f9f903f9f9f901   r9 = 0x00000b1beb8e1cd4  r10 =
0x00000b1beba13ac2  r11 = 0x00000b1beb8e1cd0
r12 = 0x0000000000000000  r13 = 0x00007ffe4f5941c8  r14 =
0x0000000000000a09  r15 = 0x0000000000000000
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (/upstream/test/dash/src/dash+0x51c40)
(BuildId: 535a280f2cc73be57729926bfac9fbc4801d63be) in strcmp
==18517==ABORTING

Environment:

Debian-12, x86-64
clang-19 compiler

Steps to reproduce:

./autogen.sh
CC=clang CFLAGS=" -fsanitize=address -g " ./configure --disable-fnmatch
--disable-lineno --disable-glob
make
cd src
echo -e '0000000000000000000000000000000000000000"$IFS"\ntest "" -a' |
./dash

I think I fixed the problem here:

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 6d844f1..f8caf86 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -266,10 +266,19 @@ aexpr(enum token n)
           for (;;) {
                   if (!nexpr(n))
                           res = 0;
+
+               if (!t_wp[1])
+                       break;
+
                   n = t_lex(t_wp + 1);
                   if (n != BAND)
                           break;
-               n = t_lex(t_wp += 2);
+
+               if (!t_wp[2]) {
+                       break;
+               }
+               t_wp += 2;
+               n = t_lex(t_wp);
           }
           return res;
    }

This diff fixes the crash in the aexpr() function by adding critical
bounds checking when processing logical AND (-a) operations in the test
command. It first verifies that t_wp[1] exists before attempting to lex
the next token, preventing null pointer dereferences when no more
arguments remain. For AND operations, it additionally checks that
t_wp[2] (the right operand) exists before advancing the pointer and
lexing, ensuring we never access invalid memory locations. The changes
separate the pointer advancement (t_wp += 2) from the lexing operation
(t_lex(t_wp)) for clearer control flow while maintaining the same
functionality, but now safely handling edge cases where arguments might
be missing after operators.
