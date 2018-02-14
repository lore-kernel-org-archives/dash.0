From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash bug: double-quoted "\" breaks glob protection for next char
Date: Wed, 14 Feb 2018 21:03:44 +0100
Message-ID: <5e1ee06d-d1ca-6442-51de-786e2739d4df@gigawatt.nl>
References: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from home.gigawatt.nl ([83.163.3.213]:33772 "EHLO home.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031338AbeBNUJn (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Feb 2018 15:09:43 -0500
In-Reply-To: <CAK1hOcPW_MZ5Nq-0z-aMMMgzZbOZYXD_9kkxz1w+U-HY+E4gbw@mail.gmail.com>
Content-Language: en-GB
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

On 13/02/2018 14:53, Denys Vlasenko wrote:
> $ >'\zzzz'
> $ >'\wwww'
> $ dash -c 'echo "\*"'
> \wwww \zzzz

Nice catch.

> The cause: uses "\\*" pattern instead of "\\\*".
> The fix:
> 
>                          /* backslash */
>                          case CBACK:
>                                  c = pgetc2();
>                                  if (c == PEOF) {
>                                          USTPUTC(CTLESC, out);
>                                          USTPUTC('\\', out);
>                                          pungetc();
>                                  } else if (c == '\n') {
>                                          nlprompt();
>                                  } else {
>                                          if (
>                                                  dblquote &&
>                                                  c != '\\' && c != '`' &&
>                                                  c != '$' && (
>                                                          c != '"' ||
>                                                          eofmark != NULL
>                                                  )
>                                          ) {
> USTPUTC(CTLESC, out); // add this line
>                                                  USTPUTC('\\', out);
>                                          }
>                                          USTPUTC(CTLESC, out);
>                                          USTPUTC(c, out);
>                                          quotef++;
>                                  }

I don't think this is right. The bug was introduced in

 
<https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=7cfd8be0dc83342b4a71f3a8e5b7efab4670e50c>

Prior to that, the line USTPUTC(CTLESC, out); was there. The commit 
message is saying that the logic for detecting whether \ should be taken 
literally doesn't belong in the parser, that the parser will get it 
wrong. The example in the commit message doesn't break with your patch, 
but short modifications to that example do make it fail:

Currently:

$ dash -c 'foo=a; echo "<${foo#[a\]]}>"'
<>

This is what I expect, and also what bash, ksh and posh do.

With your patch:

$ dash -c 'foo=a; echo "<${foo#[a\]]}>"'
<a>

Cheers,
Harald van Dijk
