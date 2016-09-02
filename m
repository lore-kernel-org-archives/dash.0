From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Fri, 2 Sep 2016 22:46:46 +0800
Message-ID: <20160902144646.GA13296@gondor.apana.org.au>
References: <20160902140437.GA12639@gondor.apana.org.au>
 <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:50769 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbcIBOqz (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Sep 2016 10:46:55 -0400
Content-Disposition: inline
In-Reply-To: <6f39229b-7196-afd9-8e8f-3db1c33bf80a@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, olof@ethup.se, dash@vger.kernel.org

On Fri, Sep 02, 2016 at 09:25:15AM -0500, Eric Blake wrote:
>
> 2.13.1 Patterns Matching a Single Character
> 
> [
>     If an open bracket introduces a bracket expression as in XBD RE
> Bracket Expression, except that the <exclamation-mark> character ( '!' )
> shall replace the <circumflex> character ( '^' ) in its role in a
> non-matching list in the regular expression notation, it shall introduce
> a pattern bracket expression. A bracket expression starting with an
> unquoted <circumflex> character produces unspecified results. Otherwise,
> '[' shall match the character itself.

BTW, this last sentence is not present in

http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html#tag_02_13

So I presume it's a newer unreleased revision.

Seriously, you guys are turning POSIX into a joke by introducing
all these new requirements.  At this point I think we should
pretty much give up on POSIX compliance the way it's headed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
