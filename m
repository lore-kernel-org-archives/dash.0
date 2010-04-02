From: maximilian attems <max@stro.at>
Subject: Re: [PATCH 2/2] [BUILTIN] respect eventual TMPDIR set
Date: Fri, 2 Apr 2010 16:30:02 +0200
Message-ID: <20100402143002.GB6199@stro.at>
References: <1269213818-23910-1-git-send-email-max@stro.at>
 <1269213818-23910-2-git-send-email-max@stro.at>
 <20100402050351.GB28307@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:58162 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab0DBOaP (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 10:30:15 -0400
Content-Disposition: inline
In-Reply-To: <20100402050351.GB28307@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Fri, 02 Apr 2010, Herbert Xu wrote:

> On Mon, Mar 22, 2010 at 12:23:38AM +0100, maximilian attems wrote:
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > 
> > while merging upstream dash in klibc,
> > noticed that klibc dash had grown that useful feature.
> > 
> > Signed-off-by: maximilian attems <max@stro.at>
> 
> Patch applied.  BTW, please cc dash@vger.kernel.org on all patch
> submissions.

thanks for merge, review and push. :)

what about, job control off:
http://www.zytor.com/pipermail/klibc/2010-March/002590.html

I'll reforward the patch, seems it didn't reach the dash mailinglist.

