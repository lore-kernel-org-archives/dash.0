From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] parser: Catch errors in expandstr
Date: Tue, 21 Jan 2020 17:06:15 +0000
Message-ID: <ifdF-mI9buGzqHAdD-wIuCKj--uNOthFkm1545tsyG3vVhkMqEqZKbx_ZEnu1vK8JQr347hcsbicRHWEo5Lsk2SNtxp4UNoQTfwe1qiR8jA=@emersion.fr>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
 <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
Reply-To: Simon Ser <contact@emersion.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-40131.protonmail.ch ([185.70.40.131]:53827 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgAURGV (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 21 Jan 2020 12:06:21 -0500
In-Reply-To: <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Tuesday, January 21, 2020 7:39 AM, Herbert Xu <herbert@gondor.apana.org.=
au> wrote:

> On Fri, Dec 13, 2019 at 02:51:34PM +0000, Simon Ser wrote:
>
> > Just noticed another dash bug: when setting invalid PS1 values dash
> > enters an infinite loop.
> > For instance, setting PS1=3D'$(' makes dash print many of these:
> > dash: 1: Syntax error: end of file unexpected (expecting ")")
> > It would be nice to fallback to the default PS1 value on error.
>
> This patch fixes it by using the literal value of PS1 should an
> error occur during expansion.
>
> Reported-by: Simon Ser <contact@emersion.fr>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks, works!

Tested-by: Simon Ser <contact@emersion.fr>
