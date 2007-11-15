From: Oleg Verych <olecom@flower.upol.cz>
Subject: select() for file descriptors (Re: Features.)
Date: Thu, 15 Nov 2007 10:05:04 +0100
Message-ID: <20071115090504.GF22435@flower.upol.cz>
References: <8499950a0711111459h33921caaxde3111fb2b719fea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:38691 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbXKOItl (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 15 Nov 2007 03:49:41 -0500
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id D27081038E2
	for <dash@vger.kernel.org>; Thu, 15 Nov 2007 09:49:38 +0100 (CET)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id G2gYroschUsLKfbJ for <dash@vger.kernel.org>; Thu, 15 Nov 2007 09:49:38 +0100 (CET)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Isaem-00078M-Rm
	for dash@vger.kernel.org; Thu, 15 Nov 2007 10:05:04 +0100
Content-Disposition: inline
In-Reply-To: <8499950a0711111459h33921caaxde3111fb2b719fea@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dAsh <dash@vger.kernel.org>

> 5. File descriptors.
> 
  5.X select() functionality. I.e. adding blocking/non blocking semantics
      with timeouts.

How i could forget that? Anyway, just for record or possible
discussion, let me place it here.
____
