From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Features.
Date: Sun, 11 Nov 2007 16:09:29 -0800
Message-ID: <473799B9.7080804@zytor.com>
References: <8499950a0711111459h33921caaxde3111fb2b719fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34440 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbXKLAJc (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 11 Nov 2007 19:09:32 -0500
In-Reply-To: <8499950a0711111459h33921caaxde3111fb2b719fea@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Oleg Verych <olecom@gmail.com>
Cc: dAsh <dash@vger.kernel.org>

Oleg Verych wrote:
> 
>    5.2 IMHO making user accessible file descriptors in range of [3-9] is
>        kind of silly, when open() returns lowest available fd number,
>        and shell have no semantics of saying "no, this fd is used already".
> 
>        Making them in higher and wider region, say in [100-255] is
>        quite reasonable. Making them as special variables, like
>        parameters `$1' are, makes even more sense, thus preventing any
>        potential problems.
> 

Everyone is using 3-9 though.  I would suggest just moving the lower 
limit higher, e.g. 3-99.

	-hpa
