Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DBCC433F5
	for <linux-dash@archiver.kernel.org>; Sat, 30 Apr 2022 19:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiD3TeS (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 30 Apr 2022 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbiD3TeR (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 30 Apr 2022 15:34:17 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466DDF77
        for <dash@vger.kernel.org>; Sat, 30 Apr 2022 12:30:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j6so8341313qkp.9
        for <dash@vger.kernel.org>; Sat, 30 Apr 2022 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y0QqUu8HbYJ8hXQILHUeyaxG/au/YiT17poRMgtDgzM=;
        b=FMRG9OeBr1LEyx6vWtbsIWSm1YL0Esoe4cZkwZ6zp3R+pQwtY0c7QjXzEBUbLbb8i/
         aGMtoom1Jkd7NlrfG6AUl1+crUrOgolN/npSMk2/empel7nFrV/xbDlGbZ5qTQS6XeCZ
         s6DB5PBWnTA+8zlBZOiXGxHL2gdQoEe+4s2dEwAvyc4FVjWPQ6oWW2J7byxxA3B02GiH
         vebP3QqD3RbslO+n1vlJPEJzRmysDIHqbbOnTM4703jA8ywQyOu3hYlCbtv7Iz8E2xtJ
         K76xVB+rQOLD/aix8bXExo7ih5Yxt1xh2SVVgKMOYCeS/0+i9dOIf7SAVC2eNeaSgZWc
         2Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y0QqUu8HbYJ8hXQILHUeyaxG/au/YiT17poRMgtDgzM=;
        b=Ndm/cswVM2OZz37lLLokJI+0rwYL7H9C3+EpZ3/P6AQWv3L8YjHbP9LC1lOUjKq9qk
         ZCzLEkkiWfTk5qA2uXAkbeZ57/C+w7GrTV5TefUq1SkgDshZ3SjwUGvXlrypK/GDBov1
         7NY7IY5EPXztw9jtb05iN3NIVluPi2sSiFMWKOSdgBKMbEpQd31p2JsxnYjQu0Jw9jFP
         JuvxhsxEiYvLfpbynDlkG4MHwZRB/2/mp2FhoMq6nZA7ycyP1wbJz/xREbT7Vjxa10Ho
         0orl2e6SbmrZ08ikcOqSztKMx+wjLM0nUQX87AeGE/Cgl6bpBbkFXX6/nLRYR0ciV2Q1
         rKSg==
X-Gm-Message-State: AOAM532CBrdjYHU4GEd/Z9JsCgUPhA1nqe3iMmmP0tz3fzcoD87pMdRW
        7YEgn2wnu7bde2dg+VTTUuqlNMtglLRw+KxNY4KHIIYv
X-Google-Smtp-Source: ABdhPJyuwtGB4EoWvFR+sVogEFEFSaDJiLgvae/a2LNLtwJND6T7uqKJcAdBI8YH/vF8GLqBIoegVmLrxsgrgNaR1h8=
X-Received: by 2002:a05:620a:430b:b0:67e:85d1:f53f with SMTP id
 u11-20020a05620a430b00b0067e85d1f53fmr3747893qko.43.1651347051834; Sat, 30
 Apr 2022 12:30:51 -0700 (PDT)
MIME-Version: 1.0
From:   Al g <algore3698@gmail.com>
Date:   Sat, 30 Apr 2022 15:30:40 -0400
Message-ID: <CAOKKkHeAkWxtgm6=0eq6D6pPt+QV3SuEhrq=YNO-Jj7vospf-w@mail.gmail.com>
Subject: [PATCH] expand: Add ifsfree to expand to fix a logic error that leaks
 the heap
To:     dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Description of problem:
First bug:
Due to a logic error in the ifsbreakup function in expand.c if a
heredoc and normal command is run one after the other by means of a
semi-colon, when the second command drops into ifsbreakup the command
will be evaluated with the ifslastp/ifsfirst struct that was set when
the here doc was evaluated. This results in a buffer over-read that
can leak the program's heap, stack, and arena addresses which can be
used to beat ASLR.
Second bug:
If the heap is sprayed with a certain amount of bash variables and
part of the first bug is sent, a predictable heap value can be free'd
and put into the tcache. After the heap value is free'd, if the heap
was sprayed correctly, an attacker can overwrite the free=E2=80=99d tcache
address to obtain numerous write-what-where and the ability to
arbitrarily overwrite any writable memory address. This could lead to
a DoS or arbitrary code execution.

Steps to Reproduce:
First bug:
cmd args: ~/exampleDir/example> dash
$ M=3D'AAAAAAAAAAAAAAAAA'    <note: 17 A's>
$ q00(){
$ <<000;echo
$ ${D?$M$M$M$M$M$M}        <note: 6 $M's>
$ 000
$ }
$ q00                      <note: After the q00 is typed in, the leak
should be echo'd out; this works with ash, busybox ash, and dash and
with all option args.>

Second bug:
cmd args: ~/exampleDir/example> dash
<Everything in the `` is not meant to show what exactly is typed in
but more or less an action if that makes sense.>
$ AAAAAAAAAAAAAA    <note: These 14 A's are necessary to get initial
heap groom correct>
$ `spray 400 bash variables with size of 0x30 bytes`
$ `send bash variable with size of 0x20 bytes`
$ `send bash variable with size of 0x60 bytes`
$ `spray 12 bash variables with size of 0x20 bytes`
$ `Send part of first vulnerability`
   $ <<000000;V
   $ <Z*16+$Y*19>${x?0p$^?A<$B*442>$0b<B*10>dbasdfg$0<S*10>}
<note: The <> in this line are not meant to be entered in as is, but
instead shows amount of letter inside <> that would be entered in.>
   $ 000000      <note: After the 000000 is entered in the
vulnerability should trigger and attempt to free a predictable heap
address; while it can differ on each host, typically around variable
C20 - C5 is where the predictable free'd address will be.>

Patch:
Adding the following to expand.c will fix both bugs in one go.
(Thank you to Harald van Dijk and Michael Greenberg for doing the
heavy lifting for this patch!)
--
--- a/src/expand.c
+++ b/src/expand.c
@@ -859,6 +859,7 @@
                               if (discard)
                                          return -1;

+                             ifsfree();
                               sh_error("Bad substitution");
                    }

@@ -1739,6 +1740,7 @@
                                 } else
                                              msg =3D umsg;
                   }
+                 ifsfree();
                   sh_error("%.*s: %s%s", end - var - 1, var, msg, tail);
 }
--
