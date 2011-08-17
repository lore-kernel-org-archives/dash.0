From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] [SHELL] Allow building without LINEO support.
Date: Tue, 16 Aug 2011 21:07:44 -0500
Message-ID: <20110817020743.GA29205@elie.gateway.2wire.net>
References: <20110816.174502.2209127983953431973.davem@davemloft.net>
 <20110817011235.GA22867@elie.gateway.2wire.net>
 <20110817013805.GA16333@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43275 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQCHv (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 22:07:51 -0400
Received: by ywf7 with SMTP id 7so426235ywf.19
        for <dash@vger.kernel.org>; Tue, 16 Aug 2011 19:07:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110817013805.GA16333@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Miller <davem@davemloft.net>, dash@vger.kernel.org, dash@packages.debian.org

Herbert Xu wrote:

> So this isn't the reason why Debian has been stuck on 0.5.5.1?
> If so what is the reason please?

Probably just Gerrit being busy and me getting distracted by how
to handle the /bin/sh symlink.

I'll propose a package for sid that just moves to the latest upstream
version with no packaging changes later today.

>> Makes sense.  The following on top trims away some code in the
>> !WITH_LINENO case, though it's kind of ugly.  Maybe something like
>>
>> 	#ifndef WITH_LINENO
>> 	static void update_lineno(void) { }
>> 	#else
>> 	static void update_lineno(void)
[...]
>> would make it more palatable.
>
> Yes please do it like that.

Will do this as well.

Thanks,
Jonathan
