From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Shell source with relative pathname does not work
Date: Sun, 27 Apr 2008 13:18:26 -0700
Message-ID: <4814DF92.9070604@zytor.com>
References: <1209282837.21826.6.camel@aurora.internal>	 <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz> <1209326269.14798.4.camel@aurora.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34017 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399AbYD0USd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 16:18:33 -0400
In-Reply-To: <1209326269.14798.4.camel@aurora.internal>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Bill Maas <bill@stsx.org>
Cc: dash list <dash@vger.kernel.org>

Bill Maas wrote:
> 
> I'm very sorry, but I obviously missed a crucial point here: the shell
> _searches_ the PATH for an executable file to be sourced. I'm still not
> convinced about the need for (and security of) such a feature, however..
> 

POSIX.1:2004:

If file does not contain a slash, the shell shall use the search path 
specified by PATH to find the directory containing file. Unlike normal 
command search, however, the file searched for by the dot utility need 
not be executable. If no readable file is found, a non-interactive shell 
shall abort; an interactive shell shall write a diagnostic message to 
standard error, but this condition shall not be considered a syntax error.

	-hpa
