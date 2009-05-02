From: Haibo Xu <haibo.xu@gmail.com>
Subject: Re: Dash problem with IFS
Date: Fri, 1 May 2009 21:31:41 -0700
Message-ID: <822b241f0905012131s4599d300n51e636a3c35084c6@mail.gmail.com>
References: <822b241f0905011133l3bcbf9dci4799abc80ec9de99@mail.gmail.com>
	 <20090502020131.GA19531@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:58431 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbZEBEbl convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 2 May 2009 00:31:41 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2090028rvb.1
        for <dash@vger.kernel.org>; Fri, 01 May 2009 21:31:41 -0700 (PDT)
In-Reply-To: <20090502020131.GA19531@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

Thanks for the explanation, but the quoted text does not mention
whether IFS is or is not supposed to interpret escape sequence. If IFS
is a string of characters, I guess most people will regard string
"\t\n" as a two character string, the first one being <tab>, and the
2nd one being the <newline>.



On Fri, May 1, 2009 at 7:01 PM, Herbert Xu <herbert@gondor.apana.org.au=
> wrote:
> On Fri, May 01, 2009 at 11:33:08AM -0700, Haibo Xu wrote:
>>
>> > #!/bin/sh
>> >
>> > IFS=3D$' \t\n'
>
> IFS is not supposed to interpret escape sequences. =A0Quoting POSIX
>
> 1419 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IFS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (Input Field Separators.) A string treated as a list of characters =
that is used for
> 1420 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 field splitting and to split lines into fields with the read co=
mmand. If IFS is not
> 1421 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 set, the shell shall behave as if the value of IFS is <space>, =
<tab>, and
> 1422 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 <newline>; see Section 2.6.5 (on page 2244). Implementations ma=
y ignore the |
> 1423 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 value of IFS in the environment at the time the shell is invoke=
d, treating IFS as |
> 1424 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if it were not set. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0|
>
> So if you want it to have a tab and newline you need to specify
> them literally, or use something that does interpret escapes,
> like
>
> IFS=3D$(echo '\n\t $')
>
> Cheers,
> --
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>
