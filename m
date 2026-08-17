Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211334D3B9
	for <dash@vger.kernel.org>; Mon, 17 Aug 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998013; cv=none; b=dgZZrzgvFAl3Nt4ZxdAItAyRH6conHTpBC2VCgFjCq4T9pj7aqLcZdvMaCJ3aj7R0ToIgSCuu53cXHPI62lYR+qGbCEslvbnDPDiPotsikK+XVbr1xVMXRG/ONeCBr3u/7wLn0ItF47y/Oc/72PQo7kQ8SLm3KDUNYL0dsGd+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998013; c=relaxed/simple;
	bh=iycWg66iOw+M9MGidGjd7dU4m8DeA0lC/f3egyVHbL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kVsCJ6eH1ixdYsOG8vY9RNapHVybMW+MYC1bghJELR99of+6eYU16kagiaSZtZNGf5X7OHwgjbQhu0gb+0PRij4zOnt4OCfL7kiMEt9lbghKeQdPRjLpvNI00ZEdoGb5ygEducxpPhe2vzOD/HZenYSiCEQu0361aE3VyLuVfMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muEXp2Ab; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muEXp2Ab"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b28d7fdac4so584582b6e.3
        for <dash@vger.kernel.org>; Mon, 17 Aug 2026 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786998011; x=1787602811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGEP2aJR1PEQh/yFC7L3SH5B0tweDJo6PB8JkrRH0bs=;
        b=muEXp2AbaRZmVV/Kp29RZ7/lQE7/lzxsp0v/cnhXOLdRU1TFGGKjFKZtyDp7JkEPcD
         V2YFvrZmgZCYGCgwg9NiT96X3ewB1JA2gUD/hKVWGLR0Z4Jr/YlSM8MazjjDVTfb7ZIa
         vRFyG5JW+tCnNoJ++GcelSDe1YG+e45XOmHgVreL1tDANtjtxsz69K5Ktrt7q714IsVG
         K8toOF5EcGMG8ctsaTmekFOJiG/lYa44yAskhlUL6jmvU+HP8+4zUHBSzshscTEl8WDK
         YvEgxyGmMHO84lwwUmDhSiZLmwRqDpHYK2h+jDSrS45uaVr8gp0CF5SGlhoy7Cscy12q
         dRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786998011; x=1787602811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yGEP2aJR1PEQh/yFC7L3SH5B0tweDJo6PB8JkrRH0bs=;
        b=dH5PQ75Kqg+ViRRa6RaaWjjDYZARK19BrFQXG2oaHbNKcOPVLjEZatazH5zHKCU4VN
         jsMGGbSNvPeTpAClMqBJEItW6Wd3Y86Z7qSzO+0HbKpBNBkzzSQzJ0AfNsdjiIKoU/v7
         mcnB4nwe9QJZHJUSGkCNfeSiUR/2Rwb9mlbPd3D7EUHHhVoFMCbltZd1+B5HkpNGQEpK
         jEgT7QxDbUJJ1KbBvtcVZGCwitZR8pghv4AXCbnBoHEOBdI6StjlANBNsbrxIUvXwRYj
         tq0LDIfVtSLpoSNoMXToKPdBjswICnwpnURBMECQSoMqKmVZHQaIuB25avUJvHIDRyRg
         u+Gg==
X-Gm-Message-State: AOJu0YxYEBBf08P4y+fVY05KzJus1LMnG+eIKpQKfAwEwbJgFlPpx3CA
	+F3tFarmkYtZEyHngNjB8PGW6muvHtach3dwYamC85SoKOQnu9L/HXs0coZEig==
X-Gm-Gg: AR+sD11yZ40lwkkN1ZghEnMu5lnVIvRxRuNea0ZyI4fZUdsx63QSX65qJuxnh25QbwX
	KtCka75x3lxLnZ0RzFQWWj6XQgrNCjqVDuL04QRD/5INx8p/dN2ZCJPcmVPMifxZ8EcRqxadOmo
	J3YdKg1091mgoAjrvPWe4WJ/n4W/Tr3Pry430bCiaQwxr72rBcEaY0qAAqAfwEGDmXUaSetfUM0
	jCf5BBTV+ll7XFdzJ6ZpsOkLeUjUcVAFR19eGKCOTJ8Y3MTNKyqsAEqprpff2OxJ50r54K04LgK
	H3+Y7/kCm2P90/EhmyS8G3zQzim+pxCzNZalMyLX6lW7ioANtxg/9vYP3VVgBmBr2k4JCwXoO6F
	JdAONtWp21ZFxwFdyCTk4GFDv/DMRFLA6yg3Kn3LnBiirte9GaUXVnE80vcnqxw1H4vuX/3ls30
	ftn8gy73OIi2GLz9UsaJl+vu2f/Eqay+5feqcq01NZsPNVI3ryw/SDtzrkTpeEainEf+OXJ/40/
	Ca3gJ2LN56B/5Ir3vLeR7I8X5bgQBvN7XQ2g9ilpZOFk866EelIiDDChm5+2StpTLOpbiCS5Aa5
	4dfZaQ==
