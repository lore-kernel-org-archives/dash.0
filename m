From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: positional argument bug
Date: Sat, 21 May 2011 10:53:32 +0200
Message-ID: <1305968012.28004.6.camel@linux>
References: <20110520235950.GA1839@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:52138 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab1EUJGm (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 21 May 2011 05:06:42 -0400
Received: from 541f32bc.cm-5-8a.dynamic.ziggo.nl ([84.31.50.188] helo=[10.0.1.100])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1QNhuF-00042s-Sv
	for dash@vger.kernel.org; Sat, 21 May 2011 10:51:32 +0200
In-Reply-To: <20110520235950.GA1839@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

On Sat, 2011-05-21 at 09:59 +1000, Herbert Xu wrote:
> Eric Blake <eblake@redhat.com> wrote:
> >
> >> Also a POSIX violation:
> >> 
> >> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
> >> 
> >> "The parameter name or symbol can be enclosed in braces, which are
> >> optional except for positional parameters with more than one digit or
> >> when parameter is followed by a character that could be interpreted as
> >> part of the name."
> > 
> > Additionally from POSIX:
> > 
> > "If the parameter name or symbol is not enclosed in braces, the
> > expansion shall use the longest valid name (see XBD Name)"
> > 
> > "In the shell command language, a word consisting solely of underscores,
> > digits, and alphabetics from the portable character set. The first
> > character of a name is not a digit."
> > 
> > Therefore, in "$10", 10 is not a name, so the longest name is the empty
> > string, and the single-character symbol is used instead, such that this
> > MUST be parsed as ${1}0, not as ${10}.
> 
> I don't think any of this explicitly states that $10 cannot be
> interpreted as ${10}.  All it says is that where the first character
> is an underscore or alphabetic, then the longest name should be
> used, and that to use $10 portably you must put braces around it.

I agree that the last quotes are not convincing. In fact, they seem to
be saying that $10 must be interpreted as ${}10: there's no "if there is
no name, use a single-character symbol". The first, however:

> "The parameter name or symbol can be enclosed in braces, which are
> optional except for positional parameters with more than one digit or
> when parameter is followed by a character that could be interpreted as
> part of the name."

does say the braces are optional in ${1}0, so if a script author changes
${1}0 to $10, there should be no change in behaviour.

Cheers,
Harald

