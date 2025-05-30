Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD623C4E0
	for <dash@vger.kernel.org>; Fri, 30 May 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627110; cv=none; b=IDl+I+4ZWC5BDplnXOgNg1qW6D/xARccSM1lv+YX70KLlsx/VA1VYBN6BT35o5VkZCcpDytmjozM4UFt1S1zQFE6teMelMP9xkKaIdN6W5d7HO0AzwsO82JQKFoimWj+/PiAW6NwMPi8ewpEiXnShfokRky3jKaGTTqmh4Q5Gxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627110; c=relaxed/simple;
	bh=C8ysV+W/EuJ6aGcf+3CI10LgHOlGVJMfV0YBIez0YHE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DOQcXYfk2HiIRDdiEdxEi7cOI9+qjxQd0Eq1d29jUNge+CQacKcCiq7L+n2AXNBIgRx+h/1/pwAMBTHBdaqSKBIzNldsjNi2ZMrInGz/Y5bPwHIG8s89KWrjNrVHadrv3hbyALL4S83Jj1mehXZA/QjQUPGN8cTyVWZgeZYkkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=WOoQip9A; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="WOoQip9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1748626630;
	bh=C8ysV+W/EuJ6aGcf+3CI10LgHOlGVJMfV0YBIez0YHE=;
	h=Date:To:From:Subject:From;
	b=WOoQip9ASQ8ZfTzh8HCO7b3isC+VvXBQs96Fuk0H5gYx8yvsktH8CaZnXylshVknu
	 9AE7HfckYT85DWutlBXG5FG7JH8snryYOJ2lZh/NwXVHAn8d8451lD1PpFrShtcJ0v
	 i+/PghsmdZh9Hq1C991+zcDddO82f0UXs2tl8XYK8SeDw6/fliM2xXohFTt3z72V4f
	 6NAGXxIZdNNB7jwpr60wuBqDD7N/CY5wwHZVP8f3R2GlWjuvjJMhLV88DhhXo2/osm
	 2BhPcDCRAL5dg3Mskf9XEpLpzkzHWtwUmNBU5rBa01XyTc34IFqrNYsxCNsLo4Y/I6
	 W+9lXUUMAzUjQ==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 7E2381F9C3
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:37:10 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru [10.177.185.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:37:10 +0300 (MSK)
Received: from [10.198.50.72] (unknown [10.198.50.72])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4b89R965gdz1c0sm
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:37:09 +0300 (MSK)
Message-ID: <0fe0fea8-24c5-4dbb-a2c9-3c0e01af7c18@astralinux.ru>
Date: Fri, 30 May 2025 20:37:09 +0300
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
Subject: [BUG] heap-use-after-free(read) pstrcmp() src/mystring.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 60 0.3.60 6d88365a2e70c53a128ac88f235883e0110f9019, {Tracking_all_Bitcoin}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 193763 [May 30 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/05/30 14:09:00 #27538393
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1


Hello Dash maintainers,

I encountered a bug in Dash in commit fd725b7a75 and would like to 
report it. The details are provided below.
The target crashed when reading from memory after it has been freed.
==119==ERROR: AddressSanitizer: heap-use-after-free on address 
0x515000008f08 at pc 0x62b3e92a9f96 bp 0x7ffe2076bc00 sp 0x7ffe2076b3b0
READ of size 1 at 0x515000008f08 thread T0
     #0 0x62b3e92a9f95 in __interceptor_strcmp 
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:466
     #1 0x62b3e9353a34 in bsearch 
/usr/include/x86_64-linux-gnu/bits/stdlib-bsearch.h:33
     #2 0x62b3e9353a34 in findstring /upstream/dash/src/mystring.c:260
     #3 0x62b3e935c140 in readtoken /upstream/dash/src/parser.c:737
     #4 0x62b3e935ce76 in list /upstream/dash/src/parser.c:181
     #5 0x62b3e936072e in readtoken1 /upstream/dash/src/parser.c:1587
     #6 0x62b3e93693ff in parseheredoc /upstream/dash/src/parser.c:690
     #7 0x62b3e93601d6 in readtoken1 /upstream/dash/src/parser.c:1597
     #8 0x62b3e9369bc3 in xxreadtoken /upstream/dash/src/parser.c:843
     #9 0x62b3e935bfb6 in readtoken /upstream/dash/src/parser.c:711
     #10 0x62b3e935ce76 in list /upstream/dash/src/parser.c:181
     #11 0x62b3e934a242 in cmdloop /upstream/dash/src/main.c:223
     #12 0x62b3e922543c in main /upstream/dash/src/main.c:180
     #13 0x7ab34e084249 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58
     #14 0x7ab34e084304 in __libc_start_main_impl ../csu/libc-start.c:360
     #15 0x62b3e9226520 in _start (/upstream/dash/src/dash+0x1a520)

0x515000008f08 is located 8 bytes inside of 512-byte region 
[0x515000008f00,0x515000009100)
freed by thread T0 here:
     #0 0x62b3e92b9068 in __interceptor_free 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
     #1 0x62b3e934c8cd in popstackmark /upstream/dash/src/memalloc.c:187

previously allocated by thread T0 here:
     #0 0x62b3e92ba38f in __interceptor_malloc 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
     #1 0x62b3e934b728 in ckmalloc /upstream/dash/src/memalloc.c:66

SUMMARY: AddressSanitizer: heap-use-after-free 
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:466 
in __interceptor_strcmp


Environment:
Debian-12, x86-64
afl-clang-lto compiler AFL++ project

Steps to reproduce:

export CC=afl-clang-lto
export AFL_USE_ASAN=1
./autogen.sh
./configure
make
cd src
./debian -i crash.txt

Steps to generate crash.txt:
copy the text into file bs64.txt
=====================================================================================
fWZmZmZmZmZmZmZmZmZmb289YGNhdCA8PEVPKApoaQojYSQoMSAvdGhVCnVjLjIKcHJpbnRmICIl
IyouKmZcIyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbl0vb3IgbW9kaWZ5CiMgICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQojICAgdGhlIEZyZWUgU29mdHdh
cmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMyBvZiB0aGUgTGljZW5zZSwgb3IKIyAgIChh
dCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCiMKIyAgIFRoaXMgcHJvZ3JhbSBpcyBk
aXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAojICAgYnV0IFdJ
VEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YK
IyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZSB0aGUKIyAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
CiMKIyAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlCiMgICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2Vl
IDxodHRwOi8vd3d3d3dudS5vcmcvbGljZW5zZXMvPi4KIwp4PXgKZT0KCnJlY2hvICR7eDorIiJ9
CnJlY2hvICR7eDorICIifQpyZWNobyAke3g6KyIiIH0KcmVjaG8gJHt4OisiJGUifQpyZWNobyAk
e3g6KyAiJGUifQpyZWNobyAke3g64ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODgKyIkZSIi
JGUiIiJ9CnJlY2hvICR7eDorIiRlIiIkZSIiIn0KcmVjaG8gJHt4OisiJGUiICIkZSIiIn0KcmVj
aG8gJHt4OisiJGUiIiRlIiAiIn0KcmVjaG8gJHt4OisgIiRlIiIkZSIiIn0KCmVjaG8gPT09PT0K
cmVjaG8gJHt4OisnJ14KcmVjaG8gJHt4OisgJyd9CnJlY2hvICR7eDorJycgfQpyZWNobyAke3g6
KycnICcnfQoKcmVjaG8gJHt4OiskZScnfQpyZWNobyAke3g6KycnJGV9CgpyZWNobyAke3g6Kycn
JGUgJGUnJ30KCmVjaG8gPT09PT0KcmVjaG8gJHt4OisiJCg6KSJ9CnJlY2hvICR7eDorICIkKDop
In0uCiMKeD14CmU9CisiJCg6KSIiJCg6KSIiIn0KcmVjaG8gJHt4OisiJCg6KSIiJCg6KSIiIn0K
cmVjaG8gJHt4OisiJCg6KSIgIiQoOikiIiJ9CnJlY2hvICR7eDorIiQoOikiIiQoOikiICIifQpy
ZWNobyAke3g6KyAiJCg6KSIiJCg6KSIiIn0KCmVjaG8gPT09PT0KcmVjaG8gJHt4OisiYDpgIn0K
cmVjaG8gJHt4OisgImA6YCJ9CnJlY2hvICR7eDorImA6YCIiYDpgIiIifQpyZWNobyAke3g6KyJg
OmAiImA6YCIiIn0KcmVjaG8gJG54OisiYDpg
======================================================================================
Then do the action:
base64 -d bs64.txt > crash.txt
