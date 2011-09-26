From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] [BUILTIN] Make "test -x" sane again when run as root
Date: Mon, 26 Sep 2011 17:16:49 -0500
Message-ID: <20110926221648.GF5629@elie>
References: <20110926211636.GA6645@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55266 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1IZWQy (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 26 Sep 2011 18:16:54 -0400
Received: by gyg10 with SMTP id 10so4582484gyg.19
        for <dash@vger.kernel.org>; Mon, 26 Sep 2011 15:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110926211636.GA6645@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Christoph Egger <christoph@debian.org>, Petr Salinger <Petr.Salinger@seznam.cz>, Herbert Xu <herbert@gondor.apana.org.au>

Jonathan Nieder wrote:

> [PATCH] [BUILTIN] Make "test -x" sane again when run as root

Quick correction: a better title would be

	[BUILTIN] Fix "test -x" as root on platforms with old-fashioned faccessat

for brevity ("fix" contains just as much information as "make sane")
and to make it more obvious that this is supposed to have no effect on
platforms like Linux.  Sorry for the lack of clarity.
