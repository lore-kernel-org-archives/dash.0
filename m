Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05506C433F5
	for <linux-dash@archiver.kernel.org>; Sun, 20 Feb 2022 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiBTQCi (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 20 Feb 2022 11:02:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiBTQCh (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 20 Feb 2022 11:02:37 -0500
X-Greylist: delayed 31584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Feb 2022 08:02:14 PST
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80421E12
        for <dash@vger.kernel.org>; Sun, 20 Feb 2022 08:02:13 -0800 (PST)
Received: (Authenticated sender: stephane@chazelas.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 010361BF205;
        Sun, 20 Feb 2022 16:02:11 +0000 (UTC)
Date:   Sun, 20 Feb 2022 16:02:11 +0000
From:   Stephane Chazelas <stephane@chazelas.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     dash@vger.kernel.org
Subject: Re: how is locale/unset intended to work with dash?
Message-ID: <20220220160211.wmq6vpo7taxczd3r@chazelas.org>
References: <2a150a397fcdda7dd357dd5b125ec585acce3a70.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a150a397fcdda7dd357dd5b125ec585acce3a70.camel@scientia.org>
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

2022-02-20 05:15:23 +0100, Christoph Anton Mitterer:
[...]
> I'm trying to understand how local/unset works with dash... and it
> seems to be a bit dangerous.
[...]

AFAIK, it's the Almquist shell that first introduced the "local"
builtin. It was later added to bash¹, zsh, ksh, pdksh, yash, bosh
etc but with semantics slightly different between all shells.

See
https://unix.stackexchange.com/questions/493729/list-of-shells-that-support-local-keyword-for-defining-local-variables/493743#493743
for details.

In the Almquist shell, "local" just makes the variable local to
the function, it doesn't change its value nor attributes. Upon
returning from the function, its original value and attributes
from before invoking "local" are restored.

That's one of the most consistent APIs among shells that have a
local builtin/keyword. IIRC, that's also the API bosh chose.

It can be surprising and dangerous if you're used to the
ksh/bash semantic whereby a new variable is instanciated (though
possibly with some attributes inherited from the original
variable) initially unset, upon the first invocation of "local"
in a given scope.

But in ash-based shells such as dash, you can do:

   local var
   unset -v var

If you want the local variable to be initially unset.

That approach doesn't work in some other shells such as mksh
where unset -v would not unset the variable but peel one level
of local'ness (reveal the variable from the parent scope if
any).

That was discussed extensively on the POSIX (austin-group-l)
mailing list a few years back. The maintainer of NetBSD sh (also
based on ash, and IIRC on which dash is based on), had suggested
adding some -I (inherit, default) and -N (null / unset) options
to "local" so you can decide which behaviour you want in the
hope that other shells would follow so POSIX can eventually
specify a "local" keyword for sh that satisfies existing
implementations.

I'm not aware that any other shell followed that. bash came up
with an alternative mechanism instead: the localvar_inherit
options which affects all "local" invocations.

So:

  bash -O localvar_inherit -O localvar_unset

(localvar_unset fixing a misfeature of bash whereby unset could
also fail to unset in some conditions like in mksh).

should behave similarly to ash-based shells such as dash.

With that clarified, commenting on your post:

> In bash, e.g., it seems to work like that:
> always the var from the next outer scope is used, when
> setting/expanding/unsetting
> 
> This implies, that bash "shadows" variables, e.g.
> 
> $ x=Vtop
> $ f1() { local x=V1 ; f2; echo f1 $x ; }
> $ f2() { echo f2 $x ; unset -v x ; echo f2 $x ; }
> $ echo top $x
> $ f1
> $ echo top $x
> 
> would give this in bash:
> top Vtop
> f2 V1
> f2 Vtop
> f1 Vtop
> top Vtop
> 
> In other words, as soon as x is unset in f2, the f1()'s local x ceases
> to exist and the global x is used.

That's the misfeature I was talking about: when unset is called
from a function where the variable has not been defined, it
doesn't unset the variable but reveals the variable from the
parent scope like mksh does.

You can do shopt -s localvar_unset for unset to always unset
(without undoing unshadowing the variable) like in ksh/zsh.

[...]
> However,... things can get far more strange:
> $ x=Vtop
> $ f1() { local x=V1 ; f2 ; echo f1 $x; }
> $ f2() { echo f2 $x; unset -v x; echo f2 $x; f3 ; echo f2 $x; }
> $ f3() { echo f3 $x; unset -v x; echo f3 $x; }
> $ echo top $x
> vf1

???

> $ echo top $x

???
 
> which gives in dash:
> 
> top Vtop
> f2 V1
> f2
> f3
> f3
> f2
> f1
> top Vtop   <- shouldn't that have been unset by the f3’s unset?
>               f1’s x was already gone by then

No, x was made local by f1. No amount of unsetting from within
that invocation, even if it's in subfunctions will undo that, it
still unsets (removes a value from) the local variable of f1.
.
The variable is local, that's the whole point, you don't want
whatever f1 does to affect the "x" variable of the parent scope
(which is why I call bash/mksh's behaviour a misfeature).

When f1 returns, the value and attributes of x are restored from
when before "local x" was invoked 

[...]
> => when the unset is in the *same* scope level as the `local` ... it
> doesn't "unshadow".

Yes, which is why it's not as bad as in mksh IMO.

---------------
¹ very shortly after in the case of bash, suggesting local was
possibly added to ash and bash independently from each other.
local in bash was an alias for typeset copied from ksh

-- 
Stephane
