Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17F54BF1
	for <dash@vger.kernel.org>; Fri,  8 Mar 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896191; cv=none; b=bAqJ9SklLOVki1L0HgGLAB4LLU/di0qDCa/aXht7/sU4/i4FJMYuu2OxH58e9qL2lKigB1p0vzUM+yTbpEBRvBsadcU+yQa60+/SVqI72b+7fEq32tcOzaYGzMKPQdQeMbOnlkK6AuBN3TrnAjYnFosGVCURLmjwOGfo1HWwCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896191; c=relaxed/simple;
	bh=gocDj/7myIT3J++mmwgHVXRJlLzzXxTbIi0lEXzZq3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrKD1dNlqV96vwimROc5XzUyOIed5OJ8yEk189Tl3LSbPZEZJIKF6U3fFsY65k9/qmoIVt0y2+WuJMENwMVjvTK+uK/Jm9kwNy9T11uJMIddwMBZEJprJMoHItGkZy++Eb67WswEh4LTJjxGjwyIGiH0aXeOYVRJE0HT9jnNFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK/WbxJE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK/WbxJE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so2486138a12.1
        for <dash@vger.kernel.org>; Fri, 08 Mar 2024 03:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709896187; x=1710500987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOvPIOztKiqw5kQE5Y6CIwt6Zzf+PM7rP8IpJpDN+FQ=;
        b=GK/WbxJEmWAc1ccBKjqYa8OwJForKx/4Ju+zmnNsggzWNzRyD7yUaON5ljADpfB9aX
         marOVM3jldxGaSj+qnzms+Vu4cpsonFCs5deIBYq2NlBQobnjANKYK0UrwUQ9e3h7J+y
         9Y8lfInps8oAOyviLVlxe6z+U926lqpvdE4lT1N63+bk7KfVAesp4oIlIJC4qvwoa6l2
         c0mBOLhPaWKs7c/ZDKgkwjTZVtq2QRBTEdx1O4sVyoCj/a0YQkka0/w3AWQjcsoAFYDU
         V7xUraY1iu4zz+Zw4QvO2uLSOlEErzMuB64P/rfvXOxS2VDEBUCeVdp+PDQdK9CL+vys
         V2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896187; x=1710500987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOvPIOztKiqw5kQE5Y6CIwt6Zzf+PM7rP8IpJpDN+FQ=;
        b=H7qkzyYNsvCqn8r6Y2R5GCYIbl2QFoWJ4cFW9hNo3oNOuK6yshRbfDWtcbaf0VWt2a
         zFf9mzTZm3X6uzFTy7joF+Xt1Rhs03B6utiexPhbj4mU1iBt1+3HuDrWgPQ6ICtgjmmt
         WiysJrf+qOroxz7DeHqlxyslLpw8a7E8XDUtfjMgLf1W9kQPGhXmPh5LB80b83SD3qZa
         AnrfbhWCNAQCQNKUOu9xK680rufaI2ieat5xvtj2dNIxGvLcuawEBRGqkRqLxYuTO9G2
         nfRTELmETl9DJkL1iAbAB78Llv9JhaRdpdVvkmGZNCmLvKVtgOqMnZRTjYfad8N1Bnht
         qrYw==
X-Gm-Message-State: AOJu0YzNnQwIPDSj3L8/xKqwcqlomdfGL8KrY8E0oFBRctK0o20ZYimX
	HyHgtTQygs/2R3GDT96l6aSZzfIn4GDdB+tjP0VGtVCKkD1O5fualemJrme7
X-Google-Smtp-Source: AGHT+IFk4q5u7oBAcl/kLFlG06w8oQlS2W6brsUlS5ZQo8vgbZU1kG8M3eMTcyCP7537mIz37pxN2w==
X-Received: by 2002:a17:906:fccc:b0:a45:ad61:c612 with SMTP id qx12-20020a170906fccc00b00a45ad61c612mr6176370ejb.43.1709896187325;
        Fri, 08 Mar 2024 03:09:47 -0800 (PST)
Received: from localhost.localdomain (193-81-211-167.adsl.highway.telekom.at. [193.81.211.167])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090660c800b00a45a09e7e23sm4059674ejk.136.2024.03.08.03.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:09:47 -0800 (PST)
From: Johannes Altmanninger <aclopte@gmail.com>
To: dash@vger.kernel.org
Cc: Johannes Altmanninger <aclopte@gmail.com>
Subject: [RFC PATCH] Allow trap to override permanently-ignored signals in background shells
Date: Fri,  8 Mar 2024 12:01:55 +0100
Message-ID: <20240308110158.2459219-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.44.0.rc1.17.g3e0d3cd5c7
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: I think this job should exit on Control-C.

	( trap - INT; sleep inf ) &

