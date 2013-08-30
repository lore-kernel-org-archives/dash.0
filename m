From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: glob pattern and redirected input file name
Date: Fri, 30 Aug 2013 16:34:22 +0200
Message-ID: <20130830143422.GA12474@stack.nl>
References: <521FDDF8.5010200@nottheoilrig.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:57652 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752329Ab3H3OeZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 30 Aug 2013 10:34:25 -0400
Content-Disposition: inline
In-Reply-To: <521FDDF8.5010200@nottheoilrig.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jack Bates <i72aoc@nottheoilrig.com>
Cc: dash@vger.kernel.org

On Thu, Aug 29, 2013 at 04:49:12PM -0700, Jack Bates wrote:
> What is DASH supposed to do when input is redirected from a file,
> and the file name is a glob pattern? e.g.

>    tar xz < foo-*.tar.gz

> Is it supposed to expand the glob pattern, or is that not supported?

Per POSIX XCU 2.7 Redirection, pathname generation may (but need not) be
performed on the word after a redirection operator other than << or <<-
if the shell is interactive and one word would result.

Dash chooses the option that results in the smallest code: never
performing pathname generation in this case.

> The following both work, is there a better workaround?

>    tar fxz foo-*.tar.gz

>    tar xz < $(echo foo-*.tar.gz)

These are both concise methods. The former's problem is that it does
something strange if more than one file matches. The second has problems
with pathnames starting with '-', containing backslashes or ending with
newlines.

In a script you might do
    set -- foo-*.tar.gz
    if [ "$#" -ne 1 ] || [ ! -f "$1" ]; then
        echo "Bad wildcard"
        exit 2
    fi
    tar -xzf "$1"

-- 
Jilles Tjoelker
