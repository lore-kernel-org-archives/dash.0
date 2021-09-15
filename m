Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791B1C433F5
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DF361131
	for <linux-dash@archiver.kernel.org>; Wed, 15 Sep 2021 17:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhIORti (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhIORti (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Sep 2021 13:49:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B5C061574
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 10:48:19 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z1so4537623ioh.7
        for <dash@vger.kernel.org>; Wed, 15 Sep 2021 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=B3shKwadRuUrrOwBU0sIKaBinQz44BVdru4kBHDHu2E=;
        b=NWKi5VicVdCJnZkW9E07C/CNazX8coqB19clywCBXSIoz+jyj+P2R4wODcqlAWiPVD
         CO4Vwq6yVWN86uS0stunmDwyBA1M2jLSctIdF7+mjlJT2JNkutXh3FoVAJN9cd5GZk8x
         PGuTT+MbRaw4Wvl1B85wWKtQaOp+9rfLWqDh2JIh2FOnHcF/gFWRo8lMwRGqZtEWIUAw
         hwD3w/+LH8NAkUNMLQYIFFHphYUzCn17c07taXWh2O5yzUhgS98qxbkA+QLzIBG9lhsj
         ZhimUs4RU9e4L6v0we1qyIxaDsmojU0KU/BbghO4Hz19/W1lscPNg2MAE//9PqVYCl13
         K0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B3shKwadRuUrrOwBU0sIKaBinQz44BVdru4kBHDHu2E=;
        b=fAEE3qkhnyaXWI8m6aXk43eS7306BUOviu6hu8GFQk3Gx9wxWsoI3+1OrC2moSCpg7
         hxihwlsQUQy6aPR9F1si0NPAaWiYbZt4h5I3JzQK1Rx7hOiBhW9VibCuTN/rTopDXBat
         m1d0yox0njWkBvY8RKpYFaWPr6Jvwdfk/fl7/XkV9k0eKGW2XcPC5qt7nF6VJ5yI1Tml
         2ayr1p05Ijx5R/bTXpsu7Dfk6wHdarEX7UgytqifOrzPkoXSm3DAR9RYR4yGz0D7GRPH
         SxGHVc4kBWCDghlpUj5lJ5YXlsdRrPENklS/5Tg6rwd0DFMFbejXEfmRy53dgPPAiwv/
         qJOw==
X-Gm-Message-State: AOAM532tnxyXDcV3BwzlPdjycsqySMUH6APi3rB6PC99/yehXUJClI9s
        lvbxeymBguqHCHpooIw+b74qHdxdrCao7CnOlmhwKWdxSg==
X-Google-Smtp-Source: ABdhPJz6jMfqGtBtt0TLGPKtGNsY9LMQ5VjtRApO+Jdy5o08dMCw9f6MtRdzUyRj+l6dbQ0ZpQi+oX4Hm5h/lyqSRzY=
X-Received: by 2002:a6b:c308:: with SMTP id t8mr1066315iof.2.1631728098187;
 Wed, 15 Sep 2021 10:48:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Date:   Wed, 15 Sep 2021 19:47:37 +0200
Message-ID: <CAJGKYO4i85vGboyucxhJ948xZYxrBjoj5PtAO0eB3TEWW8QpzA@mail.gmail.com>
Subject: shell script error management in busybox ash
To:     dash@vger.kernel.org
Cc:     Denys Vlasenko <vda.linux@googlemail.com>
Content-Type: multipart/mixed; boundary="000000000000a9c8cb05cc0c4d45"
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

--000000000000a9c8cb05cc0c4d45
Content-Type: text/plain; charset="UTF-8"

Dear all,

 Denys Vlasenko, the maintainer of BusyBox, asked me to organise a
task to synchronise busybox ash and dash in such a way the future
developments could benefit from each other's contributions. In
particular this need raised after these patches has been applied:

ash: add bash-like ERR trap and set -E
https://git.busybox.net/busybox/commit/?id=e0bf3df0205d5ccef52df67b1760b8b54f15ec6e

ash: fix LINENO in functions
https://git.busybox.net/busybox/commit/?id=d6c9cbc0727cc3875672ae280ec129514a9d8594

ash: LINENO starts from 0 in -c SCRIPT mode
https://git.busybox.net/busybox/commit/?id=64aa86b720641cb50be9636e6c20d4dbbea6fed0

ash: introduce bash-like $FUNCNAME
https://git.busybox.net/busybox/commit/?id=704c596563a5b4da4349b272d0c9c71aacea34a7

 These patches derive from a larger patch that I developed to improve
the error management/debug in busybox ash. In brief these patches add
the following functionalities:

 - trap ERR and set -E added
 - LINENO became a global variable
 - FUNCNAME global variable added

 Developing these patches we realised that the use of EXEXIT and EXEND
exceptions complicates the code and do not add any value. Moreover,
the code that these exceptions trigger (everywhere the setjmp()
returns true) restores some values and frees some memory but the traps
need the information before the restore, not the restored values. For
these reason I developed three patches here in attachment:

 1. get rid of EXEXIT in exitcmd() and fix a bug about return value
 2. get rid of EXEND at the end of evaltree()
 3. remove the EXEXIT and EXEND altogether

 The description of these patches are simply arbitrary and temporary.
I hope we will agree on these details once we are going to port them
to dash.

 Applying these patches the output printed by trap ERR and trap EXIT
is what was expected to be demonstrating that to avoid these
exceptions the code became straightforward. We are here to check your
interest in porting these patches to dash and your will to apply.

 Our focus is related to the patches listed above but in the long run
it is not limited to them but also includes the following patches.
These patches have been applied in the meantime that others made
changes to ash.c as well. The full list of patches and their order is
listed here:

https://git.busybox.net/busybox/log/

 Other patches that have been applied that might be a convenience to
port in dash are the following:

ash: eval: Check nflag in evaltree instead of cmdloop
https://git.busybox.net/busybox/commit/?id=41beb53787ec798a27f336c4758cb5ebd8f0c75a

ash: eval: Do not cache value of eflag in evaltree
https://git.busybox.net/busybox/commit/?id=f415e21a7dce1d4f4b760fddfaba85c551681e11

ash: parser: Fix handling of empty aliases
https://git.busybox.net/busybox/commit/?id=30af5938afad076e12b8ece123cab0b8bc92a596

ash: parser: Save and restore heredoclist in expandstr
https://git.busybox.net/busybox/commit/?id=1c06ddd8bbbd6906e5bf00ec93e04d5090718be9

ash: use pgetc_eatbnl() in more places, take 3
https://git.busybox.net/busybox/commit/?id=c54025612711a6b1997efd99206b9fbcaa5a29cf

ash: parser: Fix alias expansion after heredoc or newlines
https://git.busybox.net/busybox/commit/?id=8c68ae8416c8b54222eb3cd1d4908a570147e134

ash: parser: Get rid of PEOA
https://git.busybox.net/busybox/commit/?id=48cb983b136fb74c61db594a30e18bdc42b7264c

ash: eval: Prevent recursive PS4 expansion
https://git.busybox.net/busybox/commit/?id=eb607777697f4c5eb2dfd86e5837a8c379f65979

ash: fix ignoreeof option
https://git.busybox.net/busybox/commit/?id=0beee209778870888c3a80a9ae57e74888bc8e7b

ash: stopped jobs should only prevent exit from interactive shell
https://git.busybox.net/busybox/commit/?id=50239a665c88f5a95ce41146804500f5da90b19e

ash: let ignoreeof only affect interactive shells
https://git.busybox.net/busybox/commit/?id=5726df5f94f973eaa097d9853ceff2bd6b748d97

 I wish to receive your feedback and I hope you are interested in the porting.

 Best regards,
--
Roberto A. Foglietta
+39.349.33.30.697

--000000000000a9c8cb05cc0c4d45
Content-Type: application/x-patch; 
	name="0003-EXEND-and-EXEXIT-removed.patch"
Content-Disposition: attachment; 
	filename="0003-EXEND-and-EXEXIT-removed.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ktlhvn4a2>
X-Attachment-Id: f_ktlhvn4a2

RnJvbSA0YWU4ZTFhMzVkNjllNTA5MGY4ODJmOTkxOWJiZjliNmViZTI0YWFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiUm9iZXJ0byBBLiBGb2dsaWV0dGEiIDxyb2JlcnRvLmZvZ2xp
ZXR0YUBnbWFpbC5jb20+CkRhdGU6IFdlZCwgMTUgU2VwIDIwMjEgMTM6MzQ6MzQgKzAyMDAKU3Vi
amVjdDogW1BBVENIIDMvM10gRVhFTkQgYW5kIEVYRVhJVCByZW1vdmVkCgotLS0KIHNoZWxsL2Fz
aC5jIHwgMTMgKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zaGVsbC9hc2guYyBiL3NoZWxsL2FzaC5jCmlu
ZGV4IDU0ODE0YWI4OS4uMmZiZjUxZGYwIDEwMDY0NAotLS0gYS9zaGVsbC9hc2guYworKysgYi9z
aGVsbC9hc2guYwpAQCAtNDI4LDggKzQyOCw2IEBAIHN0cnVjdCBnbG9iYWxzX21pc2MgewogCXNt
YWxsaW50IGV4Y2VwdGlvbl90eXBlOyAvKiBraW5kIG9mIGV4Y2VwdGlvbjogKi8KICNkZWZpbmUg
RVhJTlQgMCAgICAgICAgIC8qIFNJR0lOVCByZWNlaXZlZCAqLwogI2RlZmluZSBFWEVSUk9SIDEg
ICAgICAgLyogYSBnZW5lcmljIGVycm9yICovCi0jZGVmaW5lIEVYRU5EIDMgICAgICAgICAvKiBl
eGl0IHRoZSBzaGVsbCAqLwotI2RlZmluZSBFWEVYSVQgNCAgICAgICAgLyogZXhpdCB0aGUgc2hl
bGwgdmlhIGV4aXRjbWQgKi8KIAogCWNoYXIgbnVsbHN0clsxXTsgICAgICAgIC8qIHplcm8gbGVu
Z3RoIHN0cmluZyAqLwogCkBAIC04MzQ2LDcgKzgzNDQsMTEgQEAgc3RhdGljIHZvaWQgc2hlbGxl
eGVjKGNoYXIgKnByb2csIGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwYXRoLCBpbnQgaWR4KQog
CWV4aXRzdGF0dXMgPSBleGVycm5vOwogCVRSQUNFKCgic2hlbGxleGVjIGZhaWxlZCBmb3IgJXMs
IGVycm5vICVkLCBzdXBwcmVzc19pbnQgJWRcbiIsCiAJCXByb2csIGUsIHN1cHByZXNzX2ludCkp
OwotCWFzaF9tc2dfYW5kX3JhaXNlKEVYRU5ELCAiJXM6ICVzIiwgcHJvZywgZXJybXNnKGUsICJu
b3QgZm91bmQiKSk7CisKKwlhc2hfbXNnKG1zZywgIiVzOiAlcyIsIHByb2csIGVycm1zZyhlLCAi
bm90IGZvdW5kIikpOworCWZsdXNoX3N0ZG91dF9zdGRlcnIoKTsKKwlleGl0c2hlbGwoKTsKKwog
CS8qIE5PVFJFQUNIRUQgKi8KIH0KIApAQCAtOTIxMSw3ICs5MjEzLDYgQEAgc3RhdGljIGludCBl
dmFsc3RyaW5nKGNoYXIgKnMsIGludCBmbGFncyk7CiAKIC8qIENhbGxlZCB0byBleGVjdXRlIGEg
dHJhcC4KICAqIFNpbmdsZSBjYWxsc2l0ZSAtIGF0IHRoZSBlbmQgb2YgZXZhbHRyZWUoKS4KLSAq
IElmIHdlIHJldHVybiBub24temVybywgZXZhbHRyZWUgcmFpc2VzIEVYRVhJVCBleGNlcHRpb24u
CiAgKgogICogUGVyaGFwcyB3ZSBzaG91bGQgYXZvaWQgZW50ZXJpbmcgbmV3IHRyYXAgaGFuZGxl
cnMKICAqIHdoaWxlIHdlIGFyZSBleGVjdXRpbmcgYSB0cmFwIGhhbmRsZXIuIFtpcyBpdCBhIFRP
RE8/XQpAQCAtMTQzMjMsNyArMTQzMjQsNyBAQCBleGl0cmVzZXQodm9pZCkKIHsKIAkvKiBmcm9t
IGV2YWwuYzogKi8KIAlpZiAoc2F2ZXN0YXR1cyA+PSAwKSB7Ci0JCWlmIChleGNlcHRpb25fdHlw
ZSA9PSBFWEVYSVQgfHwgZXZhbHNraXAgPT0gU0tJUEZVTkNERUYpCisJCWlmIChldmFsc2tpcCA9
PSBTS0lQRlVOQ0RFRikKIAkJCWV4aXRzdGF0dXMgPSBzYXZlc3RhdHVzOwogCQlzYXZlc3RhdHVz
ID0gLTE7CiAJfQpAQCAtMTQ2MDksNyArMTQ2MTAsNyBAQCBpbnQgYXNoX21haW4oaW50IGFyZ2Mg
VU5VU0VEX1BBUkFNLCBjaGFyICoqYXJndikKIAogCQllID0gZXhjZXB0aW9uX3R5cGU7CiAJCXMg
PSBzdGF0ZTsKLQkJaWYgKGUgPT0gRVhFTkQgfHwgZSA9PSBFWEVYSVQgfHwgcyA9PSAwIHx8IGlm
bGFnID09IDAgfHwgc2hsdmwpIHsKKwkJaWYgKHMgPT0gMCB8fCBpZmxhZyA9PSAwIHx8IHNobHZs
KSB7CiAJCQlleGl0c2hlbGwoKTsKIAkJfQogCi0tIAoyLjI1LjEKCg==
--000000000000a9c8cb05cc0c4d45
Content-Type: application/x-patch; 
	name="0001-fix-a-bug-in-exitcmd-raised-by-Harald-with-s-EXEXIT-.patch"
Content-Disposition: attachment; 
	filename="0001-fix-a-bug-in-exitcmd-raised-by-Harald-with-s-EXEXIT-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ktlhvn330>
X-Attachment-Id: f_ktlhvn330

RnJvbSA4YzdhMzc2MTg0M2NiYmY5NTEwNDYzMDJmYTUyMzZmMzQxZjFlZjQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiUm9iZXJ0byBBLiBGb2dsaWV0dGEiIDxyb2JlcnRvLmZvZ2xp
ZXR0YUBnbWFpbC5jb20+CkRhdGU6IFdlZCwgMTUgU2VwIDIwMjEgMDk6MjY6NDAgKzAyMDAKU3Vi
amVjdDogW1BBVENIIDEvM10gZml4IGEgYnVnIGluIGV4aXRjbWQoKSByYWlzZWQgYnkgSGFyYWxk
IHdpdGgKIHMvRVhFWElUL2V4aXRzaGVsbC8KCi0tLQogc2hlbGwvYXNoLmMgfCAxOCArKysrKysr
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3NoZWxsL2FzaC5jIGIvc2hlbGwvYXNoLmMKaW5kZXggNGJjNGY1
NWQwLi45ZjM1YjAyNjEgMTAwNjQ0Ci0tLSBhL3NoZWxsL2FzaC5jCisrKyBiL3NoZWxsL2FzaC5j
CkBAIC0xMzY0OCwxOSArMTM2NDgsMTUgQEAgZG90Y21kKGludCBhcmdjXyBVTlVTRURfUEFSQU0s
IGNoYXIgKiphcmd2XyBVTlVTRURfUEFSQU0pCiBzdGF0aWMgaW50IEZBU1RfRlVOQwogZXhpdGNt
ZChpbnQgYXJnYyBVTlVTRURfUEFSQU0sIGNoYXIgKiphcmd2KQogeworCWlmIChhcmd2WzFdKQor
CQlleGl0c3RhdHVzID0gbnVtYmVyKGFyZ3ZbMV0pOworCWVsc2UKKwkJZXhpdHN0YXR1cyA9IDA7
CisKIAlpZiAoc3RvcHBlZGpvYnMoKSkKLQkJcmV0dXJuIDA7CisJCXJldHVybiBleGl0c3RhdHVz
OwogCi0JaWYgKGFyZ3ZbMV0pCi0JCXNhdmVzdGF0dXMgPSBudW1iZXIoYXJndlsxXSk7Ci0KLS8v
VE9ETzogdGhpcyBzY3JpcHQKLS8vIHRyYXAgJ2VjaG8gdHJhcDokRlVOQ05BTUUnIEVYSVQKLS8v
IGYoKSB7IGV4aXQ7IH0KLS8vIGYKLS8vcHJpbnRzICJ0cmFwOmYiIGluIGJhc2guIFdlIGNhbiBj
YWxsIGV4aXRzaGVsbCgpIGhlcmUgdG8gYWNoaWV2ZSB0aGlzLgotLy9Gb3Igbm93LCBrZWVwaW5n
IGRhc2ggY29kZToKLQlyYWlzZV9leGNlcHRpb24oRVhFWElUKTsKKwlleGl0c2hlbGwoKTsKIAkv
KiBOT1RSRUFDSEVEICovCiB9CiAKLS0gCjIuMjUuMQoK
--000000000000a9c8cb05cc0c4d45
Content-Type: application/x-patch; 
	name="0002-FUNCNAME-bugfix-with-s-EXEND-exitshell.patch"
Content-Disposition: attachment; 
	filename="0002-FUNCNAME-bugfix-with-s-EXEND-exitshell.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ktlhvn401>
X-Attachment-Id: f_ktlhvn401

RnJvbSA1NjJhMDc2N2RlYzUzZmUyNWUyMzU2MjJjOGQ3MmIyODI2YzFhMTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiUm9iZXJ0byBBLiBGb2dsaWV0dGEiIDxyb2JlcnRvLmZvZ2xp
ZXR0YUBnbWFpbC5jb20+CkRhdGU6IFdlZCwgMTUgU2VwIDIwMjEgMDk6MzI6MDMgKzAyMDAKU3Vi
amVjdDogW1BBVENIIDIvM10gRlVOQ05BTUUgYnVnZml4IHdpdGggcy9FWEVORC9leGl0c2hlbGwv
CgotLS0KIHNoZWxsL2FzaC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc2hlbGwvYXNoLmMgYi9zaGVsbC9hc2guYwpp
bmRleCA5ZjM1YjAyNjEuLjU0ODE0YWI4OSAxMDA2NDQKLS0tIGEvc2hlbGwvYXNoLmMKKysrIGIv
c2hlbGwvYXNoLmMKQEAgLTk0MjcsNyArOTQyNyw3IEBAIGV2YWx0cmVlKHVuaW9uIG5vZGUgKm4s
IGludCBmbGFncykKIAl9CiAJaWYgKGZsYWdzICYgRVZfRVhJVCkgewogIGV4ZXhpdDoKLQkJcmFp
c2VfZXhjZXB0aW9uKEVYRU5EKTsKKwkJZXhpdHNoZWxsKCk7CiAJfQogCiAJcG9wc3RhY2ttYXJr
KCZzbWFyayk7Ci0tIAoyLjI1LjEKCg==
--000000000000a9c8cb05cc0c4d45--
