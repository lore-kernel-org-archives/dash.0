From: Martijn Dekker <martijn@inlv.org>
Subject: [BUG] 'nolog' and 'debug' options cause "$-" to wreak havoc
Date: Wed, 29 Mar 2017 21:02:19 +0200
Message-ID: <5bdf99b4-2bde-3710-c323-25162ace143f@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:60736 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbdC2TBs (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 29 Mar 2017 15:01:48 -0400
Received: from breedzicht.local (inlv.demon.nl [212.238.240.159])
        (authenticated bits=0)
        by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id v2TJ1j3V023515
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <dash@vger.kernel.org>; Wed, 29 Mar 2017 21:01:45 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

Bug: if either the 'nolog' or the 'debug' option is set, trying to
expand "$-" silently aborts parsing of an entire argument.

$ dash -o nolog -c 'set -fuC; echo "|$- are the options|"; \
	set +o nolog; echo "|$- are the options|"'
|
|uCf are the options|
$ dash -o debug -c 'set -fuC; echo "|$- are the options|"; \
	set +o debug; echo "|$- are the options|"'
|
|uCf are the options|

Also, though the 'nolog' option is POSIX[*] and (apart from this bug)
acts like POSIX, it's not documented the dash man page.

- Martijn

[*] "nolog: Prevent the entry of function definitions into the command
history; see Command History List."
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_25_03
