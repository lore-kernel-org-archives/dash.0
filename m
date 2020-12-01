Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E1C83016
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7072085B
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 10:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgLAKfl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:35:41 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:48488 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLAKfl (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 05:35:41 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kk2zg-0002VG-Ti; Tue, 01 Dec 2020 21:34:50 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 21:34:48 +1100
Date:   Tue, 1 Dec 2020 21:34:48 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Andrej Shadura <andrew.shadura@collabora.co.uk>,
        dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201103448.GA28234@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
 <20201201060618.GA27281@gondor.apana.org.au>
 <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <0e6bb3c5-96d9-18e1-e6bb-87cb34f85fab@gigawatt.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 01, 2020 at 10:14:04AM +0000, Harald van Dijk wrote:
> 
> POSIX says:
> 
>   "If  the  wait utility is invoked with no operands, it shall wait until
> all process IDs known to the invoking shell have terminated and exit with a
> zero exit status."
> 
> I would say that child processes that were created before dash was started
> do not have process IDs known to dash.

Well I disagree and the fact that the original ksh does the same
thing is an important fact.

> > bash -c set -e; export USER=`id -nu`; . /etc/profile >/dev/null 2>&1 || true;  . ~/.profile >/dev/null 2>&1 || true; buildtree="/tmp/autopkgtest-lxc.is4n6xxr/downtmp/build.f2G/real-tree"; mkdir -p -m 1777 -- "/tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-artifacts"; export AUTOPKGTEST_ARTIFACTS="/tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-artifacts"; export ADT_ARTIFACTS="$AUTOPKGTEST_ARTIFACTS"; mkdir -p -m 755 "/tmp/autopkgtest-lxc.is4n6xxr/downtmp/autopkgtest_tmp"; export AUTOPKGTEST_TMP="/tmp/autopkgtest-lxc.is4n6xxr/downtmp/autopkgtest_tmp"; export ADTTMP="$AUTOPKGTEST_TMP"; export DEBIAN_FRONTEND=noninteractive; export LANG=C.UTF-8; export DEB_BUILD_OPTIONS=parallel=2; unset LANGUAGE LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE   LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS   LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL;rm -f /tmp/autopkgtest_script_pid; set -C; echo $$ > /tmp/autopkgtest_script_pid; set +C; trap "rm -f /tmp/autopkgtest_script_pid" EXIT INT Q
 UIT PIPE; cd "$buildtree"; export AUTOPKGTEST_NORMAL_USER=; export ADT_NORMAL_USER=; chmod +x /tmp/autopkgtest-lxc.is4n6xxr/downtmp/build.f2G/real-tree/debian/tests/timedated; touch /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stdout /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stderr; /tmp/autopkgtest-lxc.is4n6xxr/downtmp/build.f2G/real-tree/debian/tests/timedated 2> >(tee -a /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stderr >&2) > >(tee -a /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stdout);
> > 
> > For some reason this is causing the final two tee's to be created
> > as children of debian/tests/timedated rather than the bash shell.
> 
> This is because of the same optimisation that dash also has, where it tries
> to avoid creating a subshell for the last command in a list when it can just
> exec() without a fork() instead. A minimal example without an explicit exec
> is
> 
>   bash -c 'dash -c ": & wait" <(sleep 1d)'

I'm not sure about that because bash itself is still hanging around,
if it were really the -c optimisation then bash should not appear in
the ps output at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
