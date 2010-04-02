From: maximilian attems <max@stro.at>
Subject: Re: (fwd) dash fix for job control off warning
Date: Fri, 2 Apr 2010 16:47:51 +0200
Message-ID: <20100402144751.GA32211@baikonur.stro.at>
References: <20100402143220.GC6199@stro.at> <20100402144220.GB31158@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:40665 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab0DBOzg (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 2 Apr 2010 10:55:36 -0400
Content-Disposition: inline
In-Reply-To: <20100402144220.GB31158@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, klibc@zytor.com

On Fri, Apr 02, 2010 at 10:42:20PM +0800, Herbert Xu wrote:
> On Fri, Apr 02, 2010 at 04:32:20PM +0200, maximilian attems wrote:
> >
> > Pulled this; there seems to be a problem with the new version of da=
sh
> > with job control off.  I can't tell if it is just a warning or is a
> > manifest bug.
> >=20
> > The solution is simple:
> >=20
> > --- a/usr/dash/jobs.h
> > +++ b/usr/dash/jobs.h
> > @@ -105,5 +105,5 @@ int waitforjob(struct job *);
> >  int stoppedjobs(void);
> >=20
> >  #if ! JOBS
> > -#define setjobctl(on)  /* do nothing */
> > +#define setjobctl(on) ((void)(on))     /* do nothing */
> >  #endif
> >=20
> > ... to keep the code syntactically valid even when setjobctl() is u=
sed
> > as the body of an if statement.
>=20
> So when exactly is this needed? Can you give an example?

usr/dash/trap.c: In function `exitshell':
usr/dash/trap.c:376: warning: suggest braces around empty body in an `i=
f' statement

exitshell() has:

        /*
         * Disable job control so that whoever had the foreground befor=
e we
         * started can get it back.
         */
        if (likely(!setjmp(loc.loc)))
                setjobctl(0);


aboves patch fixes this gcc warning for me, but I still see:
  KLIBCCC usr/dash/trap.o
usr/dash/trap.c: In function =E2=80=98exitshell=E2=80=99:
usr/dash/trap.c:352: warning: variable =E2=80=98status=E2=80=99 might b=
e clobbered by =E2=80=98longjmp=E2=80=99 or =E2=80=98vfork=E2=80=99

