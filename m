Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932A238C2B
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965376; cv=none; b=Q26PFI1cmLow6e9qTQrA2kvvlEjWg6IJi1v/d3fYmiE8trqLWvRuB5yVPK4e3yKpfh+GuAYTc3PKzEbX3UjC7Bm1rXNoruSGHIlQmgP0E9SMYAgwFZ1BVh5zFNk4IGAc9WQo6rMYvigPTqCq4SMu+RBVWlSEm5vmTTZzCrFHjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965376; c=relaxed/simple;
	bh=TyCB5vK6W6C1eZqH0kKu42DOBoZW+6FedOaelufu1qo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=FmgnSZFfc57eYPz2IYUDasrgIxYdzo7Dt68pZwotniUDm1yGzSnT2xnRfoi7HgRLyr9xkGlX/KOoEVr0OGV/eNmBar+ksTmSsTY0Q3gbGutadanm0slWJ8L/DdfMzF4ONQoB9D+WO51J5+/ODwi5JCuRdaVrzxlT5GCgCNzk2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=LPSrs/Uf; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="LPSrs/Uf"
Received: from [192.168.178.21] (unknown [31.94.68.113])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id E7130E9;
	Thu, 31 Jul 2025 13:30:58 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E7130E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1753965059;
	bh=yvmSomkKglpZC+Za3bvxtwTnBtopSxOjaSnvFqDniwc=; l=5680;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LPSrs/Ufst4x071Qzgoow5tW0vQa6EyDQ+68U5dMjMknEzetqpDuF5l75t4w4rfL5
	 sL7KyzvCZIG2hKiE+7baCR6b2fklZv7YqGL69YGvWpRx6ET8bLsD555WWRGwWdTsUc
	 oRTgmkXxp4Lo+P4i1Irc2fbUa/VahpDaG9UjOzMg=
Content-Type: multipart/mixed; boundary="------------tpBmxM2y7d0AiMPZdvD2sClT"
Message-ID: <1d7f7194-c653-4444-911a-82651def5c63@gigawatt.nl>
Date: Thu, 31 Jul 2025 13:30:56 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] SEGV getop() src/bltin/test.c:171:7
Content-Language: en-GB
To: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
References: <52d97ed4-7c78-44ec-8c1b-60569491aa31@astralinux.ru>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <52d97ed4-7c78-44ec-8c1b-60569491aa31@astralinux.ru>

This is a multi-part message in MIME format.
--------------tpBmxM2y7d0AiMPZdvD2sClT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 31/07/2025 12:30, Aleksander Ushakov wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> 
> AddressSanitizer:DEADLYSIGNAL
> 
> =================================================================
> ==18517==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000a09
> (pc 0x58db5c62ec40 bp 0x7ffe4f593610 sp 0x7ffe4f592db0 T0)
> ==18517==The signal is caused by a READ memory access.
> ==18517==Hint: address points to the zero page.
>        #0 0x58db5c62ec40 in strcmp (/upstream/test/dash/src/dash+0x51c40)
> (BuildId: 535a280f2cc73be57729926bfac9fbc4801d63be)
>        #1 0x58db5c72ef74 in getop
> /upstream/test/dash/src/bltin/test.c:171:7
>        #2 0x58db5c72f022 in t_lex
> /upstream/test/dash/src/bltin/test.c:444:7
>        #3 0x58db5c72f535 in aexpr
> /upstream/test/dash/src/bltin/test.c:269:7
>        #4 0x58db5c72f199 in oexpr
> /upstream/test/dash/src/bltin/test.c:252:10
>        #5 0x58db5c72ee30 in testcmd
> /upstream/test/dash/src/bltin/test.c:228:9
>        #6 0x58db5c6fee10 in evalbltin
> /upstream/test/dash/src/eval.c:975:12
>        #7 0x58db5c6fc183 in evalcommand
> /upstream/test/dash/src/eval.c:923:7
>        #8 0x58db5c6fa925 in evaltree /upstream/test/dash/src/eval.c:305:12
>        #9 0x58db5c717762 in cmdloop /upstream/test/dash/src/main.c:246:8
>        #10 0x58db5c71736f in main /upstream/test/dash/src/main.c:180:3
>        #11 0x76be525ad249 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>        #12 0x76be525ad304 in __libc_start_main
> csu/../csu/libc-start.c:360:3
>        #13 0x58db5c6165d0 in _start (/upstream/test/dash/src/dash+0x395d0)
> (BuildId: 535a280f2cc73be57729926bfac9fbc4801d63be)
> ==18517==Register values:
> rax = 0x000000005c74e201  rbx = 0x000058db5c74e260  rcx =
> 0x0000000000000000  rdx = 0x000058db5c74e6a0
> rdi = 0x0000000000000a09  rsi = 0x000058db5c74e260  rbp =
> 0x00007ffe4f593610  rsp = 0x00007ffe4f592db0
>     r8 = 0xf9f9f903f9f9f901   r9 = 0x00000b1beb8e1cd4  r10 =
> 0x00000b1beba13ac2  r11 = 0x00000b1beb8e1cd0
> r12 = 0x0000000000000000  r13 = 0x00007ffe4f5941c8  r14 =
> 0x0000000000000a09  r15 = 0x0000000000000000
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV (/upstream/test/dash/src/dash+0x51c40)
> (BuildId: 535a280f2cc73be57729926bfac9fbc4801d63be) in strcmp
> ==18517==ABORTING
> 
> Environment:
> 
> Debian-12, x86-64
> clang-19 compiler
> 
> Steps to reproduce:
> 
> ./autogen.sh
> CC=clang CFLAGS=" -fsanitize=address -g " ./configure --disable-fnmatch
> --disable-lineno --disable-glob
> make
> cd src
> echo -e '0000000000000000000000000000000000000000"$IFS"\ntest "" -a' |
> ./dash

