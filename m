From: "Oleg Verych" <olecom@gmail.com>
Subject: command modifiers (Re: Changes with provided user's source code transform (Size and performance efficient rewriting of the `dash.test` built-in))
Date: Thu, 1 May 2008 02:00:41 +0100
Message-ID: <8499950a0804301800x3577741ex3646035f8350e399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:24803 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbYEABAp (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 30 Apr 2008 21:00:45 -0400
Received: by py-out-1112.google.com with SMTP id u52so1183028pyb.10
        for <dash@vger.kernel.org>; Wed, 30 Apr 2008 18:00:42 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

>  == original proposition for -nt -ot (specifying lists of files to check) ==

To list of my failed shell inventions[0], i'd like to add following.

[0] ftp://flower.upol.cz/dts/ash0000_var/ideas

`test` or `[` commands show, that static shell parsing rules are not flexible.
Someone invented `[[`, somebody will invent similar (mis-)behaviour, if `sh`
will be more popular. Statement: command modifiers.

> `test: $1 = $2` -- don't do IFS spliting on $VARS (just like `[[`)

> `expr, "$1" * "$2"` -- don't expand shell patterns; or just
> `expr:, $1 * $2 `; options may be included e.g.
>> `test,n "$file" -nt arch/avr32/*` -- don't leave unexpanded patterns
>> `test:,b $file -nt [^a].*` -- pattern is BRE, (ERE, etc, what libc provides)
(examples are using -nt proposition, but `make` with file-name patterns can
there as well) etc. (still collecting input)

>`/bin/chroot! .`-- don't copy environment

So, shell will be more flexible without compatibility issues. Wired
commands with similar endings must be quoted in double quotes or placed
in vars (another way of quotation).

> `$CMD:: $2` -- just invented -- do double parsing of CMD like `eval`. Problem
with `eval` is, that it doesn't handle infinite (user input) loops in
provided string.
String is generated script.
(see final page of ftp://flower.upol.cz/upload/colorize-linux-build.sh )

etc. Use your imagination and be creative. `perl` didn't provide shell
after all.
-- 
sed 'sed && sh + olecom = love' << ''
-o--=O`C
 #oo'L O
<___=E M
