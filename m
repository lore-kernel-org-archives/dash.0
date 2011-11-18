From: Stephane CHAZELAS <stephane_chazelas@yahoo.fr>
Subject: Re: Dashhh
Date: Fri, 18 Nov 2011 08:18:04 +0000 (UTC)
Message-ID: <slrnjcc55s.5b4.stephane.chazelas@spam.is.invalid>
References: <4EC53397.2030005@am-anger-1.de>
 <slrnjcaqkf.lrr.stephane.chazelas@spam.is.invalid>
 <4EC570B3.7040408@redhat.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59025 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab1KRISU (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 18 Nov 2011 03:18:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1RRJeN-00054R-Qq
	for dash@vger.kernel.org; Fri, 18 Nov 2011 09:18:19 +0100
Received: from 188-223-3-27.zone14.bethere.co.uk ([188.223.3.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 18 Nov 2011 09:18:19 +0100
Received: from stephane_chazelas by 188-223-3-27.zone14.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 18 Nov 2011 09:18:19 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2011-11-17, 13:38(-07), Eric Blake:
[...]
>> sed 's/^[[:blank:]]*\([^[:blank:]]*\)[[:blank:]]*()[[:blank:]]*{/& loca=
> l FUNCNAME=3D\1;/'
>
> Except that 'local' is not part of POSIX, so while this conversion may
> work for dash, it's not a portable catch-all for other compliant shells.
[...]

Though "local" is in LSB, so supported by sh implementations on
Linux. Which is probably why even posh supports it. However LSB
only supports:

local var
var=value

Not

local var=value

-- 
Stephane

