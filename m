From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Allow dash to build with i18n version of Coreutils
Date: Tue, 1 Sep 2009 13:15:57 +1000
Message-ID: <20090901031557.GA17361@gondor.apana.org.au>
References: <20090831102728.GA6038@gondor.apana.org.au> <f7a46234b412965ca542f8cb4e1b3f6c@quantum.linuxfromscratch.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:42233 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751894AbZIADP5 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Aug 2009 23:15:57 -0400
Content-Disposition: inline
In-Reply-To: <f7a46234b412965ca542f8cb4e1b3f6c@quantum.linuxfromscratch.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Matthew Burgess <matthew@linuxfromscratch.org>
Cc: dash@vger.kernel.org

On Mon, Aug 31, 2009 at 08:19:24AM -0600, Matthew Burgess wrote:
> 
> su-4.0$ echo $LANG 
> en_GB.UTF-8
> 
> su-4.0$ sort -u -k 3,3 builtins
>      0  .       -s      dotcmd
> 
> su-4.0$ LC_ALL=C sort -u -k 3,3 builtins
>     21  local   -a      localcmd
>     14  export  -as     exportcmd
>      3  alias   -au     aliascmd
>      0  .       -s      dotcmd
>      4  bg      -u      bgcmd
>      7  chdir   cdcmd
>     10  echo    echocmd
>     18  hash    hashcmd
>     22  printf  printfcmd
>     23  pwd     pwdcmd
>      2  [       testcmd
>     33  type    typecmd
>     34  ulimit  ulimitcmd
> 
> su-4.0$ LC_CTYPE=C sort -u -k 3,3 builtins
>     21  local   -a      localcmd
>     14  export  -as     exportcmd
>      3  alias   -au     aliascmd
>      7  chdir   cdcmd
>     10  echo    echocmd
>     18  hash    hashcmd
>     22  printf  printfcmd
>     23  pwd     pwdcmd
>      0  .       -s      dotcmd
>      2  [       testcmd
>     33  type    typecmd
>      4  bg      -u      bgcmd
>     34  ulimit  ulimitcmd
> 
> su-4.0$ LC_COLLATE=C sort -u -k 3,3 builtins
>      0  .       -s      dotcmd

Weird, it works here:

$ LANG=en_GB.UTF-8 LC_COLLATE=C sort -u -k 3,3 /tmp/foo
     3  alias   aliascmd
     4  bg      bgcmd
     5  break   breakcmd
     6  cd      cdcmd
     8  command commandcmd
     0  .       dotcmd
    10  echo    echocmd
    11  eval    evalcmd
    12  exec    execcmd
    13  exit    exitcmd
    14  export  exportcmd
    15  false   falsecmd
    16  fg      fgcmd
    17  getopts getoptscmd
    18  hash    hashcmd
    19  jobs    jobscmd
    20  kill    killcmd
    21  local   localcmd
    22  printf  printfcmd
    23  pwd     pwdcmd
    24  read    readcmd
    26  return  returncmd
    27  set     setcmd
    28  shift   shiftcmd
     2  [       testcmd
    30  times   timescmd
    31  trap    trapcmd
     1  :       truecmd
    33  type    typecmd
    34  ulimit  ulimitcmd
    35  umask   umaskcmd
    36  unalias unaliascmd
    37  unset   unsetcmd
    38  wait    waitcmd
$

What version of glibc/sort are you using?

In fact there is definitely something screwed because usually
LANG=en_* only changes the way upper-case and lower-case letters
get sorted rather than what you saw above.

Oh I see what's going on.  In fact it's sed that's not working for
you, not sort.  Let me find a way around that.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
