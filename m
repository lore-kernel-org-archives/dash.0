Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18321158D8B
	for <dash@vger.kernel.org>; Sat, 22 Feb 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211085; cv=none; b=k+sd86J62Y593WxOh0gtRbTyhlv9fn5cxpz0+wDy1O40bMfx55AXA6N6g8PZdyGC3Pj+N5ZVaSVU48JdKFXjPyzCWURShCeDCceG+zap854+1qczyF+BXjshaKIUaaGK80z8U4PDtcr4vqdk7iq0Q1gMUDcgMpx+JmpjZjLMIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211085; c=relaxed/simple;
	bh=Q+wYSWtsKd9QSKnHW9ViTZtxgTE79MNj/lpNLOYNidU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F6KEB3AJPbmBF01JesctrikGRxDl5GoO7+ufXKT5q/vf8WkVrqLG4vI3N2/UxtY5m1TTNHcb81NKRNxdnaJTlSjr1s1DLsJa/PBwioFa6zvDNPMXoci7vqRoxReG7xtfC9VcYa3Pn+K4qEokoTbklVlFEQ6+HCYv+WGOeg2fxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1o/CrWd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1o/CrWd"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab744d5e567so494015866b.1
        for <dash@vger.kernel.org>; Fri, 21 Feb 2025 23:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740211082; x=1740815882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fc/HtnWv0BLofctzh/o0QTrQO2PpFDLC3ZBslXgUPoY=;
        b=M1o/CrWdJOS3dPP2EWez7hq0V2q5jDqGYW9q42AYViJiRCgrahRZbWhWTS6mEgLMsX
         qF0WlGtRKG4NjjO/Yeca1PPloT67knDVZBL+YGgJTBgZvQbZvS6L2dYMdg5pbZe5BmNJ
         IZmYpJdd/CK1BkYtA+xNFA2/FuU9voRK6myKml867Ulwsi3mTqq0WHb1DyFCgns1DpGV
         h25h4ftSCxv8oXhtIV8L44Gug3sJW217K6F1NJSeviGMX83KcqEiyu/VZUBfTRUGGGs+
         AlOv5ZgA2ewULvR2tU7PX80p0NHi6d3TC2QaX8WkHXXaYwnu5P1939oZlCfKhzftLIsl
         jbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740211082; x=1740815882;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc/HtnWv0BLofctzh/o0QTrQO2PpFDLC3ZBslXgUPoY=;
        b=ECf3XgLYPpkbBGa30Dckz76+rEKrsoOEdm5m0o7qIyI8L1YTqLrEbZD9mRKUgxVsWZ
         MYhgJfAfvhqwaOiLACBXUAePG96qh5lIIen/oNpmhZ3km8WwOHhbeAC8J2B6f+Hq663f
         +qxwo4tM2yTSSEpvYqJfrFMrkuNoOQ2V+MoTy2Adr+xnJQjQdvaBg4GKhRcuDa1TSLb6
         fHx6Lv3qLVIdae0gYUZaiTNr5ol2JYJIqQ56lZern/cQd60NHA1qXzWc+0Jt3o42+viS
         IrczrfLNUwNavGWYsG1RJF+CMCQeS1e92a0LOJUCOqfwoaB0a6YBp8UNZ41DzdA1mPRr
         YLJw==
X-Gm-Message-State: AOJu0Yys6lGlduGwQCSAqILJgj0UcW6nwO5DB2R/Xm91ePNtsIGsOqpg
	26QMmzfS4nQtT4Iv24SbcGSVRxE3JNS0lFooXwdhp0dYuEgffPse4eW0xw==
X-Gm-Gg: ASbGnctajfIRJGbWSf3RgQwRwe3kQgGGVYPXXrAsEnDPGDQCvcjuYilEffMnMHg7Ozo
	xG1TehNKPk4BSSPsihMOhfDd6Q/fqwxggpbXNKUV3NZonF4/TVheJpPXf8qYbh8WfWSrMr1dVTQ
	qekFI1aW5vYrmANf4flGQMEAQnbVcieIpEYNBwfgROvIq3CRTmfJUUNymG3m5uMRQchZAKENY50
	NJWO6vljz0O6+MPNEeaEBz2CMXItb6HDtw8NieyabVxoHpAX4ZGb7ALDTluFAs+7B2fvGFCg75W
	WqEyRg9i+CuNjtOmNG/l
X-Google-Smtp-Source: AGHT+IHS7AyCycPr2d1Fp/M0ASrhGKxGXAfepi/ITrNytiXoiHDAc0ycR3dhwREc3wWpdKLLbKhdPQ==
X-Received: by 2002:a17:906:308c:b0:ab3:9aba:ce7d with SMTP id a640c23a62f3a-abc0ae1ab4cmr484597766b.1.1740211082281;
        Fri, 21 Feb 2025 23:58:02 -0800 (PST)
Received: from gmail.com ([2001:871:22f:3f4:3f77:14c1:7664:63b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb82771809sm1329294066b.171.2025.02.21.23.57.59
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 23:58:00 -0800 (PST)
Date: Sat, 22 Feb 2025 08:57:57 +0100
From: Johannes Altmanninger <aclopte@gmail.com>
To: dash@vger.kernel.org
Subject: Regression in quoted remove-longest-prefix expansion
Message-ID: <Z7mDhYBNOMKSJtEJ@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I noticed another regression in c5bf970 (expand: Add multi-byte
support to pmatch, 2024-06-02).

This command now prints "abc-def" but used to print "ef".

	x=abc-def
	y="${x##*d}"
	echo "$y"

