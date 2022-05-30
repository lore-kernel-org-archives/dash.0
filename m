Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8EC433F5
	for <linux-dash@archiver.kernel.org>; Mon, 30 May 2022 17:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiE3RCq (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 30 May 2022 13:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiE3RCp (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 30 May 2022 13:02:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5B4D267
        for <dash@vger.kernel.org>; Mon, 30 May 2022 10:02:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v19so7006333edd.4
        for <dash@vger.kernel.org>; Mon, 30 May 2022 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OK9ifbHp0S6vdDJr5AsulBVQ6cxtgwUPD6XiVE256oU=;
        b=Y2MtadCA22bOHMxa09uLos0E+zSBYHRqNyTstkT5tteyjJkNvyn5Ud3oU/YXXf5Z3v
         GzduqaCrcAJC2s0FWU2cCtMYF1xbbEbDPWW3CT0T5GLLAKAENgwoS2ayN1DHUoVe8IE4
         Oixumz5XFvHzZUDo+fraK5HlTfLGy2aHkh/kgehmPbZZenhTPYoIUUvKal2XLv94bGKL
         sBUrsgiyyMkWjOQ2vLCv7tbNhCCWa022zkjnc1SS5GHaUCMBi0vOVpC3M4T9AW2VOHgO
         nT7M1OXPf8ZVEU+oQJYJhOshiyaOjhheIV59jmY7yqTtSuPWqomawRi8T0uc8j4mij41
         IrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OK9ifbHp0S6vdDJr5AsulBVQ6cxtgwUPD6XiVE256oU=;
        b=WheOjaKYofi7/jYLxHMCBADzWwd0rlGlwWaksbafK/q0N3w/hJMxh1K3zBYRS6U6+2
         GXX5XpNQgJ5s4EpwS4HmAE8x0JIwyiqUzhExd3Tn8XeGpbYFG6NblK5+3R5cO+pFH0t8
         5mj09g1hswq9UZRB3zA7si+xmSpKE01IR1/OTtYk4k2CsYPsLZNQNjPyJbBrpRQ4/nMc
         a+XEJsJ/XLTT+DFTSGvNs6tSSA7CCKxkY1rzcMGmR3jnFY/6LvtHdoeKRRNJRWGojlNA
         W7XLrj2klEJMh/92v501YSE3qs9llZ5Vhxln3gmHARBcWkWLjXQvtHdz83BPl37tT2sk
         PwYg==
X-Gm-Message-State: AOAM533WNCjdT3rTWXrodjN1Q8+03q1pbIQvHBx0gJj2zRJYBA4ajjgG
        K2qeeaxPQzg2FiGEbbT62irSHloF3TUbQKD4dqJ7Ngucwqw=
X-Google-Smtp-Source: ABdhPJxsATHlWHsOBRwaFeLg8WRfB5EaFodeGtuMRfIy8+YEJrMit7Qm61EiQnxHfYUYSP4DXGU+zIvEQO2Exwe8SYY=
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id
 h5-20020a0564020e8500b0041d121bf436mr60299579eda.121.1653930162266; Mon, 30
 May 2022 10:02:42 -0700 (PDT)
MIME-Version: 1.0
From:   Nicola Lamacchia <nicola.lamacchia@gmail.com>
Date:   Mon, 30 May 2022 19:02:30 +0200
Message-ID: <CA+z1gfX9ZexoQC8tm9V0hV_Vo3kMxxDw5GJdeNTy_DFGu_CMKg@mail.gmail.com>
Subject: [PATCH] exec.c: Fix exit status for command -v on non-executable files
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

the following patches `command -v` to make it abide by POSIX
specifications[1] as previously described by orbea in this mailing
list[2]. Behavior comparison at the bottom[5].

Please note that POSIX does not specify the exit status in this
case[1]: "Otherwise, no output shall be written and the exit status
shall reflect that the name was not found." Although it requires the
exit status to be 127 in case of command not found[3].

Also note that in order for a command to be considered "found" when
using the PATH variable, it has to be an executable file[4]: "The list
shall be searched from beginning to end, applying the filename to each
prefix, until an executable file with the specified name and
appropriate execution permissions is found."

Therefore an exit status of 127 seems to be suitable in this case.
Which would leave the exit status 126 to be used when the user tries
to execute a file while not having the right permissions to do so.

---
diff --git a/src/exec.c b/src/exec.c
index 87354d4..facaf6b 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -445,8 +445,8 @@ loop:
                                e = errno;
                        goto loop;
                }
-               e = EACCES;     /* if we fail, this will be the error */
-               if (!S_ISREG(statb.st_mode))
+               e = ENOENT;     /* if we fail, this will be the error */
+               if (!S_ISREG(statb.st_mode) || access(fullname, F_OK|X_OK) != 0)
                        continue;
                if (lpathopt) {         /* this is a %func directory */
                        stalloc(len);
@@ -832,6 +832,9 @@ describe_command(out, command, path, verbose)
                        } while (--j >= 0);
                        p = stackblock();
                }
