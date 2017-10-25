From: Martijn Dekker <martijn@inlv.org>
Subject: Re: [BUG] quoted substring parameter expansion ignores single-quotes
 in the arg
Date: Wed, 25 Oct 2017 12:08:42 +0200
Message-ID: <a2539560-b359-e465-e427-9b85cdd8a545@inlv.org>
References: <20170926034148.ohemy3jubd2nskyj@gmx.com>
 <20171019104103.7gzflupyi27artlg@gmx.com> <20171021121343.GA29646@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:35332 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932321AbdJYKP7 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 25 Oct 2017 06:15:59 -0400
Received: from breedzicht.local ([145.15.244.16])
        (authenticated bits=0)
        by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id v9PA8hFM007121
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <dash@vger.kernel.org>; Wed, 25 Oct 2017 12:08:44 +0200
In-Reply-To: <20171021121343.GA29646@stack.nl>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Op 21-10-17 om 14:13 schreef Jilles Tjoelker:
[...]
> I think it is sufficiently clear that various special
> characters are active in ${param#word}, whether the outer substitution
> is within double-quotes or not.

Yes -- this came up on austin-group-l some time ago as well.
https://www.mail-archive.com/austin-group-l@opengroup.org/msg00197.html

> Although zsh is a good interactive shell, it does not follow
> POSIX as closely; not even in sh or ksh emulation mode.

I think that may have changed. Try the latest version. Over the last
year or two, many POSIX compliance bugs have been fixed. I believe the
latest version is about as compliant as bash or dash.

Zsh does still accept the wrong "${param#'}" expansion like dash does,
but handling non-compliant input is more like an extension than actual
non-compliance. Zsh acts correctly on "${param#\'}", like dash. It also
acts correctly on "${param#'foo'}", *unlike* dash.

- M.
