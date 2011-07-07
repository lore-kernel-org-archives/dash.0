From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] [MAIN] Optimize dash -c "command" to avoid a fork
Date: Wed, 6 Jul 2011 23:27:53 -0500
Message-ID: <20110707042753.GA7684@elie>
References: <20110410071734.GA16736@elie>
 <20110410073649.GD17649@elie>
 <20110707034833.GC16157@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46013 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1GGE2O (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Jul 2011 00:28:14 -0400
Received: by iwn6 with SMTP id 6so515822iwn.19
        for <dash@vger.kernel.org>; Wed, 06 Jul 2011 21:28:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110707034833.GC16157@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, Jilles Tjoelker <jilles@stack.nl>, Drake Wilson <drake@begriffli.ch>, Reuben Thomas <rrt@sc3d.org>

Herbert Xu wrote:
> On Sun, Apr 10, 2011 at 07:36:49AM +0000, Jonathan Nieder wrote:

>> From: Jilles Tjoelker <jilles@stack.nl>
>> Date: Sat, 13 Jun 2009 16:17:45 -0500
>>
>> This change only affects strings passed to -c, when the -s option is
>> not used.
>>
>> Use the EV_EXIT flag to inform the eval machinery that the string
>> being passed is the entirety of input.  This way, a fork may be
>> omitted in many special cases.
[...]
> OK I will take this patch since its impact is much smaller than
> one that hacks around the input path, and seems to achieve most of
> what you want anyway.

Will that work?  Without the preadateof check, I would worry that
passing EV_EXIT to evalstring would break:

	$ dash -c 'echo one
		echo two'
	one
