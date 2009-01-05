From: Sven Mascheck <mascheck@in-ulm.de>
Subject: look up functions per PATH (%func)
Date: Mon, 5 Jan 2009 17:53:58 +0100
Message-ID: <20090105165358.GB28083@lisa.in-ulm.de>
Reply-To: mascheck@in-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.in-ulm.de ([217.10.8.10]:56472 "HELO mail.in-ulm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751231AbZAERAv (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 5 Jan 2009 12:00:51 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

dash still implements the "%func" directory mechanism
as inherited from the original Almquist shell. The shell
searches directories which are flagged with a trailing
"%func" for functions in files with corresponding names:

Let the non-executable file /tmp/myfunction contain
"myfunction(){ echo my function;}"

->  $ PATH=$PATH:/tmp%func  dash
    $ type myfunction
    myfunction is a shell function
    $ myfunction
    my function

The filename must correspond, so that the shell can initially
find a definition; but then all functions from that file are
available.  "%builtin" is the counterpart to make a built-in
override a function again.


With 4.4BSD-Alpha '92, this was removed from the manual, when
it was completely rewritten (starting to implement POSIX).
The code remained untouched, though.  In fact, it seems that
even to date all commonly known ash variants - even busybox -
still implement it.  So it's a rare (if not the only) feature,
for which an almquist shell can be actively tested, that is,
not just by eliminating other shells.  My nostalgic side even
regrets that it is likely to get removed as non-POSIX feature :)

Has anybody ever met scripts making use of this?
Do you know more interesting facts about this?


Cheers, Sven
-- 
http://www.in-ulm.de/~mascheck/various/ash/
