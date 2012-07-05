From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Thu, 5 Jul 2012 15:43:55 +0800
Message-ID: <20120705074355.GA969@gondor.apana.org.au>
References: <20120703201334.GA66099@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from sting.hengli.com.au ([178.18.18.71]:44761 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754496Ab2GEHoG (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 5 Jul 2012 03:44:06 -0400
Content-Disposition: inline
In-Reply-To: <20120703201334.GA66099@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: eblake@redhat.com, PaulGBoulder@aim.com, dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> On Mon, Jul 02, 2012 at 08:22:20AM -0600, Eric Blake wrote:
>> On 07/02/2012 08:11 AM, Paul Gilmartin wrote:
>> > On Jul 2, 2012, at 07:51, Eric Blake wrote:
> 
>> >> ... non-required bloat ...
> 
>> > The key phrase.  And one value of a shell lacking such
>> > extensions is that it provides an excellent test bed for
>> > code intended to be portable within the POSIX spec.
> 
>> That argues that we should drop our strcasecmp() for the much simpler
>> strcmp(), in order to remove the bloat we already have.
> 
> Such a change would be at odds with the goal of dash to be a usable
> shell. It is not good to break existing scripts, even if those scripts
> are not strictly POSIX-compliant, and particularly so if the scripts
> relied on designed behaviour. Such changes can waste a lot of time.

I agree with Jilles.  I don't think any change is required here.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
