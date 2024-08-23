Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559F219258E
	for <dash@vger.kernel.org>; Fri, 23 Aug 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451806; cv=none; b=nRW0LRzXZ0MJqeTqfQDyEvj0Fy3kBYcoqDivk7JEZho887iMueRLbAKBOoMI8Y3JWIHMZ+y0yVRLSybC/kBZS8pJJvOUrXNneiHhaB3UH/f7rjIihnpIW4beVia5FRIe+PndaONCaJaLYfTabXIaoRiHGb35CT2MTZAI+KvkCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451806; c=relaxed/simple;
	bh=33AepVl0nsATCWpOuks5JTNW31l4WXsGNj26WR7XE0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwGAMoV5ye/kiBvR4AIbxTKxtoWRxEhgtk+e2xX+EUV9PqvQ6BiZU9pZGJYwdGLZmJ3d2vyQhU8CY+1SD8Qax/UB7UEupIPBtL/XfH2M55dUEFEehWLCw03JhiuwprO5D4WKIj3RdeFjbzKVIp7J5/Ckbq6NxmReop++fuYUfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcZ8r+7A; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcZ8r+7A"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bd6f2c9d52so12028606d6.3
        for <dash@vger.kernel.org>; Fri, 23 Aug 2024 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724451804; x=1725056604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJdcaDPaa46tc1vY01FM2G8rUoDqETAE85AeTA/YOhk=;
        b=mcZ8r+7AZU/hbB9zEVjkQpUSh59s+4xPSjBOOnyOSJg2GvxL/WBY04NyXvkThoA4jU
         Cng1yvE0TjFRBf6xXvWMj7S3ilH7vYH5JPWjPmztU8Mkg4bApeAnd88IQ7BCJDtWPS44
         ig7eMoA3p9RlMEoYWXom95B+LIAOg4aCU2oPVWPKIDdPqekAvYoE3hGaFv/eTjN5QbSj
         q8k1FjXiiKKSmEbwd79IiYYncNVpbpqAzd38pY9BQ+dENQO0+6Jo2ek++5qh9EFbkckK
         B4nY2KeMhGo+sI2phiRBFzmfySCW8zG1f+/gsDUcPqHbA53HMdsLV8NVYxJi+N2CErmy
         iHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724451804; x=1725056604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJdcaDPaa46tc1vY01FM2G8rUoDqETAE85AeTA/YOhk=;
        b=uuRSpjYZI+XsPaXnXpnK+rEgXIatfZNIw8L7ibkERPI4d4O2Y7/snYIRl9kkrzb1BG
         TxZ+/ApMVhGeYHbB4XqCdpxgNMjvcLCoyKTHunNWDu7vaqySHyxwnV7HSRDYJuQF9xL8
         WHB702IQ6zDBUliyU77Jtyx1MIODqubox/xRpvo+ZZJ4CF85g18MBZyXBHiSmW5hU5T8
         8DyQ0/x+fHJmP7uRARreQ+9F5nNWhx9Ve3PF0eqyLK0H3Z9/S70ZTu84LDTxDsTn9ayy
         1E8YAO30lLzCfj6gm0iipG/k/zw0y7Xz4ofqaKk27qrwPp6QaAASwSKLKgKuTGgJ4LWI
         F32w==
X-Gm-Message-State: AOJu0YzQHdNlxdm5ZGIEvf5ZJ8ij0uGHebaLG2KgSvNWgRoJOSq6rdIa
	pTMCEDOOhsetzXcxkz2y7u44YgEL82+7kiZ0ozQ3OjjOLm67ngHhFooipA==
X-Google-Smtp-Source: AGHT+IE9XaXFcgDMidk1gAhhoaHhXFLC/bu2aIhvw10nupRb+hplgEAGP6Jce7wOEygC+qx3virTBA==
X-Received: by 2002:a05:6214:451b:b0:6c1:6ca4:6c05 with SMTP id 6a1803df08f44-6c16dc24ecdmr41556166d6.6.1724451803953;
        Fri, 23 Aug 2024 15:23:23 -0700 (PDT)
Received: from HQ.hitronhub.home ([2607:fea8:e920:1ca::5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d216fasm22807976d6.22.2024.08.23.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:23:23 -0700 (PDT)
From: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Cc: sebastien peterson boudreau <sebastien.peterson.boudreau@gmail.com>
Subject: [PATCH] histedit: When editing, use `el_set` with `EL_PROMPT_ESC` rather than `EL_PROMPT`.
Date: Fri, 23 Aug 2024 19:23:19 -0300
Message-ID: <20240823222319.6732-1-sebastien.peterson.boudreau@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As can be seen in the `man` page for `el_set`, using `EL_PROMPT_ESC` for
the op is the same as `EL_PROMPT`, but it allows escape characters to be
expanded in the prompt the same way they are when used with `echo` or
`printf(1)`.

As far as I know, this is not specified by POSIX, but neither is the
emacs editing mode (please correct me if I am wrong), so I think this is
a justified change to make it align with the behaviour or `echo` and
`printf(1)`.

Given that this is not specified by POSIX, there isn't much of a
precident for what the value of the start/stop character should be. From
what I have seen, 0o001 is common, so that is what I have included in
the patch, but it may not be the most fitting. Taking a look at how
ASCII defines its control characters, I believe any characters between
0o034 and 0o037 may be a more suitable choice, but this could be up for
debate.

Signed-off-by: Sebastien Peterson-Boudreau
<sebastien.peterson.boudreau@gmail.com>
---
 src/histedit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/histedit.c b/src/histedit.c
index 7692776..5ab718b 100644
--- a/src/histedit.c
+++ b/src/histedit.c
@@ -115,7 +115,7 @@ histedit(void)
 			if (el != NULL) {
 				if (hist)
 					el_set(el, EL_HIST, history, hist);
-				el_set(el, EL_PROMPT, getprompt);
+				el_set(el, EL_PROMPT_ESC, getprompt, '\1');
 			} else {
 bad:
 				out2str("sh: can't initialize editing\n");
-- 
2.46.0

