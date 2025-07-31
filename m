Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D83101EE
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984142; cv=none; b=gi7d1h6/b4WEJjlpe3I8Q87i7jXJLze5OaMCLJPJ+NJi3dhW9++EfjVxpWAMCfwlXvStICb0rgw9wD5XqkwgwjV2fEGNDt5NWCmcDDPJRoH2WxMQ1UQ8WvGXI3HMz+LzODOy6h8L3BTAzKGiG2P5mnbVOKH0EfLbLwiup/7zkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984142; c=relaxed/simple;
	bh=MrJbgkFTybwSVNHFEk2qdaQzm5kyX+42o3PbNTotZZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=LIeVWz+Nq971O1BgxSTJFPTJ2/Uyvm4OjlYfPUZ9UnWvPsR30yAH0ziZhzRXZh7NpWuXVAwyHDuPd3cLBi5qTu8prIGS4nKutS/5CvpUhC1ffvEtvi8KZmu/fuY0wyUgnxeWqkzNo41uJ90Jc8ZjMHLgmIWDhaTAsM9q78r1AAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=J7BcszbV; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="J7BcszbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753984133;
	bh=MrJbgkFTybwSVNHFEk2qdaQzm5kyX+42o3PbNTotZZc=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=J7BcszbVAb4ZbvnNpicfxLl+sqmDyaneurpPmrdOmvHBJuC9ibIhlK4DvxU5iEhEP
	 tasZis3ZSCTyh6eQpmmlm7uHcn7U1IOYHNsnoBgKuMcC8MEPLR7A30WCSihU9m8Yf8
	 RVZxz/I8U3Ph88rR3VwcD12i6AYiGIrz8RsD9o3Z444Mnhi76eayKXiGrTXgnIr2bK
	 2WWdwBki91mjy3PK6n//VYXHtBnARMmPNhocVrPM0rwXuI1mwxrn9HcyOdHeLb1YxS
	 Mp3SsVdegYBDY09qlfYxYP7PP/eIKnfopFii4c+RMEOfky6VgLc/bIiPY87yAsMBnQ
	 hsU7hFxtt9l6A==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 851821F994
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 20:48:53 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 20:48:53 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4btGm44ZFrzNkH4;
	Thu, 31 Jul 2025 20:48:52 +0300 (MSK)
Message-ID: <ea96c2da-f010-42b5-aecd-4ed61268ee9c@astralinux.ru>
Date: Thu, 31 Jul 2025 20:48:49 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] invalid-null-argument outmem() src/output.c:149:17
Content-Language: ru
From: Aleksander Ushakov <aushakov@astralinux.ru>
To: dash@vger.kernel.org
References: <8e89d699-8353-4294-85ee-68fba4fdb391@astralinux.ru>
In-Reply-To: <8e89d699-8353-4294-85ee-68fba4fdb391@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_all_Bitcoin}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
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


31/07/25 20:33, Aleksander Ushakov wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> 
> output.c:149:25: runtime error: null pointer passed as argument 1, which 
> is declared to never be null
> /usr/include/string.h:402:14: note: nonnull attribute specified here
>      #0 0x5f7d3a71f5d6 in outmem /upstream/ubsan/dash/src/output.c:149:17
>      #1 0x5f7d3a720841 in doformat /upstream/ubsan/dash/src/output.c:343:2
>      #2 0x5f7d3a7208f8 in out1fmt /upstream/ubsan/dash/src/output.c:275:2
>      #3 0x5f7d3a721d96 in printfcmd /upstream/ubsan/dash/src/bltin/ 
> printf.c:232:5
>      #4 0x5f7d3a6ddc85 in evalbltin /upstream/ubsan/dash/src/eval.c:975:12
>      #5 0x5f7d3a6d8ef4 in evalcommand /upstream/ubsan/dash/src/eval.c:923:7
>      #6 0x5f7d3a6d60ac in evaltree /upstream/ubsan/dash/src/eval.c:305:12
>      #7 0x5f7d3a70218c in cmdloop /upstream/ubsan/dash/src/main.c:246:8
>      #8 0x5f7d3a701e4b in main /upstream/ubsan/dash/src/main.c:180:3
>      #9 0x724e14494249 in __libc_start_call_main csu/../sysdeps/nptl/ 
> libc_start_call_main.h:58:16
>      #10 0x724e14494304 in __libc_start_main csu/../csu/libc-start.c:360:3
>      #11 0x5f7d3a6a4930 in _start (/upstream/ubsan/dash/src/ 
> dash+0x42930) (BuildId: 096851211111e4d689a2ea0deb5b5d647b8ebd40)
> 
> SUMMARY: UndefinedBehaviorSanitizer: invalid-null-argument output.c:149:25
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
> CC=clang CFLAGS=" -fsanitize=undefined -g " ./configure --disable-fnmatch
> --disable-lineno --disable-glob
> make
> cd src
> echo -e '""printf "%s"""' | ./dash


Also the patch fix the problem (just add conditional statement). I'm not 
sure if this affects the translator's functionality.

diff --git a/src/output.c b/src/output.c
index e9ee9b4..e97c570 100644
--- a/src/output.c
+++ b/src/output.c
@@ -146,7 +146,8 @@ outmem(const char *p, size_t len, struct output *dest)
         nleft = dest->end - dest->nextc;
         if (likely(nleft >= len)) {
  buffered:
-               dest->nextc = mempcpy(dest->nextc, p, len);
+               if (dest->nextc)
+                       dest->nextc = mempcpy(dest->nextc, p, len);
                 return;
         }




