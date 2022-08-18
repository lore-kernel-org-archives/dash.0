Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FF8C00140
	for <linux-dash@archiver.kernel.org>; Thu, 18 Aug 2022 14:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiHROWb (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiHROWb (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 18 Aug 2022 10:22:31 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F6FAFAF7
        for <dash@vger.kernel.org>; Thu, 18 Aug 2022 07:22:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ABED65C0136;
        Thu, 18 Aug 2022 10:22:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 18 Aug 2022 10:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        greenberg.science; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660832547; x=1660918947; bh=clcUwAlR8MG5mgG3EeGxubyOh
        X9ktG2B4fQmuTzT2JI=; b=Z2MLvqPETKrYcudzet/64Gs4r3V864EH5dV4V0Piw
        7bF5SjlHbW/1Mhnr4lYkaVuYrS5UvtPNcoiX5iXabbZM17ba9e0CawiTsbRUhGBi
        PUA5y0s6fkBBbkRhH50alyTJbETKAQ53HmKzbb3EDW+hT5hGQ0bD9TeHhLFOP6os
        2o/9ar046a0f1OAJns9ayIaQH1uhEJqy8i7zCqknw37RLeuZMG0gsfWSLorn+l1Q
        75l4+lOiw9ErkU0FM2ct1XsjfT+r1vKWV73+oeqErBrH72EN+lGqs49bke8PG4w+
        hrwqMsmslDN7PqHzgwUGJRQzlNKn8+bDhRRwE4NaCYQQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1660832547; x=1660918947; bh=c
        lcUwAlR8MG5mgG3EeGxubyOhX9ktG2B4fQmuTzT2JI=; b=WlrxVNh9v+KbGztXQ
        629y4MdF2pg9lEyg2IJtkgPxZeTjBEVZ+7gz+dIk3hvOG4yhHbyKoWbPUBTRVsYb
        9JMelo5K3Ca6lXcA7pY5rZhzdHwrkYC0wjvW/YWtBLMyXTROvdYbOTTdN3C8Y5Nm
        lmfDo2rtgUOiZp+TwdMIwCFQAfdq2Mlg1hxTlTGmBhAMiV2ozul56Z0AdN4ywJ93
        PMl+yf51E9LjzAqg/tEH/WenPy9j6wNSKDUs+d5dlLgw53XxCqZKA/NGWozIPRbJ
        qYKZFVQfd7I44XdgtRVYwERMm0Ik8hY9G6thM5cjvBvzokZP4XeicS2U9sYucRal
        qEprg==
X-ME-Sender: <xms:I0v-YoPPBzgYAVvQNi_LX6amwijZ0BPx566p523qOIbhnBhBKUC_kA>
    <xme:I0v-Yu8ofQ5r1gzVA64h_Hw3-lDQWdqf7SZ-Q_Ip3y_tbeHpAj4p6jf7rpU8AE2OC
    IrxGZ8tHT6UGbGAl4o>
X-ME-Received: <xmr:I0v-YvR_xZM6sG6jwDU5LnBEeqxzp3XCSQK-x260gaKRrZaaJOy7UM5QsSGQPbb2Qn3j742IBk3FWhCFIgypWahSjVcz1x0w_9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    fujghffffkgggtgfesthhqredttddtjeenucfhrhhomhepofhitghhrggvlhcuifhrvggv
    nhgsvghrghcuoehmihgthhgrvghlsehgrhgvvghnsggvrhhgrdhstghivghntggvqeenuc
    ggtffrrghtthgvrhhnpefghfdvhfdvffevtdfhjeekieduuefgteeujeegheffheekhfeh
    feettddvkeefieenucffohhmrghinhepghhnuhdrohhrghdpuggvsghirghnrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghh
    rggvlhesghhrvggvnhgsvghrghdrshgtihgvnhgtvg
X-ME-Proxy: <xmx:I0v-Ygsf4C0Ocy-COfFA7bRgyOBnIXDR3ScxAZM-PNsKxTWz3J2Fng>
    <xmx:I0v-YgfeuEivHFDIr1lZECnSJQJ3oMxyTKHIWLMl3T239yispFS7PQ>
    <xmx:I0v-Yk1vi089nnGUM06rBvJj5dcUeQ92N3So5EiOWDUSLbssS1M3cA>
    <xmx:I0v-Yoknf-mAtS4a9bHVLABz71GTXM_eDib_tfrMK0j2FYuRc2FY4A>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Aug 2022 10:22:27 -0400 (EDT)
From:   Michael Greenberg <michael@greenberg.science>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: Fwd: Bug#1017531: dash: for/while/if suppress errors from
 redirections with -e
In-Reply-To: <20220818114412.zeqv5auujpuvfskk@tarta.nabijaczleweli.xyz>
References: <20220818114412.zeqv5auujpuvfskk@tarta.nabijaczleweli.xyz>
Date:   Thu, 18 Aug 2022 10:22:25 -0400
Message-ID: <m2sfltskbi.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

This looks like a serious bug... nice find!

I just checked my reference semantics shell (smoosh), and it fails this
test as well. Notably, smoosh passes the POSIX test suite---which means
that the POSIX folks are not properly testing for this behavior.

Also: what version of bash are you running? I suspect the fix to this in
bash is fairly recent.

$ bash --version
GNU bash, version 4.4.12(1)-release (x86_64-apple-darwin17.7.0)
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
$ bash -ec 'while :; do :; done < /ENOENT; echo uhoh'
bash: /ENOENT: No such file or directory
uhoh

$ /bin/bash --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin17)
Copyright (C) 2007 Free Software Foundation, Inc.
$ /bin/bash -ec 'while :; do :; done < /ENOENT; echo uhoh'
/bin/bash: /ENOENT: No such file or directory
uhoh

Cheers,
Michael

On 2022-08-18 at 01:44:12 PM, =D0=BD=D0=B0=D0=B1 wrote:

> Hi!
>
> Thought I'd forward this upstream, considering I already tested on
> current git, and it's pretty grave.
>
> https://bugs.debian.org/1017531, trimmed down a bit, follows:
>
> ----- Forwarded message from =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczl=
eweli.xyz> -----
>
> Subject: Bug#1017531: dash: for/while/if suppress errors from redirections
>  with -e, POSIX violation
>
> Dear Maintainer,
>
> On current git (057cd650a4edd5856213d431a974ff35c6594489) and 0.5.11.5
> the following holds:
> -- >8 --
> $ ./src/dash -ec 'while :; do :; done < /ENOENT; echo uhoh'
> ./src/dash: 1: cannot open /ENOENT: No such file
> uhoh
> $ ./src/dash -ec 'for _ in :; do :; done < /ENOENT; echo uhoh'
> ./src/dash: 1: cannot open /ENOENT: No such file
> uhoh
> $ ./src/dash -ec 'if :; then :; fi < /ENOENT; echo uhoh'
> ./src/dash: 1: cannot open /ENOENT: No such file
> uhoh
> -- >8 --
>
> The correct output, as demonstrated by bash, is:
> -- >8 --
> $ bash -ec 'while :; do :; done < /ENOENT; echo uhoh'
> bash: line 1: /ENOENT: No such file or directory
> $ bash -ec 'for _ in :; do :; done < /ENOENT; echo uhoh'
> bash: line 1: /ENOENT: No such file or directory
> $ bash -ec 'if :; then :; fi < /ENOENT; echo uhoh'
> bash: line 1: /ENOENT: No such file or directory
> -- >8 --
>
> This is a POSIX violation, and quite a grave one at that:
> set -e is oft[1] used to guard against precisely this type of error!
>
> The same happens if set -e is executed.
>
> All quotes POSIX.1, Issue 7, TC2:
> sh, OPTIONS:
>   > The -a, -b, -C, -e, -f, -m, -n, -o option, -u, -v, and -x options
>   > are described as part of the set utility in Special Built-In
>   > Utilities.=20
>
> set, DESCRIPTION, -e:
>   > When this option is on, when any command fails (for any of the
>   > reasons listed in Consequences of Shell Errors or by returning an
>   > exit status greater than zero), the shell immediately shall exit, as
>   > if by executing the exit special built-in utility with no arguments,
>   > with the following exceptions:
>   >
>   > 1. The failure of any individual command in a multi-command pipeline
>   >    shall not cause the shell to exit. Only the failure of the
>   >    pipeline itself shall be considered.
>   > 2. The -e setting shall be ignored when executing the compound list
>   >    following the while, until, if, or elif reserved word, a pipeline
>   >    beginning with the ! reserved word, or any command of an AND-OR
>   >    list other than the last.
>   > 3. If the exit status of a compound command other than a subshell
>   >    command was the result of a failure while -e was being ignored,
>   >    then -e shall not apply to this command.
>
> XCU, 2.9.4: Shell Command Language, Shell Commands, Compound Commands:
> The while Loop:
>   > The format of the while loop is as follows:
>   >=20
>   > while compound-list-1
>   > do
>   >   compound-list-2
>   > done
> (until is equivalent).
> The if Conditional Construct:=20
>   > The format for the if construct is as follows:
>   >
>   > if compound-list
>   > then
>   >   compound-list
>   > [elif compound-list
>   > then
>   >   compound-list] ...
>   > [else
>   >   compound-list]
>   > fi
>
> It follows, therefore, that
>   * Exception 1. does not apply as there is no pipeline
>   * Exception 2. does not apply, as the redirection does /not/ follow
>     "while" or "if" directly and is /not/ part of the conditional
> 	compound-list
>   * in the "for" case, there is no such provision, so this is likely not
>     a confusion w.r.t. the conditional compound-lists
>   * Exception 3. does not apply as -e was not being ignored while the
>     compound commands were being executed (indeed, the compound commands
>     do not run at all, as evidenced by the program terminating)
>
> [1]: https://salsa.debian.org/glibc-team/glibc/-/merge_requests/6#note_32=
9899
> ----- End forwarded message -----
>
> Best,
> =D0=BD=D0=B0=D0=B1
