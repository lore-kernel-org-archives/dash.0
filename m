From: Brian Koropoff <bkoropoff@gmail.com>
Subject: Re: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Sat, 16 Apr 2011 11:25:19 -0700
Message-ID: <1302978319.19920.14.camel@gemini>
References: <1302921010.2620.3.camel@gemini>
	 <1302921279.2620.6.camel@gemini>  <20110416045435.GA10455@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab1DPSZQ (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 16 Apr 2011 14:25:16 -0400
Received: by pwi15 with SMTP id 15so1576124pwi.19
        for <dash@vger.kernel.org>; Sat, 16 Apr 2011 11:25:15 -0700 (PDT)
In-Reply-To: <20110416045435.GA10455@elie>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: dash@vger.kernel.org

Hello,

On Fri, 2011-04-15 at 23:54 -0500, Jonathan Nieder wrote:
> Hi,
> 
> Brian Koropoff wrote:
> 
> > The printf builtin modifies the user's format strings
> > by prefixing integer conversion specifications with the
> > 'j' (intmax_t) length modifier.  Since this is not portable,
> > instead prefix them with the length modifier extracted from
> > the PRIdMAX constant.
> 
> This assumes PRIdMAX, PRIxMAX, etc all consist of the same prefix
> before the standard characters.  Since the most common definitions
> are j<usual char>, l<usual char>, q<usual char>, I64<usual char>,
> and ll<usual char>, that's probably a safe assumption.  I wonder why
> C99 and its predecessors did not use
> 
> 	printf("%"PRIMAX"x\n", val);

To be completely safe we could refactor mklong() to take the PRI?MAX
string as a parameter and use the correct one at each invocation site.
I'm not sure this is warranted until we actually encounter a platform
where it makes a difference.

> Oh well.  Maybe it would warrant a comment, though?
> 
> 	/*
> 	 * Replace a string like
> 	 *
> 	 *	%92.3u
> 	 *	^    ^--- ch
> 	 *	'-------- str
> 	 *
> 	 * with "%92.3" PRIuMAX "".
> 	 *
> 	 * Although C99 does not guarantee it, we assume PRIiMAX,
> 	 * PRIoMAX, PRIuMAX, PRIxMAX, and PRIXMAX are all the same
> 	 * as PRIdMAX with the final 'd' replaced by the corresponding
> 	 * character.
> 	 */
> 
> > --- a/src/bltin/printf.c
> > +++ b/src/bltin/printf.c
> > @@ -317,15 +317,16 @@ static char *
> >  mklong(const char *str, const char *ch)
> >  {
> >  	char *copy;
> > -	size_t len;	
> > +	size_t len;
> > +	size_t pridmax_len = strlen(PRIdMAX);
> 
> I think just using strlen(PRIdMAX) as-is would make it clearer that we
> are expecting the compiler to inline the "strlen" and provides a
> reminder of the value, too (i.e., is it 2 or 3 for "jd"?).
> 
> >  
> > -	len = ch - str + 3;
> > +	len = ch - str + pridmax_len;
> 
> This changes the meaning of "len" to no longer be the size of the
> buffer.  I suppose that doesn't matter, but...
> 
> >  	STARTSTACKSTR(copy);
> > -	copy = makestrspace(len, copy);
> > -	memcpy(copy, str, len - 3);
> > -	copy[len - 3] = 'j';
> > -	copy[len - 2] = *ch;
> > -	copy[len - 1] = '\0';
> > +	copy = makestrspace(len + 1, copy);
> > +	memcpy(copy, str, len - pridmax_len);
> > +	memcpy(copy + len - pridmax_len, PRIdMAX, pridmax_len - 1);
> > +	copy[len - 1] = *ch;
> > +	copy[len] = '\0';
> 
> ... the arithmetic is getting complicated.  I think mempcpy could make
> the intention clearer, like so.
> 
> 	char *p;
> 	[...]
> 	len = ch - str + strlen(PRIdMAX) + 1;
> 	p = copy = makestrspace(len, copy);
> 	p = mempcpy(p, str, ch - str);
> 	p = mempcpy(p, PRIdMAX, strlen(PRIdMAX) - 1);
> 	*p++ = *ch;
> 	*p++ = '\0';
> 
> Like this, maybe (on top, untested)?

I like this, it feels a bit cleaner.  Maybe get rid of the len variable
now since it's only used once.

-- Brian

