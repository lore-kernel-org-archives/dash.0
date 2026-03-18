Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6734A77F
	for <dash@vger.kernel.org>; Wed, 18 Mar 2026 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773832336; cv=pass; b=qx/wy/E3gap9/oQtXabpe8rKKcrGjQGPMRe3tHWyyAmYg5u+i4dPPjUZ74mHkX+3+SeDawTdoo3xtJoxUGoqxwAz7rPheTNNZ/nYk+LqIUxND0kylhl0qU9OlFHTo5zUqFP73h0AIzcoUReiRze4+WEJ4Fs/ZfAwwrSdw3EajV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773832336; c=relaxed/simple;
	bh=B5wseKJyFfB7JkQA+jgY9n21upshSwnLfQW4sw0CDvc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sUNbXUkWACye+TxGyfn1F5aZAhJNcGpU2HhrU0i2QY+6RMtdvqZbflKKPeFt1tBYmGxBewuDolXIljVLL7/8yU2CzyNlFxAfd2EKRe0sNTfUtClkLQI77tnDVYlJx6/aHffB6UCGsRdZ19UsdHu3sloJft3cqwWgQpFnzcntrag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqiVtasa; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqiVtasa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b06c43e6a7so5750745ad.2
        for <dash@vger.kernel.org>; Wed, 18 Mar 2026 04:12:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773832334; cv=none;
        d=google.com; s=arc-20240605;
        b=UGCnJnX/rAA71DNf9VgQNHPkKEGcKCJVyQAcLTk4J4DGbevKwindvAa3NmuMP1T5NT
         ZLhfVztoQX6++GWJo381+mnZjWKGB5ND67ODLUFYkliiI5v9rjj372KNrhvYVB3r9kt/
         Yg5U/F9exI3mMD4JLkPSimbGpf0psTWwm8s2b30YGAeSQ+H55W/usdR+ri67WCdOKPsm
         LC62yv1GMw/0W7oa0/l0MUFRhyk31sBu0dpSC2v80Di4JXgcZxkmAbfTtKXjWVWsT9qX
         RfrVkV12xMzBRHbbw9lx/v7v3Od8+FgHlVqFqCHjaFINrov/G9ksZcipQj4lENU3OwP1
         4I7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vIDC0MTsVuGDM11BdQ7s0Kk7HHPHUDSBTSQLzXN7hpw=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=kaoLVxWMNSS0eYnOANx2ikQjrzS/4DgWqynw23esx+T//4VwUgtRdoa8c5fDM7+rS4
         5qqFF67hhKl6wgkiFRYTOaZGMKDIiokXK5GfjIXFY6frShKk/B1mtf/qDM5ZX1HzEWJ2
         Cv3H4aY4ZfKwLFpiOukYUTbiWcJ0FfrrcwEO9cAiKo0V2/qXlUT5TtHc5jRFowH/nq50
         JDxK3n3Ph96wmqGmlqQTVluCauf5+m1/etqWrHJsdQJNAjpl9z5CgL3MImM0kc8FvymA
         U5+OypyrSfazJmE8+eVFTacBpsfv810bF65y4Jf371XuEltNHaEyB+lvn71A9rzFq5M0
         t+wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773832334; x=1774437134; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vIDC0MTsVuGDM11BdQ7s0Kk7HHPHUDSBTSQLzXN7hpw=;
        b=UqiVtasaNxBXDr6XLpJMOQzEnHk5atOARZGDES8zOmz1x36DvfrdvagDxie27oySHn
         L0xRaSwKGaxkZPk5XIcR6WAtNgDDQSGYfWkXInb9RJpmJjukTb2Q8gTAi08whyyASRQM
         Gc5CMNcUvG2Oh5f2d5VX3uyoyP7ui5Un1UPnYL7wDiSVYqGamXdAI279RVpKcDApisFl
         Fd9M+ifJCw03SVK3hcwrVoRn6lFHtEkRzkf0R+4aAttZ9/pRgB8VOIaq/IhY2RUlPxqS
         xPLWhbBcNFGnwlNB8UFYbmkZgSw+AVIQ29t+m3syWlF10pbfZ5TPCCoBRbM6JI15k6rB
         6q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773832334; x=1774437134;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIDC0MTsVuGDM11BdQ7s0Kk7HHPHUDSBTSQLzXN7hpw=;
        b=ss7zBXGDUH1hODLIFR7Z0oak5YVnp8eF3NCDYNsip0jwPrqn6CEosJZKDBIxqQd8uK
         qbcq+PEbWBXYT3ULGEblX6S9TD51IZ4Vuq9Y0iqdfnHPxmbFssh4IoCsLKqM+naa+Bm6
         LoaKEjpn3EiB/5GFLxvt7EsJfX9NzBz4TuSN4L6zUTWKYKumGUBuh3Rl81dXbDfIKEES
         Uhi78kVMiiq4pJj/Gal0BQ4cLtdDGPS2h/FbKu5Ebu6el2zHgAFz29lMHrfsWXXsg51z
         rnmcmXf9dCywECo1acmAFCFTwH26XsdRaE2oac77BZ7MZEN0nSeBhX0SZ+WV6nGCfvnb
         X4Yg==
