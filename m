From: Dan Muresan <danmbox@gmail.com>
Subject: jobs in scripts?
Date: Tue, 8 Mar 2011 21:02:30 +0200
Message-ID: <AANLkTinDKV9uCZQPhh8LtX9fAwYix0+9bP5LTXAuSCAL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60229 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab1CHTCc (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Mar 2011 14:02:32 -0500
Received: by bwz15 with SMTP id 15so97231bwz.19
        for <dash@vger.kernel.org>; Tue, 08 Mar 2011 11:02:30 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi, is the following normal? With set -m the problem disappears; bash
& ksh don't need set -m.

SUSv3 doesn't say job control is to be disabled completely unless "set
-m" is active. And, if job control *is* disabled, why does "job"
report a non-empty list?

0.5.5.1-3ubuntu2 on Ubuntu 10.04 here.

---

$ cat x
#set -m
sleep 100 &
echo "Before kill:"; jobs -l
kill -s TERM %1
sleep 0.5
echo "After kill:"; jobs -l
pidof sleep



$ dash x
Before kill:
[1] + 18775 Running
kill: 4: No such process

After kill:
[1] + 18775 Running
18775


-- Dan
