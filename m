From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: strange `printf` arguments, parsing features (bugs?)
Date: Sun, 18 May 2008 18:40:26 +0200
Message-ID: <20080518164026.GE21428@flower.upol.cz>
References: <20080514165931.GB21428@flower.upol.cz> <E1Jxl0W-0006oV-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:60326 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbYERQTH (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 18 May 2008 12:19:07 -0400
Content-Disposition: inline
In-Reply-To: <E1Jxl0W-0006oV-00@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

Herbert Xu @ Sun, May 18, 2008 at 11:41:08PM +0800:

> > # (1) parameters to `printf`?
> > 
> > olecom@flower:/tmp$ sh -c 'printf "-1"'
> > printf: 1: Illegal option -1
> 
> This is expected.  Use printf -- if you want to disable option parsing.

[second] Again for `echo` it's not so, `printf` is a mean for "propper"
         (portable) `echo`, nothing about getopt() stuff is mentioned in
	 POSIX spec.


> > $(echo ' \\\\\' >&2)
> > `echo  ' \\\\\' >&2`
> 
> bash and dash in fact agree on these except that echo in dash
> interprets escape codes as required by POSIX.

[first] Gee, that `echo` thing (how stupid to catch it:)
        Correct test (works), question remains:

> > # (3) '\' in `` and in $();
> > # what is POSIX "literal meaning" of '\' in `` and what is '\\' then?
(bash removed)

$( ' \\\\ ' ) ; ` ' \\\\ ' ` ; $( ' \\\ ' ) ; ` ' \\\ ' `
      (4)            (2)            (3)           (2)
$( " \\\\ " ) ; ` " \\\\ " ` ; $( " \\\ " ) ; ` " \\\ " `

it is so, but how to explain this wrt spec.?

olecom@flower$ bash -s <<"E"
$(printf %s ' \\\\ ' >&2)
`printf '\n%s\n-\n'  ' \\\\ ' >&2`
$(printf %s " \\\\ " >&2)
`printf '\n%s\n-\n'  " \\\\ " >&2`
E
 \\\\
 \\
-
 \\
 \
-
olecom@flower$ sh -s <<"E"
$(printf %s ' \\\\ ' >&2)
`printf '\n%s\n-\n'  ' \\\\ ' >&2`
$(printf %s " \\\\ " >&2)
`printf '\n%s\n-\n'  " \\\\ " >&2`
E
 \\\\
 \\
-
 \\
 \
-
olecom@flower$ bash -s <<"E"
$(printf %s ' \\\ ' >&2)
`printf '\n%s\n-\n'  ' \\\ ' >&2`
$(printf %s " \\\ " >&2)
`printf '\n%s\n-\n'  " \\\ " >&2`
E
 \\\
 \\
-
 \\
 \
-
olecom@flower$ sh -s <<"E"
$(printf %s ' \\\ ' >&2)
`printf '\n%s\n-\n'  ' \\\ ' >&2`
$(printf %s " \\\ " >&2)
`printf '\n%s\n-\n'  " \\\ " >&2`
E
 \\\
 \\
-
 \\
 \
