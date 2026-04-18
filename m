Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC41C84BC
	for <dash@vger.kernel.org>; Sat, 18 Apr 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538535; cv=none; b=gXu8kpQxo/WGbWsHMJtw9Hpew412v8kO2w3YA6RB5bHHSKlZ4SbSXgVnYF++8j97BUYdUe7dJ+eF0q/81eiJY83yXK6IsCw8EEK/+OCgUvQGNcox61GosZLZIoaFDZ6SpTjkp1JDjujKqzzVbCPhiLZA/SmrKYR4kb+6O8nifaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538535; c=relaxed/simple;
	bh=sMbfjW1JK+qTxQPr/aecKykvooE9zri9DpMtTRgNNv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTiB8zktAIjT9pv/MkY8/B3ytEq/dxB7xMaz0sM1LEHjuSzpOPGDGETmElBKvKmi8AOKuyD2gRWxRODPPlhkrtI/hj7vsbmTTtAk3YWCaxYobN2D/YhQKV8kQNS2Pw2lDLgXEWQHTL3tNHj51PoCcL4MANTK1wau2j0ArqSSuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOzj0Wfw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOzj0Wfw"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8aca2726f61so22306686d6.0
        for <dash@vger.kernel.org>; Sat, 18 Apr 2026 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776538533; x=1777143333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFAQstP8u0MY/uWwn2GEYt8CN/vK8FolulRfxBWdnIg=;
        b=UOzj0Wfw9IOYaV2bTaiMd40LjH3iV23Ar0cB9fbcMcgkukYwaHPhpCjOfqSv5NGy62
         koCp6W1nQxu1xlVb820psSrYxbu3eeL4v2u/Ey1rveJo0iVNAFe7ArgDr/EhybKQtjJu
         Czms2PTG18uwWRY5g4G9D/AaB6yC/hkHFokVmk/XZCbjixomx57Ez+5/YyE94k3VuloW
         SprUn2m8DbrErdivKQrHdCvDvUamov/fdEiJkcHXaNy2tBcuPIzCgOQ5gCz47SNk8Dyc
         BF32N9J1M3MmGPCHjiLv2duLS6/rN+WzmPGC7LNMBmpHilwftuhjBMni8zYLX/qifBrh
         3bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538533; x=1777143333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFAQstP8u0MY/uWwn2GEYt8CN/vK8FolulRfxBWdnIg=;
        b=CmQfhY7J/365qRvCKt9PULHPyc4xGGTwsv3iuuIUEpXWUthOfvy6zsZesGyi1JpTL8
         8W6aa0jcOT+RQs6oBsFHff/EcprBIsWDoAkI6J72dHas+yinDvul6zbMz50ZApIg48sP
         1RG4n8ECrMz/0yu+OO5UlwYRVkXKlTBHgv/PnTD1BkDzn/Ux0CRfFrsJql6PyDwEm76N
         DUeEDjokt+0LAD+jtv6DkeiFOejXLZ03F1AqnV13VU/x76qjshAh0mYkM1XIMRXAOHSm
         BZefX9Qxu296RmR5oV67ia48cDUrrrrKFvZP4CFYPu2fV6erp+fh+K/TBJtqpKAvZH0X
         Hhaw==
X-Gm-Message-State: AOJu0YwivIFHZPviAnbUBgoj6Dnhoty4ZfLugTn4eeB1Qijn82CyInOE
	e3V/+z9DpUwvjOHLAbfkgiP1JAyXhPdPrT3nSeZScYu1wuL4vHgh7y0TWtxElA==
X-Gm-Gg: AeBDietqa+Eots9THZ3MKs0F/wTG55U39FJ2H0nwj4VtZT0FM/wmlgtBGwv4v3cOqjs
	JsHX+vFeNUSZBROfXb0Q1wC6PIVcIfWhgD8u30hqm4EnQr+BMVXQsSwnFPFOZy1oOMJwpi4VG4p
	y19BppdPaquIv02LdqwWPTYJvUIfjRi0976Q3SH15k3S8SGVeZrrjMc/utTh8rOODurEAx0EBrG
	RiwBk8v6trDuKOGig1t41J6XjHLPmc0rsnaqNNfrNP7mRY357ieHl4jL2HI8SHvWGGoCJst37pM
	v38LL3hp52AzuEriLTlkPDROkvGePuHjKAWjaNffMipBZSDEVlboHMg1mimeD+ZxpCjb8Khpp8W
	wm0r5Mihiv9h0pCdmevk+uC6yxz0finnA+8DZyyP9wUtrVIQO7TrvhXmqJgQaHECF9eLQ3jp0O0
	vNbdW7YBQzqqxxlMRRFTUYDNEzNTdgkpLYKaXjfG5SPkorL0BC5gH2+mfIHv8y73HOQCdV4sIqr
	zYXAkllZE1ITlFMluC/CF/lU81FUUra+HdSrlGruEr3f6WxoS08oQ==
X-Received: by 2002:a05:6214:8093:b0:8ac:ab31:0 with SMTP id 6a1803df08f44-8b0281254femr116046536d6.40.1776538533358;
        Sat, 18 Apr 2026 11:55:33 -0700 (PDT)
Received: from HQ.hitronhub.home ([2607:fea8:ea1f:9fea::7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm37785466d6.48.2026.04.18.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:55:33 -0700 (PDT)
From: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Cc: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
Subject: [PATCH] Use proper grave accent character
Date: Sat, 18 Apr 2026 15:55:16 -0300
Message-ID: <20260418185528.29367-1-sebastien.peterson.boudreau@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/dash.1 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index dbc34c9..f651a03 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -293,12 +293,12 @@ Enclosing characters within double quotes preserves the literal
 meaning of all characters except dollarsign
 .Pq $ ,
 backquote
-.Pq ` ,
+.Pq \(ga ,
 and backslash
 .Pq \e .
 The backslash inside double quotes is historically weird, and serves to
 quote only the following characters:
-.Dl $  `  \*q  \e  \*[Lt]newline\*[Gt] .
+.Dl $  \(ga  \*q  \e  \*[Lt]newline\*[Gt] .
 Otherwise it remains literal.
 .Ss Reserved Words
 Reserved words are words that have special meaning to the
@@ -983,7 +983,7 @@ or
 version
 .Pc :
 .Pp
-.Dl `command`
+.Dl \(gacommand\(ga
 .Pp
 The shell expands the command substitution by executing command in a
 subshell environment and replacing the command substitution with the
-- 
2.53.0

