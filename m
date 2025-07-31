Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651E22612
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987839; cv=none; b=dmx9bqqzsgEpgv+ajFnGEMxFvAzlfDoL6+S/ntbM36TfqwGhFOFBDqtjIWA+79DvgUczzaCR/AizaPbGamIGKueI85AWnOfSTWump8sahjiA5gUob/TVVqQFWKL95fn1kA29k8rm1m8eAggY990fFzZxDM3/SW6DIK1B73RL2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987839; c=relaxed/simple;
	bh=BsvgWfgwS4OCnl1UbuALfRGYpRsZ44s5viCR5SMmNg0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Q+sdA4+La8wEPxnWrjYvUbIw9mpiNThBftBHZgOp7RYCF3wQLknJANIaM9zVITTtFN6po4HOU039pNF5tH6HY5Ih3VbPUYQfd+0UB5fmXxfoLCGReVZpzthFrbrWPp3GWvDrAVmNdNtc8LljCaocrNdOcldcMAiqtD2zf9Y9o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=Qh9+uUNO; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="Qh9+uUNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753987832;
	bh=BsvgWfgwS4OCnl1UbuALfRGYpRsZ44s5viCR5SMmNg0=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=Qh9+uUNOS+B8JebC+pOfNkk6oohwvUIDa4GSU9k0DoXeoivb+DeWK8Kw2Z3ZeFAUk
	 U4lGII+zqPw26Y8EvRRWY8LlTqZgIvC7GbJn5FzUBRfX756zgBgHR+Ogn++w67zMa7
	 91K47W4vuJsfmLZKwbnJAppfWzs09/st62MbHi72JUaTw/lHV8qVNUW/SOOEuZ2I05
	 dMpq0oOdD+uk2KxjdlLHoK4sVS0Yb3f0OHry2NW8iMtiWfUhuDHSS8xBtolKRqB6b+
	 j5PQZcH6ZE6j+sZFkWBYJcn4Ufuc/nu1GoEl0cvjbdO6exUTNjnBeLtmye5WzLjK/f
	 Np/zCpxdrx9+A==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 03EEC1F955
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:50:32 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:50:31 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4btJ6d0CjPztQTS;
	Thu, 31 Jul 2025 21:50:00 +0300 (MSK)
Message-ID: <e79e39bc-02b8-4ad7-ba03-7e4d00061c3e@astralinux.ru>
Date: Thu, 31 Jul 2025 21:49:59 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] left shift of negative value do_binop
 src/arith_yacc.c:111:12
Content-Language: ru
From: Aleksander Ushakov <aushakov@astralinux.ru>
To: dash@vger.kernel.org
References: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
In-Reply-To: <1abb4964-b5ee-42d8-bbb8-959594d61665@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_all_Bitcoin}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 195265 [Jul 31 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/07/31 15:18:00 #27636131
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1


31/07/25 21:45, Aleksander Ushakov wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> 
> arith_yacc.c:111:12: runtime error: left shift of negative value -1
> 
>      #0 0x601249d1d2d1 in do_binop /upstream/ubsan/dash/src/ 
> arith_yacc.c:111:12
>      #1 0x601249d1da48 in binop2 /upstream/ubsan/dash/src/arith_yacc.c: 
> 194:20
>      #2 0x601249d1da1b in binop2 /upstream/ubsan/dash/src/arith_yacc.c: 
> 190:8
>      #3 0x601249d1d615 in binop /upstream/ubsan/dash/src/arith_yacc.c:212:9
>      #4 0x601249d1d50e in and /upstream/ubsan/dash/src/arith_yacc.c:217:15
>      #5 0x601249d1d43e in or /upstream/ubsan/dash/src/arith_yacc.c:234:15
>      #6 0x601249d1cf5e in cond /upstream/ubsan/dash/src/arith_yacc.c:251:15
>      #7 0x601249d1ce10 in assignment /upstream/ubsan/dash/src/ 
> arith_yacc.c:278:10
>      #8 0x601249d1cd93 in arith /upstream/ubsan/dash/src/arith_yacc.c: 
> 298:11
>      #9 0x601249d368df in expari /upstream/ubsan/dash/src/expand.c:520:11
>      #10 0x601249d3092e in argstr /upstream/ubsan/dash/src/expand.c:397:8
>      #11 0x601249d2f6ab in expandarg /upstream/ubsan/dash/src/expand.c: 
> 232:2
>      #12 0x601249d2800d in fill_arglist /upstream/ubsan/dash/src/eval.c: 
> 680:3
>      #13 0x601249d21eb1 in evalcommand /upstream/ubsan/dash/src/eval.c: 
> 788:13
>      #14 0x601249d210ac in evaltree /upstream/ubsan/dash/src/eval.c:305:12
>      #15 0x601249d4d18c in cmdloop /upstream/ubsan/dash/src/main.c:246:8
> 
>      #16 0x601249d4ce4b in main /upstream/ubsan/dash/src/main.c:180:3
> 
>      #17 0x761de6eac249 in __libc_start_call_main csu/../sysdeps/nptl/ 
> libc_start_call_main.h:58:16
>      #18 0x761de6eac304 in __libc_start_main csu/../csu/libc-start.c:360:3
>      #19 0x601249cef930 in _start (/upstream/ubsan/dash/src/ 
> dash+0x42930) (BuildId: 2fb8fb410aebcc20429dc4b85194b8ca2dc00a3e)
> 
> 
> 
> SUMMARY: UndefinedBehaviorSanitizer: invalid-shift-base arith_yacc.c:111:12
> Aborted (core dumped)
> 
> 
> Environment:
> 
> Debian-12, x86-64
> clang-19 compiler
> 
> Steps to reproduce:
> 
> ./autogen.sh
> CC=clang CFLAGS=" -fsanitize=undefined -g " ./configure --disable- 
> fnmatch --disable-lineno --disable-glob
> make
> cd src
> echo -ne '$((0|~0<<(0)))' | ./dash

There is a fix of the problem:

diff --git a/src/arith_yacc.c b/src/arith_yacc.c
index 1a087c3..e23060d 100644
--- a/src/arith_yacc.c
+++ b/src/arith_yacc.c
@@ -108,7 +108,9 @@ static intmax_t do_binop(int op, intmax_t a, intmax_t b)
         case ARITH_SUB:
                 return a - b;
         case ARITH_LSHIFT:
-               return a << b;
+               if (a < 0)
+                       yyerror("left shift of negative value");
+               return (intmax_t)a << b;
         case ARITH_RSHIFT:
                 return a >> b;
         case ARITH_LT:

Same case is placed in DIV branch (when divide on zero). I think it is 
analogue.
