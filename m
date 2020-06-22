From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] Don't include config.h when building helpers using the
 native compiler
Date: Mon, 22 Jun 2020 12:44:35 +0200
Message-ID: <CAPi7W83awsUjbNa2c2xFqvoJmVdyviX9ZpVD82ssE_TNK6KeRg@mail.gmail.com>
References: <20200622052513.1850288-1-fontaine.fabrice@gmail.com> <b26fe976-2937-3c0e-8543-e7360d03059b@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgFVKos (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 22 Jun 2020 06:44:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93160C061794
        for <dash@vger.kernel.org>; Mon, 22 Jun 2020 03:44:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so18691354ljh.13
        for <dash@vger.kernel.org>; Mon, 22 Jun 2020 03:44:48 -0700 (PDT)
In-Reply-To: <b26fe976-2937-3c0e-8543-e7360d03059b@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>

Dear all,

Le lun. 22 juin 2020 =C3=A0 10:53, Harald van Dijk <harald@gigawatt.nl> a =
=C3=A9crit :
>
> On 22/06/2020 06:25, Fabrice Fontaine wrote:
> > config.h contains settings for the cross compiler (most importantly
> > 32/64bit versions of functions), so don't include it when calling the
> > native compiler to build the helpers.
> >
> > Otherwise we get build errors like:
> >
> > /usr/bin/gcc -include ../config.h -DBSD=3D1 -DSHELL -DIFS_BROKEN  -g -O=
2 -Wall    -o mkinit mkinit.c
> > In file included from /usr/include/sys/stat.h:107,
> >                   from /usr/include/fcntl.h:38,
> >                   from mkinit.c:50:
> > /usr/include/bits/stat.h:117: error: redefinition of =E2=80=98struct st=
at=E2=80=99
> > In file included from /usr/include/fcntl.h:38,
> >                   from mkinit.c:50:
> > /usr/include/sys/stat.h:504: error: redefinition of =E2=80=98stat=E2=80=
=99
> > /usr/include/sys/stat.h:455: note: previous definition of =E2=80=98stat=
=E2=80=99 was here
> >
> > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> > [Retrieved from:
> > https://git.buildroot.net/buildroot/tree/package/dash/0001-no-config.h-=
for-helpers.patch]
> > Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
>
> A better version of this patch has already been submitted and accepted
> in 2018: <https://www.spinics.net/lists/dash/msg01629.html>.
Thanks and sorry for the noise, I'll then remove this patch from my
buildroot as we have just bumped to 0.5.11.
>
> Cheers,
> Harald van Dijk
Best Regards,

Fabrice
