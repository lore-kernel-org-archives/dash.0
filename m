From: Bill Maas <bill@stsx.org>
Subject: Shell source with relative pathname does not work
Date: Sun, 27 Apr 2008 09:53:57 +0200
Message-ID: <1209282837.21826.6.camel@aurora.internal>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:2251 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYD0IAt (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 04:00:49 -0400
Received: from [192.168.1.6] (stsx.xs4all.nl [213.84.238.115])
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id m3R7rvaM093527
	for <dash@vger.kernel.org>; Sun, 27 Apr 2008 09:54:02 +0200 (CEST)
	(envelope-from bill@stsx.org)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi folks,

since I couldn't figure out how to join the Dash mailing list I'm
posting this message directly to dash@vger.kernel.org , and I just hope
it will arrive properly.

First my compliments for the excellent work you are doing: I used to
believe that slowness was just another shell feature.

I possibly found a bug in Dash:

. x.conf
.: 1: x.conf: not found

The source fails, even though x.conf is definitely there. The following
variants do succeed:

. /path/to/x.conf
. ./x.conf

Well, that's all. Clear enough I guess. Keep up the good work.

Bill

