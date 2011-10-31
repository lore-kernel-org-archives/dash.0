From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 19:48:36 +0100
Message-ID: <1320086916.29101.3.camel@localhost.localdomain>
References: <20111031034146.GA19477@gondor.apana.org.au>
	 <201110310023.45138.vapier@gentoo.org> <4EAE9ECB.4040607@redhat.com>
	 <201110311439.38413.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from relay.csv-networks.nl ([84.244.151.248]:4337 "EHLO
	relay.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933100Ab1JaSsl (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 14:48:41 -0400
Received: from hosting12.csv-networks.nl ([84.244.151.141])
	by mailfilter.csv-networks.nl with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <harald@gigawatt.nl>)
	id 1RKwuT-0007GX-CO
	for dash@vger.kernel.org; Mon, 31 Oct 2011 19:48:39 +0100
Received: from 541f32bc.cm-5-8a.dynamic.ziggo.nl ([84.31.50.188] helo=[10.0.1.201])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1RKwow-0007bQ-V4
	for dash@vger.kernel.org; Mon, 31 Oct 2011 19:42:55 +0100
In-Reply-To: <201110311439.38413.vapier@gentoo.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, 2011-10-31 at 14:39 -0400, Mike Frysinger wrote:
> i plan on digging through the relevant packages and posting patches where 
> applicable.  i might be wrong about the libtool side, but do know of at least 
> one ax m4 file using it (which is what started this rat hole in the first 
> place).  but i consider that a parallel issue :).

That one m4 file was ax_prefix_config_h.m4, for which I submitted a
patch upstream and which got accepted over a year ago:
<http://savannah.gnu.org/patch/index.php?7317>.

Cheers,
Harald

