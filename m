From: Eric Blake <ebb9@byu.net>
Subject: Re: bug with $? after .
Date: Mon, 31 Aug 2009 05:28:39 -0600
Message-ID: <4A9BB3E7.6080409@byu.net>
References: <loom.20090709T210608-909@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta15.emeryville.ca.mail.comcast.net ([76.96.27.228]:35552
	"EHLO QMTA15.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751798AbZHaL2Y (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 31 Aug 2009 07:28:24 -0400
In-Reply-To: <loom.20090709T210608-909@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

According to Eric Blake on 7/9/2009 3:09 PM:
> According to POSIX, the status of . shall be 0 if no command was executed during
> the sourced script.  Therefore, this is a bug:
> 
> $ dash -c 'false; . /dev/null; echo $?'
> 1
> 
> and should be fixed to output 0.

Ping.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
