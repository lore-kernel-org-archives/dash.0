Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5A1BF58
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295083; cv=none; b=rLcIkqdKmdkQYd52jIECUTabhTIs29u7hSmCYuQnxL+Bo/O1OHgjfUBUWg7ktXRYB6/OQW16P7xoJxHY44e9w7dOBQ2IvHhkaezgxo3imswejtLQDUkNe6elWVQZdt7K94/P+oB+EZTaYnlGRjCniTmJuCNM9InWRBzp1j0C2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295083; c=relaxed/simple;
	bh=ZEdOIa1Mmj/gstToqCoq0FJgpUALmTBsKsfCLh6wlL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N7R6uj5FCMyg1pHe/klaTkFdH/5lR4OGkfOKnXT/LfeflocGIZotlVUAh5VaWQ3ppaHCed9XSAbhTzzzRLho9jbGSsGUKcvGS1XS9hy12qR+aEG+7DqXkZliRSxg+VdzAeo/zBxWmu3TZS+jY7/9Dm8ottG2Lb+CuLomxH8Ksts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF62kVYN; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF62kVYN"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375e96f5fddso10773405ab.1
        for <dash@vger.kernel.org>; Sat, 06 Jul 2024 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720295080; x=1720899880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/S6DhdIAIWOguHo4j5mrAqgdWkPCvaSWFKEz/QI9mA=;
        b=LF62kVYNds8OQlT1rdAjeZE2Xu05KKexaI/Es4Lofk9lSR32AwVnKLi7zAsujfMr3X
         x86B5JZALJeNdNJmfEstQ9SJ0RLtM7buTg4puEb94s5bc66zu0ehhpncLZmWjSkDktYm
         LiBJTNdA1gUMgUljjJvWQXcmO/5ELWvPr7Vj2xZMrsJ6RVm0x6j5PyCjrTC4bbXvC7mu
         fw6FECy05wBQijx74y4PvPNpdG52dJdGjm46bGM1r5zHWbDuvMxQ6DoTBWFgmPjQoHWF
         z07p4pJqKwSk0LreAEAnwgXC/rIz2okcK3/F6KGjEJUpDIABxjhOUpaFqstqZfYAjP4j
         4xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720295080; x=1720899880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/S6DhdIAIWOguHo4j5mrAqgdWkPCvaSWFKEz/QI9mA=;
        b=MGikq9WV7cDyaciLmyYNFt98shhYmj8e9UKC7kKvF4SX5eQ7MyTgyq98IB8geHGX6Q
         /LmMI3YdLT/Or7UH74DrZf3iE4dYExmX+GHu/ZskCL35+E5BbIqIKhWkmWywu+cCWiTq
         pnpNAve2R1ZHrOqWB30HKAZNXfY8+VT9SK3vZX0zPvG4rjfxYmJBDldatG1VJ/w9Ci2E
         B3qEHKfU8XLm+uU3hnXxYfPKCQb4lUIIDbYe1bPaxtJgVNFahHXgBT/2kZilc50hdkb3
         jd7k3PZEkmWDTnxpn7V+rf+GzC9Yjfr7HsxlB5aIbQG/Fyn1qSQoegmrB9zrDpNIeBLa
         bZQQ==
X-Gm-Message-State: AOJu0YwQxrmIQD4ihw2JXzt4tKEViKtUVis0PU0lb0nFPLun1RxRZwxb
	3erVxxQYBwivyu594sUotoJ8Ns6Cosfvpd/9FNOLVnSlmIZBJ3j+09mw0Q==
X-Google-Smtp-Source: AGHT+IFeNi6CG3UxJlYcRHFIEK9qFqPYhknqCiaM3z+GTm13tV6yXjPiX82GQ7gdRBw/hfWgWNnpPQ==
X-Received: by 2002:a05:6e02:164b:b0:383:5285:54c5 with SMTP id e9e14a558f8ab-38398fd1ea4mr100908185ab.17.1720295079815;
        Sat, 06 Jul 2024 12:44:39 -0700 (PDT)
Received: from penguin.lxd ([2603:6000:8201:10e2:216:3eff:fe7e:5331])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38386ff3f54sm14414115ab.19.2024.07.06.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 12:44:38 -0700 (PDT)
From: Buck Evan <workitharder@gmail.com>
To: dash@vger.kernel.org
Cc: Buck Evan <workitharder@gmail.com>
Subject: [PATCH 0/1] adding a test suite
Date: Sat,  6 Jul 2024 14:44:15 -0500
Message-ID: <20240706194424.5412-1-workitharder@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I pulled these test cases out of the git log. I could do more but wanted to see if this work is welcome first.

I also created a pull request at
https://github.com/herbertx/dash/pull/7, just in case that's easier.



Buck Evan (1):
  add tests

 .gitignore                                    |  3 ++
 test                                          | 33 ++++++++++++++++
 .../async-subshell-unignore-signal/result.txt |  4 ++
 tests/async-subshell-unignore-signal/test.sh  | 38 +++++++++++++++++++
 tests/backslash-outside-quotes/result.txt     |  1 +
 tests/backslash-outside-quotes/test.sh        |  4 ++
 tests/dollar-dash-expansion/result.txt        |  3 ++
 tests/dollar-dash-expansion/test.sh           |  7 ++++
 tests/echo-backslash-c-spillage/result.txt    |  2 +
 tests/echo-backslash-c-spillage/test.sh       |  4 ++
 tests/eval-empty/result.txt                   |  1 +
 tests/eval-empty/test.sh                      |  7 ++++
 tests/expmeta-nonleading-slash/result.txt     |  1 +
 tests/expmeta-nonleading-slash/test.sh        |  2 +
 tests/expmeta-slash-treatment/result.txt      |  1 +
 tests/expmeta-slash-treatment/test.sh         |  2 +
 tests/ifs-after-heredoc/result.txt            |  2 +
 tests/ifs-after-heredoc/test.sh               |  7 ++++
 tests/naked-backslash-leakage/result.txt      |  1 +
 tests/naked-backslash-leakage/test.sh         |  5 +++
 tests/no-space/result.txt                     |  2 +
 tests/no-space/test.sh                        |  2 +
 22 files changed, 132 insertions(+)
 create mode 100755 test
 create mode 100644 tests/async-subshell-unignore-signal/result.txt
 create mode 100755 tests/async-subshell-unignore-signal/test.sh
 create mode 100644 tests/backslash-outside-quotes/result.txt
 create mode 100755 tests/backslash-outside-quotes/test.sh
 create mode 100644 tests/dollar-dash-expansion/result.txt
 create mode 100755 tests/dollar-dash-expansion/test.sh
 create mode 100644 tests/echo-backslash-c-spillage/result.txt
 create mode 100755 tests/echo-backslash-c-spillage/test.sh
 create mode 100644 tests/eval-empty/result.txt
 create mode 100755 tests/eval-empty/test.sh
 create mode 100644 tests/expmeta-nonleading-slash/result.txt
 create mode 100755 tests/expmeta-nonleading-slash/test.sh
 create mode 100644 tests/expmeta-slash-treatment/result.txt
 create mode 100755 tests/expmeta-slash-treatment/test.sh
 create mode 100644 tests/ifs-after-heredoc/result.txt
 create mode 100755 tests/ifs-after-heredoc/test.sh
 create mode 100644 tests/naked-backslash-leakage/result.txt
 create mode 100755 tests/naked-backslash-leakage/test.sh
 create mode 100644 tests/no-space/result.txt
 create mode 100755 tests/no-space/test.sh

-- 
2.42.0

