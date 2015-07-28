From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: shell: dash - large file support
Date: Tue, 28 Jul 2015 10:25:39 +0800
Message-ID: <20150728022539.GA23798@gondor.apana.org.au>
References: <20150726192141.GC4346@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:36405 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbG1CZp (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Jul 2015 22:25:45 -0400
Content-Disposition: inline
In-Reply-To: <20150726192141.GC4346@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: aleksandar.ristovski@gmail.com, dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
>
> However, using a non-largefile stat() or lstat() is always wrong, since
> the inode number may not fit in a non-largefile ino_t. This happens in
> various cases: test -ef/-nt/-ot, finding a dot script (. special
> builtin) and some related to the current directory.
> 
> On another note, test -nt/-ot should really compare the nanoseconds
> parts as well.

Please send patches for these issues.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
