Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794267316;
	b=zYGcVKzCV11L0a1VRf+MBTzPABbA6p5NPos3yL4kl/f0am+ONnlv00K2TJL9udAi28Lr
	 MaX+CE+yKjuNbELUvayuFmdefUlgdL9/MChI6YVfeQtPEHSEU+teAu+g3qcQw9W49XpqA
	 YlswHWBu+kL9ps/BLe5Mt7KXU5t6e7B87RjH49S693Z1A1gwHT9kl5GJzrVOXu0ibA5x2
	 88VedzAnW92Omokqv2UIul9LKAfr5Gh4HkTOSaAEcHhSKYeUOtMixw+aMn12KILaRpd2e
	 jo4fFJnYwGftQPX3RTCmVTpVV0HrYMQjsmIAg8NHLA7ycYJYTsq17ZygfsGBCur98bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=8vlaFPQqrTDnCgp8Lmz6jsdOTFFG34kyrj5LGXWhOy4=;
	b=IEtB6W7kJ2oXOS9+mMVjTFJsmRFVnQgQAx5RDho0NoI8V+/I/eT93k50IN72tcvWo0BK
	 EoP3hqQufHHmiYz6Cy69ToC5zqhaQxzw8qpF39TeC20jFR1KbJI8sbdFOSt7MfWN3sCRD
	 ZcFfzXLmpWtkYV0KBLRJuxnOJcyaZrGLngdZp32zohrD3wIhgwHZLp9I1zTYi/eMVZyGp
	 fdDEfFXr/NEkVJRN7WIETq+y0PsZ2YrlOJwqQalGuNYLZdTH5840oLWnAMHWcWyjOK80k
	 +YQTVMwTD228HCU/H/JR8T7qU1XY0cZxDKU4yVYnA9UiblXfZ8z2qRM5/240Yc0gwDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8rK+wCX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD28606A321
	for <dash@vger.kernel.org>; Mon,  9 Nov 2026 23:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD28606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n8rK+wCX
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso953382f8f.1
        for <dash@vger.kernel.org>; Mon, 09 Nov 2026 15:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794267315; cv=none;
        d=google.com; s=arc-20260327;
        b=Xko8fk8jWxRjp5bzR7mLV8KhUH9+pT9xo9z9GPjP5JDKC1OpQPTxrb0o735JKaNTJx
         zTBdnAUTTVbDon7Tuyl/+zASwhN9xXPKt6THTDCAOOA3WnPSXadU7KzcnhvrGtWENkrQ
         UOwMG47023iMH3lJef+akP2q0Eufhqpyq3IW44MG/xF70ntmr/5bFkFYRt7oSl+b7kuX
         Wu/YkdnNt46nJZLlp8yrdFUJAsUNAak5SEGeByKUX1Bw+NEiXa7uZXpRZvyk1Sc1EdyW
         bepyPRBlwLhcXkGuq967iWUFcj7q8BcsneLzRzrRPRa8wyl6oQNev3d34LxmRyafR5+r
         V+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8vlaFPQqrTDnCgp8Lmz6jsdOTFFG34kyrj5LGXWhOy4=;
        fh=mZXIuIOCZIyKHhfcN8SoLP2476yFub/ghCNPZn/VsDM=;
        b=NFz2E0y9UE5VPHsXpDCNSaGqFB6EpLCGJp/aH2PiBdb66rmnGvm2wrC05y1XSPtyiS
         MXdyx3br/Fe6lquaaPNYY1vi462VLINL2cNpRswkH9H3EdDdGVKTx6bZQ629O6v9nxTm
         QaWiFuYE4D9m3MEpwthbw9dw6XUo34a0kgUWAKHU3mNv4O+Ml1SlCszzGDEj3emVce3q
         65vjvuqkIVcgdXfgU2FPO2cLcCrVYcRts49u74dtDZM9wz2pO3g6Th48IXrtHOlCam8v
         rSktNNvG6rI0kDCbA6Zw/kR+GV1pq6zeT+QjVIWm5QtIftiM8BPPJxwKHgGwNauYyV3Y
         cwcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267315; x=1794872115; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vlaFPQqrTDnCgp8Lmz6jsdOTFFG34kyrj5LGXWhOy4=;
        b=n8rK+wCXL6YeEw4iAZXnmBoDV3Dpe/YX9vX2kuTD0iavKYWw7eus/8c9JIz+3k8V4b
         FYjOgSGuFu8XPCWNlO6GFLy5fJZvIw8oeC5ZMCBnQJYXBz0ErY95pJ0rcQDBbBFp173r
         LWKztR21oar9EQ+RG4iN0k9WdY0dJCqNncTrdTDl23bwQOVrGAg8xy3jxoPdQYw/6b65
         FDb9OgL1l5na0Y/2EWzyBTXjhtbxG4ckzE7AFTHbWoTqXZjrD/fmS9AjB/uRqEAKk/MY
         Dn6K8xeXsewC/zFoJXl/6Wy8sIJywxuyktf2tQ6WLsIvgS1VfekGyXi4n9N5WIBogitq
         bABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267315; x=1794872115;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8vlaFPQqrTDnCgp8Lmz6jsdOTFFG34kyrj5LGXWhOy4=;
        b=aZYMgvf3wUZ1dSTiuIQxVnpsMBU8Zu1n31Me9/yZdsx/g8eKKjZMus+aGVfy5/CqAL
         N/l58dwyPYKwCMp3KfpTuj8oJJdrzRNCOcbj32kEiEu3gT2u7JtNsIyqMjO1g4AKpJ2L
         mT3ck+knum0XhoNPVwMjS2SjkMNihaH/vH/BS1Ri/XU9300wKzAhSy7rvNWFTk4lfcIJ
         This2jGfqyF5Kko/hOvMdQmv9BdRjAC2UmXzGzXj968LGHWzmjQJlWZqAYb7zNdphukv
         VTUiuGnipAhevNoXS6gjdFh0c/eFDCB0SktFDBUBt5hjf8yAH1bI7YXNUKvHr4N8/Z+o
         jPvA==
