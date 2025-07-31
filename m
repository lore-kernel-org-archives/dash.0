Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D013D51E
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983193; cv=none; b=P9UNXx0AcuRAUYUn67frQXuOxzY9XrBVFBEYu8dbWFqSiMITRMBKp5E6uE7Jmzs4TmlPFITGUV3MaPqmhHJrMCeDKbaaoANy3TbwZXNDLHVYiVOUqDEKZig15JxDNt0mO3QQeeI7b+lFRuAZcL33vT/+Viv74ePogUE4E+tmlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983193; c=relaxed/simple;
	bh=nIFA9jWtSoTdLa9tkmCb0AugC76c+3xdfY6kIWDbLuQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=EJw+BUZO+CdGwywgqc9KftpetPp1N7DeZd0e1R3O8Rzb0CguVFKxKoZCpowdfnKWBX6HNsvfiiLJ3yVP0+T9mX6cn9/vAfJPGFmFJh44U1QxYhb0d4YgKOv8sTolVyQUv7YOCllUnAlnt96n/9NRY/mRu3r5asjRvv0kMfVkYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=FT71Jmhe; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="FT71Jmhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753983183;
	bh=nIFA9jWtSoTdLa9tkmCb0AugC76c+3xdfY6kIWDbLuQ=;
	h=Date:To:From:Subject:From;
	b=FT71JmheZxajvYjAAZwRpypP9PFxSd4OChDJIeB6KUu7SzIJSLpOnImsbPrEi3lX8
	 EALjH95YDgkuBTZLUj9fk0ijCRnoQvT9vZ3WVDaTxOn7NecY4j2t6xj/i+wERbl6FD
	 KuLpUNXAcb+1JRhD6wlY2qkp1eD3jOhbc3hJuy4dXpvRR7n/aSyDAa5gOvp/XrGxJY
	 lUP5Byy6cu56KG3+Z6A21QtaVC419BmkTR09WiF3q5Wa6eI7WBB51YasiXPEJu4WIv
	 dLTRZZECV5MdWRQVLmbALa5Ve4t2FQH9H5gHmPfpxksEAKMF5HnVG7tNtmR4COSTNB
	 wtz/RuxFt0kOw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 7776F1FA00
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 20:33:03 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 20:33:03 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4btGPp526rzNkH7;
	Thu, 31 Jul 2025 20:33:02 +0300 (MSK)
Message-ID: <8e89d699-8353-4294-85ee-68fba4fdb391@astralinux.ru>
Date: Thu, 31 Jul 2025 20:33:01 +0300
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
Subject: [BUG] invalid-null-argument outmem() src/output.c:149:17
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_all_Bitcoin}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1, FromAlignment: s
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

output.c:149:25: runtime error: null pointer passed as argument 1, which 
is declared to never be null
/usr/include/string.h:402:14: note: nonnull attribute specified here
     #0 0x5f7d3a71f5d6 in outmem /upstream/ubsan/dash/src/output.c:149:17
     #1 0x5f7d3a720841 in doformat /upstream/ubsan/dash/src/output.c:343:2
     #2 0x5f7d3a7208f8 in out1fmt /upstream/ubsan/dash/src/output.c:275:2
     #3 0x5f7d3a721d96 in printfcmd 
/upstream/ubsan/dash/src/bltin/printf.c:232:5
     #4 0x5f7d3a6ddc85 in evalbltin /upstream/ubsan/dash/src/eval.c:975:12
     #5 0x5f7d3a6d8ef4 in evalcommand /upstream/ubsan/dash/src/eval.c:923:7
     #6 0x5f7d3a6d60ac in evaltree /upstream/ubsan/dash/src/eval.c:305:12
     #7 0x5f7d3a70218c in cmdloop /upstream/ubsan/dash/src/main.c:246:8
     #8 0x5f7d3a701e4b in main /upstream/ubsan/dash/src/main.c:180:3
     #9 0x724e14494249 in __libc_start_call_main 
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
     #10 0x724e14494304 in __libc_start_main csu/../csu/libc-start.c:360:3
     #11 0x5f7d3a6a4930 in _start 
(/upstream/ubsan/dash/src/dash+0x42930) (BuildId: 
096851211111e4d689a2ea0deb5b5d647b8ebd40)

SUMMARY: UndefinedBehaviorSanitizer: invalid-null-argument output.c:149:25


Environment:

Debian-12, x86-64
clang-19 compiler

Steps to reproduce:

./autogen.sh
CC=clang CFLAGS=" -fsanitize=undefined -g " ./configure --disable-fnmatch
--disable-lineno --disable-glob
make
cd src
echo -e '""printf "%s"""' | ./dash
