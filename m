From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH] fix two compile time warnings
Date: Sun, 28 Nov 2010 23:18:45 -0800
Message-ID: <AANLkTikZ3_jFLM2nHVK0f+OSzHnAbRE-iZ9NG+qH0SLa@mail.gmail.com>
References: <1287568775-2556-1-git-send-email-zenczykowski@gmail.com>
	<20101128125710.GC11109@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35574 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0K2HSr convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 29 Nov 2010 02:18:47 -0500
Received: by wyb28 with SMTP id 28so4079451wyb.19
        for <dash@vger.kernel.org>; Sun, 28 Nov 2010 23:18:45 -0800 (PST)
In-Reply-To: <20101128125710.GC11109@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, maximillian attems <max@stro.at>

> Thanks for the patch. =C2=A0I've applied the second hunk.
>
> As for the first, if I get annoyed enough after upgrading my gcc
> then I'll think about it :) It's a false positive as strsignal
> should never return anything that requires "%s".

That's unfortunate since it prevents a -Werror build of klibc (which
includes dash) from succeeding.
Cheers,
Maciej
