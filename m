Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D16A33E
	for <dash@vger.kernel.org>; Fri, 29 Mar 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711476; cv=none; b=OIJDraboyxRm9DvxnkyX4T9JHdmXj4/XLf73LzX24VH/Khw+2nZjdRoFm/WYGnAWIOZzUXvis4x8HX4LP0DU8vcuHZV8YV/h7pcJh0BMYdUkmBoXUmL1UYtBxtDuqLge3Fx4kcgM2akPp3LH55nwsxq/Cf6yMCycTuMmBbwew5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711476; c=relaxed/simple;
	bh=3JbO0gq+aTWRsw2vGj4LhzLBfntwl7ERTpw3GjtFKXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ90tK1f2F0QQr7b1/FBukMCk37ryVGQpFaF0pf6esLrhkv0P70u8IKhfmZTo4mORBIA1tvnILTrwltPdw2Fmq9ZO4s7HqBxt6t++H8RLGUWJDgtpIKWK0Dk4PDtE2uZ51ZcGOxrrjwsJtoQVBvLVTR7VEm06N1a+t+Zvg0mEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agB0eOk5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agB0eOk5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso2753276a12.2
        for <dash@vger.kernel.org>; Fri, 29 Mar 2024 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711711473; x=1712316273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQFHAgipHR4JbN24NGq3yScSsms/qrLNoTPG81lITg8=;
        b=agB0eOk5rTSfl6zeGJ3eKO9Bj7LzC2Qk8WgdCLe6JF8ChAcTIET8NOJRD3MiF9DBwi
         LOiB7Nv6Q+uWOYR7kY39UVzo/HcpXGuM7SOoFCPG/HuMwrki9Aygl2FzEgoEHrheDuia
         tboGnZECqFkx7fUKOw+5oJF7cZxHPBNKQfEe5v2jA/F3ZipTHMntD++/328Erj+MGK06
         kK0DqwhDVTk7IvYLMFiCzFcTRUghUN8Wly6R70c1tkcShN5TD19deNo6O+NG25sKmQnx
         qAYq3XU1maJIvGcmPpBgRX8PpyKQhEP4p40iz07ekhgcslsm4b3uXudx0uZYBq+141up
         CxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711473; x=1712316273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQFHAgipHR4JbN24NGq3yScSsms/qrLNoTPG81lITg8=;
        b=NOV/w4AoIPq1efnRtgbU6CxCO3J9cxGKesdMbFBdra7k1/JSLBKYS6qgktCEDneAai
         0M1p2ZIXncRkthm/HtELToby5ZE/wmhyXNosKzv/oFxzHipDlHvrqdOlwRuL9G0GTIu5
         DQmyWU30Z3fzs7/RByXbmHevk765P/XsAolBobNbQoUIRedqpY264RoFXy8lNTs1Z22n
         UOnaXy4LQV743GtWA3NPx8nFW0mOM4R40Y31tg8nRE6NPD9QlIy3tElfTBwtpbm6PMsx
         uCG7mBfUjwq+tW36V8JqPfyb70SheqCHyKCGHGOtDc02JQgRm05L/0nNrnltpV/vT0Lp
         Wnuw==
X-Forwarded-Encrypted: i=1; AJvYcCXLFYm00RACXtUsBIZNQgGIgFxG9caXKfgO7ELKvSzKYxTwCj237EfKRDLcHqHZu9W0jz6nROhOI9n/xnr+B7iwJ4yxog==
X-Gm-Message-State: AOJu0Yw6pPndKsMeZFJ/MGvmS6Ib3gcb9DmTyf7D+BtbOeXx3Xki+jmx
	EGplwYC6Rq3B8xQ3/Bg+o7cfwuHuhsQ7evuf1eqH0g6KuD0FuULy0+e6fGtx
X-Google-Smtp-Source: AGHT+IGDz6UivTGisROrkaFb64U7chyx8b5RI8J0zB69AvSC/YvlfzEO3zZNEW4i1afvc4rlYqkXFQ==
X-Received: by 2002:a17:907:7251:b0:a46:7c9c:10d0 with SMTP id ds17-20020a170907725100b00a467c9c10d0mr1626425ejc.23.1711711472670;
        Fri, 29 Mar 2024 04:24:32 -0700 (PDT)
Received: from localhost.localdomain (193-81-214-13.adsl.highway.telekom.at. [193.81.214.13])
        by smtp.gmail.com with ESMTPSA id gw4-20020a170906f14400b00a46d786365esm1831738ejb.94.2024.03.29.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:24:32 -0700 (PDT)
From: Johannes Altmanninger <aclopte@gmail.com>
To: harald@gigawatt.nl
Cc: aclopte@gmail.com,
	dash@vger.kernel.org
Subject: [PATCH v2] Allow trap to un-ignore SIGINT in asynchronous subshells
Date: Fri, 29 Mar 2024 12:24:00 +0100
Message-ID: <20240329112419.1571653-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.44.0.368.gc75fd8d815
In-Reply-To: <b42dbf13-989d-4609-bbcb-8b9eababbe65@gigawatt.nl>
References: <b42dbf13-989d-4609-bbcb-8b9eababbe65@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike in Bash or Zsh, this asynchronous job ignores SIGINT, despite
builtin trap explicitly resetting the SIGINT handler.

	dash -c '( trap - INT; sleep inf ) &'

POSIX[*] Section 2.11 on Signals and Error Handling says about
background execution:

