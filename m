From: Guido Berhoerster <guido+kernel.org@berhoerster.name>
Subject: trap bug in recent versions of dash
Date: Wed, 11 Aug 2010 10:06:16 +0200
Message-ID: <20100811080616.GA18303@wopr.local.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([83.169.16.167]:37100 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab0HKILr (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Aug 2010 04:11:47 -0400
Received: from wopr.local.invalid (p57B5B28B.dip.t-dialin.net [87.181.178.139])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id BCCE6A3F812E
	for <dash@vger.kernel.org>; Wed, 11 Aug 2010 10:01:55 +0200 (CEST)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

with the latest git version of dash trap actions are not
evaluated in the context of a function.

The following script demonstrates the bug:
----8<----
read_timeout () {
    saved_traps="$(trap)"
    trap 'printf "timed out\n"; eval "${saved_traps}"; return' TERM
    ( sleep $1; kill -TERM $$ ) >/dev/null 2>&1 &
    timer_pid=$!
    read $2
    kill $timer_pid 2>/dev/null
}

read_timeout 5 value
printf "read \"%s\"\n" "${value:=default}"

---->8----
The return statement in the trap inside the read_timeout function
does not return from the function but rather exits the script.

With dash 0.5.5.1 it works as expected.
-- 
Guido Berhoerster
