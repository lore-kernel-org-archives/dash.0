From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [EXPAND] Nested parameter expansion results in an empty string
 when quoted
Date: Wed, 29 Aug 2012 01:00:24 +0200
Message-ID: <20120828230024.GA51967@stack.nl>
References: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:64569 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751257Ab2H1XLK (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Aug 2012 19:11:10 -0400
Content-Disposition: inline
In-Reply-To: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Todor Vlaev <t.vlaev@gmail.com>
Cc: dash@vger.kernel.org

On Tue, Aug 28, 2012 at 04:27:24PM +0300, Todor Vlaev wrote:
> While playing around with parameter expansion I noticed that the
> following didn't work in dash  (dash 0.5.5.1-7.4ubuntu1) as compared
> to bash even though I believe it should be POSIX-compliant:

> my_str=swan; last_char="${my_str#${my_str%?}}"; echo ${last_char}

> If the double quotes are removed, the last character is printed
> correctly.

The double-quotes here are unnecessary and should be left out for
optimal compatibility. Note that this may require a temporary variable
if the expansion is in a context where word splitting is performed.
However, you are right that the double-quotes are permitted per POSIX.

On the other hand, some double-quotes that are really necessary are
missing:

my_str=swan; last_char=${my_str#"${my_str%?}"}; echo "${last_char}"

The inner double-quotes force any wildcard characters in $my_str to be
taken literally. This is required to work correctly with the string
sw*n, for example.

It also happens to work around dash's bugs, both the above version and a
version with the redundant quotes you like:

my_str=swan; last_char="${my_str#"${my_str%?}"}"; echo "${last_char}"

> At a quick glance through the commits after the 0.5.5.1 release I saw
> the following bug fix. Could it be related?

> 0d7d66039b614b642c775432fd64aa8c11f9a64d
> [EXPAND] Fix quoted pattern patch breakage

It is still broken with master (46abc8c6d8a5e9a5712bdc1312c0b6960eec65a4
[BUILTIN] Add support for ulimit -r 2012-07-03) here.

Fixing this requires a test suite. Without a test suite, any attempt to
fix something is likely to break something else. This is not only
because the expansions are inherently complicated but also because
dash's code for them is hard to understand.

The code for expansions in FreeBSD's sh, a related Almquist shell
variant heavily modified by me, is more correct and slightly easier to
understand. There is also a test suite. However, the dash maintainer
does not agree with some of the choices I have made where POSIX (as
modified by interpretations) is silent.

The mksh, a shell from a different lineage, also has a good set of test
cases.

-- 
Jilles Tjoelker