X-Gm-Message-State: AOJu0Yz7ammoyv16ttyzdBiVwgbk02ir+oKu7miEczxabIOcVTzDB9OP
	Ivz/QQZ5X0tIzfWq878LNL+WsMs2ZmTOPR7gbVGiXXsd/79gSjLAJV8sxpaMpBiJQYIG4+XfBng
	uCrFj9o3j4ifwU6U0yS96TC3U1iaa1ip7dDEstT4=
X-Gm-Gg: ATEYQzw68miO0zgGLIcjaeqzDwdn43wogRHyFwr8BY4lGGBazoV4InPZsAe92GTAzIn
	Eujh0Eq7KN2azXwn9RPgqe1VBZ85k8nKUmZbdMv79DOlsBacEIlmTFR8zN6bIbu9WsdtkglD0FC
	wkFVaLhRYvhP44AKSM9S1XdThzS1mCEKPFv1a3XsFN86dvqKo41V6S+iytpODzujrksLppRVnhJ
	UuiNWf+JEAHtUvYkAM2e7625Q1+Bnqt36KgvpxZrNu0+/BCWavJv08pn4E9nNI68lSMxrBK4SXK
	Q/dS3Tyee8kI+X8oRcC37A2U3xUMWIabHXXWzEI=
X-Received: by 2002:a17:902:db05:b0:2b0:5472:ac84 with SMTP id
 d9443c01a7336-2b06e3fe699mr32662465ad.35.1773832333828; Wed, 18 Mar 2026
 04:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ilia Kashintsev <ilia.kashintsev@gmail.com>
Date: Wed, 18 Mar 2026 14:12:02 +0300
X-Gm-Features: AaiRm51AhugvqIyQ6JUijqrua_eMu-BHNRnpqcsRS8dH6PQVqsHtm51I4WLkdrU
Message-ID: <CAF6ebR5pJm63sQ41rvD4jP511BrnY9A84+F4c-cNt=-ejaaonA@mail.gmail.com>
Subject: [BUG] stack-overflow in src/parser.c
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello maintainers!

There is a stack-overflow caused by a huge number of opening parentheses.

Sanitizer output:

