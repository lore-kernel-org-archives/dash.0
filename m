From: Gioele Barabucci <gioele@svario.it>
Subject: Dash only reads the first character from pipe (bash reads whole line)
Date: Sat, 14 Nov 2015 00:24:06 +0100
Message-ID: <n25ren$pf5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54388 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbbKMXZH (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 13 Nov 2015 18:25:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1ZxNiK-0005xw-N7
	for dash@vger.kernel.org; Sat, 14 Nov 2015 00:25:04 +0100
Received: from x5ce483de.dyn.telefonica.de ([92.228.131.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Sat, 14 Nov 2015 00:25:04 +0100
Received: from gioele by x5ce483de.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Sat, 14 Nov 2015 00:25:04 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

a 6 year old Debian bug [1] describes a problem with reading from pipes 
that is still present in the current dash version (I tested up to git 
commit 7062c78).

The following test, by the original reporter, shows the problem

 > The 'read' command seems to only read the first character and not the 
 > whole line.
 >
 > Example / comparison with bash:
 >
 > # /bin/dash
 > # sudo modprobe nf_conntrack
 > # read MAX </proc/sys/net/netfilter/nf_conntrack_max
 > # echo $MAX
 > 2
 >
 > # /bin/bash
 > # read MAX </proc/sys/net/netfilter/nf_conntrack_max
 > # echo $MAX
 > 262144

It this a known problem? Are there workarounds?

Regards,

[1] https://bugs.debian.org/547902

--
Gioele Barabucci <gioele@svario.it>

