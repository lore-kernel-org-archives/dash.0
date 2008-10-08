From: Sven Mascheck <mascheck@in-ulm.de>
Subject: historic syntax for loop body
Date: Wed, 8 Oct 2008 17:28:06 +0200
Message-ID: <20081008152806.GA23631@lisa.in-ulm.de>
Reply-To: mascheck@in-ulm.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.in-ulm.de ([217.10.8.10]:36541 "HELO mail.in-ulm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751495AbYJHPfF (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 8 Oct 2008 11:35:05 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The manpage still documents support for the historic almquist for-loop
syntax, "do and done may be replaced with { and }".  But it's not
implemented anymore.

I'm curious: when has it been removed?
(I can't see it in the changelogs, and it seems to have gone between
ash-0.3.8 and some earlier dash-0.4.x)

Why am I asking?  I was just curious and I stumbled over this because
AFAIK dash is the only ash variant (well, except busybox) which has it
removed; I guess simply due to POSIX, and because it had been everything
but common usage anyway.

Sven
