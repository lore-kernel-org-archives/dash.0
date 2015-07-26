From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: Ignored alias inside for loop
Date: Sun, 26 Jul 2015 20:41:59 +0200
Message-ID: <20150726184159.GB4346@stack.nl>
References: <55B4A728.9080303@openmailbox.org>
 <20150726152602.GA4346@stack.nl>
 <55B50628.5090901@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:52686 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753856AbbGZSmB (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 26 Jul 2015 14:42:01 -0400
Content-Disposition: inline
In-Reply-To: <55B50628.5090901@openmailbox.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rusty Bird <rustybird@openmailbox.org>
Cc: dash@vger.kernel.org

On Sun, Jul 26, 2015 at 04:09:12PM +0000, Rusty Bird wrote:
> > Aliases are expanded during parsing, not during execution (like 
> > functions are). The for loop is parsed completely before it is
> > executed.

> Ah, what confused me was that I wrongly remembered it working inside
> an if (instead of for) block. But looking again now, only the alias
> *definition* was inside.

> > Using a function instead of an alias, or using eval will do what
> > you want.

> Do you mean replacing the line with: eval "alias foobarbaz='echo ok'"
> That doesn't seem to work either (in dash or bash).

eval foobarbaz

This may not be practical since it needs to be done for every alias use.

-- 
Jilles Tjoelker
