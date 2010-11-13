From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Quoted closing brace in variable default expansion
Date: Sat, 13 Nov 2010 10:41:47 -0600
Message-ID: <20101113164147.GB5535@burratino>
References: <4CDEBC7B.5050805@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45035 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab0KMQmS (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 13 Nov 2010 11:42:18 -0500
Received: by gyh4 with SMTP id 4so2389354gyh.19
        for <dash@vger.kernel.org>; Sat, 13 Nov 2010 08:42:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDEBC7B.5050805@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

Hi Herald,

Harald van Dijk wrote:

>   $ ksh -c 'echo "${x:-"}"}"'
>   }
>   $ dash -c 'echo "${x:-"}"}"'
>   dash: 1: Syntax error: Unterminated quoted string
>   $ busybox sh -c 'echo "${x:-"}"}"'
>   sh: syntax error: unterminated quoted string
> 
> It looks like dash and other ash derivatives stop the expansion with
> the first }, instead of the first unquoted }. I'm getting confused
> trying to figure out whether this is a bug in dash or in the script
> relying on it.

The answer depends on how portable the script is meant to be.  If
the goal is to be portable to shells implementing future versions of
the POSIX standard, there seems to be have been an interpretation[1]
approved for the next major revision:

 http://austingroupbugs.net/view.php?id=221
 note #399

which would make the example nonconformant because there are an odd
number of unescaped double-quotes before the first unescaped closing
brace.

See http://thread.gmane.org/gmane.comp.shells.dash/262/focus=263 for
a nice summary (thanks, Jilles!).

Hope that helps,
Jonathan