+               if (access(p, X_OK) != 0) {
+                       goto not_found;
+               }
                if (verbose) {
                        outfmt(
                                out, " is%s %s",
@@ -864,15 +867,18 @@ describe_command(out, command, path, verbose)
                break;

        default:
-               if (verbose) {
-                       outstr(": not found\n", out);
-               }
-               return 127;
+               goto not_found;
        }

 out:
        outc('\n', out);
        return 0;
+
+not_found:
+       if (verbose) {
+               outstr(": not found\n", out);
+       }
+       return 127;
 }

 int
---

Cheers

-- Nicola

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
[2]: https://www.mail-archive.com/dash@vger.kernel.org/msg01968.html
[3]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02
[4]: https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08_03
[5]:
Old behavior:

$ cd /tmp
$ mkdir -p test1 test2 test3
$ umask 0000
$ touch test1/foo test2/foo test3/foo
$ chmod +x test2/foo
$ PATH=./test1
$ command -v foo
./test1/foo
$ echo $?
0
$ foo
dash: 9: foo: Permission denied
$ echo $?
126
$ test1/foo
dash: 11: test1/foo: Permission denied
$ echo $?
126
$ PATH=./test2
$ command -v foo
./test2/foo
$ echo $?
0
$ foo
$ echo $?
0
$ PATH=./test1:./test2:./test3
$ command -v foo # returns the non-executable file
./test1/foo
$ echo $?
0
$ /bin/chmod +x test1/foo test3/foo
$ command -v foo # returns the cached command
./test1/foo
$ echo $?
0
$ foo # uses the executable file (./test2/foo)
$ echo $?
0
$ /bin/rm test1/foo test2/foo test3/foo
$ /bin/rmdir test1 test2 test3 --ignore-fail-on-non-empty

Patched behavior:

$ cd /tmp
$ mkdir -p test1 test2 test3
$ umask 0000
$ touch test1/foo test2/foo test3/foo
$ chmod +x test2/foo
$ PATH=./test1
$ command -v foo
$ echo $?
127
$ foo
dash: 9: foo: not found
$ echo $?
127
$ test1/foo
dash: 11: test1/foo: Permission denied
$ echo $?
126
$ PATH=./test2
$ command -v foo
./test2/foo
$ echo $?
0
$ foo
$ echo $?
0
$ PATH=./test1:./test2:./test3
$ command -v foo
./test2/foo
$ echo $?
0
$ /bin/chmod +x test1/foo test3/foo
$ command -v foo # returns the cached command
./test2/foo
$ echo $?
0
$ foo
$ echo $?
0
$ /bin/rm test1/foo test2/foo test3/foo
$ /bin/rmdir test1 test2 test3 --ignore-fail-on-non-empty
