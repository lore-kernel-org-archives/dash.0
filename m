From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 22:04:37 +0800
Message-ID: <20160902140437.GA12639@gondor.apana.org.au>
References: <0ce0bca2-3bdd-a1f5-169e-0291a49cd6c7@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:47125 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbcIBOEp (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:04:45 -0400
Content-Disposition: inline
In-Reply-To: <0ce0bca2-3bdd-a1f5-169e-0291a49cd6c7@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: olof@ethup.se, dash@vger.kernel.org

Harald van Dijk <harald@gigawatt.nl> wrote:
>
> Yes, this looks like a bug in dash. With the default --disable-fnmatch 
> code, when dash encounters [ in a pattern, it immediately treats the 
> following characters as part of the set. If it then encounters the end 
> of the pattern without having seen a matching ], it attempts to reset 
> the state and continue as if [ was treated as a literal character right 
> from the start. The attempt to reset the state doesn't look right, and 
> has been like this since at least the initial Git commit in 2005.

pdksh exhibits the same behaviour:

$ pdksh -c 'foo=[abc]; echo ${foo#[}'
[abc]
$

POSIX says:

9.3.3 BRE Special Characters

A BRE special character has special properties in certain contexts.
Outside those contexts, or when preceded by a backslash, such a
character is a BRE that matches the special character itself. The
BRE special characters and the contexts in which they have their
special meaning are as follows:

.[\
The period, left-bracket, and backslash shall be special except
when used in a bracket expression (see RE Bracket Expression). An
expression containing a '[' that is not preceded by a backslash
and is not part of a bracket expression produces undefined results.

> This also affects
> 
>     case [a in [?) echo ok ;; *) echo bad ;; esac
> 
> which should print ok.

Even ksh prints bad here.

I would however consider a patch that simplifies the code in the
undefined case.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
