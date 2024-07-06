Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066651BF58
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295093; cv=none; b=lxa4bxBsACLMkSufTbGqv6oxm1ZerxuYLFlWXKbSL2IUgFYoXGnICW8aZzgIm1+pdDXZ1oPzDG4x3svzsoyefq642UCW63DKdBdrQ8VfUQvGk3Z64I2WZgm//b8Yx6tBtt/61QzdzcoBD8pyWst/K68nEga9U9U6MWR5mb4mfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295093; c=relaxed/simple;
	bh=jKM7QxouuL8m8x2+7fUPmulrJ3rpdH/qGC1pzOrkyec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beS6osN0Q6oOUijTc5Y8N7fOB0xQ4wBS3gcdqu+c03M5ZjkiXok2h2EmGlCtgQTWL6poQzoQ7HTEauqovcEOs5v0WZLjw1z1/3Okhg4yd3O9Kma8MSw3tVUuFgU5l8oyD9XCUMX/iBUzaclVSAG6MYaYgqjPiPZHb9ICLmh7hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYiZfCEC; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYiZfCEC"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-382458be739so12609685ab.1
        for <dash@vger.kernel.org>; Sat, 06 Jul 2024 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720295090; x=1720899890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ll7EWma+L/knyusFD78bYNT7jKeoZTO8u4f0Pjm1pl0=;
        b=QYiZfCECnxhM16Dk1rAwyPjFcB1DexXkX6wtk7wHVpYVqOm5hWT/EaV+8++55JuBym
         NubFjmsLjGZgjVy0yMh4hATTC3uD0qgtHoXrm+2OIrMuvGnyl1LRiVY+6PsZqH4w7AjH
         DDMVP4iEuZ1EehplNI7OGByicFcpI/wIle1pEnJ5j6ZS44Hf1kY0cy8NQc7NXYg1YgTr
         9myBxI94+vtkmyn23ZMhWcmYjCMkUIOS0uBY6ZM+ToB45HVck47f2gUh6XLt/TRDug8L
         z8pYUUwmguFqb9tpgPkmrtx2MOCS/DkeR9vhxqG9yvVbF1b9mj2ibL9gyv9xYZTTtQEL
         Oauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720295090; x=1720899890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ll7EWma+L/knyusFD78bYNT7jKeoZTO8u4f0Pjm1pl0=;
        b=VBWuTjjA1EJgZx8MtE8VJnSmYWO6WmBjn8y6zE+TAes9IsUvLRhDblphAFciJvU5gV
         TTFt8wO6ub8nVFQfyMWdIGZduOil0BuvDFO76bWkAfWyaXK26hSx9Ta9yBDYnDv8kzhQ
         PNN/Es6Ht5Nrwlypbkt+3x1QQallW9RgwDuo0/v/22MXpzH+c9hKyPU6irDWW2O957w1
         5z79h1xpQ2ZFhswXVrzIsijAzjctZ00XYWh+jih9xwvYmzX//FnaWqhcX+6gNWP+p14/
         7VNmfbxu+9JVqT31FTbhrzi2MQpuMZoonCusiVCSANJNe9IIOCsL8U5GtRgFle0a4Huo
         JhSQ==
X-Gm-Message-State: AOJu0Yw5bbGkCIVdIMaK0vTBiUYmDaVZXha+U0YOwwOrjNWwAQOMY6Jf
	X2Fza/ofRzvmsTCNfCZxqD4FnTtbJFImhbJySh4UOi8oRa19MLpQwP0Icw==
X-Google-Smtp-Source: AGHT+IEazsAC4eD0RBhP8uvTMTnC94We4Ex03+hbZUlEmzFajpnvYRjDniyfSugo+4Mvb+E4tU1XCA==
X-Received: by 2002:a05:6e02:b22:b0:36b:3af2:2349 with SMTP id e9e14a558f8ab-383991bf826mr113192595ab.15.1720295090504;
        Sat, 06 Jul 2024 12:44:50 -0700 (PDT)
Received: from penguin.lxd ([2603:6000:8201:10e2:216:3eff:fe7e:5331])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38386ff3f54sm14414115ab.19.2024.07.06.12.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 12:44:49 -0700 (PDT)
From: Buck Evan <workitharder@gmail.com>
To: dash@vger.kernel.org
Cc: Buck Evan <workitharder@gmail.com>
Subject: [PATCH 1/1] add tests
Date: Sat,  6 Jul 2024 14:44:16 -0500
Message-ID: <20240706194424.5412-2-workitharder@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706194424.5412-1-workitharder@gmail.com>
References: <20240706194424.5412-1-workitharder@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
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

