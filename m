From: Brian Koropoff <bkoropoff@gmail.com>
Subject: Re: [PATCH 1/3] Port to Solaris
Date: Sat, 12 Mar 2011 17:18:32 -0800
Message-ID: <1299979112.3797.9.camel@gemini>
References: <1295413636.4278.28.camel@gemini>
	 <1295414140.6486.3.camel@gemini> <20110121130602.GA70470@stack.nl>
	 <20110310121659.GC10824@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39408 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab1CMBS0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 12 Mar 2011 20:18:26 -0500
Received: by iyb26 with SMTP id 26so3846432iyb.19
        for <dash@vger.kernel.org>; Sat, 12 Mar 2011 17:18:25 -0800 (PST)
In-Reply-To: <20110310121659.GC10824@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org

I'll send an updated and rebased patch shortly.  Once we've agreed about
what to do with _LARGEFILE64_SOURCE in the HP-UX patch, I'll send a new
version of that as well.

-- Brian

On Thu, 2011-03-10 at 20:16 +0800, Herbert Xu wrote:
> On Fri, Jan 21, 2011 at 01:06:02PM +0000, Jilles Tjoelker wrote:
> >
> > What you can do is use PRIdMAX from <inttypes.h>, normally defined as
> > "jd". You can then define this to "lld" or "jd" if it is not defined.
> > I think this makes the code uglier (just like your change), but oh well.
> 
> I agree.  Brian, please update your patch accordingly.
> 
> Thanks!
> 
> > By the way, I wonder what the advantage of imaxdiv() above separate %
> > and / is. Compilers can detect the matching between a % b and a / b and
> > do it in one operation, and any use of imaxdiv() trips gcc's
> > -Waggregate-return.
> 
> It used to generate smaller code with gcc.  If gcc now knows how
> to optimise it properly then I guess we can remove imaxdiv.
> 
> I just checked and gcc 4.4.5 still generates two divisions without
> imaxdiv.  On the other hand gcc doesn't even inline imaxdiv.
> 
> Cheers,


