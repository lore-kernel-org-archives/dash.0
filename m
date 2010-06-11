From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: debian patches to exit with code 127 for nonexistent/directory
	scripts
Date: Fri, 11 Jun 2010 18:39:10 +1000
Message-ID: <20100611083910.GA3348@gondor.apana.org.au>
References: <1006081227070.5913@somehost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:58769 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759231Ab0FKIjO (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 11 Jun 2010 04:39:14 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6])
	by arnor.apana.org.au with esmtp (Exim 4.63 #1 (Debian))
	id 1OMzlg-00018b-4K
	for <dash@vger.kernel.org>; Fri, 11 Jun 2010 18:39:12 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.69)
	(envelope-from <herbert@gondor.apana.org.au>)
	id 1OMzlf-0000sD-0s
	for dash@vger.kernel.org; Fri, 11 Jun 2010 18:39:11 +1000
Content-Disposition: inline
In-Reply-To: <1006081227070.5913@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com> wrote:
> On Tue, 8 Jun 2010, Herbert Xu wrote:
> 
>> Jilles Tjoelker <jilles@stack.nl> wrote:
>> > Debian's dash package has some local changes which cause an exit
>> > with code 127, as required by POSIX, if a script (passed with dash
>> > <filename>) cannot be opened or cannot be read because it is a
>> > directory.
> 
> My interpretation of the above is that debian's patched dash is POSIX
> compliant WRT the named exit code.

Well if dash is broken then you should submit a patch.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
