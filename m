From: Brian Koropoff <bkoropoff@gmail.com>
Subject: Re: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Thu, 07 Jul 2011 00:32:25 -0700
Message-ID: <4E156109.4080600@gmail.com>
References: <1302921010.2620.3.camel@gemini> <1302921279.2620.6.camel@gemini> <20110707064154.GE16157@gondor.apana.org.au> <20110707071244.GB11514@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58189 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1GGHc2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 03:32:28 -0400
Received: by pwj7 with SMTP id 7so463360pwj.19
        for <dash@vger.kernel.org>; Thu, 07 Jul 2011 00:32:28 -0700 (PDT)
In-Reply-To: <20110707071244.GB11514@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On 07/07/2011 12:12 AM, Jonathan Nieder wrote:
> Herbert Xu wrote:
>
>> %j is part of ISO C99 and POSIX
> *checks*  Oh, so it is!  Thanks; it's nice to learn the standard
> offers more than expected.
>
> Brian: fwiw gnulib printf seems to provide %j, though of course it's a
> bit more heavyweight.  And of course there are alternative C libraries
> --- e.g., glibc runs on Solaris.

C99 also guarantees the presence of imaxdiv, but arith_yacc.c happily
#ifdefs around it if the build environment lacks it.  I submitted other
patches in the same spirit (working around non-compliant vsnprintf) and they
were accepted.  Would a patch that retains the old code verbatim but
#ifdefs in an alternate implementation on legacy systems be more acceptable?

-- Brian
