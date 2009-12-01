From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Dash fails to compile on UTF-8 with the Coreutils i18n patch
Date: Tue, 1 Dec 2009 11:03:51 +0800
Message-ID: <20091201030351.GC20669@gondor.apana.org.au>
References: <62234dc60911291654k6a4fc375o131af7460db907e4@mail.gmail.com> <20091130063621.GA9950@gondor.apana.org.au> <62234dc60911300509n7c7b28b5n9b668c28e01b431e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:56732 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107AbZLADs5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 30 Nov 2009 22:48:57 -0500
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1NFJja-0004qZ-TL
	for <dash@vger.kernel.org>; Tue, 01 Dec 2009 14:49:03 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1NFJja-0005nV-9C
	for dash@vger.kernel.org; Tue, 01 Dec 2009 11:49:02 +0800
Content-Disposition: inline
In-Reply-To: <62234dc60911300509n7c7b28b5n9b668c28e01b431e@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: William Immendorf <will.immendorf@gmail.com>

On Mon, Nov 30, 2009 at 07:09:19AM -0600, William Immendorf wrote:
> 
> I'm not talking about sed. I'm talking about the sort commands in
> mkbuiltins. The known fix is to change both of the LC_COLLATE=C stuff
> to LC_CTYPE=C, and that works.

Please check the archive, we have already established that sort
isn't the issue, it simply papers over the fact that sed didn't
cut out the necessary fields.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