# AddressSanitizer:DEADLYSIGNAL
=================================================================
==1393234==ERROR: AddressSanitizer: stack-overflow on address
0x7fff8ea6fff8 (pc 0x5c982afe24b1 bp 0x7fff8ea70060 sp 0x7fff8ea6ffe0
T0)
    #0 0x5c982afe24b1 in __pgetc /orig_to_send/dash/src/input.c:227:14
    #1 0x5c982afe201e in pgetc /orig_to_send/dash/src/input.c:248:9
    #2 0x5c982aff80cc in pgetc_eatbnl /orig_to_send/dash/src/parser.c:854:14
    #3 0x5c982aff8b39 in xxreadtoken /orig_to_send/dash/src/parser.c:810:7
    #4 0x5c982aff82b5 in readtoken /orig_to_send/dash/src/parser.c:711:6
    #5 0x5c982aff30cc in list /orig_to_send/dash/src/parser.c:181:9
    #6 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #7 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #8 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #9 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #10 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #11 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #12 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #13 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #14 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #15 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #16 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #17 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #18 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #19 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #20 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #21 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #22 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #23 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #24 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #25 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #26 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #27 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #28 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #29 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #30 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #31 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #32 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #33 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #34 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #35 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #36 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #37 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #38 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #39 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #40 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #41 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #42 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #43 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #44 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #45 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #46 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #47 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #48 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #49 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #50 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #51 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #52 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #53 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #54 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #55 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #56 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #57 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #58 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #59 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #60 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #61 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #62 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #63 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #64 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #65 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #66 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #67 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #68 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #69 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #70 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #71 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #72 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #73 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #74 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #75 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #76 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #77 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #78 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #79 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #80 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #81 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #82 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #83 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #84 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #85 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #86 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #87 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #88 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #89 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #90 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #91 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #92 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #93 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #94 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #95 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #96 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #97 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #98 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #99 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #100 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #101 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #102 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #103 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #104 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #105 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #106 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #107 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #108 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #109 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #110 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #111 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #112 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #113 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #114 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #115 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #116 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #117 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #118 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #119 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #120 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #121 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #122 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #123 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #124 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #125 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #126 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #127 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #128 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #129 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #130 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #131 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #132 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #133 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #134 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #135 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #136 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #137 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #138 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #139 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #140 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #141 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #142 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #143 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #144 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #145 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #146 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #147 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #148 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #149 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #150 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #151 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #152 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #153 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #154 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #155 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #156 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #157 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #158 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #159 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #160 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #161 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #162 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #163 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #164 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #165 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #166 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #167 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #168 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #169 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #170 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #171 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #172 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #173 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #174 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #175 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #176 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #177 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #178 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #179 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #180 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #181 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #182 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #183 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #184 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #185 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #186 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #187 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #188 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #189 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #190 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #191 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #192 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #193 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #194 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #195 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #196 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #197 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #198 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #199 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #200 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #201 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #202 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #203 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #204 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #205 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #206 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #207 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #208 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #209 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #210 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #211 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #212 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #213 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #214 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #215 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #216 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #217 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #218 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #219 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #220 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #221 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #222 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #223 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #224 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #225 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #226 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #227 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #228 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #229 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #230 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #231 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #232 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #233 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #234 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #235 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #236 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #237 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #238 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #239 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #240 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #241 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #242 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18
    #243 0x5c982aff8e9c in pipeline /orig_to_send/dash/src/parser.c:289:7
    #244 0x5c982aff881c in andor /orig_to_send/dash/src/parser.c:253:7
    #245 0x5c982aff31c8 in list /orig_to_send/dash/src/parser.c:202:8
    #246 0x5c982affa44d in command /orig_to_send/dash/src/parser.c:475:18

SUMMARY: AddressSanitizer: stack-overflow
/orig_to_send/dash/src/input.c:227:14 in __pgetc
==1393234==ABORTING

The stacktrace itself is not always consistent, f.e. sometimes the
crash occurs upon entering command() on line 321 or inside of
xxreadtoken() on line 810.

Steps to reproduce:

export CC=clang
export CFLAGS=" -g -fsanitize=address "
./autogen.sh
./configure
make
#80000 might be excessive, even 10000 is enough for ulimit -s 8192
printf '%0.s(' {1..80000} > brackets.txt
./src/dash -i brackets.txt
