From: maximilian attems <max@stro.at>
Subject: [RFC] klibc dash merge
Date: Sat, 4 Jun 2011 07:00:05 +0000
Message-ID: <20110604070005.GE22026@vostochny.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:37587 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab1FDHAG (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 4 Jun 2011 03:00:06 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: klibc@zytor.com, dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.hengli.com.au>

Hello,

Since klibc dash last merge is a bit dated yesterday I resyncronised
the dash in klibc repo from dc2bc17c7bbe3188cfb0c695dc472b39bcf0b27a
up to ec2c84d3c4dba4b74440d72bdd1de416a9acd2a9 commit.

Please test it:
git://git.kernel.org/pub/scm/libs/klibc/klibc-queue.git
http://git.kernel.org/?p=libs/klibc/klibc-queue.git;a=shortlog

Without objections this will land in klibc-1.5.23.

It got easier (less error prone handeting) since newer git got more
features. Only some commits needed a manual merge fixup.
The end result runs fine for an initramfs-tools boot.

Nevertheless please give me hints if I shouldn't merge at this
point of history and wait for some upcoming push (eventual v0.5.7)?

Thank you

-- 
maks


P.S. will send soonest the DEBUG compile fix.
P.P.S need to send in 2 klibc dash features to the main repo from hpa.

