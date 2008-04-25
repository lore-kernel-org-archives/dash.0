From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: dash race
Date: Fri, 25 Apr 2008 16:39:13 +0400
Message-ID: <4811D0F1.20801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:17230 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760277AbYDYNHX (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 25 Apr 2008 09:07:23 -0400
Received: from dhcp250-148.yandex.ru (dhcp250-148.yandex.ru [87.250.250.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id 7D2DC86818C
	for <dash@vger.kernel.org>; Fri, 25 Apr 2008 16:39:13 +0400 (MSD)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

Greetings!

Sometimes following script is get 99% CPU and will be never
finished. This happens with dash from git. I can't bisect
this because 05c1076 has this problem.

<================================
#!/bin/dash
trap "echo TRAP" USR1
stub() {
	echo ">>> STUB $1" >&2
	sleep $1
	echo "<<< STUB $1" >&2
	kill -USR1 $$
}
stub 3 &
stub 2 &
until { echo "###"; wait; } do
	echo "*** $?"
done
================================>

strace:
12541 wait4(-1, 0xaf87aca0, 0, NULL)    = -1 ECHILD (No child processes)
12541 wait4(-1, 0xaf87aca0, 0, NULL)    = -1 ECHILD (No child processes)
12541 wait4(-1, 0xaf87aca0, 0, NULL)    = -1 ECHILD (No child processes)

-- 
Rgrds, legion
