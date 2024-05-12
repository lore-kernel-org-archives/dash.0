Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC853381DA
	for <dash@vger.kernel.org>; Sun, 12 May 2024 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715549425; cv=none; b=hMFM0/NrNX2k2iSi/7aGYyZsPOuvDyhrWZcfqTgnIN9o4oER1lzf+hzLTfXwzmqat86729YE1wxCJzAyik+fWixggz62qX35BZGGGZ+aPzyXIY0jxbHn/hhdvf/mmtll2HOk4+jLCfKTLdkTAbUZGIWWSU4zW/OEeorgYiKRJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715549425; c=relaxed/simple;
	bh=JBiLTX4dpZSnvlL3ytdtnT+DfY1mRvl92DaYg99xTWk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KLDBdr1KUAh+UU/eM4YrIHVOUdBgcqrYJhUzgaAoLtfKCCwPIx3PuthbCDfNawwX0C5f/DSoHkmvjsFizakUDyFlsWo0RvmoLsJNcioDSTOnUAg1b8CT1DLYJYweTozzjEWbWLbI2hdifJdPfg3gz5fjHfQhfWgrAsDDoQ1UFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=kKCkXrMa; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="kKCkXrMa"
Received: from [IPV6:2a00:23c6:5398:5e01:4d2f:40c7:a7ea:a4e6] ([IPv6:2a00:23c6:5398:5e01:4d2f:40c7:a7ea:a4e6])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 44CL2pNS040000
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sun, 12 May 2024 23:02:51 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1715547771; bh=JBiLTX4dpZSnvlL3ytdtnT+DfY1mRvl92DaYg99xTWk=;
	h=From:From;
	b=kKCkXrMan1n0nzyBzL1U8H4KJnfPvYhxbbu2m669x0zlvn46pyZWbUBZZDnXnQrZN
	 ImfyBqhgjH9w1TpgJKhJLGjb8ssPSPg7sesCElVbDjLPp03A95y/aDJWFd9/YT4x4T
	 uVEjm3OdEyU6UcDiwhZ0SNyGN1QWTXlXabkPM6k4=
Message-ID: <38a635d8-c129-4bcf-a274-af36d928263b@inlv.org>
Date: Sun, 12 May 2024 22:02:51 +0100
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
Subject: [PATCH] Fix non-Linux build
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As of 509f5b0d, the build fails on Darwin/macOS, which does not have 
memfd_create(2). The build fails on redir.c because the fallback for 
memfd_create, which is defined in system.h, is not included. Presumably it is 
the same on other systems without memfd_create.

diff --git a/src/redir.c b/src/redir.c
index 2505d49..8a77a92 100644
--- a/src/redir.c
+++ b/src/redir.c
@@ -57,6 +57,7 @@
  #include "memalloc.h"
  #include "error.h"
  #include "trap.h"
+#include "system.h"


  #define EMPTY -2		/* marks an unused slot in redirtab */

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
