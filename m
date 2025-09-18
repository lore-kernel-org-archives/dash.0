Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679F155C88
	for <dash@vger.kernel.org>; Thu, 18 Sep 2025 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155754; cv=none; b=rDWV+g8u9RcP/HNZJKN3JWlUla/b6zG1iWc2I3i7A2uxLhxcs9q9gkiYrjcso4ZXXmpe6q8q4QXJ4Q5+7G/CIEFMCE894gSGo3Gn7KuhBKLTRVwUOx3092Yxw9zg158K9szh4Nfr1xG53CH4PqENldlm9qodpssC0fl8zRc2W0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155754; c=relaxed/simple;
	bh=V6a64cLYr6seI6PwU6EWLDhBnS6PQbkX7j3eJxrCcJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIS4XfRa3cfSaon9d/+zrKy5FmL2uznrRFq6mru+dL2NmykaQHlYbdrPlshjhgS25iy/YlqEQ9DL0BKGLgLbcylofBeTz9nK54QdW3DhpN4rPyi6jKiiCeA9Hd/5lNh40Gj5CBnIuXqDpa/TKqM/3tL8QrFD0NP7dOl8JvllF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsmqfjLI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsmqfjLI"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so71166566b.2
        for <dash@vger.kernel.org>; Wed, 17 Sep 2025 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155750; x=1758760550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcPWMUcSJDCshKZ2fCW77gS9SBNWLjk4VYa6AjG/NUE=;
        b=DsmqfjLIlsqLamZ101hi/2KUqfSoicIfIqkXgqjDxI0gpFF+pvJOh+ak45uZxwmOVQ
         w6h4THHRLufDXJ7S/sfDRzOqEf/6z1EWhnrfuQgIsnueW39PnTxwTstYvQIL9cvyAtAF
         GLNFqAr/UrAAYifNIJo7H0q8aAaXhCCglK687LGV2srNkg+sEap6fxLUEtwgV/JoJwqL
         u2VYqCKDJklKcCKWpG4HSNADNxlJMtnq0TI+Xo/FxvfoVCR42/jTIHgMoaT5mzAjuPAR
         vuz6h2KftMmuTax3W2SKobLWBdYwKwjuA8NiRqs2vYo4cazphWpUDHT9rZtmqqzw/BoK
         sxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155750; x=1758760550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcPWMUcSJDCshKZ2fCW77gS9SBNWLjk4VYa6AjG/NUE=;
        b=aA1Vfq3sBzoXnF+Wm7WgSwIeMVy2iOrTN3dzMGtna9t4LueH4s14nqLbgrYguEL5WC
         M11aMDvAmkaZzAaHPHZS0TSCdP1+VXM3FhlI50OsH3HYz4NatEZ3XVvxYGK8cltMqM1W
         cfyBQHD8yVKR+ZpqOqZoh90eEW1ohnlEKy8KTB4TQ8Mp9jIjQEhcHpljBKwJjSXCwIa/
         KYECCmrmgnbwnIMJQjkENI3YRc+J96VF9m3rRE4paQ818IqcIasa3b0eVW+IcjYpE2Lu
         /HFWnfwcmyj9HIgAs8bAE+SpmvqNMRlhmfztj7BS1CFKuA0tfOXioZDkTubWEKJf7PSo
         1nog==
X-Gm-Message-State: AOJu0Yyh3Oh9f7RATRLAnuBeOkzafq17WtRdq+xLmWwJ6vVt0BSWB2hX
	FuiShnSexB2R+781J7EA4jqzsJKY2cUX+wUnViaInVtRDt9LmgpoT7eC2iXfFdSw1Hg=
X-Gm-Gg: ASbGncvgoyCgl9joD8QZzAxg5ZJZ8Ybij4kscBdK+NoixxSJttMz52JDSU4EbqtL9ll
	nbKNBcYKeQj8n9Qbwy7YIB0/W/6Fv3csbe7tmdZ/6VmHKu0vnYPASSULKE4TieAPet4iJ3daB0X
	r8WAlD/i8wmchRXyX5Qlemjq2wMvaEMJPV3MSUuOywlS04QjF6MC937SADGOihAwiytwtCnRKb6
	apfnmvl3eWdFV3HgTIx2imv4rej0Q6HG51aLpz3eqJ2EzUSW4RcKIEducyeSq5fDQhdZ9PEBnpO
	Mo5LEaoLXpB7Li4krg9hnC7T1yR96ZjiSskqN1rmjvFNCcOnBecMpWEycRuXrBOjMB2X0xPPSA9
	Zs0Z25Z1dlN1ZceGB+CZlowGvM/hqkNvz+Xx4HF6k9rlLlN0M+FvFQQCFaD38B4Egx+/bYmIFUR
	uH1aijkwkQVpxS0zezPiyqSg==
