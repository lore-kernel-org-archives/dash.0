From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 2/3] Revert "Eliminated global exerrno."
Date: Thu, 7 Oct 2010 12:37:15 +0800
Message-ID: <20101007043715.GA15658@gondor.apana.org.au>
References: <20101006100420.GA361@burratino> <20101006100804.GB361@burratino> <20101006102930.GA6573@gondor.apana.org.au> <20101006105531.GB475@burratino> <4CAC68FD.4040602@redhat.com> <20101007010241.GB1276@burratino> <20101007010458.GD1276@burratino> <20101007025649.GA14649@gondor.apana.org.au> <20101007033518.GB2285@burratino> <20101007041406.GA15529@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:56830 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0JGEhV (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 7 Oct 2010 00:37:21 -0400
Content-Disposition: inline
In-Reply-To: <20101007041406.GA15529@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Gerrit Pape <pape@smarden.org>, dash@vger.kernel.org, "Krzysztof A. Sobiecki" <sobkas@gmail.com>, Jari Aalto <jari.aalto@cante.net>

On Thu, Oct 07, 2010 at 12:14:06PM +0800, Herbert Xu wrote:
>
> Let me run it through the tests and apply it.

There is one problem with this and that is changing the exit
status in a trap:

	sh -c 'trap "exec nosuchfile" EXIT; exit 3'; echo $?

This makes dash exit with 127 instead of 3 as it does now.

AFAIK the wording of POSIX is such that we should return 3, however,
it does seem that every other shell exits with 127.

So unless anyone objects, I will apply your patch and adopt this
new behaviour.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
