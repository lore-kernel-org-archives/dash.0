Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC205D517
	for <dash@vger.kernel.org>; Sat, 18 May 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716021769; cv=none; b=lXnk+tUak7XubUUMhqlKO4w7wC+DgnHX2cZoU3ou0aN5aOPp2G/ztImeJmr/jvcMfPuh2K4R0C+i0FlzdIrQLjSrTb8DFe4SW1pB/W2RX7JwN5Gb6MkcLMRGtKBaFCsWPFyKyhI9nf+u0dWD4z72YTW3ryAap8xRxanznb/BC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716021769; c=relaxed/simple;
	bh=35jnBfIpj5XoWbhYSEP7qZ6DPMCZaK4PeBIk2iU5554=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dl/ke5bh7XjtBhoikV4kDaGUO0pwh3EsGSC77XCl6VpSPL2sVGkpeP/mNUmApX/FrJ4/pJv5lPGcMCCuthVnRHtD+4WsL1smO9Y2VlskPaeIROG67xTrs2LMJpsNpJxRe+p5SZpbpzBE5AmryPgKBo8mcs1l5QZCiPmlxu8sfws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK2TowPN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK2TowPN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572f6ee87c1so5341999a12.2
        for <dash@vger.kernel.org>; Sat, 18 May 2024 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716021766; x=1716626566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bezEymaf1MNB02ZOSclSpWwGGBwx20v1Y8ewzRUcuF4=;
        b=AK2TowPNf3a9ipUCfeYEPFkdukGy94asG4s1xb8gUxY66usY3NZGzarrOvm4WFkARj
         k1/F505gZkJ00Psl1hOztoJK1medehgpR7mQG9MLMaD6dVM0CP6QsGf2gAVShi8k/bQ9
         cOTtQ2xADjmN6MiS/n0MpyX7T5J3li2piJvGXRRLMEJPXPfH9GUALWyBs9glY4oTWfH2
         AMab895R4EqvaE8KLbPB0hkc3xETX4DDNFZV375q8tl62Z4p5bZUqB17JdwrwtA5wqCj
         cQMeMPEpyI9wydbp87bZ1xfzeOCkDe96qa4x6OnSRbm49/MDe3/ryuf3JzEKYYf/LyqS
         96Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716021766; x=1716626566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bezEymaf1MNB02ZOSclSpWwGGBwx20v1Y8ewzRUcuF4=;
        b=gLzK0MbHQApqV5rQFQ2zrOf/8TwefU0mYF+Fj+5ZRcj1V0EvSf1u+G3JZKEqvbAH7X
         w7SfYWbB2VOoQkra3CYJIJ0ivPOO6lqGl0uozWbeYwXzkdLj43EjlCcwBjSwZgpcNeTq
         ddjbspTsjDStv7vLmM8myfxtlIIUy74WKk6TNK/wVkUVHujRdHbSeHNUDO276n1nJj5R
         2+sLSnMVwX2g34j2LEGQxNwJ52h7u7bHrL2HsOBsvRE7POHtkRWNKFv76nhoilMWeQBz
         izBLgjM94FO7wacAC1Bp/Fg/digbNm+Jsp5vKYk75YIfy0Wo8V4CRpJV4km/jyYf50o2
         6MWA==
X-Forwarded-Encrypted: i=1; AJvYcCUh/gZFuGuqEcokabEMA4RjmqbqTAzx6E71BvP9JpDXhaArV6KyylmP8UE826HVb78sbaSWxDUe8I7L1KmxpjnNmmeXjQ==
X-Gm-Message-State: AOJu0YwiJRDJi79nb775dCxyru5tOrAP8VjVZJIEjW5y+s5duU53Kocq
	SEH739Tc4EvJ+OyeT5uciBjGJhJp4iyfoHFNmZmf2rGqthye6o/3
X-Google-Smtp-Source: AGHT+IHMrVgWbEEIdglKewn/tUzUaIU2bHn82sk6M01U3eF4Fau0ld1QZ0f5O43L3Ba2HKJhSdI99Q==
X-Received: by 2002:a17:906:3ad2:b0:a58:ca9d:7b6b with SMTP id a640c23a62f3a-a5a2d6653e9mr1502237266b.60.1716021766131;
        Sat, 18 May 2024 01:42:46 -0700 (PDT)
Received: from localhost.localdomain (178-189-141-61.adsl.highway.telekom.at. [178.189.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d92sm1215843466b.98.2024.05.18.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 01:42:45 -0700 (PDT)
From: Johannes Altmanninger <aclopte@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jilles Tjoelker <jilles@stack.nl>,
	harald@gigawatt.nl,
	dash@vger.kernel.org,
	Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH v4] Allow trap to un-ignore SIGINT/SIGQUIT in async subshells
Date: Sat, 18 May 2024 10:38:30 +0200
Message-ID: <20240518084105.111682-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.45.1.190.g19fe900cfc
In-Reply-To: <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>
References: <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike in Bash or Zsh, this asynchronous job ignores SIGINT, despite
builtin trap explicitly resetting the SIGINT handler.

	dash -c '( trap - INT; sleep inf ) & read _'

POSIX Section 2.11 on [Signals] and Error Handling says about
background execution:

> If job control is disabled (see the description of set -m) when
> the shell executes an asynchronous list, the commands in the list
> shall inherit from the shell a signal action of ignored (SIG_IGN)
> for the SIGINT and SIGQUIT signals.

Builtin [trap] has this requirement:

> Signals that were ignored on entry to a non-interactive shell
> cannot be trapped or reset, although no error need be reported when
> attempting to do so.

Apparently this only applies to signals that were inherited as ignored,
not to the special case of SIGINT/SIGQUIT begin ignored in asynchronous
subshells.

Make it so. This means that either of

	trap - INT; trap - QUIT
	set -i

in a backgrounded subshell will now un-ignore SIGINT and SIGQUIT.

[Signals]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
[trap]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap

{{{ Test cases:

shell=src/dash

set -e

SubshellWith() {
	parent_pid=$(setsid "$shell" -c "( $1; sleep 99 ) </dev/null >/dev/null 2>&1 & echo \$\$")
	sleep 1
	subshell_pid=$(ps -o pid= -$parent_pid | tail -n 1)
}

trap 'kill -TERM -$parent_pid 2>/dev//null ||:' EXIT # Tear down after a failure.

echo Scenario 0: '"set -i"' makes a subshell un-ignore SIGINT.
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
 src/trap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/trap.c b/src/trap.c
index f871656..90e9607 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -296,11 +296,11 @@ setsignal(int signo)
 void
 ignoresig(int signo)
 {
-	if (sigmode[signo - 1] != S_IGN && sigmode[signo - 1] != S_HARD_IGN) {
-		signal(signo, SIG_IGN);
-	}
+	if (sigmode[signo - 1] == S_IGN || sigmode[signo - 1] == S_HARD_IGN)
+        	return;
+	signal(signo, SIG_IGN);
 	if (!vforked)
-		sigmode[signo - 1] = S_HARD_IGN;
+		sigmode[signo - 1] = S_IGN;
 }
 
 
-- 
2.45.1.190.g19fe900cfc