With shell=bash or shell=zsh this works with below script.
Meanwhile, shell=dash fails

	shell=dash
	set -e
	n=123
	pkill -f "sleep.$n" ||:
	pid=$(setsid "$shell" -c "( trap - INT; sleep $n ) </dev/null >/dev/null 2>&1 & echo \$\$")
	sleep 1
	kill -INT -$pid
	ps aux | grep "[s]leep.$n"

POSIX[*] Section 2.11 on Signals and Error Handling says about
background execution:

> If job control is disabled (see the description of set -m) when
> the shell executes an asynchronous list, the commands in the list
> shall inherit from the shell a signal action of ignored (SIG_IGN)
> for the SIGINT and SIGQUIT signals.

and continues:

> In all other cases, commands executed by the shell shall inherit the
> same signal actions as those inherited by the shell from its parent
> unless a signal action is modified by the trap special built-in
> (see trap)

It is not clear to me whether the trap builtin is supposed to override
the ignore. Intuitively, I'd say yes, and the Bash maintainer seems
to agree responding to a related bug report about Bash functions[**]

> The issue is that the processes in this list have to ignore SIGINT
> [...] but they have to be allowed to use trap to change the signal
> dispositions (POSIX interp 751)

Attached patch works for me though it's barely thought-through or
tested. Happy to take it to completion.

[*]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
[**]: https://lists.gnu.org/archive/html/bug-bash/2023-01/msg00050.html

{{{

Backstory:

The Kakoune[1] editor likes to run shell commands that boil down to

	mkfifo /tmp/fifo
	(
		sleep inf # in practice "make"
	) >/tmp/fifo 2>&1 &

On Control-C, the editor traditionally sends SIGINT to the process
group. Bash documentation says[2]:

> When job control is not in effect, asynchronous commands ignore
> SIGINT and SIGQUIT in addition to these inherited handlers.

This means that the "sleep inf" process ignores SIGINT.
We have worked around this fact by sending SIGTERM instead[3].

If the forked process sets a SIGINT handler of any form, for example
by using "signal(SIGINT, SIG_DFL)", it will no longer ignore SIGINT.

It seems reasonable to give (sub)shells the same powers, via the
"trap" builtin. This would allow me to change the above subshell to

	(
		trap - INT
		sleep inf
	) >/tmp/fifo 2>&1 &

to have it be terminated by SIGINT.

In general, I wonder if SIGINT is only for actual shells, and SIGTERM
is the signal to use in our situation.

[1]: https://kakoune.org/
[2]: https://www.gnu.org/software/bash/manual/html_node/Signals.html
[3]: https://lists.sr.ht/~mawww/kakoune/%3C20240307135831.1967826-3-aclopte@gmail.com%3E

}}}
---
 src/trap.c | 12 +++++++++---
 src/trap.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/trap.c b/src/trap.c
index cd84814..a6778e8 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -159,7 +159,7 @@ trapcmd(int argc, char **argv)
 		}
 		trap[signo] = action;
 		if (signo != 0)
-			setsignal(signo);
+			setsignal_maybe_user(signo, 1);
 		INTON;
 		ap++;
 	}
@@ -175,6 +175,12 @@ trapcmd(int argc, char **argv)
 
 void
 setsignal(int signo)
+{
+    setsignal_maybe_user(signo, 0);
+}
+
+void
+setsignal_maybe_user(int signo, int user)
 {
 	int action;
 	int lvforked;
@@ -234,7 +240,7 @@ setsignal(int signo)
 		}
 		if (act.sa_handler == SIG_IGN) {
 			if (mflag && (signo == SIGTSTP ||
-			     signo == SIGTTIN || signo == SIGTTOU)) {
+			              signo == SIGTTIN || signo == SIGTTOU)) {
 				tsig = S_IGN;	/* don't hard ignore these */
 			} else
 				tsig = S_HARD_IGN;
@@ -242,7 +248,7 @@ setsignal(int signo)
 			tsig = S_RESET;	/* force to be set */
 		}
 	}
-	if (tsig == S_HARD_IGN || tsig == action)
+	if ((!user && tsig == S_HARD_IGN) || tsig == action)
 		return;
 	switch (action) {
 	case S_CATCH:
diff --git a/src/trap.h b/src/trap.h
index beaf660..595992c 100644
--- a/src/trap.h
+++ b/src/trap.h
@@ -43,6 +43,7 @@ extern volatile sig_atomic_t gotsigchld;
 
 int trapcmd(int, char **);
 void setsignal(int);
+void setsignal_maybe_user(int, int);
 void ignoresig(int);
 void onsig(int);
 void dotrap(void);
-- 
2.44.0.rc1.17.g3e0d3cd5c7

