From: Eric Blake <eblake@redhat.com>
Subject: Re: dash -n and -v not implemented?
Date: Mon, 23 Aug 2010 14:22:39 -0600
Message-ID: <4C72D88F.1000502@redhat.com>
References: <i4uj8q$ah3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1029 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0HWUWu (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 16:22:50 -0400
In-Reply-To: <i4uj8q$ah3$1@dough.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Kellas <Adam.Kellas@gmail.com>
Cc: dash@vger.kernel.org

On 08/23/2010 01:47 PM, Adam Kellas wrote:
> Am I missing something, or do the -n and -v flags have no effect? The
> following compares the behavior of bash, ksh, and dash (bash requires an
> extra flag to suppress startup files):
>
> % ksh -v -n -c uname
> uname
>
> % bash --norc -v -n uname
> uname
>
> % dash -v -n -c uname
> Linux

POSIX states that an interactive shell may ignore 'set -n'; and by 
extension, 'sh -n' can be a no-op if the shell would otherwise be 
interactive.  But your example is not an interactive shell; and POSIX is 
clear that both -v and -n must have the same effect as an option to the 
shell command line as they would have to a use of set within the shell.

I think the absence of handling for both of these options is a definite 
bug according to POSIX rules on sh.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
