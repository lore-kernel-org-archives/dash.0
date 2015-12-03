From: Martijn Dekker <martijn@inlv.org>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 03 Dec 2015 22:43:39 +0100
Message-ID: <5660B78B.5000302@inlv.org>
References: <n3nrqu$mj2$1@ger.gmane.org> <5660ADD6.4020308@gigawatt.nl> <20151203211748.GC9581@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:51239 "EHLO kahlil.inlv.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbbLCWNU (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 Dec 2015 17:13:20 -0500
Received: from breedzicht.local (inlv.demon.nl [212.238.240.159])
	(authenticated bits=0)
	by kahlil.inlv.org (8.14.9/8.14.4) with ESMTP id tB3Lhdnx008146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <dash@vger.kernel.org>; Thu, 3 Dec 2015 22:43:40 +0100
In-Reply-To: <20151203211748.GC9581@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Stephane Chazelas schreef op 03-12-15 om 22:17:
> It's meant to split into "a" and "b", not "a", "b" and "". As
> ":" is meant to be treated as a *delimiter* or *terminator*.

That was my interpretation of the standard, too. So I reported this as a
bug to author of yash, but he reads the standard differently and came up
with a good argument for that. See:

https://osdn.jp/ticket/browse.php?group_id=3863&tid=35283#comment:3863:35283:1435293070

Summarising: POSIX states that "each occurrence in the input of an IFS
character that is not IFS white space, along with any adjacent IFS white
space, shall delimit a field". This *may* be interpreted to read that a
final non-whitespace IFS character denotes an empty final field, because
otherwise that final character wouldn't be delimiting any field, but
only terminating one. It's pretty ambiguous, though.

Based on that discussion I concluded that both interpretations are
defensible, so I didn't report this to the zsh-workers list as a bug.
(In the shell library I'm developing, which you have an earlier copy of,
I gave this quirk the id QRK_IFSFINAL instead of BUG_IFSFINAL to reflect
that it's a quirk.) Maybe this is still worth bringing up on zsh-workers
as a discussion, but lately I haven't had much time.

- Martijn

