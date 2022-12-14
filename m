Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBD4C4332F
	for <linux-dash@archiver.kernel.org>; Wed, 14 Dec 2022 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLNOT1 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 14 Dec 2022 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLNOTZ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 14 Dec 2022 09:19:25 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193326AE1
        for <dash@vger.kernel.org>; Wed, 14 Dec 2022 06:19:23 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 002C45C0197;
        Wed, 14 Dec 2022 09:19:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Dec 2022 09:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        greenberg.science; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1671027562; x=1671113962; bh=sT5gf9WCd5VqVtN5Rc3sbSMxg
        PD1i3mtW0OfEUKxRRM=; b=VD6zbb/lJ+kXJndUnf6C/BLoDD3aZLkF674GYvcF9
        XWpUqIWaZElIgebPaRJpn/7lpK7AbLBtqxGzbTX7IDWZtgEBGjEjRQNabqW6zhNm
        ziTQqYH1AnltMRFbKqv2GLwXDmx+xhiq1vxgdwaTciH80hPKD2osbI5y7gMqRIZt
        TbXR9brDN/vAiYzPoXa5DNvKAUBkus206F8s1j1MKPuif9CH4PgzL8bnaJcKhVnC
        7DA+7WEKJWIQLZb4cxpYtixfQiHSvPfz7Z//gzs2jet7K30L/eXqSwop51yhmxtV
        OaXMN8NwX46m8USHZ1yo/Je5d2MmpL8SzsQsU5aQznm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1671027562; x=1671113962; bh=s
        T5gf9WCd5VqVtN5Rc3sbSMxgPD1i3mtW0OfEUKxRRM=; b=dY+t2uICLaAPTVjGn
        4qb8sK9ePUJd10yNgBgCjv2XuDAgqSA2E5O4yHzIlR9JCY1716r+eJHt/asPzZcZ
        wYhtuN+0zW/itnUvOxWGuvmgr26Ifet1fMDF5y3JaOguwOpAVczwFja4kxVuNnU/
        5iitYLfHdSc41Wb6lPEVU7xgad2eQ8CS1hqUTZMc2R9UKmSal1egl0TLNPDk42Fn
        MjM5fAQNygVEELHLz+yRO+D7yxLyxXlVkwEUwFans0OvbngiRZwBfpDy0hPJ4YvQ
        k6DT3xuy5LFC5IyP6Xf+/oWn5Ntn1kuI1qTBB/qYEk+yTIkxCW0duysZkj9e7so2
        BGjrw==
X-ME-Sender: <xms:atuZY6sLbYlMvxgMMQvPeZn7QQUrjjzirLln9P1phQve8vef66ZA-Q>
    <xme:atuZY_e1g8-_atZpLl_ESlkNrJpH0eQiaTVR4JzhS-5q-SyCK4gXfC6PAAgIbf8CR
    1tzO6pjA73TVc363L0>
X-ME-Received: <xmr:atuZY1y8pJlYFr_FtFCRNZfdlSVyCVbADbdMlV1Z3vtP5LtJezUMNnF_kygyCzkllFPhEayhNRS2HCC9cITyd5vCgXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfggtgfgsehtqhertd
    dttdejnecuhfhrohhmpefoihgthhgrvghlucfirhgvvghnsggvrhhguceomhhitghhrggv
    lhesghhrvggvnhgsvghrghdrshgtihgvnhgtvgeqnecuggftrfgrthhtvghrnhepvdegud
    efudetgfefffelgfetieekledtgfeiueeiffeiteefuedvvdelkeeivdfhnecuffhomhgr
    ihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmihgthhgrvghlsehgrhgvvghnsggvrhhgrdhstghivghntggv
X-ME-Proxy: <xmx:atuZY1NHEh5lGQ2c2rh_4wFf5PNZbMOcvTYGATDPWsRV8MrjCl6hZQ>
    <xmx:atuZY6-0pDAhavJE3bVZwzk-KTHMF1vESKupoIzoRVfCvb5v7CvlYg>
    <xmx:atuZY9XEsIQ5Hhm51SOrkYuT9RIleTQ1KaNf-tSqyvoriFsMVAsf9A>
    <xmx:atuZY_GI0qQfdXCdrJMbRNJOCw7sLaNkIvopuYyDgi-8AHD1Eb-YXQ>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 09:19:22 -0500 (EST)
From:   Michael Greenberg <michael@greenberg.science>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
        dash@vger.kernel.org
Subject: Re: [PATCH] options: don't error when unsetting OPTIND
In-Reply-To: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
References: <20221214023130.u7pn4ca6ma4kuxot@tarta.nabijaczleweli.xyz>
Date:   Wed, 14 Dec 2022 09:18:25 -0500
Message-ID: <m2edt2nk5q.fsf@greenberg.science>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

While we're thinking about it, is this the behavior we want? Or should
`readonly` produce an error?

```
$ getopts abc ARG -ab -c foo
$ echo $OPTIND
2
$ echo $ARG
a
$ readonly OPTIND
$ getopts abc ARG -ab -c foo
/Users/mgree/smoosh/libdash/src/dash: 5: getopts: OPTIND: is read only
$ echo $ARG
a
$ echo $OPTIND
2
```

There are similar questions for PWD and other shell-set nameable
variables:

```
$ readonly PWD
$ pwd
/Users/mgree/pash-medium/budgeting
$ cd ..
/Users/mgree/smoosh/libdash/src/dash: 13: cd: PWD: is read only
$ pwd
/Users/mgree/pash-medium
```

But special parameters (like @ and ?) are outright rejected by
`readonly`.

