Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CEFC433FE
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 15:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F7523B26
	for <linux-dash@archiver.kernel.org>; Thu, 10 Dec 2020 15:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgLJP2E (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:28:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:56962 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbgLJP15 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 10 Dec 2020 10:27:57 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 10:27:57 EST
Received: (qmail 32631 invoked by uid 109); 10 Dec 2020 15:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Dec 2020 15:20:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28561 invoked by uid 111); 10 Dec 2020 15:20:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Dec 2020 10:20:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Dec 2020 10:20:29 -0500
From:   Jeff King <peff@peff.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, 976865@bugs.debian.org,
        andrew@shadura.me, dash@vger.kernel.org
Subject: Re: Bug#976865: Fwd: Bug#974900: dash removes trailing slash from
 script arguments
Message-ID: <X9I8vStSYdovXOIM@coredump.intra.peff.net>
References: <20201116094531.GA40024@coredump.intra.peff.net>
 <20201210025654.GA26577@gondor.apana.org.au>
 <20201210075837.GN2297@aurel32.net>
 <20201210113508.GA28224@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210113508.GA28224@gondor.apana.org.au>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Thu, Dec 10, 2020 at 10:35:08PM +1100, Herbert Xu wrote:

> Yes but it's really a bug in glob(3).  It should really return
> a no-match for the case in question, rather than matching and then
> returning a filename without the slash.
> 
> IOW the pattern "foo\/" should not match a regular file foo.
> 
> Note that the problem doesn't occur for "foo/".

It seems like it happens for "foo/", too. If I compile:

-- >8 --
#include <glob.h>
#include <stdio.h>

int main(int argc, const char **argv)
{
	while (*++argv) {
		glob_t r;
		if (glob(*argv, 0, NULL, &r))
			perror(*argv);
		else {
			size_t i;
			for (i = 0; i < r.gl_pathc; i++)
				printf("%s -> %s\n", *argv, r.gl_pathv[i]);
			globfree(&r);
		}
	}
	return 0;
}
-- >8 --

I get:

  $ rm -f foo bar
  $ touch foo
  $ ./a.out foo foo/ 'foo\/' bar bar/ 'bar\/'
  foo -> foo
  foo/ -> foo
  foo\/ -> foo
  bar: No such file or directory
  bar/: No such file or directory
  bar\/: No such file or directory

-Peff
