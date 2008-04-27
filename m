From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: job control (Re: dash race)
Date: Sun, 27 Apr 2008 13:49:17 +0200
Message-ID: <20080427114917.GN24008@flower.upol.cz>
References: <4811D0F1.20801@gmail.com> <20080425161721.GM24008@flower.upol.cz> <4814624D.6010108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:55670 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYD0L2e (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 07:28:34 -0400
Content-Disposition: inline
In-Reply-To: <4814624D.6010108@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: dash list <dash@vger.kernel.org>

[...]
> >Also, `ps` && `kill` is better implementation of job control. dash's
> >interactivity isn't a good one, so what reason is behind shell's job
> >control after all?
> 
> I don't understand this.

You don't understand, that `wait` and job control is interactive shell
features adopted from Korn Shell?

Then we talk different languages, sorry.
____
