From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: stalls whenever PS4 contains $() and set -x
Date: Mon, 25 May 2020 09:41:15 -0400
Message-ID: <20200525134115.GO423431@lena.dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <dash-owner@vger.kernel.org>
Received: from washoe.dartmouth.edu ([129.170.30.229]:49452 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403849AbgEYOZm (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 25 May 2020 10:25:42 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Kyle Meyer <kyle@kyleam.com>

Dear DASH maintainer(s),

I like to (ab)use PS4 and set -x for tracing execution of scripts.
Reporting time and PID is very useful in this context.

I am not 100% certain if bash's behavior (of actually running the command
embedded within PS4 string, probably eval'ing it) is actually POSIX
compliant, posh seems to not do that; but I think it is definitely not
desired for dash to just stall:

- the script:

#!/bin/sh
set -x
export PS4='+ $(date +%T.%N) [$$] '

echo "lets go"
sleep 1
echo "done $var"

- bash:

/tmp > bash --posix test.sh 
+export 'PS4=+ $(date +%T.%N) [$$] '
+PS4='+ $(date +%T.%N) [$$] '
+ 09:15:48.982296333 [2764323] echo 'lets go'
lets go
+ 09:15:48.987829613 [2764323] sleep 1
+ 09:15:49.994485037 [2764323] echo 'done '
done 


- posh:
exit:130 /tmp > posh test.sh
+export PS4=+ $(date +%T.%N) [$$] 
+ $(date +%T.%N) [$$] echo lets go
lets go
+ $(date +%T.%N) [$$] sleep 1
+ $(date +%T.%N) [$$] echo done 
done 

- dash: (stalls it set -x)

/tmp > dash test.sh        
+export PS4=+ $(date +%T.%N) [$$] 
^C^C

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
