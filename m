From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 3 Dec 2015 00:25:51 +0100
Message-ID: <20151202232551.GA40234@stack.nl>
References: <n3nrqu$mj2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:56595 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755306AbbLBXfs (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 2 Dec 2015 18:35:48 -0500
Content-Disposition: inline
In-Reply-To: <n3nrqu$mj2$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

On Wed, Dec 02, 2015 at 11:37:17PM +0100, Gioele Barabucci wrote:
> I am forwarding a bug [1] reported by a Debian user: `read` does not
> ignore trailing spaces. The current version of dash is affected by
> this bug.

> A simple test from the original reporter:

>     $ dash -c 'echo "  a b  " | { read v ; echo "<$v>" ; }'
>     <a b  >

>     $ bash -c 'echo "  a b  " | { read v ; echo "<$v>" ; }'
>     <a b>

> Other shells like posh and mksh behave like bash.

> This error is reproducible with dash 0.5.7 and with the current master
> git master branch, commit 2e5842258bd5b252ffdaa630db09c9a19a9717ca.

> [1] https://bugs.debian.org/794965

This is a valid bug. Note that it only occurs when there are more fields
than variables. For example,
  dash -c 'echo "  a  " | { read v ; echo "<$v>" ; }'
correctly prints <a>.

Since dash has its own code for read's splitting, it is not possible to
take a fix from NetBSD or FreeBSD sh, other than by replacing the
splitting code completely with their version.

-- 
Jilles Tjoelker
