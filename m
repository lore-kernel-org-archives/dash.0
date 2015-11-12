From: Seb <sbb@tuxfamily.org>
Subject: Re: [bug?] echo -n does not work as described
Date: Thu, 12 Nov 2015 09:35:36 +0100
Message-ID: <20151112083536.GA796@ein.free.fr>
References: <5643F1B2.5050207@sanitarium.net>
 <56440406.7000201@redhat.com>
 <56440A1E.8070701@sanitarium.net>
 <56440B7A.4040508@sanitarium.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:60215 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbbKLIfl (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 12 Nov 2015 03:35:41 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 59B77D8E1E1
	for <dash@vger.kernel.org>; Thu, 12 Nov 2015 09:35:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56440B7A.4040508@sanitarium.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Kevin Korb <kmk@sanitarium.net>

On Wed, Nov 11, 2015 at 10:46:02PM -0500, Kevin Korb wrote:

> >> By the way, 'echo -n' is non-portable, and POSIX says you
> >> should use 'printf' instead.
> 
> If dash refuses to supply a compatible version of echo then
> dash must not include a builtin version of echo.  If dash
> didn't have a broken embedded version of echo I wouldn't have a
> problem.

dash just claims to be compatible with POSIX, not with *sh. If
you look for something like this (lighter than bash but with many
of its features), glance rather at mksh:

  https://www.mirbsd.org/mksh.htm

Now, I don't understand the present issue, all seems just work as
expected here (0.5.8):

 $ dash -c 'type echo; echo -n foo; echo foo'
 echo is a shell builtin
 foofoo

++
Seb.

