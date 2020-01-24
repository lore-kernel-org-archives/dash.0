From: Martijn Dekker <martijn@inlv.org>
Subject: Alias/heredoc/cmdsubst regression
Date: Sat, 25 Jan 2020 00:48:51 +0100
Message-ID: <40db0aa1-195b-f29e-5068-01fa101affd9@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:59536 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbgAYAPK (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 24 Jan 2020 19:15:10 -0500
Received: from breedzicht.fritz.box (inlv.demon.nl [82.161.110.186])
        (authenticated bits=0)
        by kahlil.inlv.org (8.15.2/8.15.2) with ESMTPSA id 00ONmpKi028260
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <dash@vger.kernel.org>; Sat, 25 Jan 2020 00:48:52 +0100
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: DASH shell mailing list <dash@vger.kernel.org>

There is a regression involving alias expansion, a here-document, and a 
command substitution. The following worked fine until dash 0.5.8; it 
throws a syntax error as of dash 0.5.9.

alias BEGIN='{' END='}'
BEGIN
cat <<eof
$(echo hi)
eof
END

With some git brute-forcing I determined this was the commit that broke it:

> commit 7c245aa8ed33ba5db30eef9369d67036a05b0371
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Tue Oct 28 17:22:16 2014 +0800
> 
>     [PARSER] Simplify EOF/newline handling in list parser
> 
>     This patch simplifies the EOF and new handling in the list parser.
>     In particular, it eliminates a case where we may leave here-documents
>     unfinished upon EOF.
> 
>     It also removes special EOF/newline handling from parsecmd.

Related shells:
- I've confirmed the test case to work fine on:
	FreeBSD sh 9, 10, 11 and 12
	NetBSD sh 8 and 9.0RC1
	busybox ash 1.20 - 1.24
- I've confirmed the test case broken on:
	busyboxy ash 1.25 through current

Since busybox ash tracks dash, it's not surprising it broke there as well.

- M.

-- 
modernish -- harness the shell
https://github.com/modernish/modernish
