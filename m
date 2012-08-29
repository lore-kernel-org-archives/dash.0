From: Todor Vlaev <t.vlaev@gmail.com>
Subject: Re: [EXPAND] Nested parameter expansion results in an empty string
 when quoted
Date: Wed, 29 Aug 2012 16:46:50 +0300
Message-ID: <CAAv6kGQue_cKF9h6bC0FRZi1t4uD2r+tob05fw-5Aj3xWT5ZFA@mail.gmail.com>
References: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
 <20120828230024.GA51967@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46903 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab2H2NrL (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 29 Aug 2012 09:47:11 -0400
Received: by qaas11 with SMTP id s11so392867qaa.19
        for <dash@vger.kernel.org>; Wed, 29 Aug 2012 06:47:11 -0700 (PDT)
In-Reply-To: <20120828230024.GA51967@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

> The double-quotes here are unnecessary and should be left out for
> optimal compatibility. Note that this may require a temporary variable
> if the expansion is in a context where word splitting is performed.
> However, you are right that the double-quotes are permitted per POSIX.
>
> On the other hand, some double-quotes that are really necessary are
> missing:
>
> my_str=swan; last_char=${my_str#"${my_str%?}"}; echo "${last_char}"
>
> The inner double-quotes force any wildcard characters in $my_str to be
> taken literally. This is required to work correctly with the string
> sw*n, for example.
>
> It also happens to work around dash's bugs, both the above version and a
> version with the redundant quotes you like:
>
> my_str=swan; last_char="${my_str#"${my_str%?}"}"; echo "${last_char}"

Thanks for the useful tips!

> Fixing this requires a test suite. Without a test suite, any attempt to
> fix something is likely to break something else.

A bit worrying not to have regression tests, indeed.

In any case, there are plenty of workarounds to this minor issue, even
if not fixed there is a reference now for someone else who might
wonder.

Br,
Todor