diff --git a/.gitignore b/.gitignore
index e349901..1827ca2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,3 +40,6 @@ Makefile
 .Spotlight*
 .Trash*
 *[Tt]humbs.db
+
+# vim
+.*.sw[a-z]
diff --git a/test b/test
new file mode 100755
index 0000000..8d214f5
--- /dev/null
+++ b/test
@@ -0,0 +1,33 @@
+#!/bin/sh
+set -eu
+export PATH="$PWD/src:$PATH"
+if [ "$#" -eq 0 ]; then
+  # default arguments: all tests
+  set -- ./tests/*
+fi
+
+success=true
+for test in "$@"; do
+  printf "%-40s " "$test"
+  if "$test/test.sh" >"$test/result.txt" 2>&1; then
+    :
+  else
+    exit="$?"
+    echo "(exit: $exit)" >>"$test/result.txt"
+  fi
+  if git diff --quiet --exit-code "$test/result.txt"; then
+    echo PASS
+  else
+    echo FAIL
+    git diff "$test/result.txt"
+    echo
+    success=false
+  fi
+done
+
+if "$success"; then
+  echo PASS
+else
+  echo FAIL
+  exit 1
+fi
diff --git a/tests/async-subshell-unignore-signal/result.txt b/tests/async-subshell-unignore-signal/result.txt
new file mode 100644
index 0000000..e96c3ad
--- /dev/null
+++ b/tests/async-subshell-unignore-signal/result.txt
@@ -0,0 +1,4 @@
+Scenario 0: "set -i" makes a subshell un-ignore SIGINT.
+Scenario 1: resetting SIGINT handler.
+Scenario 2: ignoring SIGINT.
+OK
diff --git a/tests/async-subshell-unignore-signal/test.sh b/tests/async-subshell-unignore-signal/test.sh
new file mode 100755
index 0000000..35ae9aa
--- /dev/null
+++ b/tests/async-subshell-unignore-signal/test.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+shell=src/dash
+
+set -e
+
+SubshellWith() {
+        parent_pid=$(setsid "$shell" -c "( $1; sleep 99 ) </dev/null >/dev/null 2>&1 & echo \$\$")
+        sleep 1
+        subshell_pid=$(ps -o pid= -$parent_pid | tail -n 1)
+}
+
+trap 'kill -TERM -$parent_pid 2>/dev//null ||:' EXIT # Tear down after a failure.
+
+echo Scenario 0: '"set -i"' makes a subshell un-ignore SIGINT.
+SubshellWith 'set -i'
+kill -INT $subshell_pid
+if ps -p $subshell_pid | grep -q sleep; then
+  echo FAIL
+fi
+kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.
+
+echo Scenario 1: resetting SIGINT handler.
+SubshellWith 'trap - INT'
+kill -INT -$parent_pid # kill the whole process group since that's the my use case
+if ps -p $subshell_pid | grep -q sleep; then
+  echo FAIL
+fi
+kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.
+
+echo Scenario 2: ignoring SIGINT.
+SubshellWith 'trap "" INT'
+kill -INT $subshell_pid
+if ! ps -p $subshell_pid | grep -q sleep; then
+  echo FAIL
+fi
+kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.
+
+echo OK
diff --git a/tests/backslash-outside-quotes/result.txt b/tests/backslash-outside-quotes/result.txt
new file mode 100644
index 0000000..030ebde
--- /dev/null
+++ b/tests/backslash-outside-quotes/result.txt
@@ -0,0 +1 @@
+/b/c/
diff --git a/tests/backslash-outside-quotes/test.sh b/tests/backslash-outside-quotes/test.sh
new file mode 100755
index 0000000..4b3a476
--- /dev/null
+++ b/tests/backslash-outside-quotes/test.sh
@@ -0,0 +1,4 @@
+#!./src/dash
+a=/b/c/*
+b=\\
+echo ${a%$b*}
diff --git a/tests/dollar-dash-expansion/result.txt b/tests/dollar-dash-expansion/result.txt
new file mode 100644
index 0000000..dfafdb2
--- /dev/null
+++ b/tests/dollar-dash-expansion/result.txt
@@ -0,0 +1,3 @@
+0: the options are e
+1: the options are fe
+2: the options are ufe
diff --git a/tests/dollar-dash-expansion/test.sh b/tests/dollar-dash-expansion/test.sh
new file mode 100755
index 0000000..ba72a12
--- /dev/null
+++ b/tests/dollar-dash-expansion/test.sh
@@ -0,0 +1,7 @@
+#!./src/dash
+set -e
+echo "0: the options are $-"
+set -fo debug
+echo "1: the options are $-"
+set +o debug -uo nolog
+echo "2: the options are $-"
diff --git a/tests/echo-backslash-c-spillage/result.txt b/tests/echo-backslash-c-spillage/result.txt
new file mode 100644
index 0000000..ecb747d
--- /dev/null
+++ b/tests/echo-backslash-c-spillage/result.txt
@@ -0,0 +1,2 @@
+test\ test
+test\ test
diff --git a/tests/echo-backslash-c-spillage/test.sh b/tests/echo-backslash-c-spillage/test.sh
new file mode 100755
index 0000000..f6f4886
--- /dev/null
+++ b/tests/echo-backslash-c-spillage/test.sh
@@ -0,0 +1,4 @@
+#!./src/dash
+echo test\\ test
+echo '\c'
+echo test\\ test
diff --git a/tests/eval-empty/result.txt b/tests/eval-empty/result.txt
new file mode 100644
index 0000000..d86bac9
--- /dev/null
+++ b/tests/eval-empty/result.txt
@@ -0,0 +1 @@
+OK
diff --git a/tests/eval-empty/test.sh b/tests/eval-empty/test.sh
new file mode 100755
index 0000000..d1d1772
--- /dev/null
+++ b/tests/eval-empty/test.sh
@@ -0,0 +1,7 @@
+#!./src/dash
+false
+if eval ''; then
+  echo OK
+else
+  echo not ok
+fi
diff --git a/tests/expmeta-nonleading-slash/result.txt b/tests/expmeta-nonleading-slash/result.txt
new file mode 100644
index 0000000..b555872
--- /dev/null
+++ b/tests/expmeta-nonleading-slash/result.txt
@@ -0,0 +1 @@
+/dev/null
diff --git a/tests/expmeta-nonleading-slash/test.sh b/tests/expmeta-nonleading-slash/test.sh
new file mode 100755
index 0000000..711e1a7
--- /dev/null
+++ b/tests/expmeta-nonleading-slash/test.sh
@@ -0,0 +1,2 @@
+#!./src/dash
+echo /*"/null"
diff --git a/tests/expmeta-slash-treatment/result.txt b/tests/expmeta-slash-treatment/result.txt
new file mode 100644
index 0000000..cd3d018
--- /dev/null
+++ b/tests/expmeta-slash-treatment/result.txt
@@ -0,0 +1 @@
+/root
diff --git a/tests/expmeta-slash-treatment/test.sh b/tests/expmeta-slash-treatment/test.sh
new file mode 100755
index 0000000..735f69b
--- /dev/null
+++ b/tests/expmeta-slash-treatment/test.sh
@@ -0,0 +1,2 @@
+#!./src/dash
+echo "/"root*
diff --git a/tests/ifs-after-heredoc/result.txt b/tests/ifs-after-heredoc/result.txt
new file mode 100644
index 0000000..3b7172a
--- /dev/null
+++ b/tests/ifs-after-heredoc/result.txt
@@ -0,0 +1,2 @@
+abcdefghijklmnopqrstuvwxyz
+OK
diff --git a/tests/ifs-after-heredoc/test.sh b/tests/ifs-after-heredoc/test.sh
new file mode 100755
index 0000000..2f0a96e
--- /dev/null
+++ b/tests/ifs-after-heredoc/test.sh
@@ -0,0 +1,7 @@
+#!./src/dash
+dash -c '
+cat <<EOF
+$@
+EOF
+echo OK
+' - abcdefghijklmnopqrstuvwxyz
diff --git a/tests/naked-backslash-leakage/result.txt b/tests/naked-backslash-leakage/result.txt
new file mode 100644
index 0000000..dcb7930
--- /dev/null
+++ b/tests/naked-backslash-leakage/result.txt
@@ -0,0 +1 @@
+<bc>
diff --git a/tests/naked-backslash-leakage/test.sh b/tests/naked-backslash-leakage/test.sh
new file mode 100755
index 0000000..66df7bd
--- /dev/null
+++ b/tests/naked-backslash-leakage/test.sh
@@ -0,0 +1,5 @@
+#!./src/dash
+a="\\*bc"
+b="\\"
+c="*"
+echo "<${a##$b"$c"}>"
diff --git a/tests/no-space/result.txt b/tests/no-space/result.txt
new file mode 100644
index 0000000..e714e38
--- /dev/null
+++ b/tests/no-space/result.txt
@@ -0,0 +1,2 @@
+./tests/no-space/test.sh: 2: echo: echo: I/O error
+(exit: 1)
diff --git a/tests/no-space/test.sh b/tests/no-space/test.sh
new file mode 100755
index 0000000..dc9cb42
--- /dev/null
+++ b/tests/no-space/test.sh
@@ -0,0 +1,2 @@
+#!./src/dash
+echo foo >>/dev/full
-- 
2.42.0

