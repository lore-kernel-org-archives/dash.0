From: Wez Furlong <kingwez@gmail.com>
Subject: Re: "fc -l" broken between v0.5.5.1 and v0.5.6
Date: Mon, 9 Aug 2010 23:54:07 -0400
Message-ID: <AANLkTimKQcUa=dpDVoO9TdiH3A5iW1_hJRsOdDE2LB9f@mail.gmail.com>
References: <AANLkTi=7L7EC0xuBF4fqBksFAMAmjEiCc5VgAj75Hg=h@mail.gmail.com>
	<20100808131732.GB83966@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59478 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab0HJDyJ (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 9 Aug 2010 23:54:09 -0400
Received: by wwj40 with SMTP id 40so12422824wwj.1
        for <dash@vger.kernel.org>; Mon, 09 Aug 2010 20:54:07 -0700 (PDT)
In-Reply-To: <20100808131732.GB83966@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Sun, Aug 8, 2010 at 9:17 AM, Jilles Tjoelker <jilles@stack.nl> wrote:
> On Mon, Jul 26, 2010 at 10:17:43AM -0700, Wez Furlong wrote:
>> When building with libedit, I get the following behavior:
>
>> % ./src/dash -E
>> $ fc -l
>> fc: 1: history number -16 not found (internal error)
>> $
>
>> Please bisect this to find the commit that introduced the problem.

0df96793ef6aa103df228d7dfe56099b7d721a15 is first bad commit
commit 0df96793ef6aa103df228d7dfe56099b7d721a15
Author: Rocky Bernstein <rocky.bernstein@gmail.com>
Date:   Tue Aug 11 15:59:33 2009 +1000

    [SHELL] Add preliminary LINENO support

    Looks like in contrast to what the dash.1 manual page says, expansion
    of PS{1,2,4} does work.

    Here is a little patch to set LINENO. The ways in that it is less than
    ideal mirror the ways that the line number error reporting is also
    less than ideal.

    For example if you run this:

    (
        x=$((1/0))
        # Just to add another line
        # And another
    ) # error reports this line

    The error reported will be  the closing parenthesis even though I
    think most people would prefer the error to be the one where x was
    set.

    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

 % git bisect log
# bad: [02a568bb1466de25e9749ee7f501524f9e76c503] Release 0.5.6.
# good: [6045fe25078345074f027312d106d3fc19df56e5] Release 0.5.5.1.
git bisect start 'v0.5.6' 'v0.5.5.1'
# bad: [d53f173bb00bcc1d89ceb9e82b7d7e2b2a8dd852] [EVAL] Revert
SKIPEVAL into EXEXIT
git bisect bad d53f173bb00bcc1d89ceb9e82b7d7e2b2a8dd852
# good: [956b4bd209a9d17613e419e2b50e0f533600497b] [MAN] Update manual
page to differentiate dash from ash
git bisect good 956b4bd209a9d17613e419e2b50e0f533600497b
# good: [55c46b7286f5d9f2d8291158203e2b61d2494420] [BUILTIN] Honor tab
as IFS whitespace when splitting fields in readcmd
git bisect good 55c46b7286f5d9f2d8291158203e2b61d2494420
# bad: [68097929869a3a3e511ac2e2c3d9dc3730652286] [EVAL] Pass
EV_TESTED into evalcmd
git bisect bad 68097929869a3a3e511ac2e2c3d9dc3730652286
# bad: [0df96793ef6aa103df228d7dfe56099b7d721a15] [SHELL] Add
preliminary LINENO support
git bisect bad 0df96793ef6aa103df228d7dfe56099b7d721a15

Digging into this, if I remove the initialization of the LINENO
variable, "fc -l" no longer reports an error:

diff --git a/src/var.c b/src/var.c
index 2737fb1..fd206df 100644
--- a/src/var.c
+++ b/src/var.c
@@ -90,7 +90,7 @@ struct var varinit[] = {
        { 0,    VSTRFIXED|VTEXTFIXED,           "PS2=> ",       0 },
        { 0,    VSTRFIXED|VTEXTFIXED,           "PS4=+ ",       0 },
        { 0,    VSTRFIXED|VTEXTFIXED,           "OPTIND=1",     getoptsreset },
-       { 0,    VSTRFIXED|VTEXTFIXED,           "LINENO=1",     0 },
+//     { 0,    VSTRFIXED|VTEXTFIXED,           "LINENO=1",     0 },
 #ifndef SMALL
        { 0,    VSTRFIXED|VTEXTFIXED|VUNSET,    "TERM\0",       0 },
        { 0,    VSTRFIXED|VTEXTFIXED|VUNSET,    "HISTSIZE\0",   sethistsize },

I'm at a loss to explain this, but having done the legwork, I'll let
you folks figure out how to fix it.

--Wez.
