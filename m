Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DC376
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985966; cv=none; b=ap6BWyde8lPef1GvTnTRzkurq+JfA8OUnMuB1VwlDttiTUU9rqWDxF0LLZE0tL1aeLRtxTjPNX88TkJXWOShzfardfNGOa8W8HVYyhKUhqH5Hbhpt40WIgpBSMewgrBNpC7JYOSB684aVsSVBEMr1eaDmFe75xXGFKkr20ZtLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985966; c=relaxed/simple;
	bh=jbA42USdPCiBrLw4UxqEQ+LgTI3lE95B3lQQE1abqrk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=n4207Jz+98DTVQlT7sJPQ82c3+ABiYUQcvi99/ymaODqqurjS+utN0GqAStHZg1ykoQn4KqPieYGX8IVMvn4oRezuo6PX80XASANuaxDK4NdQGuqTb/MXgZCbGJ8kki/ZEaWLOkSZNxKPlxDkZgXeStyD+KzZev3vY6L7FTjMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=ejSLOOgP; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="ejSLOOgP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1753985960;
	bh=jbA42USdPCiBrLw4UxqEQ+LgTI3lE95B3lQQE1abqrk=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=ejSLOOgPpa/V1HIdqHI9POl/6i/uniHJc3H2WDBr8Bb15lQBYefsLKnicNdNnJ6XB
	 AIxM6kPMy6ANNORLd/oVI5ih7HoUGsK87sowiukxfPLSxsHW0n1O6yXL//iDuZte/B
	 1q64Llh0+KZhtyx8oUBR22Nvr1l1NeSP6T/Oh9meY93O2LTNsTnnXZ6VprP/MFsP71
	 GkiLfX0ujgEwtklNI129eT/sPSMoC0zCZEAi4lVpGkpQov5BdHZPAsZISi6zEhfQ4Z
	 l0KzamNX0fQnICKcBQ8rY8+ZFVF1J0jjMpJ15Oc2lxAxtaYI75otJZ4EnjCbfkDzCl
	 6pgKV7hCMlekw==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 5A6481F9C9
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:19:20 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:19:19 +0300 (MSK)
Received: from [10.198.61.242] (rbta-msk-lt-666375.astralinux.ru [10.198.61.242])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4btHQd3SlcztQTS;
	Thu, 31 Jul 2025 21:18:49 +0300 (MSK)
Message-ID: <2bbac76d-4190-4d56-8a26-c834a80208c3@astralinux.ru>
Date: Thu, 31 Jul 2025 21:18:41 +0300
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH] applying zero offset to null pointer growjobtab()
 src/jobs.c:819:34
Content-Language: ru
From: Aleksander Ushakov <aushakov@astralinux.ru>
To: dash@vger.kernel.org
References: <02afc2e3-b996-4ab1-8b92-c79bcf8d789c@astralinux.ru>
In-Reply-To: <02afc2e3-b996-4ab1-8b92-c79bcf8d789c@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: aushakov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_all_Bitcoin}, {Tracking_uf_ne_domains}, {Tracking_bl_eng_cat}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
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


31/07/25 21:12, Aleksander Ushakov wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> 
> 
> jobs.c:819:34: runtime error: applying zero offset to null pointer
>      #0 0x5adb67991deb in growjobtab /upstream/ubsan/dash/src/jobs.c:819:34
>      #1 0x5adb67991985 in makejob /upstream/ubsan/dash/src/jobs.c:774:9
>      #2 0x5adb679937a8 in vforkexec /upstream/ubsan/dash/src/jobs.c:992:7
>      #3 0x5adb6796edcc in evalcommand /upstream/ubsan/dash/src/eval.c:916:9
>      #4 0x5adb6796c0ac in evaltree /upstream/ubsan/dash/src/eval.c:305:12
>      #5 0x5adb6799818c in cmdloop /upstream/ubsan/dash/src/main.c:246:8
>      #6 0x5adb67997e4b in main /upstream/ubsan/dash/src/main.c:180:3
>      #7 0x7a95463ad249 in __libc_start_call_main csu/../sysdeps/nptl/ 
> libc_start_call_main.h:58:16
>      #8 0x7a95463ad304 in __libc_start_main csu/../csu/libc-start.c:360:3
>      #9 0x5adb6793a930 in _start (/upstream/ubsan/dash/src/dash+0x42930) 
> (BuildId: bf877a87a1c989c4907f14ce16668321dedc5edd)
> 
> SUMMARY: UndefinedBehaviorSanitizer: nullptr-with-offset jobs.c:819:34
> 
> Environment:
> 
> Debian-12, x86-64
> clang-19 compiler
> 
> Steps to reproduce:
> 
> ./autogen.sh
> CC=clang CFLAGS=" -fsanitize=undefined -g " ./configure --disable- 
> fnmatch --disable-lineno --disable-glob
> make
> cd src
> echo "sudo" | ./dash
> 
> You can put any installed utility instead of sudo on your system, except 
> builtin commands.

My patch looks like:

diff --git a/src/jobs.c b/src/jobs.c
index 51e6fa1..cd7bff7 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -815,8 +815,8 @@ growjobtab(void)
         if (offset) {
                 /* Relocate pointers */
                 size_t l = len;
-
-               jq = (struct job *)((char *)jq + l);
+               if (jq)
+                       jq = (struct job *)((char *)jq + l);
                 while (l) {
                         l -= sizeof(*jp);
                         jq--;

It fixes the runtime error, but I'm not sure how it affects the 
translator functionalty.
