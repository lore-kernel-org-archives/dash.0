Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F31AE877
	for <dash@vger.kernel.org>; Sun, 12 Apr 2026 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776038244; cv=none; b=JCIwTm38LaFOECccZzOIkVsxZ0isWREGxSkJaoxi8mm0pYDVxq4w9cS2T5/RX4rvZJgxb2Vw6eVny/brdV0CDwXgbEnm8sb46O3E8mmkPT09h9wyGcScV8UJKM756hPNGQ7LkskYWLuMx0gBdKK/7dK+EXI5mLFzOLVy9fskp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776038244; c=relaxed/simple;
	bh=KQLTzegI9zvVWe19FVyWXy30PI2bO20EbHxu5Gs9Ow0=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rEg4ubHyP1rOtHbiTqPQdhi1IRfR9knpCZvgbS+XuYVpQVPM/y1ekSvzPk6j130yQt1fRoMi8FU4mVpm7GhFaiJcYSM/rTRF1GmO4sClanjnI8Hqs4JfeQUjidEZ/uDo3dwGuFUqM3ks849spcLmBGvvvjy+SUH26EP03k0Icjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e//IBEBp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e//IBEBp"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488afb0427eso48214385e9.1
        for <dash@vger.kernel.org>; Sun, 12 Apr 2026 16:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776038241; x=1776643041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQLTzegI9zvVWe19FVyWXy30PI2bO20EbHxu5Gs9Ow0=;
        b=e//IBEBpEH3Nkr+igGObYJdxt8Y2kE0bif+/ZMOAgSkb5EhfBgdH5ihU9vijPxsh5k
         0DwJetwxpROldFeLXS78zhfKSCVZZhoRNLCLJ4HyMnLeLK34lTYtNdD8SZk9E0ZZTo5B
         vOb1+h5dkJQAGZ/ErwAxBC4hQHuKPMGQA/QpPEHofuR9RCEAlP84Fvqm/FBJOOKRKR6x
         DJei3HLYotfirDuBOtqWq15CpaGYkYh5SlFNRqh6+IhoTQvyXYFLVn7mwp2O42+B2zKE
         nr/Ip1zLPRpU/PI2ZbQLJEXqQ68Jb8sKP+DcaKit9ZlEGJcPqAWiSu/IYGLYKrh/Ywj/
         lUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776038241; x=1776643041;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQLTzegI9zvVWe19FVyWXy30PI2bO20EbHxu5Gs9Ow0=;
        b=nwLqjjIxKQ3iOLrUvc2a0zzJ/RzMdHHuNAfU3s1mWqC9RnrjkY5ouFBHni0VjsXvpi
         fdZwxpg5GmCm43va33hgPjVo3yMCoPc+MY/7uTnkpEs11F3nF2DtGB/fFKtnhXe0ClAw
         ZVneqDvY++ZXVmyxgG/uaGh+FyzIHU0k5JyiM7GLUxskgLudas4u99sbb5TGAfqo51Xf
         gr3+t9fwpH4Gb1BOO3J33L2rRtFwl9b0J8abILakrP4jzrXOys2hfJgMOjZMK6GIWryi
         Gel/UWKZkFWUWi883Qc5uMA5cOeQ/GibHxHIjW70rud/5giehJfbv0zwW1RL9XPqquaw
         /47w==
X-Gm-Message-State: AOJu0YzZfdoB09Egdnjr3qJ+fTlSb10Ov3nb7WVevcnxsM5F5o3wot1T
	SBpeDrrGaL1BTWLGQB/DbvoyVj1RWwxPeFeYf+RRg5GhNhy/xATErn8x
X-Gm-Gg: AeBDievUlrZhoQb0rXzlIpaha5Nl1WhX4Pzzm5S3pbPU1BZHAn4Bb3rFGvtspc28PuL
	E7mk5ixmYxN1Br2QX6bqKxy2kgMXQBmYD02waqLR1Nm7y/rQV10/rNkngJHgZ+TTFuNxzWDM8be
	4Oo50zTFU15gDskJjiBomsXkoAuG56i6gThBW70z5lGhKKQ3ljxFg0X6Rioq5U2q7SotSWX2kvR
	IT0ST60AGUIrmHvRk7SSqgvek1mwLPVMptTPwhdUqFpdwsimbLNUvgtkur24X9r1IDdP7B4i09/
	QrU9OsrLKVm3qe9fjlxD81PZ76Ot1rLDZxZ+3hBKKfXFOUKZkJ0ZS9nEXTMO5SGbFLTI48O1lF1
	n3rIrRQIQtYPyjPgCZ4bCMUI6lE9oWcBsHjSVy30gDPp+d9mM0g+kdmn21Y78qadZBD8CJ2VJnM
	zJGsqx4hjuEoY/eEAjC+S4a54qhzxMPNu3+AkgKImu
X-Received: by 2002:a05:600c:3ba1:b0:488:90ac:8f71 with SMTP id 5b1f17b1804b1-488d67c704amr160598215e9.5.1776038241108;
        Sun, 12 Apr 2026 16:57:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58a414bsm253424815e9.4.2026.04.12.16.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 16:57:20 -0700 (PDT)
Date: Mon, 13 Apr 2026 00:57:21 +0100
From: Josh Law <joshlaw48@gmail.com>
To: samuelmarks@gmail.com
CC: dash@vger.kernel.org
Subject: Re: WASM + dash (again!)
In-Reply-To: <CAMfPbcbH6C6vd8Cp-sWfpZL5ih_q=2pTMcDbZ9PidQFjzc+3hg@mail.gmail.com>
Message-ID: <77A35247-965B-4CE7-A501-F6095D4925C1@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hello Samuel!
This looks really good!
Keep it up!

V/R

Josh Law