X-Google-Smtp-Source: AGHT+IHdEg1IXc0pjpBQzRPdHjCEbp40Sb/J+NxdSUI6p2tkr6ThO3nNExAPlR/RFm1RQvCv3Gar7Q==
X-Received: by 2002:a17:907:94d1:b0:af9:c119:3b4 with SMTP id a640c23a62f3a-b1baf8ed67bmr435221566b.13.1758155750225;
        Wed, 17 Sep 2025 17:35:50 -0700 (PDT)
Received: from Al-T400 ([169.224.9.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44fb5sm73895266b.16.2025.09.17.17.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:35:49 -0700 (PDT)
From: Abdullah <3bd3bdr@gmail.com>
To: dash@vger.kernel.org
Cc: Abdullah <3bd3bdr@gmail.com>
Subject: [PATCH] histedit: fix dash exiting when receiving a signal interactively
Date: Thu, 18 Sep 2025 03:33:58 +0300
Message-ID: <20250918003435.11162-2-3bd3bdr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918003435.11162-1-3bd3bdr@gmail.com>
References: <20250918003435.11162-1-3bd3bdr@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/input.c | 32 ++++++++++++++++++++++++++++----
 src/trap.c  | 16 +++++++++++++++-
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/src/input.c b/src/input.c
index c36d120..f775c9f 100644
--- a/src/input.c
+++ b/src/input.c
@@ -39,6 +39,7 @@
 #include <string.h>
 #include <termios.h>
 #include <unistd.h>
+#include <wchar.h>
 
 /*
  * This file implements the input routines used by the parser.
@@ -276,6 +277,11 @@ preadfd(void)
 	int unget;
 	int pnr;
 	int nr;
+#ifndef SMALL
+	const LineInfoW *liw;
+	wchar_t wbuf[2];
+	const wchar_t *wc;
+#endif
 
 	nr = input_get_lleft(parsefile);
 
@@ -306,9 +312,8 @@ retry:
 			rl_cp = el_gets(el, &el_len);
 			popstackmark(&smark);
 		}
-		if (rl_cp == NULL)
-			nr = 0;
-		else {
+
+		if (rl_cp) {
 			if (nr > el_len)
 				nr = el_len;
 			memcpy(buf, rl_cp, nr);
@@ -317,9 +322,28 @@ retry:
 				rl_cp += nr;
 			} else
 				rl_cp = 0;
+			return nr;
 		}
 
-		return nr;
+		/* Got a signal while reading. */
+		if (el_len < 0 && errno == EINTR && pending_sig) {
+			out2c('\r');
+			liw = el_wline(el);
+			/* Don't lose the current line.
+			 * el_wpush() takes a L'\0' terminated string.
+			 * el_wline() gives us a string with N elements.
+			 * Simple solution: el_wpush() it wchar-by-wchar.
+			 */
+			wbuf[1] = L'\0';
+			wc = liw->buffer;
+			while (wc < liw->lastchar) {
+				wbuf[0] = *wc++;
+				el_wpush(el, wbuf);
+			}
+			dotrap();
+			goto retry;
+		}
+		return 0;
 	}
 #endif
 
diff --git a/src/trap.c b/src/trap.c
index 23829a5..c045257 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -53,6 +53,7 @@
 #include "error.h"
 #include "trap.h"
 #include "mystring.h"
+#include "myhistedit.h"
 
 /*
  * Sigmode records the current value of the signal handlers for the various
@@ -243,7 +244,12 @@ setsignal(int signo)
 		}
 	}
 
-	if (signo == SIGCHLD)
+	if (
+		signo == SIGCHLD
+#if defined(WINCH) && !defined(SMALL)
+		|| signo == WINCH
+#endif
+	)
 		action = S_CATCH;
 
 	t = &sigmode[signo - 1];
@@ -321,6 +327,11 @@ onsig(int signo)
 			return;
 	}
 
+#if defined(SIGWINCH) && !defined(SMALL)
+	if (signo == SIGWINCH && el)
+		el_resize(el);
+#endif
+
 	gotsig[signo - 1] = 1;
 	pending_sig = signo;
 
@@ -397,6 +408,9 @@ setinteractive(int on)
 	setsignal(SIGINT);
 	setsignal(SIGQUIT);
 	setsignal(SIGTERM);
+#if defined(WINCH) && !defined(SMALL)
+	setsignal(WINCH);
+#endif
 }
 
 
-- 
2.51.0

