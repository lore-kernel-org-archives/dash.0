From: bd@bc-bd.org
Subject: How to pass parameters containig options from variables
Date: Tue, 25 Sep 2012 10:47:29 +0200
Message-ID: <20120925084729.GG17149@bc-bd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.bc-bd.org ([88.217.195.190]:47934 "EHLO bc-bd.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab2IYJIM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 25 Sep 2012 05:08:12 -0400
Received: from bd by bc-bd.org with local (Exim 4.72)
	(envelope-from <bd@bc-bd.org>)
	id 1TGQni-0004az-2X
	for dash@vger.kernel.org; Tue, 25 Sep 2012 10:47:30 +0200
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello list,

I am trying to pass these arguments

	-N -p -F "not host foo"

to a binary, but

	ARGS="-N -p -F 'not host foo'"
	$DAEMON $ARGS

get's passed as 6 arguments and not 4.

Using xargs this works, but I'd like to not introduce that dependency:

	ARGS="-N -p -F 'not host foo'"
	echo $ARGS | xargs $DAEMON

Now for the complete picture, it's the init script for arpwatch. Options that
should be passed to arpwatch can be specified by the sysadm in
/etc/default/arpwatch with is sourced by the initscript and then passed (via
start-stop-daemon) to the arpwatch binary.

This is on debian stable, package version 0.5.5.1-7.4

	Stefan
-- 
Reader, suppose you were an idiot.  And suppose you were a member of
Congress.  But I repeat myself.
		-- Mark Twain
