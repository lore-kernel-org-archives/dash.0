Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F61E32D7
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985564; cv=none; b=rjnflXiC9l/EyWuhDXJXTl4j2cr5mVXvTd7URHWD0kNIYfAxiXUjejRsVO/TD7lH7nyitXKhgXzB+/HHjfDuJPtNs4DsB6FM0dS9c+VseeizdovJFFzgtCS6LLWNK1sE9ice7GP7dveQre9dfeoSHhB23c3I/xYPILfmXs11j7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985564; c=relaxed/simple;
	bh=P9O37j5CaO5gyvN48lw9Decgkhwbv2EIZqdPD5yrMDY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pv05q0MxyUKU9ZXQkJMmxtW4frpJAORrnc8HBBN4Xtc/IE9VNXYGODwMeOTV5QUpabuvgRr3grFjcMd7iGZnKmJpnZsjNA1bgMWjRDYhd8OwZq6fM11Ona1GdXVBmhl4KTOqYG+T0IHiT2rbPNSwthhRAzzaRdphgIz7CCj9cTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=g7u5oT4b; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="g7u5oT4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753985554;
	bh=P9O37j5CaO5gyvN48lw9Decgkhwbv2EIZqdPD5yrMDY=;
	h=Date:To:From:Subject:From;
	b=g7u5oT4bSL/redDnU46Xh0gEU1Z9A9pzo/9OrjXHsVgsr9J3Zi6B46AqnOIVcVuw/
	 LlQbAeaJFt01+j4xsWIFQ9P9FlDNp+ty8hEmAk0gDHwrfeOtFEXY5YO/LTSEq+Soip
	 YMntLy6z+IveNg+F1D/ZtgphjhpTn3Ncae6pBJxB0X5JY7P6uFX5IRZcPijJ7PRbqd
	 TO8VVcbmohxGfGw4BpsAUc9pFzkhrL6jKR28EALdLR692XzXygCsVItokjRD5g2gdl
	 J0+RReVwrts6StVxrM6xHIfFq4nHzqzZvi251NQaIg/LrJ8Hic82wA7q/mNmfFMIAs
	 /QnFdrxdOocaQ==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 782CA1F9C9
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:12:34 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:12:34 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4btHHP4Tcfz1J9kj;
	Thu, 31 Jul 2025 21:12:33 +0300 (MSK)
Message-ID: <02afc2e3-b996-4ab1-8b92-c79bcf8d789c@astralinux.ru>
Date: Thu, 31 Jul 2025 21:12:33 +0300
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
Subject: [BUG] applying zero offset to null pointer growjobtab()
 src/jobs.c:819:34
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_all_Bitcoin}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
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

Hello Dash maintainers,

I encountered a bug in Dash in commit b4ef25d7 and would like to report
it. The details are provided below.


jobs.c:819:34: runtime error: applying zero offset to null pointer
     #0 0x5adb67991deb in growjobtab /upstream/ubsan/dash/src/jobs.c:819:34
     #1 0x5adb67991985 in makejob /upstream/ubsan/dash/src/jobs.c:774:9
     #2 0x5adb679937a8 in vforkexec /upstream/ubsan/dash/src/jobs.c:992:7
     #3 0x5adb6796edcc in evalcommand /upstream/ubsan/dash/src/eval.c:916:9
     #4 0x5adb6796c0ac in evaltree /upstream/ubsan/dash/src/eval.c:305:12
     #5 0x5adb6799818c in cmdloop /upstream/ubsan/dash/src/main.c:246:8
     #6 0x5adb67997e4b in main /upstream/ubsan/dash/src/main.c:180:3
     #7 0x7a95463ad249 in __libc_start_call_main 
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
     #8 0x7a95463ad304 in __libc_start_main csu/../csu/libc-start.c:360:3
     #9 0x5adb6793a930 in _start (/upstream/ubsan/dash/src/dash+0x42930) 
(BuildId: bf877a87a1c989c4907f14ce16668321dedc5edd)

SUMMARY: UndefinedBehaviorSanitizer: nullptr-with-offset jobs.c:819:34

Environment:

Debian-12, x86-64
clang-19 compiler

Steps to reproduce:

./autogen.sh
CC=clang CFLAGS=" -fsanitize=undefined -g " ./configure 
--disable-fnmatch --disable-lineno --disable-glob
make
cd src
echo "sudo" | ./dash

You can put any installed utility instead of sudo on your system, except 
builtin commands.
