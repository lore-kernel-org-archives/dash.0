Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F76A001
	for <dash@vger.kernel.org>; Sun, 22 Feb 2026 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771758565; cv=pass; b=BzTiAhvhbuOe0E2zuSgbkm21eUGA62aLqP9WR4/ymcIZW7MePU52puNeOp8wrmhG3AYs8gxMgS82qkkqzWUPsrEoT0GULP4bVeir/NCQAepuwht3Ife43vAArDdSMNry8Bwaru8u3FsrgwlKoU0fUk0pQVCG8LZYn0bT8cJldx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771758565; c=relaxed/simple;
	bh=S+eDHUrCS9N2TtfbbUUNzwYRIp1/KZFARS0mC5YZQuY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iCVZBDh1QRl8K75TlcTebkkZ8MQSksO294IZNkqHUEqOzvqDRUSFArLUF5HoD1OhvIbyTtqSxXS9iGMiL5+5D1skh2VEyE24M+9VD6/M/zd8+CLHWx8S6qW7i1FdxgdbI6kMVdN6G3k3rfXP6iVBptrg3TdOtkQzpwl/tadVDGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=upsun.com; spf=pass smtp.mailfrom=platform.sh; dkim=pass (2048-bit key) header.d=upsun.com header.i=@upsun.com header.b=wY/l6E++; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=upsun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=platform.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=upsun.com header.i=@upsun.com header.b="wY/l6E++"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8f8d80faebso633115566b.1
        for <dash@vger.kernel.org>; Sun, 22 Feb 2026 03:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771758562; cv=none;
        d=google.com; s=arc-20240605;
        b=jUAkkOCtWFS/VavAzPP+gHOvV86daSUVK3kxD9VThAPGIw480RAWP7yvpNYCpNEo+/
         eSgrfQgHWT/yhi7mCYHdZiRG6eJVxZ8adUawitvCAWGVeWScnXNj2tUcw0ahbyq0gIP7
         inPclerN5hR8LpYq6SzF43UpYWZwxnVZ7C5zKe9J4nTyzmnY0eF6JJA3nxfzJlhI0TmX
         eIXq4KZ5VHhg9y+Hy2FCWp+iOB2fAhB8X6TldZqOSpj5IzPEgb+UyrHZIDH2CgikkEtT
         KdOBGut4wCNXg6gt8nww0y9VaVh727sp+SwQXbaQXRT4kcD0fBPUEDCoCxtHzwO7VYg9
         s01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QWk9IB7XrslP+G+RYKu/Wca4+JXPLOJsRHHzgA4ywww=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=UpjjDB9gAe9IT8c9gfwkmOzmioWoK8lYFLRLpf5RNyl9T+zXM+2KbQ7xvuAAOqqrWe
         KkKI1R0pINtl9hU0H/u8UgVklGf5IS58RYtz8gnmxal+tXiuqoGHBrAbWoa6TIU7TALs
         pnAaaDk7k7Or5A63ev8CJW1XH4a0nWFfjpwMtV+wK/G40P/s3JWMNe6ztqLbjwukrLWG
         1EhHlj1q/BBo8fWq+S2e/W60dOwkEKaqVVQuT/BLdvYlfj148ahC+MpbIBOLHpxMYcGG
         3MDM4LgajaD12fOQTBnbXkomKxQ3DVENE6pTDTxIjGIRzHrjJToj9egjLcvucjJX3hee
         Gk5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=upsun.com; s=google; t=1771758562; x=1772363362; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QWk9IB7XrslP+G+RYKu/Wca4+JXPLOJsRHHzgA4ywww=;
        b=wY/l6E++dSl7MQCM5IbF9vx7BHoJcMK2r2MCF3tS4OqCkqpIDe2AdMm9F92Irsu+CG
         0JaVFR/mpeGK/OZ5rpSS0c0k/287xxFQNVYC/FBDqtrTvrgyNtTXQQXiP1MBBn8nJumk
         V5wYXOEtYfKN/w9KH5pLqbkDtNgbPHtCHgQEAhWWSjF/lOxyH7IYYg596CuyaXZyfPaB
         Uq9MYo2GwVnnYnnvBiuuJWK8gGhuPeMYnaeiJ87/K4ZTKOrRzk5dbLRvbGIMW//eqctH
         N7ar+E4eJ3VmgmZ2D6zE1Jjl/VWcX6hGWltJCnTF93Fhku96BhEpaWYzAAB45GOr4KjK
         z8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771758562; x=1772363362;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWk9IB7XrslP+G+RYKu/Wca4+JXPLOJsRHHzgA4ywww=;
        b=M/wAxpDBJ5R12bSNGmSOkIc5p/kMUjKwQlhU0QnJZC3QL7YF7W8DIprasLJKsFmxUF
         k1Q8LPnad+PNj2+Ymi14xJ1c4Nlr5KNqADcfqG90H8ewkmcpmz1I/7NjZYDieDUGi4i7
         XG1a9nndybf4W0y7bdlkhTgRTdK9gdbhPHZ6Myb/HHEuNP+KAIBenu15jpo6nLDd+/NH
         J6GZ6hUEhsckcKrm3QIJ9DoMVoc53Js/p3F6Jdby93ZDbDttTCZiZK+NxqiZ0Ztyotgj
         QIF4RytwH8d+Ex8B07K7kd7hpUOURloOwm2EnGBqJQ+O3//TJmzy84ooUiJNYLGFX3CO
         O/xg==
