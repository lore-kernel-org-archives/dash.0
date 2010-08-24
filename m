From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [Partial patch] IFS and read builtin
Date: Wed, 25 Aug 2010 01:40:06 +0200
Message-ID: <4C745856.6000105@gigawatt.nl>
References: <4C71A29C.1080609@gigawatt.nl> <20100822230003.GB49760@stack.nl> <4C71BAB5.1030504@gigawatt.nl> <20100823193510.GA67671@stack.nl> <4C72FB83.5070206@gigawatt.nl> <20100824225138.GB79263@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from cp1107341-a.dbsch1.nb.home.nl ([84.31.115.1]:44753 "EHLO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934071Ab0HXXiH (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 24 Aug 2010 19:38:07 -0400
In-Reply-To: <20100824225138.GB79263@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On 25/08/10 00:51, Jilles Tjoelker wrote:
> Yes, I think that's the proper way to implement LINENO.
> 
> FreeBSD sh avoids extending the nodes by detecting expansions of LINENO
> at parse time and storing the line number at that time. However, this is
> only possible because it does not print a line number when there is an
> error in a builtin.

I'm curious to try to see how FreeBSD sh handles eval 'echo $LINENO',
then. This will be a nice excuse to give it another try.

> POSIX.1-2008 (aka SUSv4) says, at one point, that the shell shall "use
> the delimiters as field terminators".
[...]

Ah! So something _was_ wrong -- the standard I was reading. That
explains it all, thank you very much.

When I have a more polished and complete LINENO implementation, I'll
post it here.

Cheers,
Harald
