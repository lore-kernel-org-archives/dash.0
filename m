From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Dash only reads the first character from pipe (bash reads whole
 line)
Date: Sat, 14 Nov 2015 18:51:22 +0800
Message-ID: <20151114105122.GA17789@gondor.apana.org.au>
References: <n25ren$pf5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hengli.com.au ([209.40.204.226]:47620 "EHLO
	helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbKNKv1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 14 Nov 2015 05:51:27 -0500
Content-Disposition: inline
In-Reply-To: <n25ren$pf5$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Gioele Barabucci <gioele@svario.it>
Cc: dash@vger.kernel.org

Gioele Barabucci <gioele@svario.it> wrote:
> 
> > The 'read' command seems to only read the first character and not the 
> > whole line.
> >
> > Example / comparison with bash:
> >
> > # /bin/dash
> > # sudo modprobe nf_conntrack
> > # read MAX </proc/sys/net/netfilter/nf_conntrack_max
> > # echo $MAX
> > 2
> >
> > # /bin/bash
> > # read MAX </proc/sys/net/netfilter/nf_conntrack_max
> > # echo $MAX
> > 262144
> 
> It this a known problem? Are there workarounds?

Yes it's a known problem, but arguably it's more of a kernel bug
than a dash bug (proc files cannot be read byte-by-byte).  You
can work around it using cat

MAX=$(cat /proc/.../file)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
