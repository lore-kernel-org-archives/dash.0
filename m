From: Eric Blake <ebb9@byu.net>
Subject: bugs in cd
Date: Tue, 14 Jul 2009 21:39:03 +0000 (UTC)
Message-ID: <loom.20090714T212706-910@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:57541 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbZGNVjQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 14 Jul 2009 17:39:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MQpiV-0002Eb-Kc
	for dash@vger.kernel.org; Tue, 14 Jul 2009 21:39:15 +0000
Received: from l3-128-170-36-102.l-3com.com ([128.170.36.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 14 Jul 2009 21:39:15 +0000
Received: from ebb9 by l3-128-170-36-102.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 14 Jul 2009 21:39:15 +0000
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

For the cd command, POSIX 2008 requires that after all pathnames in CDPATH have 
been tested and failed in step 5, then step 6 interprets the directory argument 
relative to PWD.  In other words, this demonstrates a bug:

$ dash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
cd: 1: can't cd to foo
2
/tmp

while bash gets it correct:

$ bash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
0
/tmp/foo

Furthermore, POSIX requires that if the element in CDPATH ends in slash, that 
no additional slashes are added while forming the candidate curpath.  In light 
of the fact that //home need not be the same directory as /home (and indeed, on 
cygwin, they are distinct entities), this is also a bug:

$ dash -c 'CDPATH=/; cd home'
//home
$ bash -c 'CDPATH=/; cd home'
/home

-- 
Eric Blake


