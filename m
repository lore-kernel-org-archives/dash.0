From: Isaac Jurado <diptongo@gmail.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Mon, 2 Jul 2012 20:57:54 +0200
Message-ID: <CALqPu351j4k-gO0Zdvwv5vMaczVtVfZfvwNg-qBTxTUXjwh23g@mail.gmail.com>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
	<4FF1A76F.6020307@redhat.com>
	<2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com>
	<4FF1AE9C.7040307@redhat.com>
	<CALqPu34=a629YmEiqk008a7aMF26ObEz=MCGA3vZBKTkr25hQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63313 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2GBS5z (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 Jul 2012 14:57:55 -0400
Received: by vbbff1 with SMTP id ff1so3739725vbb.19
        for <dash@vger.kernel.org>; Mon, 02 Jul 2012 11:57:54 -0700 (PDT)
In-Reply-To: <CALqPu34=a629YmEiqk008a7aMF26ObEz=MCGA3vZBKTkr25hQA@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Paul Gilmartin <PaulGBoulder@aim.com>, dash <dash@vger.kernel.org>

On Mon, Jul 2, 2012 at 8:53 PM, Isaac Jurado <diptongo@gmail.com> wrote:
>
> Since the set of signal names to be recognized is known at compile
> time, you can use a perfect hash function generator like GNU Perf [1]
> which minimizes character comparisons in order to return the desired
> constant assigned to a name/symbol/token/whatever-string.

As usual, I forgot the link.  My apologies:

[1] http://www.gnu.org/software/gperf/

-- 
Isaac Jurado

"The noblest pleasure is the joy of understanding"
Leonardo da Vinci
