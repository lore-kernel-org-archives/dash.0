From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: command substitutions in $PS4
Date: Mon, 17 Nov 2014 21:49:32 +0000
Message-ID: <20141117214931.GA4601@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41670 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbaKQVuO (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 17 Nov 2014 16:50:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1XqUBZ-00034G-0p
	for dash@vger.kernel.org; Mon, 17 Nov 2014 22:50:13 +0100
Received: from 5ec33b79.skybroadband.com ([94.195.59.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 17 Nov 2014 22:50:13 +0100
Received: from stephane.chazelas by 5ec33b79.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 17 Nov 2014 22:50:13 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello.

[tested on current git head
f6d4def4e27b13fab174e948b94cd10550d3e10e]

Command substitution doesn't seem to work in $PS4 (used for
xtrace prompt):

$ PS4='$(date +%T)> ' dash -xc :
dash: 1: Syntax error: end of file unexpected (expecting ")")

And with the old syntax:

$ PS4='`date +%T`> ' dash -xc :
> :

And with more than one command:

$ PS4='`date +%T`> ' dash -xc ':;:'
> :

dash doesn't return and seems to go in a forking loop,
presumably because the `date` there triggers another PS4
expansion and so on recursively

If I prevent the recursion with:

--- a/src/eval.c
+++ b/src/eval.c
@@ -776,7 +776,15 @@ evalcommand(union node *cmd, int flags)
 		int sep;
 
 		out = &preverrout;
+
+		/*
+		 * reset xflag temporarily for command substitutions performed
+		 * upon $PS4 expansion
+		 */
+		xflag = 0;
 		outstr(expandstr(ps4val()), out);
+		xflag = 1;
+
 		sep = 0;
 		sep = eprintlist(out, varlist.list, sep);
 		eprintlist(out, arglist.list, sep);

$ PS4='`date +%T`> ' ./src/dash -xc ':;sleep 1; date'
> :
21:43:47> sleep 1
21:43:48> date
Mon Nov 17 21:43:48 GMT 2014

The command substitution still fails upon the first expansion
only. I quickly gave up trying to find out why as I found the
code there hard to follow.

-- 
Stephane



