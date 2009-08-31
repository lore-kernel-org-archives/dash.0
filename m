From: Eric Blake <ebb9@byu.net>
Subject: Re: bugs in cd
Date: Mon, 31 Aug 2009 05:28:16 -0600
Message-ID: <4A9BB3D0.30504@byu.net>
References: <loom.20090714T212706-910@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:50520 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751798AbZHaL2B (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 31 Aug 2009 07:28:01 -0400
In-Reply-To: <loom.20090714T212706-910@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

According to Eric Blake on 7/14/2009 3:39 PM:
> For the cd command, POSIX 2008 requires that after all pathnames in CDPATH have 
> been tested and failed in step 5, then step 6 interprets the directory argument 
> relative to PWD.  In other words, this demonstrates a bug:
> 
> $ dash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
> cd: 1: can't cd to foo
> 2
> /tmp
> 
> while bash gets it correct:
> 
> $ bash -c 'cd /tmp; mkdir -p foo; CDPATH=oops; cd foo; echo $?; pwd'
> 0
> /tmp/foo
> 
> Furthermore, POSIX requires that if the element in CDPATH ends in slash, that 
> no additional slashes are added while forming the candidate curpath.  In light 
> of the fact that //home need not be the same directory as /home (and indeed, on 
> cygwin, they are distinct entities), this is also a bug:
> 
> $ dash -c 'CDPATH=/; cd home'
> //home
> $ bash -c 'CDPATH=/; cd home'
> /home

Ping.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