Bafflingly, the POSIX spec gives the example `readonly HOME PWD`, but
with no explanation about why one might want to do that. (I get making
`HOME` readonly, but `PWD`? Is that supposed to stop `cd` from working?)

Cheers,
Michael

On 2022-12-14 at 03:31:30 AM, =D0=BD=D0=B0=D0=B1 wrote:

> unset OPTIND ends up calling getoptsreset("") which errors out with
>   sh: 1: unset: Illegal number:
> or even
>   sh: 1: unset: Illegal number: leweli/bin:/usr/l=EF=BF=BD=EF=BF=BD
>
> Pass the current flags to struct var->func, set the getopts optind to 1
> and continue with allowing the unset.
>
> We still forbid OPTIND=3D, OPTIND=3D-1, OPTIND=3Dabc, &c.
>
> Fixes: https://bugs.debian.org/985478
> ---
>  src/exec.c    | 2 +-
>  src/exec.h    | 2 +-
>  src/mail.c    | 2 +-
>  src/mail.h    | 2 +-
>  src/options.c | 5 ++---
>  src/options.h | 2 +-
>  src/var.c     | 4 ++--
>  src/var.h     | 2 +-
>  8 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/src/exec.c b/src/exec.c
> index 87354d4..68fa8ab 100644
> --- a/src/exec.c
> +++ b/src/exec.c
> @@ -565,7 +565,7 @@ hashcd(void)
>   */
>=20=20
>  void
> -changepath(const char *newval)
> +changepath(const char *newval, int unused)
>  {
>  	const char *new;
>  	int idx;
> diff --git a/src/exec.h b/src/exec.h
> index 423b07e..0f74be4 100644
> --- a/src/exec.h
> +++ b/src/exec.h
> @@ -69,7 +69,7 @@ int hashcmd(int, char **);
>  void find_command(char *, struct cmdentry *, int, const char *);
>  struct builtincmd *find_builtin(const char *);
>  void hashcd(void);
> -void changepath(const char *);
> +void changepath(const char *, int);
>  #ifdef notdef
>  void getcmdentry(char *, struct cmdentry *);
>  #endif
> diff --git a/src/mail.c b/src/mail.c
> index 8eacb2d..e81d2b4 100644
> --- a/src/mail.c
> +++ b/src/mail.c
> @@ -109,7 +109,7 @@ chkmail(void)
>=20=20
>=20=20
>  void
> -changemail(const char *val)
> +changemail(const char *val, int unused)
>  {
>  	changed++;
>  }
> diff --git a/src/mail.h b/src/mail.h
> index 3c6b21d..70b54a4 100644
> --- a/src/mail.h
> +++ b/src/mail.h
> @@ -35,4 +35,4 @@
>   */
>=20=20
>  void chkmail(void);
> -void changemail(const char *);
> +void changemail(const char *, int);
> diff --git a/src/options.c b/src/options.c
> index a46c23b..81f2c4b 100644
> --- a/src/options.c
> +++ b/src/options.c
> @@ -390,10 +390,9 @@ setcmd(int argc, char **argv)
>=20=20
>=20=20
>  void
> -getoptsreset(value)
> -	const char *value;
> +getoptsreset(const char *value, int flags)
>  {
> -	shellparam.optind =3D number(value) ?: 1;
> +	shellparam.optind =3D (flags & VUNSET) ? 1 : number(value) ?: 1;
>  	shellparam.optoff =3D -1;
>  }
>=20=20
> diff --git a/src/options.h b/src/options.h
> index 975fe33..10bcb88 100644
> --- a/src/options.h
> +++ b/src/options.h
> @@ -83,4 +83,4 @@ int shiftcmd(int, char **);
>  int setcmd(int, char **);
>  int getoptscmd(int, char **);
>  int nextopt(const char *);
> -void getoptsreset(const char *);
> +void getoptsreset(const char *, int);
> diff --git a/src/var.c b/src/var.c
> index ef9c2bd..a7d4a92 100644
> --- a/src/var.c
> +++ b/src/var.c
> @@ -266,7 +266,7 @@ struct var *setvareq(char *s, int flags)
>  			goto out;
>=20=20
>  		if (vp->func && (flags & VNOFUNC) =3D=3D 0)
> -			(*vp->func)(strchrnul(s, '=3D') + 1);
> +			(*vp->func)(strchrnul(s, '=3D') + 1, flags);
>=20=20
>  		if ((vp->flags & (VTEXTFIXED|VSTACK)) =3D=3D 0)
>  			ckfree(vp->text);
> @@ -531,7 +531,7 @@ poplocalvars(void)
>  			unsetvar(vp->text);
>  		} else {
>  			if (vp->func)
> -				(*vp->func)(strchrnul(lvp->text, '=3D') + 1);
> +				(*vp->func)(strchrnul(lvp->text, '=3D') + 1, lvp->flags);
>  			if ((vp->flags & (VTEXTFIXED|VSTACK)) =3D=3D 0)
>  				ckfree(vp->text);
>  			vp->flags =3D lvp->flags;
> diff --git a/src/var.h b/src/var.h
> index aa7575a..4329e22 100644
> --- a/src/var.h
> +++ b/src/var.h
> @@ -56,7 +56,7 @@ struct var {
>  	struct var *next;		/* next entry in hash list */
>  	int flags;			/* flags are defined above */
>  	const char *text;		/* name=3Dvalue */
> -	void (*func)(const char *);
> +	void (*func)(const char *, int flags);
>  					/* function to be called when  */
>  					/* the variable gets set/unset */
>  };
> --=20
> 2.30.2
