Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369217550
	for <dash@vger.kernel.org>; Fri, 29 Mar 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726757; cv=none; b=eFAZOI4DwAvE5GV3wSeq453Iyk0orMo+GcH4aFhrCol1dBp3b4PRyX7cksrGx610sxNAhb/o/i7/eo16HaONCFfscasdjX21foIKYlY2OYI524St40M8oeQ4JaovFHTXpVKOskK43axiGo5M/DBwrCdT7DvtUBdkWK09GF+ucQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726757; c=relaxed/simple;
	bh=uUQ+0dtGRtc5kCkiRzZoz5tI75M5V3A2X4LlCMsTw/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIIESUv3p0NMCtVI1V1/xzblUGeI/VIATGZKvMmJjhS/RgALfZN67pywbYkyx2RwfSAmlUnMFS9PTCG4i7EAPF6t+f2SNgWwwLKA7Avkhmc5KQnPmEKf4PlPxgQZzYybEV0oI6gDC0KzcHg+gs2iaDt0glhQuRzAxaz3AXCJ+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt4A52iG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt4A52iG"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56d5d4d2e2bso535980a12.3
        for <dash@vger.kernel.org>; Fri, 29 Mar 2024 08:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711726753; x=1712331553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSM/H6C02KO1CMredI4hecRoPVCmnOG+kWeF/Me1IVA=;
        b=Pt4A52iG1q5oB/gtga8ew1N6E7KgKqn90/eFOOxWN9XCdmpB7p1jGuGxYQJgcJfOEW
         2h4RE8G1PkfBdepWzlArBtRYUZYY7HkAYYmYzMDfeV96dYJ6qrYFujGm49ZKCWMS4y2q
         lbFQZVKz+zZoD7iPXXukpHAVSZGRx4CToIFuQJyUnDx1Uor7QsL5pVuNXAWL3fA1bZj6
         6Mb5VrcTcWW2nVvZRX6ilAq4SFsBa3ZNfcqkYEuXvYy+6CCcXGIma6xgZX0f2KUhjwzo
         jhHQNvbOyKxCSVMtVH9/DF2Tl76GNjwqA58KI6z8PoXzQKpEoSEZVxblFJ9ViJ8ouiV6
         ewmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726753; x=1712331553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSM/H6C02KO1CMredI4hecRoPVCmnOG+kWeF/Me1IVA=;
        b=TiBovr8wkmEDT1QeLyUpDlp8Y1erEwdQ8OuGnxsyR+Z75VlHd/C80zo2YnyeL7/GOf
         twBvaOvtrH/wr8DgAwGBLkPr2TR78vNmxsF3ehvMAX0P5Itl8ujAAd2LDOJsj2BmdxKH
         OwXCBj7jas6fjfczOl2BM88sAUvMh3Oy89p2qSFKBuag00di/X6jp5ppltycFDiTgff7
         bAMyvMxp/Xq+p0ce7AklHkiaRAgg3w4tfu0xG0FOZn0VL8rU5tGQ0AKJU8NttWKQmSKA
         MZScEX8su9HbMMt2tKLnVUv5Dm15tAEOTRYbdPa52Rm+GUdm9DyFV2A7LAupgGP8JswD
         ckPA==
X-Forwarded-Encrypted: i=1; AJvYcCUaIZy6Use4ip0k9o71pSDrxaU6P/HTJGYfJgkBLcL5XUAyj89NED3R2nrl4Du3L0nBxAKtiEzwiUblAXxL3xoNXGntVA==
X-Gm-Message-State: AOJu0YzpiAj4DvzKhbs79IJATgkKvzRRQpK11y0kZdPmED25wdGYLzzq
	mREoauFecx9lOak1d9e+lnObQzUZTGVYxHv1sLokNX+ugtZjATWt
X-Google-Smtp-Source: AGHT+IEwAxXvZzv3PDhARGFekvGmMNo8B9NDDo/ORVnueAResAZa0ll1ricTdENl/8TH2VZRf7H16A==
X-Received: by 2002:a05:6402:4315:b0:567:29d9:99ae with SMTP id m21-20020a056402431500b0056729d999aemr1867774edc.28.1711726753192;
        Fri, 29 Mar 2024 08:39:13 -0700 (PDT)
Received: from localhost.localdomain (193-81-214-13.adsl.highway.telekom.at. [193.81.214.13])
        by smtp.gmail.com with ESMTPSA id co3-20020a0564020c0300b0056bb6a51dd9sm2129731edb.24.2024.03.29.08.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:39:12 -0700 (PDT)
From: Johannes Altmanninger <aclopte@gmail.com>
To: Jilles Tjoelker <jilles@stack.nl>
Cc: harald@gigawatt.nl,
	dash@vger.kernel.org,
	Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH v3] Allow trap to un-ignore SIGINT/SIGQUIT in async subshells
Date: Fri, 29 Mar 2024 16:39:01 +0100
Message-ID: <20240329153905.154792-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.44.0.368.gc75fd8d815
In-Reply-To: <ZgbYAvgixaQEsF4K@gmail.com>
References: <ZgbYAvgixaQEsF4K@gmail.com>
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
 src/trap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/trap.c b/src/trap.c
index cd84814..dbf81ea 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -272,7 +272,7 @@ ignoresig(int signo)
 		signal(signo, SIG_IGN);
 	}
 	if (!vforked)
-		sigmode[signo - 1] = S_HARD_IGN;
+		sigmode[signo - 1] = S_IGN;
 }
 
 
-- 
2.44.0.368.gc75fd8d815

