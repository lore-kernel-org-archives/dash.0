From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH] fix two compile time warnings
Date: Mon, 29 Nov 2010 00:52:15 -0800
Message-ID: <AANLkTi=18kZ+yPm7GtbQ=jvebngEDd5POaVA68tF0ZjP@mail.gmail.com>
References: <1287568775-2556-1-git-send-email-zenczykowski@gmail.com>
	<20101128125710.GC11109@gondor.apana.org.au>
	<AANLkTikZ3_jFLM2nHVK0f+OSzHnAbRE-iZ9NG+qH0SLa@mail.gmail.com>
	<20101129074035.GA16888@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38735 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab0K2IwQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 29 Nov 2010 03:52:16 -0500
Received: by wyb28 with SMTP id 28so4150244wyb.19
        for <dash@vger.kernel.org>; Mon, 29 Nov 2010 00:52:15 -0800 (PST)
In-Reply-To: <20101129074035.GA16888@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, maximillian attems <max@stro.at>

>> That's unfortunate since it prevents a -Werror build of klibc (which
>> includes dash) from succeeding.
>
> And that's precisely why I would never use -Werror with gcc.

My personal experience has been that the warnings gcc produces are far
more often a sign of real bugs
than they are spurious.  Usually fixing them isn't particularly bothersome.

(although this is based on experience predominantly gained not on klibc or dash)

> You can always apply this patch in klibc locally.

I do, however, I prefer submitting patches upstream whenever possible.

I'll continue to maintain this one locally.

- Maciej
