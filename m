From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: strange `printf` arguments, parsing features (bugs?)
Date: Mon, 19 May 2008 05:18:42 +0200
Message-ID: <20080519031842.GH21428@flower.upol.cz>
References: <20080519024755.GG21428@flower.upol.cz> <E1JxvLX-0007jt-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:36284 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbYESC5P (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 22:57:15 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 43221145DE9
	for <dash@vger.kernel.org>; Mon, 19 May 2008 04:56:54 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id h0qsB95Ki6Fk3qeI for <dash@vger.kernel.org>; Mon, 19 May 2008 04:56:54 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jxvta-0008LC-71
	for dash@vger.kernel.org; Mon, 19 May 2008 05:18:42 +0200
Content-Disposition: inline
In-Reply-To: <E1JxvLX-0007jt-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> > Or, if you want to have a slash (odd number), use slash (same). If you
> > what to place two slashes (even), use four (even << 1).
> > 
> > Nice.
> 
> Yes it is confusing, however, the `` construct is deprecated
> and the $() construct is more reasonable in this regard.

Still it is quite useful with nested calls, it is (at least) something
different and interesting with $[{((] all over and also a matter of
taste sometimes. But this behaviour of \\ there is just ugly.
____
