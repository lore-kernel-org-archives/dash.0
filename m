From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: setvar MIA?
Date: Tue, 11 Jan 2011 20:58:12 +0100
Message-ID: <20110111195811.GA62146@stack.nl>
References: <4D2C7D44.1060904@phat.za.net>
 <4D2C810E.4070707@redhat.com>
 <4D2C8B2C.3060001@phat.za.net>
 <4D2C8CB1.4070204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:54565 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752441Ab1AKT6N (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Jan 2011 14:58:13 -0500
Content-Disposition: inline
In-Reply-To: <4D2C8CB1.4070204@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Aragon Gouveia <aragon@phat.za.net>, dash@vger.kernel.org

On Tue, Jan 11, 2011 at 10:00:33AM -0700, Eric Blake wrote:
> On 01/11/2011 09:54 AM, Aragon Gouveia wrote:
> > I wasn't sure of its status in POSIX.  It is useful for declaring
> > variable variables - tidier than eval and I imagine faster, eg.

> > index="1"
> > setvar var_${index} "value"

> > Will emulate it with a local function - thanks.

> Indeed, it looks like FreeBSD introduced it as shorthand for:

> setvar() { eval $1=\$2; }

> The speed difference between that function doing an eval and a shell
> builtin would be in the noise.  I don't know why FreeBSD even bothered
> to pollute the namespace with a builtin like that.

The setvar builtin was already present and documented in the initial
ash. FreeBSD simply inherited it. Dash inherited it too, but it was
removed in dash-0.4.14, 3 Apr 2003.

The use of Almquist's additions like this one is certainly questionable;
many of them have been removed. However, setvar has been available and
documented in /bin/sh in all versions of FreeBSD, which makes removal
less likely at this point.

-- 
Jilles Tjoelker
