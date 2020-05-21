From: Matt Whitlock <dash@mattwhitlock.name>
Subject: Bug in Dash's unquoting of backslashes within backquoted strings
Date: Thu, 21 May 2020 16:06:38 -0400
Message-ID: <b2fe3536-23b8-4d04-8197-701ab50da86f@mattwhitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUUJi (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 21 May 2020 16:09:38 -0400
Received: from resqmta-ch2-04v.sys.comcast.net (resqmta-ch2-04v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A99C061A0E
        for <dash@vger.kernel.org>; Thu, 21 May 2020 13:09:38 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

A minimal example:

: `: "\\\\
\\$(bug)"`

That's one command, containing a newline character, embedded in a=20
double-quoted string, embedded in a backquoted string. The command is an=20
invocation of the : (colon) built-in, passing arguments obtained by word=20
splitting the result of the backquoted command substitution.

The Open Group says: "Within the backquoted style of command substitution,=20=

backslash shall retain its literal meaning, except when followed by: '$',=20
'`', or '\' (dollar sign, backquote, backslash)." Thus, each pair of=20
backslashes between the backquotes is to be reduced to a single backslash.

Thus, the subcommand to be executed is:

: "\\
\$(bug)"

This subcommand is an invocation of the : (colon) built-in command, passing=20=

a single argument obtained by performing quote removal on the double-quoted=20=

string. After quote removal, the resulting argument consists of these eight=20=

characters: backslash, newline, dollar sign, open parenthesis, b, u, g,=20
close parenthesis.

If the above subcommand is entered directly at the Dash command line, all=20
is well. However, when it appears inside a backquoted subcommand (with the=20=

backslash characters being appropriately escaped), such as given at the top=20=

of this report, then Dash processes it incorrectly:

/bin/sh: 1: bug: not found

Dash apparently skips over the backslash immediately following the newline=20=

embedded in the double-quoted string. Thus, Dash sees the dollar sign as=20
introducing a command substitution rather than as a literal character.

This does not happen if the backslashes preceding the embedded newline are=20=

absent. It also does not happen if any other character, including linear=20
whitespace, is inserted immediately after the embedded newline.

Both Bash and Busybox Ash get it right. Dash is non-conformant.

This bug has potentially grave security implications since Dash is=20
interpreting a string literal as though it were a command and executing it.=20=

If the word "bug" in my examples above had been "rm -rf /" instead, the=20
results would have been catastrophic.
