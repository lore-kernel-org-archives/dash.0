From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Partial patch] IFS and read builtin
Date: Sun, 17 Oct 2010 22:03:48 -0500
Message-ID: <20101018030348.GA32213@burratino>
References: <4C71A29C.1080609@gigawatt.nl>
 <20100908115324.GA17029@gondor.apana.org.au>
 <20100908120849.GA17121@gondor.apana.org.au>
 <20101016191548.GA10626@burratino>
 <20101018025402.GA29011@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34269 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0JRDH2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 17 Oct 2010 23:07:28 -0400
Received: by ywi6 with SMTP id 6so135681ywi.19
        for <dash@vger.kernel.org>; Sun, 17 Oct 2010 20:07:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101018025402.GA29011@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

Herbert Xu wrote:
> On Sat, Oct 16, 2010 at 02:15:48PM -0500, Jonathan Nieder wrote:

>> Bisects to f42e443bb.  Reverting it avoids the problem.  Any ideas
>> before I investigate further?
>
> Does this patch help?

Yes, thanks!
