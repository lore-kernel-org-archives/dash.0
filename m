From: Stephane CHAZELAS <stephane_chazelas@yahoo.fr>
Subject: Re: Dashhh
Date: Thu, 17 Nov 2011 20:11:59 +0000 (UTC)
Message-ID: <slrnjcaqkf.lrr.stephane.chazelas@spam.is.invalid>
References: <4EC53397.2030005@am-anger-1.de>
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:38813 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162Ab1KQUMN (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 17 Nov 2011 15:12:13 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1RR8Jg-0006r0-FJ
	for dash@vger.kernel.org; Thu, 17 Nov 2011 21:12:12 +0100
Received: from 188-223-3-27.zone14.bethere.co.uk ([188.223.3.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 17 Nov 2011 21:12:12 +0100
Received: from stephane_chazelas by 188-223-3-27.zone14.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 17 Nov 2011 21:12:12 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2011-11-17, 17:17(+01), Heiko Gerstung:
[...]
> 1. The usual "[[" and "==" stuff (pretty easy to change, thank you sed)
> 2. shift returns with a critical error when no arguments are left (no really good solution found)

[ "$#" -eq 0 ] || shift

> 3. $[] arithmetic stuff not working (OK, worked around that with bc)

$((...))

> 4. The bash FUNCNAME variable was very valuable for debugging purposes and is nonexistent in dash


If your functions are written as

f() {
  ...
}

sed 's/^[[:blank:]]*\([^[:blank:]]*\)[[:blank:]]*()[[:blank:]]*{/& local FUNCNAME=\1;/'

-- 
Stephane

