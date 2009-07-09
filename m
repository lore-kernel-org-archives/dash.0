From: Eric Blake <ebb9@byu.net>
Subject: bug with $? after .
Date: Thu, 9 Jul 2009 21:09:11 +0000 (UTC)
Message-ID: <loom.20090709T210608-909@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:37652 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbZGJBUG (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 9 Jul 2009 21:20:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MP4mQ-0004k4-En
	for dash@vger.kernel.org; Fri, 10 Jul 2009 01:20:02 +0000
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 10 Jul 2009 01:20:02 +0000
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 10 Jul 2009 01:20:02 +0000
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

According to POSIX, the status of . shall be 0 if no command was executed during
the sourced script.  Therefore, this is a bug:

$ dash -c 'false; . /dev/null; echo $?'
1

and should be fixed to output 0.

-- 
Eric Blake


