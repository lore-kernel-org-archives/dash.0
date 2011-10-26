From: Stephane CHAZELAS <stephane_chazelas@yahoo.fr>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Wed, 26 Oct 2011 07:59:06 +0000 (UTC)
Message-ID: <slrnjaffea.cpd.stephane.chazelas@spam.is.invalid>
References: <1319579884-423-1-git-send-email-vapier@gentoo.org>
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44070 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827Ab1JZIFM (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 Oct 2011 04:05:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1RIyU0-0003JL-To
	for dash@vger.kernel.org; Wed, 26 Oct 2011 10:05:08 +0200
Received: from 188-223-3-27.zone14.bethere.co.uk ([188.223.3.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 26 Oct 2011 10:05:08 +0200
Received: from stephane_chazelas by 188-223-3-27.zone14.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Wed, 26 Oct 2011 10:05:08 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2011-10-25, 17:58(-04), Mike Frysinger:
> POSIX states that octal escape sequences should take the form \0num
> when using echo.

Only with the XSI option (Unix), for POSIX, echo "\whatever" is
unspecified. But as far as I can tell even with XSI, "echo
'\123'" is unspecified as well, so dash is free to do what it
likes here.

> dash however additionally treats \num as an octal
> sequence.  This breaks some packages (like libtool) who attempt to
> use strings with these escape sequences via variables to execute sed
> (since sed ends up getting passed a byte instead of a literal \1).

Given that the result of  

echo "\123" is unspecified, those scripts would not be POSIX and
they are those to be fixed.

-- 
Stephane

