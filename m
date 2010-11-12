From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Fri, 12 Nov 2010 19:16:09 +0059
Message-ID: <4CDD8481.1060306@gigawatt.nl>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:39401 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932140Ab0KLSPQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 12 Nov 2010 13:15:16 -0500
In-Reply-To: <20101110220008.GC17871@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>

On 10/11/10 22:59, Jilles Tjoelker wrote:
> What I was thinking of was adding a lineno field to narg instead of to
> all command types. The lineno variable would then be set by expand.c. I
> think that leads to a smaller patch and it should still give a sensible
> value for almost all errors.

Unfortunately, I do not believe this will work. In

   echo $LINENO \
     $LINENO

two identical numbers must be printed, because LINENO is supposed to be 
set when a command is executed. It is not supposed to change during the 
execution of the command. Taking the first word of a command also will 
not work:

   (
     :
     :
     :
     :
     :
   ) >test-$LINENO

should write to file test-1, not test-7, even though the only word is on 
line 7. bash gets this wrong, pdksh gets this almost right.

If I am missing an obvious way to address these issues, or if I am 
missing some part of the standard that clarifies why these issues do not 
exist, please share, but otherwise I will take the rest of your 
suggestions and rework my first patch, storing the line number for each 
command.
