Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20153C64E7B
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B501F2087D
	for <linux-dash@archiver.kernel.org>; Tue,  1 Dec 2020 06:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgLAGHH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 1 Dec 2020 01:07:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:47738 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLAGHH (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 1 Dec 2020 01:07:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kjynq-00043g-Dp; Tue, 01 Dec 2020 17:06:19 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 01 Dec 2020 17:06:18 +1100
Date:   Tue, 1 Dec 2020 17:06:18 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     dash@vger.kernel.org, Michael Biebl <biebl@debian.org>,
        974705@bugs.debian.org
Subject: Re: Changes to job handling cause hangs in wait
Message-ID: <20201201060618.GA27281@gondor.apana.org.au>
References: <0b1af921-f0dc-33e1-eae3-91192c2ec60a@collabora.co.uk>
 <20201201053837.GA26889@gondor.apana.org.au>
 <20201201054203.GA27074@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201201054203.GA27074@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On Tue, Dec 01, 2020 at 04:42:03PM +1100, Herbert Xu wrote:
>
> Nevermind, I see that the script has been modified to use bash.
> 
> I can reproduce the problem now so it's all good.

OK the problem is this:

	sh -c 'sleep 1d& exec $MYSHELL -c "sleep 1& wait"'

You can replace MYSHELL with whatever shell you want to use.

Essentially dash will now wait for all children, even ones that
were created prior to its existence, however, bash only waits for
children that it created directly.

FWIW ksh exhibits the same behaviour as dash and I think there
is nothing wrong with this.

So the problem is really in the parent of this shell, which appears
to be bash:

bash -c set -e; export USER=`id -nu`; . /etc/profile >/dev/null 2>&1 || true;  . ~/.profile >/dev/null 2>&1 || true; buildtree="/tmp/autopkgtest-lxc.is4n6xxr/downtmp/build.f2G/real-tree"; mkdir -p -m 1777 -- "/tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-artifacts"; export AUTOPKGTEST_ARTIFACTS="/tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-artifacts"; export ADT_ARTIFACTS="$AUTOPKGTEST_ARTIFACTS"; mkdir -p -m 755 "/tmp/autopkgtest-lxc.is4n6xxr/downtmp/autopkgtest_tmp"; export AUTOPKGTEST_TMP="/tmp/autopkgtest-lxc.is4n6xxr/downtmp/autopkgtest_tmp"; export ADTTMP="$AUTOPKGTEST_TMP"; export DEBIAN_FRONTEND=noninteractive; export LANG=C.UTF-8; export DEB_BUILD_OPTIONS=parallel=2; unset LANGUAGE LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE   LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS   LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL;rm -f /tmp/autopkgtest_script_pid; set -C; echo $$ > /tmp/autopkgtest_script_pid; set +C; trap "rm -f /tmp/autopkgtest_script_pid" EXIT INT QUIT 
 PIPE; cd "$buildtree"; export AUTOPKGTEST_NORMAL_USER=; export ADT_NORMAL_USER=; chmod +x /tmp/autopkgtest-lxc.is4n6xxr/downtmp/build.f2G/real-tree/debian/tests/timedated; touch /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stdout /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stderr; /tmp/autopkgtest-lxc.is4n6xxr/downtmp/build.f2G/real-tree/debian/tests/timedated 2> >(tee -a /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stderr >&2) > >(tee -a /tmp/autopkgtest-lxc.is4n6xxr/downtmp/timedated-stdout);

For some reason this is causing the final two tee's to be created
as children of debian/tests/timedated rather than the bash shell.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
