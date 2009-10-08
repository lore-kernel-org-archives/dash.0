From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: 'wait' program does not wait
Date: Thu, 08 Oct 2009 18:18:13 +0400
Message-ID: <4ACDF4A5.3040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:52791 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643AbZJHOS4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Oct 2009 10:18:56 -0400
Received: from localhost.localdomain (dhcp250-217.yandex.ru [87.250.250.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id 8E55B86810D
	for <dash@vger.kernel.org>; Thu,  8 Oct 2009 18:18:15 +0400 (MSD)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

Greetings!

'wait' does not wait for all jobs and return a non-zero exit status.

According dash(1):

wait [job]
Wait for the specified job to complete and return the exit status
of the last process in the job. If the argument is omitted, wait
for all jobs to complete and the return an exit status of zero.

$ cat test.sh
#!/bin/dash
func() {
	sleep $1
	echo "func($1)"
}
func 1 &
func 2 &
func 3 &
wait

$ dash ./test.sh; echo "after rc=$?"
func(1)
after rc=145
func(2)
func(3)

$ bash ./test.sh; echo "after rc=$?"
func(1)
func(2)
func(3)
after rc=0

-- 
Rgrds, legion

