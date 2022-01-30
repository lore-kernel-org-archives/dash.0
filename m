Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A80CC433EF
	for <linux-dash@archiver.kernel.org>; Sun, 30 Jan 2022 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353509AbiA3ALa (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 29 Jan 2022 19:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbiA3AL3 (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 29 Jan 2022 19:11:29 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6BDC061714
        for <dash@vger.kernel.org>; Sat, 29 Jan 2022 16:11:29 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 13so8852370qkd.13
        for <dash@vger.kernel.org>; Sat, 29 Jan 2022 16:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TqMbIJDASS7g8H8n1qYU4HgBT88/mWffMBQ/4JKbAnY=;
        b=VQz+Z+MMm5+0DdaWteIxxkUKqLvMWu/T0AbQOWz6XHQ5UWUJxtDCeursilGdUb4ipP
         R5/v8O4jhPQk9ZTy2Sz2596cmpbV/KV1B0Z2hE/u/jIEyqLrZMMbbTmjjafO+/x61BaV
         ryPILUFA+/hctUMrN8gpcubdyFpCJD0Fc6bpT82q4XSYhnOVUcPC0NazghbsaAGeC2Vm
         HbyuJeZMBdG7bUPAYnjhMh3Kdc3smTHNp7BbIFubLCCMIrjqv2/GqeO52Kahor6us4u1
         fwbRklp7FmEy3ilOfFVxNZF4Zaznj88td5A0eYRf2fimkdiAkZUhHyL7FmN+2bfaNpsU
         jO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TqMbIJDASS7g8H8n1qYU4HgBT88/mWffMBQ/4JKbAnY=;
        b=Iig57tAoiwwMABiTHjgnl6OPo52NR5DylIiEbnZTiRELGP/l8VmIiJAi3RDLFW+yfB
         ZGUo+pBQRqB0nNOtELCt9MPgY2OxV+cwImRZvz++EURKg1cfdfBc9rc+P+vdpOz6Ra4R
         oZKNXZz8BquC2Rg2Zds8S2yAN3/keEPCxaxM2h5x+UjeeaevDvJI+o9KV4oqFJe6YJla
         S/2sab627tT8hFc9N0ACnw8i83PlGl7DI9eYVxB3DBrWKrodkJCnC7bLyW2iewKxMMhq
         vgfA8HWQ2kLnPnj4LmY37vHDgzuPQbUcosVP/hkwVCjqymn0MxoPVr6zJTGar+nkaJOa
         P1fA==
X-Gm-Message-State: AOAM531oii6M2tA+K8zx8CzHpJDFJef+TfPNAEWLeLRAGHpiC8hG5780
        lBaT89a7aGv7KeOq+/qoLyhOVkU26YNIL7qDzxvMN/SIpCw=
X-Google-Smtp-Source: ABdhPJymRWwBI0u/a9uly/I8se1juW6TMeyXw6lqSPxicM2YeF3XdgGJBHGJQs2BSzZNX7pX61s/NQeCK1/CQOzVtWA=
X-Received: by 2002:a37:984:: with SMTP id 126mr9546008qkj.495.1643501488447;
 Sat, 29 Jan 2022 16:11:28 -0800 (PST)
MIME-Version: 1.0
From:   Parke <parke.nexus@gmail.com>
Date:   Sat, 29 Jan 2022 16:10:52 -0800
Message-ID: <CAPxz1+bq_JM4OmgPNh+Hgkx=eDrdiXrFFxi3BscKv3F1VJk2xQ@mail.gmail.com>
Subject: Dash man page error regarding: background commands and the
 redirection of standard input to /dev/null
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

While writing a script, I wanted a background command to be able to
read from standard input.  (Specifically, from the terminal.)

While trying to achieve this result, I believe I found an error in the
dash man page.

The dash man page says:

   Background Commands -- &
     If the shell is not interactive, the standard input of an asynchronous
     command is set to /dev/null.

Source:
https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/dash.1#n583
(Specifically, see line 592.)

I believe the above is incorrect.  I believe it is the 'monitor'
option flag that determines whether or not standard input is
redirected.

Below is a script that exposes the actual (and correct?) behavior.

I have tested the script with:
dash 0.5.11.4-1 on Arch
dash 0.5.10.2-6 on Ubuntu

----

PS1=3D'$ '

probe  ()  {
  [ -t 0 ]  &&  s0=3D'0'  ||  s0=3D'1'
  [ -t 1 ]  &&  s1=3D'0'  ||  s1=3D'1'
  [ -t 2 ]  &&  s2=3D'0'  ||  s2=3D'1'
  echo  "probe.$1  $s0 $s1 $s2"  ;  }

echo  ;  echo  'plain'
probe  1
probe  2  &  wait
sleep  1

echo  ;  echo  'set  -o monitor'
set  -o monitor
probe  3
probe  4  &  wait
sleep  1
set  +o monitor

echo  ;  echo  'set  -o interactive'
set  -o interactive
probe  5
probe  6  &  wait
sleep  1
sleep  1

----

Actual output:

plain
probe.1  0 0 0
probe.2  1 0 0

set  -o monitor
probe.3  0 0 0
probe.4  0 0 0
[1] + Done                       probe 4

set  -o interactive
$ probe.5  0 0 0
$ probe.6  1 0 0
$ $ $

----

In the above, probe.4 and probe.6 do not behave as described by the
dash man page.

If the dash man page were correct, probes 4 and 6 would echo the
following output:
probe.4  1 0 0
probe.6  0 0 0

----

To compare with bash, the bash man page says:

       If a command is followed by a & and job control is not active, the  =
de=E2=80=90
       fault standard input for the command is the empty file /dev/null.  O=
th=E2=80=90
       erwise, the invoked command inherits the file descriptors of the  ca=
ll=E2=80=90
       ing shell as modified by redirections.

----

When run with bash, the above test script behaves as described in the
bash man page.

----

plain
probe.1  0 0 0
probe.2  1 0 0

set  -o monitor
probe.3  0 0 0
probe.4  0 0 0

set  -o interactive
test.sh: line 23: set: interactive: invalid option name
probe.5  0 0 0
probe.6  1 0 0

----

Observations:

1)  It appears that the 'monitor' option flag controls the redirection
of standard input for background commands.  This is true in both dash
and bash.

2)  Whereas: The dash man page (incorrectly?) says that only the
'interactive' option flag controls redirection of standard input for
background commands.

3)  dash (surprisingly?) allows run-time toggling the interactive
option flag.  (bash does not.)

4)  (Surprisingly?) 'set -o monitor' causes dash to print out '[1] +
Done probe 4' even when the interactive action flag is not set.  (bash
does not print out this 'Done' message.)

5)  If the interactive option flag is toggled on at run-time, dash
echos PS1 after every command.  (Whereas bash does not allow run-time
toggling of the interactive option flag.)

6)  Assuming dash's current behavior is correct (i.e. redirecting
standard input based solely on the monitor option flag), then I
recommend updating the dash man page so it accurately describes the
current behavior.
