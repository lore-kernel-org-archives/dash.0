From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash.1 - Confusion between two pages c[h]sh
Date: Tue, 11 Nov 2014 15:20:46 +0800
Message-ID: <20141111072046.GA15725@gondor.apana.org.au>
References: <20141110132742.GA8481@gondor.apana.org.au>
 <5460D391.2090603@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:34459 "EHLO
	helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaKKHUx (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Nov 2014 02:20:53 -0500
Content-Disposition: inline
In-Reply-To: <5460D391.2090603@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: =?iso-8859-1?Q?St=E9phane?= Aulery <saulery@free.fr>, dash@vger.kernel.org, 646847@bugs.debian.org, 646847-submitter@bugs.debian.org

On Mon, Nov 10, 2014 at 04:02:41PM +0100, Harald van Dijk wrote:
> 
> Even if csh is intentionally in the "See also" section despite not
> being referenced anywhere else, is it also intentional that chsh is
> not in that section despite the earlier reference? Would a patch
> that leaves csh but also adds chsh be more appropriate, or do you
> prefer to leave it as it is now?

The see also section is not meant to be an exhaustive list of
all commands referred to in the manual.  It's meant to be a list
of manual entries related to dash.  So no I'm not going to add
chsh there just because there was an earlier reference.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
