From: "Rocky Bernstein" <rocky.bernstein@gmail.com>
Subject: Re: LINENO and PS{1,2,4} ?
Date: Thu, 26 Jun 2008 11:29:56 -0400
Message-ID: <6cd6de210806260829g3da75e8fv681b790debeaf6e6@mail.gmail.com>
References: <6cd6de210806231229x1b30d3f6yb65e989b11c6a95e@mail.gmail.com>
	 <E1KBt13-00085P-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:52222 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYFZPaA (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 26 Jun 2008 11:30:00 -0400
Received: by yx-out-2324.google.com with SMTP id 31so38495yxl.1
        for <dash@vger.kernel.org>; Thu, 26 Jun 2008 08:29:57 -0700 (PDT)
In-Reply-To: <E1KBt13-00085P-00@gondolin.me.apana.org.au>
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Thu, Jun 26, 2008 at 11:04 AM, Herbert Xu
<herbert@gondor.apana.org.au> wrote:
> Rocky Bernstein <rocky.bernstein@gmail.com> wrote:
>> I have been looking at dash recently and notice in the manual page:
>>
>> BUGS: PS1, PS2, and PS4 should be subject to parameter expansion
>> before being displayed.
>>
>> Also I notice that there isn't a builtin LINENO which POSIX suggests
>> (e.g. http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html)
>>
>> I've been considering rectifying this. What's the protocol for
>> submitting a patch, and/or the likelihood this would get into a
>> release assuming the patch is reasonable.
>
> Just send it to the list (with a cc to me preferably).
>
>> Is there currently a schedule for the next release?
>
> The next release is overdue :) There is a serious performance
> regression since the last release.  Once I've tracked that down
> a release will be made.
>
> Cheers,
> --
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>
Ok, makes sense. A patch was sent to the mailing list. The main thing
that is of interest to me is whether LINENO is going to get into the
next dash release - it a POSIX shell variable.

Assuming the answer is yes, here's my critique of the patch. I don't
think it will be much of a performance hit although there are now
assignments made every statement to a variable that wasn't previously
there. *If* it is deemed a slowdown, then this could be reduced by
caching the name and hash address of the LINENO var -- avoiding
hashvar and findvar and even updates to vn->text.

More important to me though is the fact that the number is wrong
inside compound statements. I've seen this all too many times, e.g.
bash and Ruby if not others. And it's not so much a LINENO problem as
much as an overall line number tracking problem, because dash reports
the same inaccurate line numbers on error reports.

But if I've seen this before it's also been fixed many times before as
well. And here I think the overall approach would be to make more use
of startlinno; inside these compound commands they would have their
own line numbering variable which is initially startlinno  and counts
up from there as line breaks are encountered.
