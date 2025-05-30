Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DC1A0B08
	for <dash@vger.kernel.org>; Fri, 30 May 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627410; cv=none; b=jZD31aF6LnYaKNvfLGropGhRj6I2VJdO93eX7htPSd91eVbMw2sphowYJTeqMpNSzb4pS+9735N/lZmrU21hl72Q52YMPLqtXKosnLaZezb7/2ATAqAJ6JAbKx+TMoNpnAevC5D3JR7g4n2Ajly7NVRAIeWRzeb4AjGAHxexqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627410; c=relaxed/simple;
	bh=FfocgJLidhcy+LIt+xpMC2Hlmf7pu2WQcLCfjEJ9uLQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=WTb24s7A9JahGfJSMiZ4Sq8L783aFB+JjZiLmPYQ/zbr+As9jZGYAvQfvE/kZnb6zgOjHgroLfAgisrEw6mwxf2hTj9sv6Ntn1H1d44fcupQEge2URJ4foQC7Is93q26eNc16Epw59c2OisVJs0xZTi2hiWrYqLQUGJvFzubd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=1NEG8A31; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="1NEG8A31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1748626901;
	bh=FfocgJLidhcy+LIt+xpMC2Hlmf7pu2WQcLCfjEJ9uLQ=;
	h=Date:From:Subject:To:From;
	b=1NEG8A311rjF4n5LApynhDFCYu6DlU/+UzeGrXDKVElbYdaF5BWqa9aH+5XKnj0rF
	 2o/PE3njBUvSZxUCy7StkwkPhqe3e1aJ6LUOE52bSDSniUBsOuLnc7j4LspL1uJd53
	 XNqjSHs99FevqStfX8vzSrGsP7PlLUnyZ7i66rcFvNq0dWGSzXQz5/rT2SReeGVEpm
	 AndHLiihszydK83qBS+s2nxsQhEOx21JJu2qJz5J6gWLQLVVjpZC+VS+v7fMPsRssN
	 No1zR0m0uCihL5dHKyXKoPDhdvY0yGNuuKFCbhTFR9Vz6hDP268sNFRNzbNbLr+p03
	 81lLC0ML2mvrg==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 1A2092487E
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:41:41 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru [10.177.185.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:41:40 +0300 (MSK)
Received: from [10.198.50.72] (unknown [10.198.50.72])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4b89XN4f27z1c0sm;
	Fri, 30 May 2025 20:41:40 +0300 (MSK)
Message-ID: <d7016eb2-44fb-4f7c-a457-ea0566641d03@astralinux.ru>
Date: Fri, 30 May 2025 20:41:40 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
From: Aleksander Ushakov <aushakov@astralinux.ru>
Subject: [BUG] heap-buffer-overflow setinputstring() src/input.c
To: dash@vger.kernel.org
Content-Language: ru
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 60 0.3.60 6d88365a2e70c53a128ac88f235883e0110f9019, {Tracking_all_Bitcoin}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
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
==131==ERROR: AddressSanitizer: heap-buffer-overflow on address 
0x5020000004f5 at pc 0x60bd0214d131 bp 0x7fff45c03700 sp 0x7fff45c02eb0
READ of size 2 at 0x5020000004f5 thread T0
     #0 0x60bd0214d130 in __interceptor_strlen 
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:389
     #1 0x60bd02239fee in setinputstring /upstream/dash/src/input.c:593
     #2 0x60bd0226936c in expandstr /upstream/dash/src/parser.c:1739
     #3 0x60bd02215e18 in evalcommand /upstream/dash/src/eval.c:881
     #4 0x60bd0220d9f0 in evaltree /upstream/dash/src/eval.c:305
     #5 0x60bd0224b2eb in cmdloop /upstream/dash/src/main.c:246
     #6 0x60bd0212643c in main /upstream/dash/src/main.c:180

0x5020000004f5 is located 0 bytes to the right of 5-byte region 
[0x5020000004f0,0x5020000004f5)
allocated by thread T0 here:
     #0 0x60bd021bb38f in __interceptor_malloc 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
     #1 0x60bd0224c728 in ckmalloc /upstream/dash/src/memalloc.c:66

SUMMARY: AddressSanitizer: heap-buffer-overflow 
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:389 
in __interceptor_strlen

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
UFM0PSdcXFxcXFxcXFxcXFxcXFxcXFwgIiR7dp5yLSQqXApwcmludCAvdGhVCm1jLlxcXFxcXFxc
K1skTElORU5gXSAnCnRyYXAgJ2VjaG8gdHJhcDogJExJTkVOTycgRVJSCgpzZXQgLXgKCiNpcyCA
AG4jIG1kLWEKYjp4CmI6eQpyXSBbamMgMC9hCmNkICRFTVBkIC4uCmxpICMgb3JpZ5Jic3BlYyAw
L2EKY2QgB0VNUGQgLi709PT09PT0AAD//1M9Ll1uIGFuIGV4aXQjICAgVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKIyAg
IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMg
cHVibGlzaGVkIGJ5CiMgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXIgdmVy
c2lvbiAzIG9mIHRoZSBMaWNlbnNlLCBvcgojICAgKGYKIyAgIE1FUkNIQU5UQUJJTElUWSBvciBG
IyBvcGlnaW5hbGx5IGZyb20gTWlrZSBIYWVydGVsCmZvbygpIHsgY2FzZSAkMSBpbiBhKikgOzsg
KikgOzsgZXNhYyA7fQpiYXIoKSB7IGNhc2UgJDUgaW4gW2FiY10qKSA7OyAqKTs7IGVzYWMgO30K
YmF6KCkgeyBjYXNlICQxIGluIHh5enp5KSA7OyAqKSA7OyBlc2FjIDt9CmZ+RH4jICAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkKIyAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgYXMgcHVibGlzaGVkIGJ5CiMgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBl
aXRoZXIgdmVyc2lvbiAzIG9mIHRoZSBMaWNlbnNlLCBvcgojICAgKGF0IHlvdXIgb3B0aW9uKSBh
bnkgbGF0ZXIgdmVyc2lvbi4KIwojICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCiMgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFO
VFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgojICAgTUVSQ0hBTlRBQklM
SVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQojICAgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KIwojICAgWW91IHNob3Vs
ZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UK
IyAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiAgSWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251
Lm9yZy9saWNlbnNlcy8+LgojCmRlY2xhcmUgLW50IHI9YQoKZigpCnsKCWRlY2xhcmUgYQoJZGVj
bGFyZSAtbiByPWEKCWRlY2xhcmUgLXAgYSByCn0KCmYKdW5zZXQgUFM0PScrWyRMSU5FPCRoZWxs
bywId29ybGNobyB0cmFwOiAkTElORU5PJyBFUlIKCnNldCAteAoKIyAgbSBpcyBmcmVlIHNvZnR3
YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgICBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eQojICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMzZvZiB0
aGUgTGljZW5zZSwgb3IKIyAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCiMK
IyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwg
YmUgdXNlZnVsLAojICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhl
IGltcGxpZWQgd2FycmFudHkgb2YKIyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKIyAgIEdOVSBHZW5lcmFsICNhJCgxIC90aFUK
dWMuMgpwcmludGYgIiUjKi4qZiMgbWFrZSBzdXJlIGFsaWFzZXMgdGhhdCBlbmQgaW4gbXVsdGli
eXRlIGNoYXJhY3RlcnMgZG9uJ3QgaW50ZnJmZXJlIHdpdGggdDBcMmhlCiMgc3BhY2Ugc2VudCMg
ICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTogeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQg
YW5kL29yIG1vZGlmeQojICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKIyAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb24sIGVpdGhlciB2ZXJzaW9uIDMgb2YgdGhlIExpY2Vuc2UsIG9yCiMgICAoYXQgeW91ciBv
cHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgojCiMgICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0
ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKIyAgIGJ1dCBXSVRIT1VUIEFO
WSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiMgICBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
CiMgICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZQpaSUZTPSQnXG4nJCdcdCck
JyAnIGRldGFpbHMuCiMKIyAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
======================================================================================
Then do the action:
base64 -d bs64.txt > crash.txt
