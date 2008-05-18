From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: Inconsistent parameter expansion
Date: Sun, 18 May 2008 20:11:51 +0200
Message-ID: <20080518181151.GF21428@flower.upol.cz>
References: <20080515142601.GA73886@healthgrid203d.healthgrid.org> <20080518170104.GA26635@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:32950 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYERRu0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 13:50:26 -0400
Content-Disposition: inline
In-Reply-To: <20080518170104.GA26635@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
Cc: Romain Tarti?re <romain.tartiere@healthgrid.org>, dash@vger.kernel.org, Baptiste Grenier <baptiste.grenier@healthgrid.org>

> > I can't figure out why '*/FILE' and '*"/FILE"' are not expanded the same
> > way...

This and one from "[EXPAND] Fix slash treatment in expmeta"
work with Etch:

olecom@flower$ dash -c 'echo "/"root*'
/root
olecom@flower$ dash -c 'echo *"/FILE"'
A/FILE B/FILE C/FILE D/FILE
olecom@flower$


> This is a bug in dash.  The following patch should fix the problem,
> provided that Ubuntu hasn't built dash with glob(3) enabled because
> glob(3) has a similar bug and that needs to be fixed in glibc.

What was/is whole story? What are FNMATCH_BROKEN GLOB_BROKEN?

Thanks.
____
