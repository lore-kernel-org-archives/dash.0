Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC55B63CF
	for <dash@vger.kernel.org>; Sat, 13 Sep 2025 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772396; cv=none; b=cH5IW9oS0sSgqqAIAcKaOQ3mQXfBuP9OsJ6WsDnqzdxtGiLj7fhXh/O+zBW6r5shGMKFv00u59yVHOpdRQPK2rpMSla2+A/C8wIsVi8K7gEZumNFZcSm7KmWF0KYsF75y/Ye8JZkZzcfbHdVi85YDkwS2G5Z+J89jY+q0R0lrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772396; c=relaxed/simple;
	bh=HSvKYFABriJ1QqCr12/rX6hQ6t4Yc3PYiGeIVRPiexA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsdUEnMan/r3Hh5zSO+L1LOhO8AC8R0P6g4vq6Ft5MXsmC32/ClTbBtrR5zbkB24Jqw3y+jqgxu8EdJcPtIDE8uLdFBcuowuCOTmIquByyKxJRD+gexHt/n7exNxncrVwX0OwkGPBeforJ8pICzEtM9ZfJFJZFR1OifaCtk0b1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=OfoIiszp; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="OfoIiszp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Oq8qO5+mTnNBUP09cCpAiMJOAWnVSmMXsAAf+pZGetE=; b=OfoIiszpJYtAQ9dPO9jPJCFsjw
	whW4muLzEHZ/wuAOF4BqhvHQU+ETFvn15Yi+2veo5yFv4YAQWDec20y7AQ40+ShlSiqKFcHm94UJJ
	wapMUDlj1pmQUKRVHBCj+lAE3QvrdVi9xfBq3VUbIJzfz0w2bEOcdDH29+jWWh+YwZQVHDWqDQ0uJ
	nLmUSWqLJglHdaXYXOezs/nXhCwXETI+NeY1esAtj5ALtfLmlMyKm+nZs4WcUMstD1h/bVAvcj7TO
	TdNeU7DPpUrkoVoRaJQBafK2Nb6X4Ps3BMBuZfasFr8GniwK+2Vzua77tOm0Oh9IVJ/0xS8ed/4Mv
	yg1eQHyA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxQe8-0058Bw-1U;
	Sat, 13 Sep 2025 22:06:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Sep 2025 22:06:28 +0800
