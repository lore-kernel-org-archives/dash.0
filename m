From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Fwd: bug? Spawned childs always remain in zombie state
Date: Fri, 23 Aug 2013 20:44:44 +1000
Message-ID: <20130823104444.GE10632@gondor.apana.org.au>
References: <CAMqPLXWsMhPBjYa3JnCmuO=M6m2F=hSdiEfRx390VKdgC5qxZg@mail.gmail.com>
 <CAMqPLXX4GtCXcfrOnBkhPw+PEFRXh0x9X54H9paqm6b7vDnzNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([178.18.16.133]:46106 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755054Ab3HWKos (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 23 Aug 2013 06:44:48 -0400
Content-Disposition: inline
In-Reply-To: <CAMqPLXX4GtCXcfrOnBkhPw+PEFRXh0x9X54H9paqm6b7vDnzNA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Sjon Hortensius <Sjon@hortensius.net>
Cc: dash@vger.kernel.org

On Sun, Jan 20, 2013 at 12:04:04PM +0000, Sjon Hortensius wrote:
> Hi. I'm trying to create a script which monitors a directory using
> inotify and spawns a background process for all events. However I
> found that all childs will remain in zombie state until the script
> quits and I am unable to find a proper fix.
> 
> A minimal testcase:
> 
> #!/bin/dash
> while true
> do
>     sleep 1 &
> #    jobs >/dev/null
> done
> 
> If you open a second terminal you'll see that all the 'sleep'
> processes end up being defunct. I have tried playing with `set -ma`
> but the only workaround I found is the commented 'jobs' line.
> Uncommenting that line will result in expected behavior where childs
> are properly reaped. Is this a bug, or is there an alternative
> solution I'm missing?

You need to wait on them as otherwise dash has to keep them around
in case you call wait(1) later on.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
