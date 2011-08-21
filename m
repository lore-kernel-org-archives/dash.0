From: Paul Gilmartin <PaulGBoulder@aim.com>
Subject: set -o vi
Date: Sun, 21 Aug 2011 10:01:24 -0600
Message-ID: <9AD96B5F-3C88-4E01-9582-B75184164026@aim.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58758 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647Ab1HUQBi convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 21 Aug 2011 12:01:38 -0400
Received: from imr-da03.mx.aol.com (imr-da03.mx.aol.com [205.188.105.145])
	by hera.kernel.org (8.14.4/8.14.3) with ESMTP id p7LG1a1I026880
	for <dash@vger.kernel.org>; Sun, 21 Aug 2011 16:01:37 GMT
Received: from mtaout-ma01.r1000.mx.aol.com (mtaout-ma01.r1000.mx.aol.com [172.29.41.1])
	by imr-da03.mx.aol.com (8.14.1/8.14.1) with ESMTP id p7LG1XtL011748
	for <dash@vger.kernel.org>; Sun, 21 Aug 2011 12:01:33 -0400
Received: from [192.168.0.3] (75-166-241-37.hlrn.qwest.net [75.166.241.37])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mtaout-ma01.r1000.mx.aol.com (MUA/Third Party Client Interface) with ESMTPSA id D5A97E0001A0
	for <dash@vger.kernel.org>; Sun, 21 Aug 2011 12:01:30 -0400 (EDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

(Damn! I clicked the wrong link in the confirmation notice.
Apologies.)

For some time now, on both Ubuntu and Cygwin, "set -o vi"
is ineffective.

The command is accepted and a query indicates it's in effect:

\! $ uname -a
Linux Linux-Mac 2.6.38-11-generic #48-Ubuntu SMP Fri Jul 29 19:05:14 UTC 2011 i686 i686 i386 GNU/Linux
\! $ set -o vi
\! $ set -o
Current option settings
    ...
vi              on
emacs           off
    ...

But when I press ESC to enter command history, it simply
echoes the ESC as "^[" and calls the next command illegal:

\! $ ^[
dash:  not found

Thanks,
gil

