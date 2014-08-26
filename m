From: Oleg Bulatov <oleg@bulatov.me>
Subject: Line continuation and variables
Date: Tue, 26 Aug 2014 16:15:04 +0400
Message-ID: <1554581409055304@web13g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from forward16.mail.yandex.net ([95.108.253.141]:51360 "EHLO
	forward16.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbaHZMZT (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 26 Aug 2014 08:25:19 -0400
Received: from web13g.yandex.ru (web13g.yandex.ru [95.108.252.113])
	by forward16.mail.yandex.net (Yandex) with ESMTP id 367D7D21487
	for <dash@vger.kernel.org>; Tue, 26 Aug 2014 16:15:05 +0400 (MSK)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi!

While playing with sh generators I found that dash and bash have different
interpretations for <slash><newline> sequence.

$ dash -c 'EDIT=xxx; echo $EDIT\
> OR'
xxxOR
$ bash -c 'EDIT=xxx; echo $EDIT\
OR'
/usr/bin/vim

$ dash -c 'echo "$\
(pwd)"'
$(pwd)

Is it undefined behaviour in POSIX?

-- 
WBR, Oleg Bulatov
