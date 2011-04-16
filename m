From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Fix additional use of 'j' printf length modifier.
Date: Fri, 15 Apr 2011 23:54:35 -0500
Message-ID: <20110416045435.GA10455@elie>
References: <1302921010.2620.3.camel@gemini>
 <1302921279.2620.6.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47300 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1DPEym (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 16 Apr 2011 00:54:42 -0400
Received: by iyb14 with SMTP id 14so2620357iyb.19
        for <dash@vger.kernel.org>; Fri, 15 Apr 2011 21:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302921279.2620.6.camel@gemini>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Brian Koropoff <bkoropoff@gmail.com>
Cc: dash@vger.kernel.org

Hi,

Brian Koropoff wrote:

> The printf builtin modifies the user's format strings
> by prefixing integer conversion specifications with the
> 'j' (intmax_t) length modifier.  Since this is not portable,
> instead prefix them with the length modifier extracted from
> the PRIdMAX constant.

This assumes PRIdMAX, PRIxMAX, etc all consist of the same prefix
before the standard characters.  Since the most common definitions
are j<usual char>, l<usual char>, q<usual char>, I64<usual char>,
and ll<usual char>, that's probably a safe assumption.  I wonder why
C99 and its predecessors did not use

	printf("%"PRIMAX"x\n", val);

Oh well.  Maybe it would warrant a comment, though?

	/*
	 * Replace a string like
	 *
	 *	%92.3u
	 *	^    ^--- ch
	 *	'-------- str
	 *
	 * with "%92.3" PRIuMAX "".
	 *
	 * Although C99 does not guarantee it, we assume PRIiMAX,
	 * PRIoMAX, PRIuMAX, PRIxMAX, and PRIXMAX are all the same
	 * as PRIdMAX with the final 'd' replaced by the corresponding
	 * character.
	 */

> --- a/src/bltin/printf.c
> +++ b/src/bltin/printf.c
> @@ -317,15 +317,16 @@ static char *
>  mklong(const char *str, const char *ch)
>  {
>  	char *copy;
> -	size_t len;	
> +	size_t len;
> +	size_t pridmax_len = strlen(PRIdMAX);

I think just using strlen(PRIdMAX) as-is would make it clearer that we
are expecting the compiler to inline the "strlen" and provides a
reminder of the value, too (i.e., is it 2 or 3 for "jd"?).

>  
> -	len = ch - str + 3;
> +	len = ch - str + pridmax_len;

This changes the meaning of "len" to no longer be the size of the
buffer.  I suppose that doesn't matter, but...

>  	STARTSTACKSTR(copy);
> -	copy = makestrspace(len, copy);
> -	memcpy(copy, str, len - 3);
> -	copy[len - 3] = 'j';
> -	copy[len - 2] = *ch;
> -	copy[len - 1] = '\0';
> +	copy = makestrspace(len + 1, copy);
> +	memcpy(copy, str, len - pridmax_len);
> +	memcpy(copy + len - pridmax_len, PRIdMAX, pridmax_len - 1);
> +	copy[len - 1] = *ch;
> +	copy[len] = '\0';

... the arithmetic is getting complicated.  I think mempcpy could make
the intention clearer, like so.

	char *p;
	[...]
	len = ch - str + strlen(PRIdMAX) + 1;
	p = copy = makestrspace(len, copy);
	p = mempcpy(p, str, ch - str);
	p = mempcpy(p, PRIdMAX, strlen(PRIdMAX) - 1);
	*p++ = *ch;
	*p++ = '\0';

Like this, maybe (on top, untested)?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 src/bltin/printf.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 4ac2ee8..0b4a4e1 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -317,16 +317,25 @@ static char *
 mklong(const char *str, const char *ch)
 {
 	char *copy;
+	char *p;
 	size_t len;
-	size_t pridmax_len = strlen(PRIdMAX);
 
-	len = ch - str + pridmax_len;
+	/*
+	 * Replace a string like "%92.3u" with "%92.3"PRIuMAX.
+	 *
+	 * Although C99 does not guarantee it, we assume PRIiMAX,
+	 * PRIoMAX, PRIuMAX, PRIxMAX, and PRIXMAX are all the same
+	 * as PRIdMAX with the final 'd' replaced by the corresponding
+	 * character.
+	 */
+
+	len = ch - str + strlen(PRIdMAX) + 1;
 	STARTSTACKSTR(copy);
-	copy = makestrspace(len + 1, copy);
-	memcpy(copy, str, len - pridmax_len);
-	memcpy(copy + len - pridmax_len, PRIdMAX, pridmax_len - 1);
-	copy[len - 1] = *ch;
-	copy[len] = '\0';
+	p = copy = makestrspace(len, copy);
+	p = mempcpy(p, str, ch - str);
+	p = mempcpy(p, PRIdMAX, strlen(PRIdMAX) - 1);
+	*p++ = *ch;
+	*p++ = '\0';
 	return (copy);	
 }
 
-- 
1.7.5.rc2

