From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 3 Dec 2015 21:17:48 +0000
Message-ID: <20151203211748.GC9581@chaz.gmail.com>
References: <n3nrqu$mj2$1@ger.gmane.org>
 <5660ADD6.4020308@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33046 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbLCVRv (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 Dec 2015 16:17:51 -0500
Received: by wmec201 with SMTP id c201so46788851wme.0
        for <dash@vger.kernel.org>; Thu, 03 Dec 2015 13:17:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5660ADD6.4020308@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Gioele Barabucci <gioele@svario.it>, dash@vger.kernel.org

2015-12-03 22:02:14 +0100, Harald van Dijk:
[....]
>   $ for shell in bash mksh posh zsh; do printf %s: "$shell"; $shell
> -c 'IFS=,; echo a, | { read v; echo "<$v>"; }'; done
>   bash:<a>
>   mksh:<a>
>   posh:<a,>
>   zsh:<a,>
> 
> As far as I can tell, the posh/zsh behaviour is the correct
> behaviour, but I'm not convinced yet my interpretation is correct.
[...]

No, that would be the same as for:

v=a:b:
IFS=:
set -f

set -- $v

It's meant to split into "a" and "b", not "a", "b" and "". As
":" is meant to be treated as a *delimiter* or *terminator*.

That has been discussed a few times on the austin group mailing
list.

zsh and pdksh (and other descendants of the Forsyth shell) treat it as
separator (and are not compliant), mksh (derived from pdksh)
changed it recently. posh (also based on pdksh) still hasn't changed it.

That's a bit counter-intuitive and means for instance you can't
use $IFS to split variables like $PATH/$LD_LIBRARY_PATH...

In the case of read, it even makes less sense because:

~$ echo a:: | sh -c 'IFS=: read a; echo "$a"'
a::
~$ echo a: | sh -c 'IFS=: read a; echo "$a"'
a

But that's how it's specified.

So dash is indeed conformant there.

-- 
Stephane
