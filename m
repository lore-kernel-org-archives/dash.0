Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E47C7EE2E
	for <linux-dash@archiver.kernel.org>; Thu,  8 Jun 2023 09:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjFHJG6 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 8 Jun 2023 05:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjFHJG4 (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 8 Jun 2023 05:06:56 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA657E7
        for <dash@vger.kernel.org>; Thu,  8 Jun 2023 02:06:51 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q7BbQ-000Wlo-PN; Thu, 08 Jun 2023 17:06:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Jun 2023 17:06:44 +0800
Date:   Thu, 8 Jun 2023 17:06:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
Subject: Re: [Debian#1037195] dash: $(here-doc in <<substitution) is always
 empty, must consume subsequent lines per POSIX?
Message-ID: <ZIGaJAHo8OY1QzQa@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ygxq63mk22evfzirlilu4eexc2q44uul6zsade73om5hgbvj7@a6er2aqswli7>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> POSIX Issue 7, XCU, 2. Shell Command Language says
>   2.7.4 Here-Document
>  
>  The redirection operators "<<" and "<<-" both allow redirection of subsequent lines read by the shell to the input of a command. The redirected lines are known as a "here-document".
>  
>  The here-document shall be treated as a single word that begins after the next <newline> and continues until there is a line containing only the delimiter and a <newline>, with no <blank> characters in between. Then the next here-document starts, if there is one. The format is as follows:
> and its counterpart in Issue 8 Draft 3
>  80601  2.7.4 Here-Document
>  80602  The redirection operators "<<" and "<<-" both allow redirection of subsequent lines read by
>  80603  the shell to the input of a command. The redirected lines are known as a ``here-document’’.
>  80604  The here-document shall be treated as a single word that begins after the next NEWLINE token 
>  80605  and continues until there is a line containing only the delimiter and a <newline>, with no
>  80606  <blank> characters in between. Then the next here-document starts, if there is one. For the
>  80607  purposes of locating this terminating line, the end of a command_string operand (see sh) shall be
>  80608  treated as a <newline> character, and the end of the commands string in $(commands) and 
>  80609  `commands` may be treated as a <newline>. If the end of input is reached without finding the
>  80610  terminating line, the shell should, but need not, treat this as a redirection error. The format is as
>  80611  follows:

I don't know.  It sounds like someone has changed the standard
to support what you want it to do, but at the same time the old
behaviour is still allowed.  This is because the text uses the
word may instead of must.

Does anyone have a link to the discussion around this change so
we can infer the intention?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
