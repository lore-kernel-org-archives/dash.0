From: Adam Kellas <Adam.Kellas@gmail.com>
Subject: dash -n and -v not implemented?
Date: Mon, 23 Aug 2010 15:47:39 -0400
Message-ID: <i4uj8q$ah3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:43614 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab0HWUKF (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 16:10:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1OndLH-0006wO-5m
	for dash@vger.kernel.org; Mon, 23 Aug 2010 22:10:03 +0200
Received: from c-76-24-28-236.hsd1.ma.comcast.net ([76.24.28.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 23 Aug 2010 22:10:03 +0200
Received: from Adam.Kellas by c-76-24-28-236.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 23 Aug 2010 22:10:03 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Am I missing something, or do the -n and -v flags have no effect? The 
following compares the behavior of bash, ksh, and dash (bash requires an 
extra flag to suppress startup files):

% ksh -v -n -c uname
uname

% bash --norc -v -n uname
uname

% dash -v -n -c uname
Linux

AK


