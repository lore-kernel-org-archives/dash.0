From: Richard Retanubun <richardretanubun@ruggedcom.com>
Subject: /bin/dash -c != /bin/bash -c with pgrep
Date: Tue, 24 Jan 2012 10:51:38 -0500
Message-ID: <4F1ED38A.1050401@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail2.ruggedcom.com ([204.50.148.11]:12965 "EHLO
	mail2.ruggedcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab2AXP7j (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Jan 2012 10:59:39 -0500
Received: from [10.200.21.246] (unknown [10.200.21.246])	by rceng01.eng.lan
 (Postfix) with ESMTP id 4770129A185	for <dash@vger.kernel.org>; Tue, 24 Jan
 2012 10:54:11 -0500 (EST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

my dash version is 0.5.5.1-7.4 (from debian/stable I believe)

I ran these two commands on a system where atftpd is not running and I am getting different results

/bin/dash -c "pgrep -f /usr/sbin/atftpd"; echo $?
-vs-
/bin/bash -c "pgrep -f /usr/sbin/atftpd"; echo $?

The dash version returns the PID of the grep itself and thus always succeeds.
The bash version works as expected.

Sorry if this is an old bug that is already fixed...
Has it been reported? (and fixed?) I saw a patch about the "-c" mode in  but it was reverted...

-- 
Richard Retanubun
