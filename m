Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB59C433DB
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 20:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB20A64DDE
	for <linux-dash@archiver.kernel.org>; Fri, 29 Jan 2021 20:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhA2Uhg (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:37:36 -0500
Received: from scw01.stack.nl ([51.15.111.152]:60982 "EHLO mail02.stack.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232887AbhA2Uhf (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 29 Jan 2021 15:37:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail02.stack.nl (Postfix) with ESMTP id 38F221E00A3;
        Fri, 29 Jan 2021 20:36:52 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
        by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jP7hhNZjUqYd; Fri, 29 Jan 2021 20:36:50 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
        by mail02.stack.nl (Postfix) with ESMTP id 516391E0093;
        Fri, 29 Jan 2021 20:36:50 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
        id 349222422A7; Fri, 29 Jan 2021 21:36:50 +0100 (CET)
Date:   Fri, 29 Jan 2021 21:36:50 +0100
From:   Jilles Tjoelker <jilles@stack.nl>
To:     earnestly <zibeon@gmail.com>, dash@vger.kernel.org
Subject: Re: getopts appears to not be shifting $@ when consuming options
Message-ID: <20210129203650.GA21262@stack.nl>
References: <YBRTFXGM6pLwR5hg@teapot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBRTFXGM6pLwR5hg@teapot>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Fri, Jan 29, 2021 at 06:25:25PM +0000, earnestly wrote:
> In this example dash will repeatedly append 'attr=foo' to the list of
> parameters in an infinite loop:

>     #!/bin/dash -x

>     while getopts :a: arg -a foo -a bar; do
>         case $arg in
>             a) set -- "$@" attr="$OPTARG"
>         esac
>     done
>     shift "$((OPTIND - 1))"

> Instead I expected this to result in parameter list containing
> 'attr=foo' and 'attr=bar'.

Hmm, that's pretty clever. By passing the parameters to be parsed to the
getopts command instead of via $@, it is possible to modify $@ without
violating POSIX's rule that only allows parsing a single unmodified set
of parameters (unless getopts is reset via OPTIND=1).

Unfortunately, dash and FreeBSD sh reset the getopts state when the
positional parameters are modified via set or shift. They probably do
this to avoid use after free and out of bounds memory access when a
script violates POSIX's rule. However, when the parameters come from the
getopts command, there is no violation of the rule and no memory
unsafety problem.

> This works in all shells I have been able to test with the exception of
> busybox sh:

>     * sh   (bash)
>     * bash (All versions from 1.14 through 5.1.4)
>     * mksh (MIRBSD KSH R59 2020/05/16)
>     * ksh  (93u+)
>     * zsh  (5.8)
>     * zsh --emulate sh
>     * heirloom-sh (bourne)

> The only workaround I've found is to explicitly use `shift 2` in the a)
> case and obviate the final shift using OPTIND.  This will unfortunately
> break every other shell.

Since you need code to "un-eval" a list of parameters to construct the
getopts command above in a general case, a better workaround would be to
use that code to construct the attr="$OPTARG" list.

If your actual code is more like:

set -- -a foo -a bar # for testing
while getopts :a: arg; do
...

then the script violates the rule I mentioned, and has unspecified
results.

-- 
Jilles Tjoelker
