From: "Dan McGee" <dan@archlinux.org>
Subject: Re: dash regression against klibc
Date: Fri, 2 May 2008 20:08:34 -0500
Message-ID: <449c10960805021808k6f4bb039nc37ba5177a9584d5@mail.gmail.com>
References: <449c10960805011025v675414cco36cb2d6400cc6217@mail.gmail.com>
	 <20080502052530.GA15890@gondor.apana.org.au>
	 <20080502062303.GA16356@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:8361 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756738AbYECBIf (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 May 2008 21:08:35 -0400
Received: by rv-out-0506.google.com with SMTP id l9so285718rvb.1
        for <dash@vger.kernel.org>; Fri, 02 May 2008 18:08:34 -0700 (PDT)
In-Reply-To: <20080502062303.GA16356@gondor.apana.org.au>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Fri, May 2, 2008 at 1:23 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, May 02, 2008 at 01:25:30PM +0800, Herbert Xu wrote:
>  >
>  > I suspect the problem is klibc's getcwd implementation but this
>  > should confirm it for us.
>
>  Actually klibc's getcwd is just fine as it is.  It's dash that's
>  relying on glibc extensions of getcwd.
>
>  This patch sould make it work again.

You pushed this patch to git, so I tried to grab the repository and
compile from there. I'll follow this message with a series of patches
to fix some other compilation issues that have cropped up since the
last release of klibc.

Unfortunately this patch didn't work:
$ for f in /bin/bash /bin/sh /usr/lib/klibc/bin/sh /bin/dash
./src/dash; do echo "  trying shell $f:"; env - $f -c 'echo $PWD; pwd;
pwd -P; /bin/pwd'; done
  trying shell /bin/bash:
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
  trying shell /bin/sh:
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
  trying shell /usr/lib/klibc/bin/sh:
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
/home/dmcgee/projects/dash
  trying shell /bin/dash:



/home/dmcgee/projects/dash
  trying shell ./src/dash:



/home/dmcgee/projects/dash

So the post-patch version of dash is acting identical to the prepatch
version. I'm not convinced this is a dash problem- it could very well
be an upstream klibc issue, and I will try to look into this
possibility as well.

-Dan
