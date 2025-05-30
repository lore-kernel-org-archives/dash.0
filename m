Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658312367BB
	for <dash@vger.kernel.org>; Fri, 30 May 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627058; cv=none; b=Cl0hKBs0ILym/ccOKUB2afTs8jjjvKf/tl6wQ1RMtUL7+gsGxz/2h2y4EErp8BYntNfKr97Zt04wDPtZ0bBsikNUUqHj6vShulugqP3479rsW1zwvpdDhOVHgdswoWpQC2zDUryGFT76yYEaL2J3H8ODshHgUScarA0qhKI4bbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627058; c=relaxed/simple;
	bh=aa+cWL9PydlRHDwQoTNnKkvr69KvxVFhAEyZmDJFa6I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=BYYD1Wds60L33y2I5CurfpyxzJYKSAIylssWlf7g802MGoGTVtyvq6lkXm/yPaXpnzAOyhkUpYIBVmfX0BbxNiQlHdcA/Vz4GG2ypv2xVobfUV5daZFv+Scnxrphr4sTuI49/TEgHK2GmWLodDD3vdIgOzaf2OirdXCqf2GIHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=CgiUiOzJ; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="CgiUiOzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1748627048;
	bh=aa+cWL9PydlRHDwQoTNnKkvr69KvxVFhAEyZmDJFa6I=;
	h=Date:From:Subject:To:From;
	b=CgiUiOzJG+yGYLEjr0OJLL898tgjmmKmR3fY2ifZ8lCkkBM9f3FKgwi+xCFMQggm5
	 O8fPRWKkz4xWZi1NpoCVbZIHIHqHqmr+xDVxewBIKFlJBveCVUFp7Uu1mt4sccTOrJ
	 TA3CA18GRXTJKZWJJ150rDfJRDKkLCLY+9XPOSeVHWC+ejp5kPziIhLbzdrcl3AO4y
	 NiPwyKXGLyM5P6ThWdL2k9QizOl6WcThz3JydEaaZbrbSwXDww4RR+MzrUfAbNYRvL
	 /cZDr3pdCBFZBlyXTXbkHdTbgR+YG01sVGLUxzFhKd8GcDQUAtd0EquIEF/oUod0tO
	 zuk8QkSdzIZ8w==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 7B12F250DF
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:44:08 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail04.astralinux.ru [10.177.185.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Fri, 30 May 2025 20:44:08 +0300 (MSK)
Received: from [10.198.50.72] (unknown [10.198.50.72])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4b89bC6spqzkX0c;
	Fri, 30 May 2025 20:44:07 +0300 (MSK)
Message-ID: <65a83843-f91f-4220-8915-60cb51ce606f@astralinux.ru>
Date: Fri, 30 May 2025 20:44:07 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
From: Aleksander Ushakov <aushakov@astralinux.ru>
Subject: [BUG] heap-use-after-free argstr() src/expand.c
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
==133==ERROR: AddressSanitizer: heap-use-after-free on address 
0x515000081b88 at pc 0x59f1e650ae68 bp 0x7ffe24fb08a0 sp 0x7ffe24fb0898
READ of size 1 at 0x515000081b88 thread T0
     #0 0x59f1e650ae67 in argstr /upstream/dash/src/expand.c:300
     #1 0x59f1e65116d5 in casematch /upstream/dash/src/expand.c:2165
     #2 0x59f1e64eabd4 in evalcase /upstream/dash/src/eval.c:464
     #3 0x59f1e64e99f0 in evaltree /upstream/dash/src/eval.c:305
     #4 0x59f1e65272eb in cmdloop /upstream/dash/src/main.c:246
     #5 0x59f1e640243c in main /upstream/dash/src/main.c:180
     #6 0x7a56d2386249 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58
     #7 0x7a56d2386304 in __libc_start_main_impl ../csu/libc-start.c:360
     #8 0x59f1e6403520 in _start (/upstream/dash/src/dash+0x1a520)

0x515000081b88 is located 8 bytes inside of 512-byte region 
[0x515000081b80,0x515000081d80)
freed by thread T0 here:
     #0 0x59f1e6496068 in __interceptor_free 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
     #1 0x59f1e65298cd in popstackmark /upstream/dash/src/memalloc.c:187

previously allocated by thread T0 here:
     #0 0x59f1e649738f in __interceptor_malloc 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
     #1 0x59f1e6528728 in ckmalloc /upstream/dash/src/memalloc.c:66

SUMMARY: AddressSanitizer: heap-use-after-free 
/upstream/dash/src/expand.c:300 in argstr


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
UFM0PScrWyRMSU5FTmBdICcKdHJhcCAnZWNobyB0cmFwOgkkTElORU5PJyBFUlIKCnNldCAteAoK
IyAgIFRoaWUgc29sdHdhZQAAAP9sbAoKdW5hbGlhcyAtYQoLY29tcmU6IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKIyAgIGl0IHVuZGVyIHRodyB0ZXJtY2Vuc2UgYXMgcHVi
bGlzaGVkIGJ5cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibBAAIExpY2Vuc2UgYXMgcHVibGlzaGVk
IGJ5CiMgICB0aGUgRnJlZSBTb2Z0d2FyZSBGIHZlcnNpb24gMyBvZiBoZXIgdmVyc2lvbiAzIG9m
IHRoZSBMaSMgbWFrZSBzc2VzIHRoYXQgZW4jICAgVGhpcyBwcm1ncmFtIGlyb2dyYW0uICBJZiBu
b3QsIHNlZSA8aHR0cGVkaXN0cmlidXRlIGl0IAAAAABvciBtb2RpZnkKIyAgIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY3MgcHViLgoKdWxpbWl0IC1zdHJp
YnV0ZQZpdCBhbmQvb3IgbWxpc2hlZCBieQojICBieQojICAgdGhlIEZyZWUgU29mZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmaGVyIHZlcnNpIyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOiB5
b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgICBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlNUdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQojICAg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMyBvZiB0aGUgTGlj
ZW5zZSwgb3IKIyAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCiMKIyAgIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLAojICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxp
ZWQgd2FycmFudHkgb2YKIyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKIyAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZv
ciBtb3JlIGRldGFpbHMuCiMKIyAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCiMgICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3Jh
bS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4KIwpPSUZTPSIk
SUZTIgpmb289JyAgICxmb28nCnNldCAtLSAiJGZvbyIKCmlmIFtbICRmb28gPSAsKiBdXTsgdGhl
biBlY2hvIGJhZCAxOyBlbHNlIGVjaG8gb2sgMTsgZmkKaWYgW1sgJEAgPSAsKiBdXTsgdGhlbiBl
Y2hvIGJhZCAyOyBlbHNlIGVjaG8gb2sgMjsgZmkKaWYgW1sgJCogPSAsKiBdXTsgdGhlbiBlY2hv
IGJhZCAzOyBlbHNlIGVSaG8gb2sgMzsgZmkKaWYgW1sgJHtAfSA9ICwqIF1dOyB0aGVuIGVjaG8g
YmFkIDQ7IGVsc2UgZWNobyBvayA0OyBmaQppZiBbWyAkeyp9ID0gLCogXV07IHRoZW4gZWNobyBi
YWQgNTsgZWxzZSBlY2hvIG9rIDU7IGZpCmlmIFtbICQxID0gLCogXV07IHRoZW4gZWNobyBiYWQg
NjsgZWxzZSBlY2hvIG9rIDY7IGZpCgpzZXQgLS0gJyAgICxmb28nCmlmIFtbICRmb28gPSAsKiBd
XTsgdGhlbiBlY2hvIGJhZCA3OyBlbHNlIGVjaG8gb2sgNzsgZmkKaWYgW1sgJEAgPSAsKiBdXTsg
dGhlbiBlY2hvIGJhZCA4OyBlbHNlIGVjaG8gb2sgODsgZmkKaWYgW1sgJCogPSAsKiBdXTsgdGhl
biBlY2hvIGJhZCA5OyBlbHNlIGVjaG8gb2sgOTsgZmkKaWYgW1sgJHtAfSA9ICwqIF1dOyB0aGVu
IGVjaG8gYmFkIDEwOyBlbHNlIGVjaG8gb2sgMTA7IGZpCmlmIFtbICR7Kn0gPSAsKiBdXTsgdGhl
biBlY2hvIGJhZCAxMTsgZWxzZSBlY2hvIG9rIDExOyBmaQppZiBbWyAkMSA9ICwqIF1dOyB0aGVu
IGVjaG8gYmFkIDEyOyBlbHNlIGVjaG8gb2sgMTI7IGZpCgpJRlM9CmlmIFtbICRAID0gLCogXV07
IHRoZW4gZWNobyBiYWQgMTM7IGVsc2UgZWNobyBvayAxMzsgZmkKaWYgW1sgJCogPSAsKiBdXTsg
dGhlbiBlY2hvIGJhZCAxNDsgZWxzZSBlY2hvIG9rIDE0OyBmaQpJRlM9IiRPSUZTIgoKZm9vPScg
ICAsZm9vJwpzZXQgLS0gJyAgICcgJyxmb28nCgppZiBbWyAkQCA9ICwqIF1dOyB0aGVuIGVjaG8g
YmFkIGF0IDE7IGVsc2UgZWNobyBvayBhdCAxOyBmaQppZiBbWyAke0B9ID0gLCogXV07IHRoZW4g
ZWNobyBiYWQgYXQgMjsgZWxzZSBlY2hvIG9rIGF0IDI7IGZpCgppZiBbWyAkKiA9ICwqIF1dOyB0
aGVuIGVjaG8gYmFkIHN0YXIgMTsgZV5zZSBlY2hvIG9rIHN0YXIgMTsgZmkKaWYgW1sgJHsqfSA9
ICwqIF1dOyB0aGVuIGVjaG8gYmFkIHN0YXIgMjsgZWxzZSBlY2hvIG9rIHN0YXIgMjsgZmkKCmZv
bz0nICAgLGZvbycKc2V0IC0tICIkZm9vIgoKIyBleHBhbmRfc3RyaW5nX2Zvcl9yaHMKCmZvbzI9
JEAKZWNobyAiJGZvbzIiCgpmb28yPSQqCmVjaG8gIiRmb28yIgoKZm9vMj0iJEAiCmVjaG8gIiRm
b28yIgoKZm9vMj0iJCoiCmVjaG8gIiRmb28yIgoKIyBleHBhbmRfd29yZF91bnNwbGl0CmNhc2Ug
JEAgaW4KJGZvbzIpCWVjaG8gb2sgYXQgMSA7OwoqKQllY2hvIGJhZCBhdCAxIDs7CmVzYWMKCiMg
YWxzbyB1c2VzIGV4cGFuZF93b3JkX2xlYXZlX3F1b3RlZApjYXNlICRAIGluCiRAKQllY2hvIG9r
IGF0IDI7OwoqKQllY2hvIGJhZCBhdCAyOzsKZXNhYwoKY2FzZSAkQCBpbgokZm9vKQllY2hvIG9r
IGF0IDMgOzsKKikJZWNobyBiYWQgYXQgMzs7CmVzYWMKCiMgZXhwYW5kX3dvcmRfdW5zcGxpdApj
YXNlICQqIGluCiRmb28yKQllY2hvIG9rIHN0YXIgMSA7OwoqKQllY2hvIGJhZCBzdGFyIDEgOzsK
ZXNhYwoKIyBhbHNvIHVzZXMgZXhwYW5kX3dvcmRfbGVhdmVfcXVvdGVkCmNhc2UgJCogaW4KJCop
CWVjaG8gb2sgc3RhciAyOzsKKikJZWNobyBiYWQgc3RhciAyOzsKZXNhYwoKY2FzZSAkKiBpbgok
Zm9vKQllY2hvIG9rIHN0YXIgMyA7OwoqKQllY2hvIGJhZCBzdGFyIDM7Owplc2FjCgpjYXNlICRA
IGluCiQqKQllY2hvIG9rIGF0LXN0YXIgMTs7CiopCWVjaG8gYmFkIGF0LXN0YXIgMTs7CmVzYWMK
CmNhc2UgJCogaW4KJEApCWVjaG8gb2sgYXQtc3RhciAyOzsKKikJZWNobyBiYWQgYXQtc3RhciAy
OzsKZXNhYwoKZm9vPSdhIGIgYycKc2V0IC0tICRmb28KCiMgZXhwYW5kX3N0cmluZ19mb3Jfcmhz
CklGUz0nfCcKZm9vMj0kQAplY2hvICIkZm9vMiIKCmZvbzI9JCoKZWNobyAiJGZvbzIiCgpmb28y
PSIkQCIKZWNobyAiJGZvbzIiCgpmb28yPSIkKiIKZWNobyAiJGZvbzIiCgpmb289ImEgYiBjIgpz
ZXQgLS0gJGZvbwoKaWYgW1sgJEAgPSAkZm9vIF1dOyB0aGVuIGVjaG8gb2sgYXQgMTsgZWxzZSBl
Y2hvIGJhZCBhdCAxOyBmaQppZiBbWyAkZm9vID0gJEAgXV07IHRoZW4gZWNobyBvayBhdCAyOyBl
bHNlIGVjaG8gYmFkIGF0IDI7IGZpCgpjYXNlICRAIGluCiRAKQllY2hvIG9rIGF0IDMgOzsKKikJ
ZWNobyBiYWQgYXQgMyA7Owplc2FjCgpjYXNlICRAIGluCiRmb28pCWVjaG8gb2sgYXQgNDs7Ciop
CWVjaG8gYmFkIGF0IDQ7Owplc2FjCgpjYXNlICRmb28gaW4KJEApCWVjaG8gb2sgYXQgNTs7Ciop
CWVjaG8gYmFkIGF0IDU7Owplc2FjCklGUz0iJE9JRlMiCgpmb289ImEgYiBjIgpzZXQgLS0gJGZv
bwoKSUZTPToKaWYgW1sgJEAgPSAkZm9vIF1dOyB0aGVuIGVjaG8gb2sgYXQgMTsgZWxzZSBlY2hv
IGJhZCBhdCAxOyBmaQppZiBbWyAkZm9vID0gJEAgXV07IHRoZW4gZWNobyBvayBhdCAyOyBlbHNl
IGVjaG8gYmFkIGF0IDI7IGZpCgpjYXNlICRAIGluCiRAKQllY2hvIG9rIGF0IDMgOzsKKikJZWNo
byBiYWQgYXQgMyA7Owplc2FjCgpjYXNlICRAIGluCiRmb28pCWVjaG8gb2sgYXQgNDs7Cj4pCWVj
aG8gYmFkIGF0IDQ7Owplc2FjCgpjYXNlICRmb28gaW4KJEApCWVjaG8gb2sgYXQgNTs7CiopCWVj
aG8gYmFkIGF0IDU7Owplc2FjCklGUz0iJE9JRlMiCgpmb289ImEgYiBjIgpzZXQgLS0gJGZvbwoK
SUZTPSd8Jwpmb28yPSRACgpjYXNl
======================================================================================
Then do the action:
base64 -d bs64.txt > crash.txt
