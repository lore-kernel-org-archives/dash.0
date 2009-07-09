From: Eric Blake <ebb9@byu.net>
Subject: LINENO status?
Date: Thu, 09 Jul 2009 06:40:26 -0600
Message-ID: <4A55E53A.7020500@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:52485 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760595AbZGIMga (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 9 Jul 2009 08:36:30 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I noticed in the archives a first round patch for adding LINENO support:
http://www.mail-archive.com/dash@vger.kernel.org/msg00059.html

What's holding this up from inclusion?  The lack of LINENO is the biggest
reason why current autoconf-generated configure scripts prefer other
shells over dash, even if they are slower, which then forces the user to
jump through hoops with CONFIG_SHELL to actually experiment with dash
speed on configure scripts.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