> If job control is disabled (see the description of set -m) when
> the shell executes an asynchronous list, the commands in the list
> shall inherit from the shell a signal action of ignored (SIG_IGN)
> for the SIGINT and SIGQUIT signals.  In all other cases, commands
> executed by the shell shall inherit the same signal actions as those
> inherited by the shell from its parent unless a signal action is
> modified by the trap special built-in (see trap)

It is not clear to me from this description whether the trap builtin is
supposed to un-ignore SIGINT and SIGQUIT in the above asynchronous job.
I think yes because processes like "sh -c 'trap ...'"  can already
do that, so why treat subshells differently.  The Bash maintainer
seems to agree when responding to a related bug report[**]
although that one is not about subshells specifically.

> The issue is that the processes in this list have to ignore SIGINT
> [...] but they have to be allowed to use trap to change the signal
> dispositions (POSIX interp 751)

This issue exists because we "hard-ignore" (meaning ignore
permanently) SIGINT and SIGQUIT in backgrounded subshells; I'm
not sure why.  Git blame is not helpful since this existed since
the initial Git import. I failed to find a test suite; no luck at
http://www.opengroup.org/testing/testsuites/vscpcts2003.htm where I
get SSL errors.

Since I don't see any reason for hard-ignore logic, remove it
altogether.  This means that either of

	trap - INT; trap - QUIT
	set -i

in a backgrounded subshell will now un-ignore SIGINT and SIGQUIT.
I did not find other behavior changes but maybe there is a good reason
for S_HARD_IGN?

[*]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
[**]: https://lists.gnu.org/archive/html/bug-bash/2023-01/msg00050.html

{{{ Test cases:

shell=src/dash

set -e

SubshellWith() {
	parent_pid=$(setsid "$shell" -c "( $1; sleep 99 ) </dev/null >/dev/null 2>&1 & echo \$\$")
	sleep 1
	subshell_pid=$(ps -o pid= -$parent_pid | tail -n 1)
}

trap 'kill -TERM -$parent_pid 2>/dev//null ||:' EXIT # Tear down after a failure.

echo Scenario 0: '"set -i"' maks a subshell un-ignore SIGINT.
SubshellWith 'set -i'
kill -INT $subshell_pid
! ps -p $subshell_pid | grep sleep || exit 1
kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.

echo Scenario 1: resetting SIGINT handler.
SubshellWith 'trap - INT'
kill -INT -$parent_pid # kill the whole process group since that's the my use case
! ps -p $subshell_pid | grep sleep || exit 1
kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.

echo Scenario 2: ignoring SIGINT.
SubshellWith 'trap "" INT'
kill -INT $subshell_pid
ps -p $subshell_pid | grep sleep || exit 1
kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.

}}}

{{{ Backstory/motivation:

The Kakoune[1] editor likes to run noninteractive shell commands that
boil down to

	mkfifo /tmp/fifo
	(
		trap - INT
		make
	) >/tmp/fifo 2>&1 &

On Control-C, the editor sends SIGINT to its process group,
which should terminate the subshell running make[2].

We experimented with sending SIGTERM instead but found issues,
specifically if the editor is invoked (without exec) from a wrapper
script, sending SIGTERM to the whole process group would kill the
wrapper script, which in turn makes it send SIGTERM to the editor,
which then terminates.

[1]: https://kakoune.org/
[2]: https://lists.sr.ht/~mawww/kakoune/%3C20240307135831.1967826-3-aclopte@gmail.com%3E

}}}
---
 src/trap.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/src/trap.c b/src/trap.c
index cd84814..d80fdde 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -55,14 +55,12 @@
 /*
  * Sigmode records the current value of the signal handlers for the various
  * modes.  A value of zero means that the current handler is not known.
- * S_HARD_IGN indicates that the signal was ignored on entry to the shell,
  */
 
 #define S_DFL 1			/* default signal handling (SIG_DFL) */
 #define S_CATCH 2		/* signal is caught */
 #define S_IGN 3			/* signal is ignored (SIG_IGN) */
-#define S_HARD_IGN 4		/* signal is ignored permenantly */
-#define S_RESET 5		/* temporary - to reset a hard ignored sig */
+#define S_RESET 4		/* temporary - to reset an ignored sig */
 
 
 /* trap handler commands */
@@ -233,16 +231,12 @@ setsignal(int signo)
 			return;
 		}
 		if (act.sa_handler == SIG_IGN) {
-			if (mflag && (signo == SIGTSTP ||
-			     signo == SIGTTIN || signo == SIGTTOU)) {
-				tsig = S_IGN;	/* don't hard ignore these */
-			} else
-				tsig = S_HARD_IGN;
+			tsig = S_IGN;
 		} else {
 			tsig = S_RESET;	/* force to be set */
 		}
 	}
-	if (tsig == S_HARD_IGN || tsig == action)
+	if (tsig == action)
 		return;
 	switch (action) {
 	case S_CATCH:
@@ -268,11 +262,11 @@ setsignal(int signo)
 void
 ignoresig(int signo)
 {
-	if (sigmode[signo - 1] != S_IGN && sigmode[signo - 1] != S_HARD_IGN) {
+	if (sigmode[signo - 1] != S_IGN) {
 		signal(signo, SIG_IGN);
 	}
 	if (!vforked)
-		sigmode[signo - 1] = S_HARD_IGN;
+		sigmode[signo - 1] = S_IGN;
 }
 
 
-- 
2.44.0.368.gc75fd8d815

