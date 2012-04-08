From: Jim Pryor <dubiousjim@gmail.com>
Subject: local var=$(cat) only reads one line
Date: Sun, 08 Apr 2012 18:09:06 -0400
Message-ID: <1333922946.15345.140661059835993.31129B93@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53587 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755479Ab2DHWJH (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 8 Apr 2012 18:09:07 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7E5F921644
	for <dash@vger.kernel.org>; Sun,  8 Apr 2012 18:09:06 -0400 (EDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi, I'm not a subscriber to this list and am not sure where's the best
place to report this bug. A cursory search didn't find other reports of
the same issue; but I can imagine there may well be such. If so, excuse
the noise. I'm just trying to help.

I notice the following issue in the version of dash that's bundled in a
recent release of finnix (not sure which one, but the kernel version is
3.0.6, so it's probably finnix 103, released 23 October 2011). I also
see it in the FreeBSD sh, from a FreeBSD-9 release candidate I compiled
in January. I know that's not dash, but I understand the codebases are
closely related. Neither of these are my active systems; hence the fuzzy
details.

Here is a testcase:

#!/bin/dash

test1() {
    local IN=$(cat)
    printf "test1 <%s>\n" "$IN"
}

test2() {
    local IN="$(cat)"
    printf "test2 <%s>\n" "$IN"
}

test3() {
    IN=$(cat)
    printf "test3 <%s>\n" "$IN"
}

test4() {
    IN=$(cat)
    printf "test4 <%s>\n" "$IN"
}

MSG=$(printf "abc\ndef\nghi")

printf "%s" "$MSG" | test1
printf "%s" "$MSG" | test2
printf "%s" "$MSG" | test3
unset IN
printf "%s" "$MSG" | test4

#######

The weird bit only shows up in test1: IN will only be assigned the first
line of stdin.

Hope this helps someone.
-- 
dubiousjim@gmail.com

