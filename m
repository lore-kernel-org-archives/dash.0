From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH 1/2] [SHELL] Allow building without LINEO support.
Date: Wed, 17 Aug 2011 08:04:46 +0200
Message-ID: <1313561086.28006.6.camel@linux>
References: <20110816.174502.2209127983953431973.davem@davemloft.net>
	 <20110817011235.GA22867@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:51612 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab1HQGIE (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 17 Aug 2011 02:08:04 -0400
Received: from 541f32bc.cm-5-8a.dynamic.ziggo.nl ([84.31.50.188] helo=[10.0.1.116])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1QtZEf-0002RZ-21
	for dash@vger.kernel.org; Wed, 17 Aug 2011 08:04:17 +0200
In-Reply-To: <20110817011235.GA22867@elie.gateway.2wire.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Tue, 2011-08-16 at 20:12 -0500, Jonathan Nieder wrote:
> David Miller wrote:
> 
> > [Subject: [SHELL] Allow building without LINEO support.]
> 
> Thanks!  Debian has been using something like this (but unconditional)
> to convince autoconf not to use dash as CONFIG_SHELL, to work around
> bugs in various configure scripts[1].  I imagine other users might
> want the same thing, so a patch like this seems like a good idea.

If you don't mind me asking, if you want configure scripts to run from
bash, why not simply run configure scripts from bash, instead of running
them from sh and trusting that sh will call bash if it is really some
other shell? Don't get me wrong, there are other reasons why making
LINENO support optional is a good idea (smaller executable at the low
cost of a rarely used feature), so don't take this as an argument
against this patch, I'm just curious about this one point.

