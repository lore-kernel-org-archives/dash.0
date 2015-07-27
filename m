From: Seb <sbb@tuxfamily.org>
Subject: Re: Ignored alias inside for loop
Date: Mon, 27 Jul 2015 10:24:19 +0200
Message-ID: <20150727082419.GA811@ein.free.fr>
References: <55B4A728.9080303@openmailbox.org>
 <20150726152602.GA4346@stack.nl>
 <55B50628.5090901@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:41166 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbG0IY0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 27 Jul 2015 04:24:26 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id D5F60D1A0AE
	for <dash@vger.kernel.org>; Mon, 27 Jul 2015 10:24:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55B50628.5090901@openmailbox.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Rusty Bird <rustybird@openmailbox.org>

On Sun, Jul 26, 2015 at 04:09:12PM +0000, Rusty Bird wrote:

Hello,

> > Using a function instead of an alias, or using eval will do what
> > you want.
> 
> Do you mean replacing the line with: eval "alias foobarbaz='echo ok'"
> That doesn't seem to work either (in dash or bash).

In this case, where there is no further expansion to be done in the
alias content, you could use a mere variable:

  foobarbaz='echo ok'
  $foobarbaz "$@"

Or, if some further expansion has to be made, 'eval' again:

  foobarbaz='echo $PATH'
  eval $foobarbaz '"$@"'

++
Seb.

