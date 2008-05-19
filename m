From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: strange `printf` arguments, parsing features (bugs?)
Date: Mon, 19 May 2008 04:47:55 +0200
Message-ID: <20080519024755.GG21428@flower.upol.cz>
References: <20080514165931.GB21428@flower.upol.cz> <E1Jxl0W-0006oV-00@gondolin.me.apana.org.au> <20080518164026.GE21428@flower.upol.cz> <20080519005328.GA29081@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:36110 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYESC0c (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 22:26:32 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id 41EB5145DD1
	for <dash@vger.kernel.org>; Mon, 19 May 2008 04:26:11 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id A7adQXzBmnAiJcPm for <dash@vger.kernel.org>; Mon, 19 May 2008 04:26:11 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JxvPr-0006fq-0U
	for dash@vger.kernel.org; Mon, 19 May 2008 04:47:59 +0200
Content-Disposition: inline
In-Reply-To: <20080519005328.GA29081@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> > > > # (3) '\' in `` and in $();
> > > > # what is POSIX "literal meaning" of '\' in `` and what is '\\' then?
>             Within the backquoted style of command substitution, backslash
>             shall retain its literal meaning, except when followed by:
>             '$', '`', or '\\' (dollar sign, backquote, backslash).

> > $( ' \\\\ ' ) ; ` ' \\\\ ' ` ; $( ' \\\ ' ) ; ` ' \\\ ' `
> >       (4)            (2)            (3)           (2)
> > $( " \\\\ " ) ; ` " \\\\ " ` ; $( " \\\ " ) ; ` " \\\ " `

So, literal meaning of '\' is '\' and '\\' is '\' there.

Or, if you want to have a slash (odd number), use slash (same). If you
what to place two slashes (even), use four (even << 1).

Nice.

> > it is so, but how to explain this wrt spec.?
> 
> Section 2.6.3, "Command Substitution":
> 
____
