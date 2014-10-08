From: Paul Smith <paul@mad-scientist.net>
Subject: Re: Failure of nested substring processing inside double-quotes
Date: Wed, 08 Oct 2014 01:08:25 -0400
Message-ID: <1412744905.3143.95.camel@homebase>
References: <1412625793.29340.94.camel@mad-scientist.net>
	 <20141008022856.GA5783@gondor.apana.org.au>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from gproxy8-pub.mail.unifiedlayer.com ([67.222.33.93]:47237 "HELO
	gproxy8-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751244AbaJHFPM (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 8 Oct 2014 01:15:12 -0400
In-Reply-To: <20141008022856.GA5783@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Wed, 2014-10-08 at 10:28 +0800, Herbert Xu wrote:
> This is already fixed in the current git tree, by the commit:

Thanks Herbert!  I should have checked Git.  I did check Debian and the
current dash in "stable" and "sid" all still have this issue.

The version in "experimental", however, dash_0.5.8-1_amd64.deb, has the
fix in it and works.

I'll report it in the appropriate places.

Cheers!

