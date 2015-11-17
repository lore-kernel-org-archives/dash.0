From: Gioele Barabucci <gioele@svario.it>
Subject: Sourcing an empty files does not reset exit status
Date: Tue, 17 Nov 2015 03:18:53 +0100
Message-ID: <n2e2qe$voq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57436 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbbKQCTC (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 16 Nov 2015 21:19:02 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1ZyVrI-00067f-Jr
	for dash@vger.kernel.org; Tue, 17 Nov 2015 03:19:00 +0100
Received: from x4db5c1ae.dyn.telefonica.de ([77.181.193.174])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 17 Nov 2015 03:19:00 +0100
Received: from gioele by x4db5c1ae.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 17 Nov 2015 03:19:00 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

a bug has been filed in the Debian BTS about dash not resetting the exit 
status after sourcing an empty file with the dot command. [1]

The following test echoes "OK" with bash and "fail" with dash

     #!/bin/sh

     echo > ./empty
     false

     . ./empty && echo "OK" || echo "fail"

A similar bug in dash has been discussed and addressed in 2011 [2], but 
it looks like the solution has been only partial.

The version of dash I tested is the current git master branch, commit 
2e58422.

[1] https://bugs.debian.org/777262
[2] http://article.gmane.org/gmane.comp.shells.dash/531

Regards,

--
Gioele Barabucci <gioele@svario.it>

