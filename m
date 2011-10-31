From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 19:07:24 +0100
Message-ID: <1320084444.28517.11.camel@localhost.localdomain>
References: <20111031034146.GA19477@gondor.apana.org.au>
	 <201110310023.45138.vapier@gentoo.org> <4EAE9ECB.4040607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from relay.csv-networks.nl ([84.244.151.248]:4219 "EHLO
	relay.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933659Ab1JaS1l (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 14:27:41 -0400
Received: from hosting12.csv-networks.nl ([84.244.151.141])
	by mailfilter.csv-networks.nl with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <harald@gigawatt.nl>)
	id 1RKwGb-00071y-7n
	for dash@vger.kernel.org; Mon, 31 Oct 2011 19:07:25 +0100
Received: from 541f32bc.cm-5-8a.dynamic.ziggo.nl ([84.31.50.188] helo=[10.0.1.201])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1RKwB4-0004HS-SK
	for dash@vger.kernel.org; Mon, 31 Oct 2011 19:01:43 +0100
In-Reply-To: <4EAE9ECB.4040607@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Mon, 2011-10-31 at 07:12 -0600, Eric Blake wrote:
> Scripts that rely on a certain interpretation of "echo '\1'" are broken 
> regardless of how dash behaves; but that said, since POSIX doesn't 
> require dash's current behavior, and since the proposed patch makes dash 
> both smaller and more like other shells in treating it as an extension 
> that means a literal 1 rather than an octal escape, I would be in favor 
> of making the change in dash.

The problem with that is that the patch makes dash behave differently
from other shells in its interpretation of printf's %b format. bash, for
instance, does accept \1 escape sequences there, as an extension to
POSIX. Currently, so does dash. With this patch, it stops working in
dash. And unsharing the code between echo and printf would probably make
dash larger.

There's also another problem: the patch doesn't work as advertised
anyway. It should continue to make echo "\0101" print a single character
followed by newline. Instead, with that patch dash takes \010 as an
escape sequence, and then follows it by 1 and a newline.

Cheers,
Harald

