From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Sat, 3 Sep 2016 17:16:28 +0200
Message-ID: <28252930-bab6-18fd-901d-c3bb6515df4c@gigawatt.nl>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
 <20160902142928.GA13022@gondor.apana.org.au>
 <dd9729a1-ce0d-8549-b52a-9d205740858c@redhat.com>
 <20160902145153.GA13458@gondor.apana.org.au>
 <b25fbf0a-1b36-24d4-9a6c-7d8a9d8dd894@gigawatt.nl>
 <20160903130506.GA19749@gondor.apana.org.au>
 <1acf6563-5a42-2bfa-ac7a-fbdd2c315b85@gigawatt.nl>
 <20160903135850.GA20234@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:46100
        "EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752951AbcICPQg (ORCPT
        <rfc822;dash@vger.kernel.org>); Sat, 3 Sep 2016 11:16:36 -0400
In-Reply-To: <20160903135850.GA20234@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <eblake@redhat.com>, olof@ethup.se, dash@vger.kernel.org

On 03/09/16 15:58, Herbert Xu wrote:
> On Sat, Sep 03, 2016 at 03:19:57PM +0200, Harald van Dijk wrote:
>>
>> But yeah, sure, if the bug has been there for over 10 years, and I'm
>> unable to find older versions of dash to check, I would have guessed
>> that dash indeed has never worked this way.
>
> OK it looks like this actually wasn't the original behaviour.
> It was introduced along with the character class support.  So
> with that in mind, I feel a lot happier in changing the behaviour
> of the case statement.
>
> I've changed your patch slightly and will commit it if there are
> no other issues.

None that I can see. Agreed that avoiding increment-decrement-increment 
to just do a single increment instead is an improvement, and I don't 
spot any issues in it.

> ---8<---
> Subject: expand - Fix dangling left square brackets in patterns
>
> When there is an unmatched left square bracket in patterns, pmatch
> will behave strangely and exhibit undefined behaviour.  This patch
> (based on Harld van Dijk's original) fixes this by treating it as
> a literal left square bracket.
>
> Reported-by: Olof Johansson <olof@ethup.se>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/src/expand.c b/src/expand.c
> index 36bea76..2a50830 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -1584,14 +1584,14 @@ pmatch(const char *pattern, const char *string)
>  				p++;
>  			}
>  			found = 0;
> -			chr = *q++;
> +			chr = *q;
>  			if (chr == '\0')
>  				return 0;
>  			c = *p++;
>  			do {
>  				if (!c) {
>  					p = startp;
> -					c = *p;
> +					c = '[';
>  					goto dft;
>  				}
>  				if (c == '[') {
> @@ -1618,6 +1618,7 @@ pmatch(const char *pattern, const char *string)
>  			} while ((c = *p++) != ']');
>  			if (found == invert)
>  				return 0;
> +			q++;
>  			break;
>  		}
>  dft:	        default:
>
