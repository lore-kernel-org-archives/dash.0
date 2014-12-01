From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: [MAN] Clarify two redirection mechanisms
Date: Mon, 1 Dec 2014 12:27:19 +0000
Message-ID: <20141201122718.GC3842@chaz.gmail.com>
References: <1416570754-9998-1-git-send-email-saulery@free.fr>
 <20141201100456.GA16404@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41081 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbaLAMaQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 1 Dec 2014 07:30:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1XvQ7K-0006G8-2L
	for dash@vger.kernel.org; Mon, 01 Dec 2014 13:30:14 +0100
Received: from 5ec1853a.skybroadband.com ([94.193.133.58])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 01 Dec 2014 13:30:14 +0100
Received: from stephane.chazelas by 5ec1853a.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 01 Dec 2014 13:30:14 +0100
Content-Disposition: inline
In-Reply-To: <20141201100456.GA16404@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2014-12-01 18:04:56 +0800, Herbert Xu:
[...]
> > --- a/src/dash.1
> > +++ b/src/dash.1
> > @@ -402,11 +402,13 @@ Append standard output (or n) to file.
> > .It [n] Ns \*[Lt] file
> > Redirect standard input (or n) from file.
> > .It [n1] Ns \*[Lt]& Ns n2
> > -Duplicate standard input (or n1) from file descriptor n2.
> > +Redirect standard input (or fd n1) from the same resource as currently open on
> > +fd n2.
> 
> "Resource" is rather unwieldy, how about simply "file"?
[...]

"file" could be misleading (as actually it's dup(2)ing a file
descriptor, so more like redirecting to same _open file
description_ (not the same as reopening the file like "n1>
/dev/fd/n2" does on Linux for instance) and "file" is understood
by many as "regular file" while here, it could be (and often is)
socket/pipe/devices...).

IMO, "resource" is vague enough so as not to give the wrong idea
and I like that wording because it conveys the intended
mechanism clearly ("redirect to same thing as"). But I agree
it's not ideal.

The "dupliciting fd x onto y" wording may be more correct, but
doesn't convey the redirection idea as clearly IMO.

-- 
Stephane