X-Gm-Message-State: AOJu0Yy4MjZPL4WUI9sogsuf60EElHLjgyB9Al0ppbJTH5/RWJqOQMe0
	9+Q/Illj90WeOnshO3JRzV7woIUzoBQT1Y5zA0f9mj7ZoSKqu05PEbiEYVAfAnr+5cJ01OgHdpa
	zdKKbxE7eV4LsHRUbahiXAGV1AwgFMeeJh39de0tDXNfAWHXlm44=
X-Gm-Gg: AZuq6aLeR42LCccdeiO3C77/UR5IoZjDTjl8euUGo/GmGWFJcW/OqmynyRGC6UuQCY3
	oJNghTMkBRHQBb41q2wXumIF5OjirnYQBQ0hyAaS/Uc3qThpgqHbI7kU6cUtu9cxqTPIxX5CKGW
	4ztnamwWgtaYKDsVjzY3bj66HlZ6kPRG6BmhRdX8nWY5WMYYGlVccJ/Sf8EzfMJ/pk3g+1xDbNc
	S4ejnMj5m9eSYBGOtqCeZOMARu5al7ZggUvM5mozu8Ki2gLQO5psRCeJWsemv+ZDLVRyQtBJ/Zz
	feiv1zdqycgro+IRmTM4m9b6wDt7M+vf/F5WWLQq/IXX5cneQA==
X-Received: by 2002:a17:907:844:b0:b8d:bcea:44e with SMTP id
 a640c23a62f3a-b90543ad1eamr749548466b.15.1771758562177; Sun, 22 Feb 2026
 03:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Snider <daniel.snider@upsun.com>
Date: Sun, 22 Feb 2026 05:09:10 -0600
X-Gm-Features: AaiRm523Yh8N69N9_GhBFDEopkRi8ffLr22w_NfdJ5297l3Pr7ZfrKRysK8u8NY
Message-ID: <CAB_UPCCnoM-7oU=u51jCDGarLPTM5TzYWVSfhqWHaQP0BFpotQ@mail.gmail.com>
Subject: [PATCH] input: Fix heap buffer overflow in preadbuffer for non-SMALL builds
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 0242b3e94da8de5043d5b2a8fba2f380347f6eaf Mon Sep 17 00:00:00 2001
From: Daniel Snider <daniel.snider@platform.sh>
Date: Fri, 20 Feb 2026 20:37:21 -0600
Subject: [PATCH] input: Fix heap buffer overflow in preadbuffer for non-SMALL
 builds

Commit a065467 ("input: Move newline loop into preadbuffer") removed a
guard that prevented looping back to preadfd when no more characters
remain in the buffer.  In non-SMALL builds (with libedit), this causes
preadbuffer to call preadfd again without resynchronising the buffer
pointer, overwriting heap memory past the allocated IBUFSIZ input buffer.

Any single-line shell input longer than IBUFSIZ (~8 KB) triggers a heap
buffer overflow that corrupts glibc malloc metadata, resulting in
SIGABRT or SIGSEGV.

Reproducer (requires --with-libedit build):

  { printf 'export X='; head -c 16000 /dev/zero | tr '\0' A; echo; } > /tmp/t.sh
  dash -c '. /tmp/t.sh'

Restore the guard so that "goto again" only fires when no characters
have been consumed from the current buffer (q == parsefile->nextc),
matching the pre-a065467 behaviour.

Signed-off-by: Daniel Snider <daniel.snider@platform.sh>
---
 src/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/input.c b/src/input.c
index c36d120..c0f5a9f 100644
--- a/src/input.c
+++ b/src/input.c
@@ -429,7 +429,7 @@ again:

 check:
         if (more <= 0) {
-            if (!IS_DEFINED_SMALL)
+            if (!IS_DEFINED_SMALL && q == parsefile->nextc)
                 goto again;
             break;
         }
--
2.53.0
