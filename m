From: Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Rergession in readcmd (commit 55c46b7)
Date: Wed, 26 Aug 2009 22:18:02 +0400
Message-ID: <4A957C5A.6090901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mojo.unsafe.ru ([83.222.2.183]:51397 "EHLO mojo.unsafe.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbZHZSVm (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 Aug 2009 14:21:42 -0400
Received: from localhost.localdomain (unknown [77.91.195.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mojo.unsafe.ru (Postfix) with ESMTP id 84495868099
	for <dash@vger.kernel.org>; Wed, 26 Aug 2009 22:21:41 +0400 (MSD)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Greeting!

readcmd put trash in the variables.

Test case:

$ cat /tmp/conf
Include common.conf
FullSpeedCPU yes

$ cat /tmp/z.sh
while read option params; do
  printf '[%s] [%s]\n' "$option" "$params"
done < /tmp/conf

Result:

$ dash /tmp/z.sh
[Include] [common.conf]
[FullSpeedCPU] [yesFnf]

-- 
Rgrds, legion

