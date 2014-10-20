From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: [EXPAND] Split unquoted $@/$* correctly when IFS is set but empty
Date: Mon, 20 Oct 2014 22:59:40 +0100
Message-ID: <20141020215940.GB20449@chaz.gmail.com>
References: <20141008072636.GA7524@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55222 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbaJTWKH (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 20 Oct 2014 18:10:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1XgL9Q-0000Ly-OM
	for dash@vger.kernel.org; Tue, 21 Oct 2014 00:10:04 +0200
Received: from 4e5660b2.skybroadband.com ([78.86.96.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 21 Oct 2014 00:10:04 +0200
Received: from stephane.chazelas by 4e5660b2.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Tue, 21 Oct 2014 00:10:04 +0200
Content-Disposition: inline
In-Reply-To: <20141008072636.GA7524@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2014-10-08 15:26:36 +0800, Herbert Xu:
> commit 3c06acdac0b1ba0e0acdda513a57ee6e31385dce
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Wed Oct 8 15:24:23 2014 +0800
> 
>     [EXPAND] Split unquoted $@/$* correctly when IFS is set but empty
>     
>     Currently we do not field-split $@/$* when it isn't quoted and IFS
>     is set but empty.  This is obviously wrong.  This patch fixes this.
[...]

Well, if IFS is empty, field splitting is disabled. There's
nothing in POSIX that clearly says that $@ and $* should expand
to the positional parameters *as separate arguments in list
contexts*. yash and the Bourne shell behave like dash. Only
shells with array support behave differently.

The whole $*/$@ expansion is rather unclear in the POSIX spec.
I've just raised the problem on the Austin group mailing list.

See also

http://thread.gmane.org/gmane.linux.debian.devel.general/197901

Cheers,
Stephane

