From: Oleg Verych <olecom@flower.upol.cz>
Subject: that multi-threading (Re: funny `dash` build, `sed` + BRE (Re: shell and glibc))
Date: Mon, 19 May 2008 13:47:31 +0200
Message-ID: <20080519114731.GK21428@flower.upol.cz>
References: <20080519033047.GI21428@flower.upol.cz> <E1Jxwig-0007sq-00@gondolin.me.apana.org.au> <20080519104809.GJ21428@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:49428 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756207AbYESL0E (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 19 May 2008 07:26:04 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id C3399147E03
	for <dash@vger.kernel.org>; Mon, 19 May 2008 13:25:43 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id 8hdQerMmJAmLlEzV for <dash@vger.kernel.org>; Mon, 19 May 2008 13:25:43 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1Jy3pz-0000NM-8j
	for dash@vger.kernel.org; Mon, 19 May 2008 13:47:31 +0200
Content-Disposition: inline
In-Reply-To: <20080519104809.GJ21428@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

Forgot one thing.

> == Let strange quark decay ==
> 
> $time sed -n '/:Version: /s`.*/\(.*\):Version: \([^:]*:\)*`\1_`p' <sed.input >here2
> 
> real    0m0.284s
> user    0m0.268s
> sys     0m0.020s
> $diff -u here here2 | head
> $
> 
> So, nearly one order of magnitude?

$time sed -n '/:Version: /s`.*/\(.*\):Version: \([^:]*:\)*`\1_`p' <sed.input >here2

real    0m0.283s
user    0m0.268s
sys     0m0.012s
$
$time sed -n '/:Version: /s`.*/``p' <sed.input | sed 's`\(.*\):Version: \([^:]*:\)*`\1_`' >here3

real    0m0.142s
user    0m0.188s
sys     0m0.012s
$
$time sed -n '/:Version: /s`.*/``p' <sed.input | sed 's`\(.*\):Version: \([^:]*:\)*`\1_`' >here3

real    0m0.142s
user    0m0.184s
sys     0m0.008s
$
$diff -u here3 here2
$

Linuxthreads in past TODO or yet TO DO NPTL for faster ERE in glibc?

I think, making processes in kernel light, new scheduler, splice(), etc,
etc, is better way, rather than inventing userspace-multi-tasking.

I wonder, who needs it anyway, except big closed enterprise...
____
