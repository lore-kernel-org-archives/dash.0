Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC93FF1AE
	for <dash@vger.kernel.org>; Mon, 27 Jul 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170400; cv=none; b=goH/wiuyHka6VOCHlqvJwkWKvTrJOQh104hZdrcNoN0jpKwJzL9yZU25G5+dBYor40yD+FhY3Kub6XcQystON+id6r0AXB+1ygA39RyfyMj+3ltn5MkENxAtaBuAsfw+kwh0EEMtISJCpM8ZycuPWNnheiz6idR4tLZe8eG8E3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170400; c=relaxed/simple;
	bh=blR8mGQxpOk5ecZeGfqKU6GootNj27g4V1oC4sLgsHs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lZpNqsKd8zvGVCQ0mDaR72O5NvKDimx8nJMJXhWA0V0U6Vrf58P0oi7gSQWNIdlXtB3iaxV6raHka0bvNaLh7Poi6uoqGl2/9fKJFA/NY5eqkfmPMGKHZBcA2U+xgP8q5BOooQtljuw7oAxgzHagOvqEAmiFD27yD2/lzLlrpO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=LuJRIxtF; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="LuJRIxtF"
Received: from [192.168.1.218] (host81-133-56-137.in-addr.btopenworld.com [81.133.56.137])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.18.1/8.18.1) with ESMTPSA id 66RGdsmR094501
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Mon, 27 Jul 2026 18:39:54 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1785170394; bh=blR8mGQxpOk5ecZeGfqKU6GootNj27g4V1oC4sLgsHs=;
	h=From:From;
	b=LuJRIxtFMHVRwyNhN06HQp5KDCQ6j9ge4kjsHwp0EdlDShcqJDuOCXmn++Xv0ViYG
	 ZyY64pW8GiJkAkBOPibygByUSKYKE2o5WH+b/C2qakvz6Gt0bCOhUvvgPC0EsGIPIn
	 +gCLstkQveEzurodwHxpMKmVIxf2ivpJjNaiwbz0=
Message-ID: <a0afa62b-f2fb-423e-94bc-e84dd182cf4d@inlv.org>
Date: Mon, 27 Jul 2026 17:39:54 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ASan crash on failed eval with redirection in subshell
From: Martijn Dekker <martijn@inlv.org>
To: DASH shell mailing list <dash@vger.kernel.org>
References: <80abf283-bcaa-4cfe-b70f-a8f762b7da1d@inlv.org>
Content-Language: en-GB
In-Reply-To: <80abf283-bcaa-4cfe-b70f-a8f762b7da1d@inlv.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 27-07-2026 om 17:28 schreef Martijn Dekker:
> I've compiled dash (current master branch, commit 037bbdfd) on an M1 (arm64) 
> machine with macOS 15.7.4 with Apple's clang 17.0.0 and CFLAGS='-O0 -g - 
> fsanitize=address'.
> 
> Looks like there are multiple crashes when running the shellspec[*1] and 
> modernish[*2] regression tests. I will try to derive some concrete reproducers.


Here's another reproducer, derived from the modernish feature test for 
arithmetic for loops. The subshell, the eval and the redirection are all 
necessary to trigger the crash. It can be any redirection.

	(eval 'for ((;0;)) do :; done' 2>&2)

$ src/dash asan_crash.sh
asan_crash.sh: 1: eval: Syntax error: Bad for loop variable
AddressSanitizer: CHECK failed: asan_poisoning.cpp:40 "((AddrIsInMem(addr + 
size - (1ULL << 3)))) != (0)" (0x0, 0x0) (tid=16319841)
     #0 0x0001016031cc in __asan::CheckUnwind()+0x24 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x471cc)
     #1 0x00010161d048 in __sanitizer::CheckFailed(char const*, int, char 
const*, unsigned long long, unsigned long long)+0x94 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x61048)
     #2 0x000101641f34 in __asan::PoisonShadow(unsigned long, unsigned long, 
unsigned char) (.cold.4)+0x20 (libclang_rt.asan_osx_dynamic.dylib:arm64e+0x85f34)
     #3 0x0001015fafb0 in __asan::PoisonShadow(unsigned long, unsigned long, 
unsigned char)+0x1c8 (libclang_rt.asan_osx_dynamic.dylib:arm64e+0x3efb0)
     #4 0x0001015fc8c0 in __asan::PlatformUnpoisonStacks()+0x54 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x408c0)
     #5 0x000101602e68 in __asan_handle_no_return+0x2c 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x46e68)
     #6 0x000100d509e4 in evalcommand eval.c:926
     #7 0x000100d4ed44 in evaltree eval.c:305
     #8 0x000100d52de8 in evaltreenr eval.c:352
     #9 0x000100d51a34 in evalsubshell eval.c:512
     #10 0x000100d4ed44 in evaltree eval.c:305
     #11 0x000100d76894 in cmdloop main.c:244
     #12 0x000100d7638c in main main.c:178
     #13 0x00019e60ab94  (<unknown module>)

Abort trap: 6

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