Thanks for the report.

> I think I fixed the problem here:

Did you fix it, or did you ask AI to fix it? Asking because the 
description reads very much as if it is AI-generated, and if it is, that 
really should be disclosed in my opinion.

The patch does not look complete (-o has the same problem and is not 
fixed), and does not look right. It's not enough to not crash, we have 
to actually do the right thing. Here, doing the right thing is reporting 
the error for the invalid use of the test command.

For e.g. test x =, dash already reports:

   $ src/dash -c 'test x ='
   src/dash: 1: test: =: argument expected

For test x -a and test x -o, dash could do the same, as with the 
attached patch.

Note: it is not necessary to check t_wp[1] because t_lex supports null 
pointers and returns EOI. We could use this for the check too, we could 
check for EOI after the last t_lex, rather than what my patch does. I am 
not sure what is better, the effect would be the same.

Cheers,
Harald van Dijk
--------------tpBmxM2y7d0AiMPZdvD2sClT
Content-Type: text/plain; charset=UTF-8;
 name="test-avoid-out-of-bounds-access.patch"
Content-Disposition: attachment;
 filename="test-avoid-out-of-bounds-access.patch"
Content-Transfer-Encoding: base64

RnJvbSAzNGQ4NjFmZDUwYWJmNDY5M2ViOWU0MjRhOWNmZTc1N2U1MTU0MmNlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJhbGQgdmFuIERpamsgPGhhcmFsZEBnaWdhd2F0
dC5ubD4KRGF0ZTogVGh1LCAzMSBKdWwgMjAyNSAxMzoxODoyOCArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIHRlc3Q6IGF2b2lkIG91dCBvZiBib3VuZHMgYWNjZXNzCgpXaGVuIGEgYm9vbGVh
biBvcGVyYXRvciBhcHBlYXJzIGF0IHRoZSBlbmQgb2YgYW4gZXhwcmVzc2lvbiwgbWFrZSBz
dXJlIHdlCmRvIG5vdCB0cnkgdG8gY29udGludWUgcGFyc2luZyB0aGUgZXhwcmVzc2lvbiBw
YXN0IGl0cyBlbmQuCi0tLQogc3JjL2JsdGluL3Rlc3QuYyB8IDQgKysrKwogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3NyYy9ibHRpbi90ZXN0LmMg
Yi9zcmMvYmx0aW4vdGVzdC5jCmluZGV4IDZkODQ0ZjEuLjA4NzY1NTkgMTAwNjQ0Ci0tLSBh
L3NyYy9ibHRpbi90ZXN0LmMKKysrIGIvc3JjL2JsdGluL3Rlc3QuYwpAQCAtMjUzLDYgKzI1
Myw4IEBAIG9leHByKGVudW0gdG9rZW4gbikKIAkJbiA9IHRfbGV4KHRfd3AgKyAxKTsKIAkJ
aWYgKG4gIT0gQk9SKQogCQkJYnJlYWs7CisJCWlmICh0X3dwWzJdID09IE5VTEwpCisJCQlz
eW50YXgodF93cFsxXSwgImFyZ3VtZW50IGV4cGVjdGVkIik7CiAJCW4gPSB0X2xleCh0X3dw
ICs9IDIpOwogCX0KIAlyZXR1cm4gcmVzOwpAQCAtMjY5LDYgKzI3MSw4IEBAIGFleHByKGVu
dW0gdG9rZW4gbikKIAkJbiA9IHRfbGV4KHRfd3AgKyAxKTsKIAkJaWYgKG4gIT0gQkFORCkK
IAkJCWJyZWFrOworCQlpZiAodF93cFsyXSA9PSBOVUxMKQorCQkJc3ludGF4KHRfd3BbMV0s
ICJhcmd1bWVudCBleHBlY3RlZCIpOwogCQluID0gdF9sZXgodF93cCArPSAyKTsKIAl9CiAJ
cmV0dXJuIHJlczsKLS0gCjIuNDcuMgoK

--------------tpBmxM2y7d0AiMPZdvD2sClT--
