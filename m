From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: sed script fails to run in dash
Date: Fri, 22 Nov 2013 11:25:59 -0800
Message-ID: <20131122192559.GH4212@google.com>
References: <528F9E5E.4020807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:39310 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab3KVT0D (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 Nov 2013 14:26:03 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so557290yho.30
        for <dash@vger.kernel.org>; Fri, 22 Nov 2013 11:26:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <528F9E5E.4020807@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tormen <quickhelp@gmail.com>
Cc: dash@vger.kernel.org

Hi Tormen,

Tormen wrote:

>     sed -e 1$'{w/dev/stdout\n;d}' -i /tmp/x
>
> in a dash script will yield the error message:
>
>     sed: -e expression #1, char 2: unknown command: `$'
>
> But why ? :(

POSIX sayeth[1]:

  The '$' character is used to introduce parameter expansion, command
  substitution, or arithmetic evaluation. If an unquoted '$' is
  followed by a character that is not one of the following:

  * A numeric character
  * The name of one of the special parameters (see 2.5.2 Special
    Parameters)
  * A valid first character of a variable name
  * A <left-curly-bracket> ( '{' )
  * A <left-parenthesis>

  the result is unspecified.

A single-quote is not the name of a special parameter nor valid as the
first character of a variable name, so this is unspecified behavior
and should be avoided in scripts meant to run on an arbitrary POSIX
shell.

However the next major version of POSIX is likely to mandate support
for $'' string handling[2].  Work towards an implementation in dash would
be very welcome.

Thanks and hope that helps,
Jonathan

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06
[2] http://austingroupbugs.net/view.php?id=249
