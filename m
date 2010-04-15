From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [patch v2] dash fix for job control off warning
Date: Thu, 15 Apr 2010 13:50:46 +0800
Message-ID: <20100415055046.GA32060@gondor.apana.org.au>
References: <20100406221925.GE7863@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:46435 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754841Ab0DOFuw (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 15 Apr 2010 01:50:52 -0400
Content-Disposition: inline
In-Reply-To: <20100406221925.GE7863@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: dash@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com

On Wed, Apr 07, 2010 at 12:19:25AM +0200, maximilian attems wrote:
> fix subject and added warning to patch mail,
> thanks for review.
> 
> ----- Forwarded message from "H. Peter Anvin" <hpa@zytor.com> -----
> 
> Date: Mon, 29 Mar 2010 15:07:01 -0700
> From: "H. Peter Anvin" <hpa@zytor.com>
> To: maximilian attems <max@stro.at>
> Cc: Colin Watson <cjwatson@ubuntu.com>, klibc@zytor.com,
> 	Herbert Xu <herbert@gondor.apana.org.au>,
> 	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Subject: Re: [klibc] dash fix for job control off warning
> 
> There seems to be a problem with the new version of dash
> with job control off.  I can't tell if it is just a warning or is a
> manifest bug.
> 
> usr/dash/trap.c: In function `exitshell':
> usr/dash/trap.c:376: warning: suggest braces around empty body in an `if' statement

Patch applied.  Thanks!
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
