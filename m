From: jca+dash@wxcvbn.org (=?utf-8?Q?J=C3=A9r=C3=A9mie_Courr=C3=A8ges-Angl?=
	=?utf-8?Q?as?=)
Subject: Re: [PATCH dash] [BUILTIN] ensure LC_COLLATE is not overriden
Date: Tue, 05 Aug 2014 19:00:30 +0200
Message-ID: <87wqamswgh.fsf@ritchie.wxcvbn.org>
References: <1407256813-30944-1-git-send-email-chema@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from chomsky.autogeree.net ([91.216.110.36]:56317 "EHLO
	chomsky.autogeree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbaHERFM (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 5 Aug 2014 13:05:12 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chema Gonzalez <chema@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

Chema Gonzalez <chema@google.com> writes:

> If the user environment has either LC_ALL or LANG defined, the setting
> of LC_COLLATE in src/mkbuiltins is overriden. With a non-POSIX locale,
> the orders of dotcmd (remember that '.' is 0x2e in ascii) and truecmd
> (':' is 0x3a in ascii) are reversed, which makes the ":" command fail
> in the bsearch.

Actually the problem should only occur when you set LC_ALL, which
overrides LANG and LC_COLLATE.  Even though some may find nice to
protect the unwary, but I'd expect lots of brokenness in this unusual
build situation, and this not limited to dash.

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE
