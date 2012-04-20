From: Marc Glisse <marc.glisse@inria.fr>
Subject: wait and ctrl+Z
Date: Fri, 20 Apr 2012 13:31:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1204201316550.2583@laptop-mg.saclay.inria.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <dash-owner@vger.kernel.org>
Received: from mail4-relais-sop.national.inria.fr ([192.134.164.105]:3539 "EHLO
	mail4-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752781Ab2DTLbn (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 20 Apr 2012 07:31:43 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I noticed a strange behavior of "wait" when I suspend and resume a script.

$ cat a.sh
#!/bin/dash
(sleep 7; echo blah) &
(sleep 7; echo bloh) &
wait ; echo coucou
$ ./a.sh
^Z
zsh: suspended  ./a.sh
$ fg
[1]  + continued  ./a.sh
coucou
$ blah
bloh

As you can see, the instruction after "wait" was executed immediatly on 
resume, without waiting for the jobs.

If I replace the ';' after "wait" by "&&" and do the same suspend+resume, 
"coucou" is never printed.

I am using dash version 0.5.7-3 in debian testing.

-- 
Marc Glisse
