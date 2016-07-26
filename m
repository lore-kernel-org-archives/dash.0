From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Declaring local variables inside while loop leads to memory leak
Date: Tue, 26 Jul 2016 23:35:06 +0200
Message-ID: <20160726213506.GC16428@stack.nl>
References: <CAHRK1yP1GyUJEPNLSicUatRJPOJg=Oeac1daJkuJs6eDD+xi9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:27759 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752732AbcGZVo3 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 26 Jul 2016 17:44:29 -0400
Content-Disposition: inline
In-Reply-To: <CAHRK1yP1GyUJEPNLSicUatRJPOJg=Oeac1daJkuJs6eDD+xi9Q@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Vladimir Didenko <vladimir.didenko@gmail.com>
Cc: dash@vger.kernel.org

On Tue, Jul 26, 2016 at 01:35:53PM +0300, Vladimir Didenko wrote:
> I found that declaring local variables inside while loop leads to
> memory leak. Code sample:

> test()
> {
>    while [ true ]; do
>       local a=
>    done
> }

> test

This can indeed consume a lot of memory. The memory is freed when the
function returns.

This could be fixed by adding a check before making a variable local but
that might make functions with many distinct locals slower.

Also note that the problem does not occur if local is used at the top of
a function only, as recommended by the man page.

-- 
Jilles Tjoelker
