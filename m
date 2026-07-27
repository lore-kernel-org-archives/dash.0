Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99496423789
	for <dash@vger.kernel.org>; Mon, 27 Jul 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169807; cv=none; b=WfkN8/4IYLcTayxpGDLqLBELEJcbbfTrtCGEX3QW67LDIgQJ5G9lNII4jqvukL1rF+zM38qKknUTVwINYKuWEE/a5JMYTbvU1RpTWCgwC/nWdAgSnfVyPISEiHlFTlGVQaEUeurslfKQGPCNOAamlz9THB2luvcyFV46Bab+Sts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169807; c=relaxed/simple;
	bh=nmEURiYZXnFW8LwXSO8A4Xx8ukC3mjvCSCj0qL1nnrU=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=hdKKa7wDlGt5xSyEkAZLjvJFtbbLmifYhyMjYJocgbE+QIMeR1QmdqUHQa8CvDRGsR44zjYMA95iLXB/kivffxyoPsvp65k1r8A2byiOBdoHn2ylRLyaZ+kXvXwhusX4sbNpi2D/+hnWc1QV8CCmut3ZOeFamIYzesV+6Cjj7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=E8mf6rUC; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="E8mf6rUC"
Received: from [192.168.1.218] (host81-133-56-137.in-addr.btopenworld.com [81.133.56.137])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.18.1/8.18.1) with ESMTPSA id 66RGSOKF094443
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Mon, 27 Jul 2026 18:28:25 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1785169705; bh=nmEURiYZXnFW8LwXSO8A4Xx8ukC3mjvCSCj0qL1nnrU=;
	h=From:From;
	b=E8mf6rUCrsWD9RQE92LS5YICL7iWTl7Q0D70Prv8NRndugy7jtc4P+dzzKaK3CHuc
	 zYImC5gkXzbZpY9ORmbX2DNAB44iLCpSo7//jKisTkldVNPcwaaSIrisHvQLtgCeyF
	 //8wUAUTKUfh0LS+qsk6nJh4ynRuNPWxUTnsGRIQ=
Message-ID: <80abf283-bcaa-4cfe-b70f-a8f762b7da1d@inlv.org>
Date: Mon, 27 Jul 2026 17:28:24 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martijn Dekker <martijn@inlv.org>
Content-Language: en-GB
To: DASH shell mailing list <dash@vger.kernel.org>
Subject: ASan crash on failed redirection in subshell
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I've compiled dash (current master branch, commit 037bbdfd) on an M1 (arm64) 
machine with macOS 15.7.4 with Apple's clang 17.0.0 and CFLAGS='-O0 -g 
-fsanitize=address'.

Looks like there are multiple crashes when running the shellspec[*1] and 
modernish[*2] regression tests. I will try to derive some concrete reproducers.

To begin with, this reproducer script:

	(
		: >/dev/null/nonexistent
	)

crashes as follows:

$ src/dash asan_crash.sh
asan_crash.sh: 2: cannot create /dev/null/nonexistent: Directory nonexistent
AddressSanitizer: CHECK failed: asan_poisoning.cpp:40 "((AddrIsInMem(addr + 
size - (1ULL << 3)))) != (0)" (0x0, 0x0) (tid=16311095)
     #0 0x000100e3b1cc in __asan::CheckUnwind()+0x24 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x471cc)
     #1 0x000100e55048 in __sanitizer::CheckFailed(char const*, int, char 
const*, unsigned long long, unsigned long long)+0x94 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x61048)
     #2 0x000100e79f34 in __asan::PoisonShadow(unsigned long, unsigned long, 
unsigned char) (.cold.4)+0x20 (libclang_rt.asan_osx_dynamic.dylib:arm64e+0x85f34)
     #3 0x000100e32fb0 in __asan::PoisonShadow(unsigned long, unsigned long, 
unsigned char)+0x1c8 (libclang_rt.asan_osx_dynamic.dylib:arm64e+0x3efb0)
     #4 0x000100e348c0 in __asan::PlatformUnpoisonStacks()+0x54 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x408c0)
     #5 0x000100e3ae68 in __asan_handle_no_return+0x2c 
(libclang_rt.asan_osx_dynamic.dylib:arm64e+0x46e68)
     #6 0x000100848314 in evalcommand eval.c:857
     #7 0x000100846d44 in evaltree eval.c:305
     #8 0x00010084ade8 in evaltreenr eval.c:352
     #9 0x000100849a34 in evalsubshell eval.c:512
     #10 0x000100846d44 in evaltree eval.c:305
     #11 0x00010086e894 in cmdloop main.c:244
     #12 0x00010086e38c in main main.c:178
     #13 0x00019e60ab94  (<unknown module>)

Abort trap: 6


[*1] To run the shellspec tests:
git clone --depth=1 https://github.com/shellspec/shellspec
cd shellspec
path/to/dash shellspec

[*2] To run the modernish regression tests:
git clone --depth=1 https://github.com/modernish/modernish
cd modernish
path/to/dash bin/modernish --test

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