X-Gm-Message-State: APuU4Z+zmQvj9rlzPS1Oc6z9qJLa1WEMQXxI+N2BzkomW0zL/1EpTXms
	2YkEALj4/kV5nokd9VN5QxFJrd0ARbN4WbckPsjRz+s/kMEhazuq/zGbOUEfek5i0v8erZXOwSu
	kIiw3+pVUf4sFaWNCBZZP6f91PKOPjtlNd3IeiKqmbw==
X-Gm-Gg: AYBFou1JN9wTaXZfYbEednIz3cmZDYr+K1WuL4BBrdLN1dk7kghwNL9Y8cgI45p3ZJr
	tg63RsqPQZckQDqmMwTWmP3u7jN3CW7RlLRdAM4J4+Vwc396laZJG6/XXSc3MxnQvKn10ejGrl9
	z04GMZTdcC91yevInN2y3b06gXLHobi2ddE6rG0VzKE9dnChAfEI9G7blzzqLM/7LfasUSwdObJ
	psO+8P0DBoEt2N++cS/Wru1BtBwldEND/CckV/1svjTfUyeWn6ibovpekO0kke9bnX04royTvV4
	Zf2eDHwTk9Jr/wqbm9gLVWqXi6mBGt8fLbyLCySEZWyCoq+DxuDnSuqMZgUEF0EhCz7Rkdk02OY
	iSoDZfT8BCvManPmHj6LJ+aVTcMVjAhfFMyVJHssIAiybwuhUMceCxEu/bPXAzIr5+TaQ9nYBb1
	xiVS3Lh+afc0b0I1Rx9i97jkJ3/jRatvLuRKEwFeUEA40idA==
X-Received: by 2002:a05:6000:4b10:b0:48e:678d:396e with SMTP id
 ffacd0b85a97d-4982e362a4emr1603117f8f.9.1794267314440; Mon, 09 Nov 2026
 15:35:14 -0800 (PST)
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: vvkj <lueqit@gmail.com>
Date: Tue, 10 Nov 2026 07:34:31 +0800
X-Gm-Features: AclHuK-Q7bo8W7bTHDPttRCUQuzPNa7fEgYImUyzP7_36U_uLy9vpTNKkMSYz7Q
Message-ID: <CALwy4xJPUYmHJkBvwAr02zp9HfMp0h2upeRxc4NnyXT5ELn4CA@mail.gmail.com>
Subject: [BUG] dash: command substitution leaks 0x81 (CTLESC) across 128-byte boundaries
To: dash@vger.kernel.org
Cc: herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"

Command substitution in dash corrupts multi-byte UTF-8 strings by
injecting an uncleaned 0x81 (CTLESC) byte across 128-byte boundaries.

Tested on dash 0.5.13.4-1 (Arch Linux x86_64, LANG=en_US.UTF-8).

Reproducer:

tmp=$(mktemp)
printf '%126s\346\233\264' '' | tr ' ' 'A' > "$tmp"

echo 'raw:'
xxd -g 1 -s 120 "$tmp"

echo 'dash command substitution:'
h=$(cat "$tmp")
printf '%s' "$h" | xxd -g 1 -s 120

rm -f "$tmp"

Output:

raw:
00000078: 41 41 41 41 41 41 e6 9b b4                       AAAAAA...
dash command substitution:
00000078: 41 41 41 41 41 41 e6 81 9b b4                    AAAAAA....

At the 128-byte boundary, an extraneous 0x81 (CTLESC) byte is injected
into the character stream (0xe6 0x9b b4 -> 0xe6 0x81 0x9b b4). This
reproduces deterministically at offsets matching (128 * N); pure 7-bit
ASCII is unaffected.

Thanks,
vvkj
