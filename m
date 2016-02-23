From: Oleg Bulatov <oleg@bulatov.me>
Subject: heredoc and subshell
Date: Wed, 24 Feb 2016 01:07:44 +0300
Message-ID: <2978711456265264@web9h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from forward11h.cmail.yandex.net ([87.250.230.153]:51272 "EHLO
	forward11h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755476AbcBWWQg (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 23 Feb 2016 17:16:36 -0500
Received: from web9h.yandex.ru (web9h.yandex.ru [84.201.186.38])
	by forward11h.cmail.yandex.net (Yandex) with ESMTP id 6592C20DE0
	for <dash@vger.kernel.org>; Wed, 24 Feb 2016 01:07:48 +0300 (MSK)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

trying to minimize a shell code I found an unobvious moment with heredocs and subshells.

Is it specified by POSIX how next code should be parsed? dash output for this code differs from bash and zsh.

--- code
prefix() { sed -e "s/^/$1:/"; }
DASH_CODE() { :; }

prefix A <<XXX && echo "$(prefix B <<XXX
echo line 1
XXX
echo line 2)" && prefix DASH_CODE <<DASH_CODE
echo line 3
XXX
echo line 4)"
echo line 5
DASH_CODE

--- bash 4.3.42 output:
A:echo line 3
B:echo line 1
line 2
DASH_CODE:echo line 4)"
DASH_CODE:echo line 5

--- dash 0.5.8 output:
A:echo line 1
B:echo line 2)" && prefix DASH_CODE <<DASH_CODE
B:echo line 3
line 4
line 5

-- 
Oleg