X-Received: by 2002:a05:6808:3502:b0:4a4:adaf:5570 with SMTP id 5614622812f47-4b2412a4b5fmr25619087b6e.4.1786998010622;
        Mon, 17 Aug 2026 13:20:10 -0700 (PDT)
Received: from localhost.localdomain ([144.92.135.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b290ac75a8sm1869573b6e.7.2026.08.17.13.20.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 13:20:10 -0700 (PDT)
From: Ayesha Shafique <ayeshashafique123@gmail.com>
To: dash@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	Ayesha Shafique <ayeshashafique123@gmail.com>
Subject: [PATCH] expand: Fix out-of-bounds syntax table access
Date: Mon, 17 Aug 2026 15:20:07 -0500
Message-ID: <20260817202007.93924-1-ayeshashafique123@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbtodest passes a signed byte to chtodest. Bytes with the high bit set
can therefore be negative. The syntax tables are based at SYNBASE so
that signed character values can be used as indices. However, the
is_type path did not apply this offset, causing chtodest and mbtodest
to read before the array:

  $ printf 'v=\377\nw=$v\n' | src/dash
  AddressSanitizer: global-buffer-overflow in chtodest

Apply SYNBASE to is_type, as is already done by the is_special macro.

Fixes: c0c860df08c9 ("expand: Count multi-byte characters for VSLENGTH")
Signed-off-by: Ayesha Shafique <ayeshashafique123@gmail.com>
---

Hi,

I found this while working on a research project, testing against
commit 037bbdf ("Release 0.5.13.5"). Here is the relevant GDB and
AddressSanitizer trace:

  $ printf 'v=\xff\nw=$v\n' > /tmp/s.sh
  $ gdb -q --args ./dash /tmp/s.sh
  Reading symbols from ./dash...
  (gdb) b expand.c:895
  Breakpoint 1 at 0x8c028: file expand.c, line 895.
  (gdb) run
  Starting program: /home/aysha/dash/src/dash /tmp/s.sh

  Breakpoint 1, chtodest (c=-1,
      syntax=0x55555562d680 <is_type> "",
      out=0x5555556bea42 <stackbase+98> "\377") at expand.c:895
  895     {
  (gdb) info args
  c = -1
  syntax = 0x55555562d680 <is_type> ""
  out = 0x5555556bea42 <stackbase+98> "\377"
  (gdb) n
  896             if (syntax[c] == CCTL)
  (gdb) p c
  $1 = -1
  (gdb) n
  =================================================================
  ERROR: AddressSanitizer: global-buffer-overflow on address
  0x55555562d67f
  READ of size 1 at 0x55555562d67f thread T0
      #0 in chtodest /home/aysha/dash/src/expand.c:896
      #1 in mbtodest /home/aysha/dash/src/expand.c:918
      #2 in memtodest /home/aysha/dash/src/expand.c:996
      #3 in strtodest /home/aysha/dash/src/expand.c:1017
      #4 in varvalue /home/aysha/dash/src/expand.c:1140
      #5 in evalvar /home/aysha/dash/src/expand.c:811
      #6 in argstr /home/aysha/dash/src/expand.c:391
      #7 in expandarg /home/aysha/dash/src/expand.c:232
  0x55555562d67f is located 1 bytes before global variable 'is_type'
  defined in 'syntax.c:285:12' (0x55555562d680) of size 257
  SUMMARY: AddressSanitizer: global-buffer-overflow
  /home/aysha/dash/src/expand.c:896 in chtodest

This is my first patch to dash, so apologies for any mistakes I might
have made. I'm happy to fix anything you point out.

Thanks!
Ayesha

 src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/expand.c b/src/expand.c
index 76e67ce..7ebb841 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -980,7 +980,7 @@ static size_t memtodest(const char *p, size_t len, int flags)
 		p += count;
 
 		syntax = flags & (QUOTES_ESC | EXP_MBCHAR) ?
-			 BASESYNTAX : is_type;
+			 BASESYNTAX : is_type + SYNBASE;
 	} else
 		syntax = SQSYNTAX;
 
-- 
2.55.0
