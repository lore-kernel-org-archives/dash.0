From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BUG] ${#var} returns length in bytes, not characters
Date: Mon, 8 Jun 2015 13:25:59 +0800
Message-ID: <20150608052559.GA25647@gondor.apana.org.au>
References: <556EE51D.8080100@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:58280 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbFHF0M (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Jun 2015 01:26:12 -0400
Content-Disposition: inline
In-Reply-To: <556EE51D.8080100@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org

Martijn Dekker <martijn@inlv.org> wrote:
>
> dash does not expand the length in characters; it expands the length in
> bytes instead. That is invalid for locales that include multi-byte
> characters, such as the now ubiquitous UTF-8 set.

dash doesn't handle locales at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
