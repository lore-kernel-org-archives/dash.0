From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: Invalid signal used with trap causes dash to abort
Date: Wed, 24 Feb 2010 11:23:34 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC73EBD7D0507@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from krynn.se.axis.com ([193.13.178.10]:37396 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756442Ab0BXKpF convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 24 Feb 2010 05:45:05 -0500
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o1OANaVE006551
	for <dash@vger.kernel.org>; Wed, 24 Feb 2010 11:23:36 +0100
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Hi,

there seems to be a problem  with the trap implementation in dash
(tested with 0.5.4 and 0.5.5.1). If I specify a signal which is not 
supported, the shell unconditionally aborts. E.g., I had expected
the following to print foo (like bash and zsh do):

# dash -c 'trap "echo trap executed" UNKNOWNSIGNAL || echo "foo"'
trap: 1: UNKNOWNSIGNAL: bad trap

This means I cannot write a construct like the following to take 
advantage of the ERR signal which is present in some shells:

trap "echo ERR trap executed" ERR 2>/dev/null || :

I also checked the POSIX documentation, and quoting from
http://www.opengroup.org/onlinepubs/009695399/utilities/trap.html
(exit status): "For both interactive and non-interactive shells, 
invalid signal names [XSI] [Option Start] or numbers [Option End] 
shall not be considered a syntax error and do not cause the shell 
to abort."

Best regards,
//Peter

