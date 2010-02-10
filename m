From: Eric Blake <ebb9@byu.net>
Subject: test -x should use faccessat, not stat
Date: Wed, 10 Feb 2010 15:32:30 +0000 (UTC)
Message-ID: <loom.20100210T162915-629@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57859 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab0BJPdA (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Feb 2010 10:33:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1NfEYk-0000k5-11
	for dash@vger.kernel.org; Wed, 10 Feb 2010 16:32:58 +0100
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 10 Feb 2010 16:32:58 +0100
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 10 Feb 2010 16:32:58 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This report was originally raised on the cygwin list:

http://cygwin.com/ml/cygwin/2010-02/msg00239.html

In short, in the presence of ACLs, dash's implementation of test -r, test -w, 
and test -x gives incorrect answers, when the current user has permissions to 
access a file that were granted by ACLs but not by the current stat() 
permissions.  dash should be using faccessat(,AT_EACCESS) (or 
eaccess/euidaccess) if available, rather than stat(), to determine whether a 
file is accessible.

-- 
Eric Blake


