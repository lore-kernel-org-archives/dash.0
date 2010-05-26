From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH 4/4] [VAR] Replace cmdenviron with localvars
Date: Thu, 27 May 2010 00:37:23 +0200
Message-ID: <20100526223723.GB5679@stack.nl>
References: <20100526105948.GA26352@gondor.apana.org.au>
 <E1OHELi-0006sy-Nn@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:62125 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755871Ab0EZWh0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 18:37:26 -0400
Content-Disposition: inline
In-Reply-To: <E1OHELi-0006sy-Nn@gondolin.me.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, pape@smarden.org

On Wed, May 26, 2010 at 09:00:34PM +1000, Herbert Xu wrote:
> [VAR] Replace cmdenviron with localvars

> This patch replaces the cmdenviron mechanism for temporary command
> variables with the localvars mechanism used by functions.

> This reduces code size, and more importantly, makes the variable
> assignment take effect immediately as required by POSIX.

This change breaks passing variable assignments to regular builtins.
For example,
  dash -c 'HOME=/ cd; pwd'
This should print /. (For some reason, this does not work in ksh93
either.)
Or
  dash -c 'cd /bin&&CDPATH=/ cd bin; pwd'
This should print /bin twice and not fail any command. (Again this fails
in ksh93.)

A more common example,
  IFS=: read -r x y z
is already broken in master before this change (due to git commit
55c46b7286f5d9f2d8291158203e2b61d2494420 which effectively replaced
bltinlookup("IFS") with ifsval()).

Similar issues may pop up with
  PATH=/foo command -V bar
  PATH=/foo type bar
  LC_NUMERIC=de_DE.UTF-8 printf '%f\n' 1,2

(Note: the latter is broken in bash, but in ksh93 and zsh it works, as
well as with an external printf(1) program.)

'local' may need additional magic to avoid making things local to the
temporary regular-builtin scope. I suppose only functions should induce
scope for 'local', such that things like command eval 'local i' continue
to create a variable local to the function.

-- 
Jilles Tjoelker
