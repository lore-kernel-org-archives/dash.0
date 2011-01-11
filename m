From: Aragon Gouveia <aragon@phat.za.net>
Subject: Re: setvar MIA?
Date: Tue, 11 Jan 2011 18:54:04 +0200
Message-ID: <4D2C8B2C.3060001@phat.za.net>
References: <4D2C7D44.1060904@phat.za.net> <4D2C810E.4070707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from decoder.geek.sh ([196.36.198.81]:58236 "EHLO mail.geek.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932276Ab1AKQyI (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Jan 2011 11:54:08 -0500
In-Reply-To: <4D2C810E.4070707@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

Hi,

On 01/11/11 18:10, Eric Blake wrote:
> Decidedly missing.  POSIX doesn't require it.  Neither bash nor ksh
> provides setvar as a builtin, either.  And what does setvar do anyways?
>   Perhaps it is some alias or shell function that you have inherited from
> startup files in one of your other shells, but I've never heard of a
> 'setvar' program.  So why bloat dash to include it?

It is a builtin in FreeBSD's Bourne shell:

http://www.freebsd.org/cgi/man.cgi?query=sh&apropos=0&sektion=0&manpath=FreeBSD+8.1-RELEASE&format=html

I wasn't sure of its status in POSIX.  It is useful for declaring 
variable variables - tidier than eval and I imagine faster, eg.

index="1"
setvar var_${index} "value"

Will emulate it with a local function - thanks.


Regards,
Aragon
