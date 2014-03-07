From: Jason Miller <jason@milr.com>
Subject: Re: command lookup and POSIX
Date: Fri, 7 Mar 2014 14:48:21 -0800
Message-ID: <20140307224821.GA22435@home.jasonmmiller.org>
References: <20140307194318.GA2317@home.jasonmmiller.org>
 <531A3FE2.8050109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:37224 "EHLO
	fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbaCGWsz (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 7 Mar 2014 17:48:55 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20140307224855.LZWH16857.fed1rmfepo201.cox.net@fed1rmimpo209>
          for <dash@vger.kernel.org>; Fri, 7 Mar 2014 17:48:55 -0500
Content-Disposition: inline
In-Reply-To: <531A3FE2.8050109@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On 14:53 Fri 07 Mar     , Eric Blake wrote:
> On 03/07/2014 12:43 PM, Jason Miller wrote:
> > Reading this:
> > 
> > http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_09_01_01
> > 
> > Any built-in other than the special built-ins, or listed in the table
> > there should not be run unless it is present in the PATH.
> > 
> > dash however doesn't follow that:
> > 
> > PS1="% " dash
> > 
> >     % PATH=
> 
> Stop right there.
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08
> 
> "If PATH is unset or is set to null, the path search is
> implementation-defined."
> 
> Therefore, you have triggered implementation-defined behavior, rather
> than exposing a bug in dash.
Okay same question with PATH=/foo (dash's behavior is the same)