Date: Sat, 13 Sep 2025 22:06:28 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: Re: I found multiple crash bugs in Dash v0.5.12-115-gb4ef25d
Message-ID: <aMV6ZCrLe_v5XBJs@gondor.apana.org.au>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:40:16PM -0700, Nathan Mills wrote:
>
> * Crash #71 is an overread when the pointer `p` is near the end of the
> string being processed and it checks the next 6 characters or so
> looking for `$@`.
>
> ** Crash #71 heap-buffer-overflow (memcmp) **
> 
> Base64'd:
> SkooKQoLITwqIT0KCgpKPCohPQoKCkooKTxuJycnJzsnJzsKCoODyfohPPf///8qIT0KCgpK
>
> ** Crash #71 heap-buffer-overflow (memcmp) **
> 
> Base64'd:
> SkooKQoLITwqIT0KCgpKPCohPQoKCkooKTxuJycnJzsnJzsKCoODyfohPPf///8qIT0KCgpK
> 
> 
> 
> ../v0.5.12-gb4ef25d/default/crashes/id:000071,sig:06,src:001663,time:5639570,execs:803122,op:havoc,rep:7:
> 5: cannot open *!=: No such file
> ../v0.5.12-gb4ef25d/default/crashes/id:000071,sig:06,src:001663,time:5639570,execs:803122,op:havoc,rep:7:
> 8: : Permission denied
> ../v0.5.12-gb4ef25d/default/crashes/id:000071,sig:06,src:001663,time:5639570,execs:803122,op:havoc,rep:7:
> 10: cannot open ����*!=: No such file
> =================================================================
> ==75725==ERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x50d0000000d0 at pc 0x55555564ca84 bp 0x7fffffff9100 sp
> 0x7fffffff88c0
> READ of size 5 at 0x50d0000000d0 thread T0
>     #0 0x55555564ca83  (/home/nixos/src/dash/asan_debug/src/dash+0xf8a83)
>     #1 0x55555564cfad  (/home/nixos/src/dash/asan_debug/src/dash+0xf8fad)
>     #2 0x5555556db48d  (/home/nixos/src/dash/asan_debug/src/dash+0x18748d)
>     #3 0x5555556dadc7  (/home/nixos/src/dash/asan_debug/src/dash+0x186dc7)
>     #4 0x5555556d18fa  (/home/nixos/src/dash/asan_debug/src/dash+0x17d8fa)
>     #5 0x5555556d2647  (/home/nixos/src/dash/asan_debug/src/dash+0x17e647)
>     #6 0x5555556d13cc  (/home/nixos/src/dash/asan_debug/src/dash+0x17d3cc)
>     #7 0x5555556d63ed  (/home/nixos/src/dash/asan_debug/src/dash+0x1823ed)
>     #8 0x5555556d2df9  (/home/nixos/src/dash/asan_debug/src/dash+0x17edf9)
>     #9 0x5555556d13cc  (/home/nixos/src/dash/asan_debug/src/dash+0x17d3cc)
>     #10 0x5555556ef42c  (/home/nixos/src/dash/asan_debug/src/dash+0x19b42c)
>     #11 0x5555556eefe4  (/home/nixos/src/dash/asan_debug/src/dash+0x19afe4)
>     #12 0x7ffff7c2a47d
> (/nix/store/g8zyryr9cr6540xsyg4avqkwgxpnwj2a-glibc-2.40-66/lib/libc.so.6+0x2a47d)
> (BuildId: 076d831f9114b2d83bda538386af4e9665308c38)
>     #13 0x7ffff7c2a538
> (/nix/store/g8zyryr9cr6540xsyg4avqkwgxpnwj2a-glibc-2.40-66/lib/libc.so.6+0x2a538)
> (BuildId: 076d831f9114b2d83bda538386af4e9665308c38)
>     #14 0x55555558c5c4  (/home/nixos/src/dash/asan_debug/src/dash+0x385c4)
> 
> 0x50d0000000d0 is located 0 bytes after 144-byte region
> [0x50d000000040,0x50d0000000d0)
> allocated by thread T0 here:
>     #0 0x55555567f2c7  (/home/nixos/src/dash/asan_debug/src/dash+0x12b2c7)
>     #1 0x5555556efbf4  (/home/nixos/src/dash/asan_debug/src/dash+0x19bbf4)
>     #2 0x55555570db42  (/home/nixos/src/dash/asan_debug/src/dash+0x1b9b42)
>     #3 0x5555556da016  (/home/nixos/src/dash/asan_debug/src/dash+0x186016)
>     #4 0x5555556d14e6  (/home/nixos/src/dash/asan_debug/src/dash+0x17d4e6)
>     #5 0x5555556d1345  (/home/nixos/src/dash/asan_debug/src/dash+0x17d345)
>     #6 0x5555556ef42c  (/home/nixos/src/dash/asan_debug/src/dash+0x19b42c)
>     #7 0x5555556eefe4  (/home/nixos/src/dash/asan_debug/src/dash+0x19afe4)
>     #8 0x7ffff7c2a47d
> (/nix/store/g8zyryr9cr6540xsyg4avqkwgxpnwj2a-glibc-2.40-66/lib/libc.so.6+0x2a47d)
> (BuildId: 076d831f9114b2d83bda538386af4e9665308c38)
> 
> SUMMARY: AddressSanitizer: heap-buffer-overflow
> (/home/nixos/src/dash/asan_debug/src/dash+0xf8a83)
> Shadow bytes around the buggy address:
>   0x50cffffffe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x50cffffffe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x50cfffffff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x50cfffffff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x50d000000000: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
> =>0x50d000000080: 00 00 00 00 00 00 00 00 00 00[fa]fa fa fa fa fa
>   0x50d000000100: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x50d000000180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x50d000000200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x50d000000280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x50d000000300: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> ==75725==ABORTING
> 
> Program received signal SIGKILL, Killed.
> 0x000055555569d350 in __sanitizer::internal__exit(int) ()
> (rr) bt
> #0  0x000055555569d350 in __sanitizer::internal__exit(int) ()
> #1  0x00005555556aa393 in __sanitizer::Die() ()
> #2  0x0000555555689203 in __asan::ScopedInErrorReport::~ScopedInErrorReport() ()
> #3  0x00005555556887fa in __asan::ReportGenericError(unsigned long,
> unsigned long, unsigned long, unsigned long, bool, unsigned long,
> unsigned int, bool) [clone .part.0] ()
> #4  0x000055555564cab4 in MemcmpInterceptorCommon(void*, int (*)(void
> const*, void const*, unsigned long), void const*, void const*,
> unsigned long) ()
> #5  0x000055555564cfae in __interceptor_memcmp ()
> #6  0x00005555556db48e in argstr (p=0x50d0000000cc "\210", flag=8) at
> expand.c:357
> #7  0x00005555556dadc8 in expandarg (arg=0x50d0000000a8,
> arglist=0x7ffff5e005a0, flag=10) at expand.c:232
> #8  0x00005555556d18fb in expredir (n=0x50d000000080) at eval.c:542
> #9  0x00005555556d2648 in evalcommand (cmd=0x50d000000060, flags=0) at
> eval.c:847
> #10 0x00005555556d13cd in evaltree (n=0x50d000000060, flags=0) at eval.c:305
> #11 0x00005555556d63ee in evalfun (func=0x50d000000040, argc=1,
> argv=0x5555560bc670 <stackbase+112>, flags=0)
>     at eval.c:1017
> #12 0x00005555556d2dfa in evalcommand (cmd=0x5555560bc630
> <stackbase+48>, flags=0) at eval.c:931
> #13 0x00005555556d13cd in evaltree (n=0x5555560bc630 <stackbase+48>,
> flags=0) at eval.c:305
> #14 0x00005555556ef42d in cmdloop (top=1) at main.c:246
> #15 0x00005555556eefe5 in main (argc=2, argv=0x7fffffffa2d8) at main.c:180
> (rr) frame 6
> #6  0x00005555556db48e in argstr (p=0x50d0000000cc "\210", flag=8) at
> expand.c:357
> 357                             if (!inquotes && !memcmp(p, dolatstr + 1,
> (rr) p p
> $1 = 0x50d0000000cc "\210"
> (rr) up
> #7  0x00005555556dadc8 in expandarg (arg=0x50d0000000a8,
> arglist=0x7ffff5e005a0, flag=10) at expand.c:232
> 232             argstr(arg->narg.text, flag);

This is actualy harmless because memcmp will return non-zero if we
read past the NUL character on the string p.  If there was a way
to mark this as a false-positive it would be nice.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
