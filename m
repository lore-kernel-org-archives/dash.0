From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Fri, 22 May 2015 12:25:31 +0800
Message-ID: <20150522042531.GA30829@gondor.apana.org.au>
References: <CAOhdH0uf7Kj2noz4vnuLo_06W2HZ4Xwh_Bm5vKC71VHfeswD_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:59949 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbEVEZg (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 22 May 2015 00:25:36 -0400
Content-Disposition: inline
In-Reply-To: <CAOhdH0uf7Kj2noz4vnuLo_06W2HZ4Xwh_Bm5vKC71VHfeswD_Q@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Fredrik Fornwall <fredrik@fornwall.net>
Cc: dash@vger.kernel.org

Fredrik Fornwall <fredrik@fornwall.net> wrote:
> In mkbuiltins LC_COLLATE is set, but since "The value of the LC_ALL
> environment variable has precedence over any of the other environment
> variables starting with LC_"
> (http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html), this
> has no effect when LC_ALL is set.
> 
> This breaks when having e.g. LC_ALL=en_US.UTF-8 during make, which
> causes the test case
>    dash -c :
> to fail, probably due to broken ordering in builtins.c. The patch
> corrects that by setting LC_ALL instead of LC_COLLATE.

This causes any errors printed by sort to come out in English.

Please fix this by simply setting LC_ALL to empty alongside
LC_COLLATE=C.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
