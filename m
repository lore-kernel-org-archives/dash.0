Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FCBC433F5
	for <linux-dash@archiver.kernel.org>; Wed, 12 Jan 2022 16:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355212AbiALQbG (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 12 Jan 2022 11:31:06 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:63743 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355210AbiALQbG (ORCPT
        <rfc822;dash@vger.kernel.org>); Wed, 12 Jan 2022 11:31:06 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C976F6238B6
        for <dash@vger.kernel.org>; Wed, 12 Jan 2022 16:25:55 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 012766238D9
        for <dash@vger.kernel.org>; Wed, 12 Jan 2022 16:25:54 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.114.196.230 (trex/6.4.3);
        Wed, 12 Jan 2022 16:25:55 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Slimy-Trouble: 05b0301e54ae3f96_1642004755534_864099100
X-MC-Loop-Signature: 1642004755534:419285673
X-MC-Ingress-Time: 1642004755534
Received: from ppp-88-217-46-204.dynamic.mnet-online.de ([88.217.46.204]:32794 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1n7gRY-0003EY-VL
        for dash@vger.kernel.org; Wed, 12 Jan 2022 16:25:53 +0000
Message-ID: <09fd70edcf08c75b4f9f2e158e3e6c0832d35d90.camel@scientia.org>
Subject: possible wrong behaviour with patterns using a quoted ^ at the
 start of a bracket expression
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     dash@vger.kernel.org
Date:   Wed, 12 Jan 2022 17:25:47 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hey.


I recently got some big deal of help from the people at the help-bash
mailing list when I've tried to understand what POSIX mandates with
respect to pattern matching (that is in the sense of [0], not
Basic/Extended Regular Expressions).

I'm still not so sure whether I understand it exactly by the wording of
POSIX itself (which seems a bit odd to me), but what people
explained[1] me at help-bash - and I hope I explain it correctly - is:

In the patterns, even in a bracket expression in a pattern, there may
be quoting (with double and single quotes), and - and this is key -
anything that is quoted is already taken literal with respect to the
pattern.

So when one has e.g. a case compound command:
case $foo in
	(['*?'])
...
is already the literal * and ? within a pattern's bracket expression.


Further, POSIX says:
"If an open bracket introduces a bracket expression as in XBD RE
Bracket Expression, except that the <exclamation-mark> character ( '!'
) shall replace the <circumflex> character ( '^' ) in its role in a
non-matching list in the regular expression notation, it shall
introduce a pattern bracket expression. A bracket expression starting
with an unquoted <circumflex> character produces unspecified results.
Otherwise, '[' shall match the character itself."



I found not the following probably wrong behaviour of dash and busybox'
sh:




$ cat circumflex-test 
case "$1" in
(['^.a'])
 echo match
 ;;
(*)
 echo else
esac


$ cat exclamation-test 
case "$1" in
(['!.a'])
 echo match
 ;;
(*)
 echo else
esac


$ cat run-circumflex 
echo dash:
dash circumflex-test ^
dash circumflex-test .
dash circumflex-test a

echo busybox-sh:
busybox sh circumflex-test ^
busybox sh circumflex-test .
busybox sh circumflex-test a

echo bash:
bash circumflex-test ^
bash circumflex-test .
bash circumflex-test a

echo klibc-sh:
/usr/lib/klibc/bin/sh circumflex-test ^
/usr/lib/klibc/bin/sh circumflex-test .
/usr/lib/klibc/bin/sh circumflex-test a


$ cat run-exlamation 
echo dash:
dash exclamation-test '!'
dash exclamation-test .
dash exclamation-test a

echo busybox-sh:
busybox sh exclamation-test '!'
busybox sh exclamation-test .
busybox sh exclamation-test a

echo bash:
bash exclamation-test '!'
bash exclamation-test .
bash exclamation-test a

echo klibc-sh:
/usr/lib/klibc/bin/sh exclamation-test '!'
/usr/lib/klibc/bin/sh exclamation-test .
/usr/lib/klibc/bin/sh exclamation-test a




When run:
$ sh run-circumflex | paste - - - - | column -t
dash: match else else
busybox-sh: match else else
bash: match match match
klibc-sh: match match match
$
 ^ . a


$ sh run-exlamation | paste - - - - | column -t
dash: match match match
busybox-sh: match match match
bash: match match match
klibc-sh: match match match
$
 ! . a


The results for the run-circumflex seem pretty odd.
Apparently, the ^ is taken literally, but the other two are negated.

$ dash circumflex-test b
match
$ busybox sh circumflex-test b
match

match again (which, AFAIU, they should not).

While POSIX does say:
"A bracket expression starting with an unquoted <circumflex> character
produces unspecified results."
... the circumflex *is* quoted above...


I haven't verified any further unusual patterns like ['$var'] vs.
["$var"], so maybe an eye should be kept open, whether there could be
any issues as well.


Thanks,
Chris.

PS: For reference, the bug[2] I've opened at BusyBox.



[0] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13
[1] https://lists.gnu.org/archive/html/help-bash/2022-01/msg00000.html
[2] https://bugs.busybox.net/show_bug.cgi?id=14516

