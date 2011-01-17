From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Improper 8-bit parsing because of signed overflow
Date: Mon, 17 Jan 2011 15:23:19 -0600
Message-ID: <20110117212319.GB21507@burratino>
References: <1295119477.12334.78.camel@ulidtko>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60037 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab1AQVXa convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 17 Jan 2011 16:23:30 -0500
Received: by qwa26 with SMTP id 26so5199561qwa.19
        for <dash@vger.kernel.org>; Mon, 17 Jan 2011 13:23:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295119477.12334.78.camel@ulidtko>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: max ulidtko <ulidtko@gmail.com>
Cc: dash@vger.kernel.org

Hi Max,

max ulidtko wrote:

> $ cat < =D1=82=D0=B5=D1=81=D1=82
> sh: cannot open =D1=82=D0=B5=EF=BF=BD=D1=82: No such file

With Debian dash 0.5.5.1-7.4:

 $ dash -c 'cat < =D1=82=D0=B5=D1=81=D1=82' 2>&1 |
	LC_ALL=3DC sed -e 's/dash: cannot open \(.*\):.*/\1/' |
	xxd
 0000000: d182 d0b5 d1d1 820a                      ........
 $ dash -c 'echo =D1=82=D0=B5=D1=81=D1=82' | xxd
 0000000: d182 d0b5 d181 d182 0a                   .........
=20
The \x81 is being swallowed up.  This is <http://bugs.debian.org/532302=
>,
fixed by f8231a ([EXPAND] Fix corruption of redirections with byte 0x81=
,
2010-05-27).

But your question is still interesting from the point of view of
investigation, so let's move on to that.

> The reason is signed overflow. The parser uses syntax tables to
> determine the class to which a given byte (assuming it's a whole
> character) belongs. The lookup is done like this:
> 	switch(syntax[c]) {

Given confusing code, it is often helpful to learn what the authors
were thinking when it was written:

 $ git log -S'switch(syntax[c])' -- src/parser.c
 commit 05c1076ba2d1a68fe7f3a5ae618f786b8898d327
 Author: Herbert Xu <herbert@gondor.apana.org.au>
 Date:   Mon Sep 26 18:32:28 2005 +1000

     Initial import.

Well, so much for that.  Except, does that mean the signed lookup
has been present for five years?  So looking at 05c107:src/parser.c,
one is led to wonder how c gets set in the first place.

	c =3D pgetc();

What did pgetc do?

	int
	pgetc(void)
	{
		return pgetc_macro();
	}

And pgetc_macro?

	extern char *parsenextc;		/* next character in input buffer */
[...]
	#define pgetc_macro()	(--parsenleft >=3D 0? *parsenextc++ : preadbuffe=
r())

Sounds unportable --- the signedness depends on the platform.  Okay,
so what does syntax[-1] give?  05c107:src/mksyntax.c has some hints:

	if (sign)
		base +=3D 1 << (nbits - 1);

So syntax starts in the _middle_ of the builtin table when char is
signed.

That code isn't present in current src/mksyntax.c.  What gives, one
might wonder?

 $ git log -1 -S'base +=3D' -- src/mksyntax.c
 commit d8014392bc291504997c65b3b44a7f21a60b0e07
 Author: Herbert Xu <herbert@gondor.apana.org.au>
 Date:   Sun Apr 23 16:01:05 2006 +1000

     [PARSER] Only use signed char for syntax arrays

     The existing scheme of using the native char for syntax array indi=
cies
     makes cross-compiling difficult.  Therefore it makes sense to choo=
se
     one specific sign for everyone.

     Since signed chars are native to most platforms and i386, it makes=
 more
     sense to use that if we are to choose one type for everyone.

Ah.

Hope that helps,
Jonathan
