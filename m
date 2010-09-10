From: Sven Mascheck <mascheck@in-ulm.de>
Subject: Re: [PATCH] [MAN] Document optional open parenthesis for case
	patterns.
Date: Sat, 11 Sep 2010 01:52:02 +0200
Message-ID: <20100910235202.GE16906@lisa.in-ulm.de>
References: <20100908024219.GA3283@zaphod.pweis.com>
Reply-To: mascheck@in-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.in-ulm.de ([217.10.8.10]:37730 "HELO mail.in-ulm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755038Ab0IJX6p (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 10 Sep 2010 19:58:45 -0400
Content-Disposition: inline
In-Reply-To: <20100908024219.GA3283@zaphod.pweis.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Tue, Sep 07, 2010 at 10:42:19PM -0400, Philipp Weis wrote:

> while inspecting some dash scripts on my system, I was surprised to
> see that some of them use an open parenthesis at the beginning of cas=
e
> patterns while that's not mentioned in the manpage. Dash currently is
> fine with and without that parenthesis (parser.c:413).

BTW, This feature is a workaround:
Without the left paren, several shells=B9 are confused with "case"
inside $( ), because now the parens are not "balanced" anymore.
Although dash doesn't need this (in fact any ash variant),
it was added ('99) for reasons of script portability.
Another benefit is easy searching for matching parens in editors.

=B9 bash pre-4, ksh88, pdksh-variants
