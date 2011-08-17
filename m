From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] [SHELL] Add top-level autogen.sh
Date: Tue, 16 Aug 2011 20:15:06 -0500
Message-ID: <20110817011506.GB22867@elie.gateway.2wire.net>
References: <20110816.174522.285622493440427234.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62016 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab1HQBPK (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 16 Aug 2011 21:15:10 -0400
Received: by yie30 with SMTP id 30so403255yie.19
        for <dash@vger.kernel.org>; Tue, 16 Aug 2011 18:15:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110816.174522.285622493440427234.davem@davemloft.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dash@vger.kernel.org, herbert@gondor.hengli.com.au

David Miller wrote:

> --- /dev/null
> +++ b/autogen.sh
> @@ -0,0 +1,6 @@
> +#!/bin/sh
> +
> +aclocal \
> +&& autoheader \
> +&& automake --add-missing \
> +&& autoconf

Doesn't "autoreconf -fis" work?
