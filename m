From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH] [BUILD] Avoid compiler warning
Date: Tue, 11 Aug 2009 21:20:22 -0600
Message-ID: <4A8234F6.1090605@byu.net>
References: <20090811040133.GD10700@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:60277 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755805AbZHLDUU (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 11 Aug 2009 23:20:20 -0400
In-Reply-To: <20090811040133.GD10700@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

According to Herbert Xu on 8/10/2009 10:01 PM:
> On Thu, Jul 09, 2009 at 06:52:15AM -0600, Eric Blake wrote:
>> Pass correct type to ctype macro.
>>
>> Signed-off-by: Eric Blake <ebb9@byu.net>
> 
> Hmm, what warning did you get from the compiler?

As reported in my original patch submission:

miscbltin.c: In function `umaskcmd':
miscbltin.c:201: warning: subscript has type `char'

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
