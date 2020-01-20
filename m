From: Michael Greenberg <Michael.Greenberg@pomona.edu>
Subject: Re: [PATCH] builtin: Fix seconds part of times(1)
Date: Mon, 20 Jan 2020 15:09:08 +0000
Message-ID: <m2lfq26u7h.fsf@pomona.edu>
References: <m2r281wn3m.fsf@pomona.edu>
 <20200120094648.b23lt2izmg5cz34g@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:36212
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgATPJN (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 20 Jan 2020 10:09:13 -0500
In-Reply-To: <20200120094648.b23lt2izmg5cz34g@gondor.apana.org.au>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

Looks great! Thanks for getting to this. :)

Cheers,
Michael

On Mon, Jan 20 2020, Herbert Xu wrote:

> On Mon, Jun 10, 2019 at 02:07:11PM +0000, Michael Greenberg wrote:
>>
>> If folks are opposed to including math.h for some reason, I'm sure the
>> computation could be done another way.
>
> Thanks for the patch.  Yes I would like to avoid the libm dependency.
> How about something like this:
>
> ---8<---
> The seconds part of the times(1) built-in is wrong as it does not
> exclude the minutes part of the result.  This patch fixes it.
>
> This problem was first noted by Michael Greenberg who also sent
> a similar patch.
>
> Reported-by: Michael Greenberg <michael.greenberg@pomona.edu>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/src/bltin/times.c b/src/bltin/times.c
> index 8eabc1f..1166a68 100644
> --- a/src/bltin/times.c
> +++ b/src/bltin/times.c
> @@ -15,16 +15,28 @@
>  int timescmd() {
>         struct tms buf;
>         long int clk_tck =3D sysconf(_SC_CLK_TCK);
> +       int mutime, mstime, mcutime, mcstime;
> +       double utime, stime, cutime, cstime;
>
>         times(&buf);
> -       printf("%dm%fs %dm%fs\n%dm%fs %dm%fs\n",
> -              (int) (buf.tms_utime / clk_tck / 60),
> -              ((double) buf.tms_utime) / clk_tck,
> -              (int) (buf.tms_stime / clk_tck / 60),
> -              ((double) buf.tms_stime) / clk_tck,
> -              (int) (buf.tms_cutime / clk_tck / 60),
> -              ((double) buf.tms_cutime) / clk_tck,
> -              (int) (buf.tms_cstime / clk_tck / 60),
> -              ((double) buf.tms_cstime) / clk_tck);
> +
> +       utime =3D (double)buf.tms_utime / clk_tck;
> +       mutime =3D utime / 60;
> +       utime -=3D mutime * 60.0;
> +
> +       stime =3D (double)buf.tms_stime / clk_tck;
> +       mstime =3D stime / 60;
> +       stime -=3D mstime * 60.0;
> +
> +       cutime =3D (double)buf.tms_cutime / clk_tck;
> +       mcutime =3D cutime / 60;
> +       cutime -=3D mcutime * 60.0;
> +
> +       cstime =3D (double)buf.tms_cstime / clk_tck;
> +       mcstime =3D cstime / 60;
> +       cstime -=3D mcstime * 60.0;
> +
> +       printf("%dm%fs %dm%fs\n%dm%fs %dm%fs\n", mutime, utime, mstime, s=
time,
> +              mcutime, cutime, mcstime, cstime);
>         return 0;
>  }
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: https://nam01.safelinks.protection.outlook.com/?url=3Dhttp:%2F=
%2Fgondor.apana.org.au%2F~herbert%2F&amp;data=3D02%7C01%7CMichael.Greenberg=
%40pomona.edu%7Cdd48fafec4ff4860dd3d08d79d8dae5a%7C817f590439044ee8b3a5a65d=
4746ff70%7C0%7C0%7C637151104157970338&amp;sdata=3D50I8unmDcArdkRhrzECnv4S05=
daM6cq1az7SBENGpG4%3D&amp;reserved=3D0
> PGP Key: https://nam01.safelinks.protection.outlook.com/?url=3Dhttp:%2F%2=
Fgondor.apana.org.au%2F~herbert%2Fpubkey.txt&amp;data=3D02%7C01%7CMichael.G=
reenberg%40pomona.edu%7Cdd48fafec4ff4860dd3d08d79d8dae5a%7C817f590439044ee8=
b3a5a65d4746ff70%7C0%7C0%7C637151104157970338&amp;sdata=3D1wrzxGBArZ5YVQCKV=
%2BdYH03e0v0wevKHFnfYcCgwQWM%3D&amp;reserved=3D0
> ________________________________
>
> [EXTERNAL EMAIL] Exercise caution before clicking on links or opening att=
achments.
