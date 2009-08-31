From: Matthew Burgess <matthew@linuxfromscratch.org>
Subject: Re: Allow dash to build with i18n version of Coreutils
Date: Mon, 31 Aug 2009 8:19:24 -0600
Message-ID: <f7a46234b412965ca542f8cb4e1b3f6c@quantum.linuxfromscratch.org>
References: <20090831102728.GA6038@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from quantum.linuxfromscratch.org ([216.171.237.234]:59217 "EHLO
	quantum.linuxfromscratch.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbZHaOTp (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 31 Aug 2009 10:19:45 -0400
In-Reply-To: <20090831102728.GA6038@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Mon, 31 Aug 2009 20:27:28 +1000, Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Thank you.  I've applied the patch but replaced LC_CTYPE with
> LC_COLLATE.

Hi Herbert, for some reason, 'sort' doesn't appear to be honouring LC_COLLATE; only
LC_ALL & LC_CTYPE appears to get things working with this particular invocation of
'sort':

su-4.0$ echo $LANG 
en_GB.UTF-8

su-4.0$ sort -u -k 3,3 builtins
     0  .       -s      dotcmd

su-4.0$ LC_ALL=C sort -u -k 3,3 builtins
    21  local   -a      localcmd
    14  export  -as     exportcmd
     3  alias   -au     aliascmd
     0  .       -s      dotcmd
     4  bg      -u      bgcmd
     7  chdir   cdcmd
    10  echo    echocmd
    18  hash    hashcmd
    22  printf  printfcmd
    23  pwd     pwdcmd
     2  [       testcmd
    33  type    typecmd
    34  ulimit  ulimitcmd

su-4.0$ LC_CTYPE=C sort -u -k 3,3 builtins
    21  local   -a      localcmd
    14  export  -as     exportcmd
     3  alias   -au     aliascmd
     7  chdir   cdcmd
    10  echo    echocmd
    18  hash    hashcmd
    22  printf  printfcmd
    23  pwd     pwdcmd
     0  .       -s      dotcmd
     2  [       testcmd
    33  type    typecmd
     4  bg      -u      bgcmd
    34  ulimit  ulimitcmd

su-4.0$ LC_COLLATE=C sort -u -k 3,3 builtins
     0  .       -s      dotcmd

Regards,

Matt.

