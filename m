From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH] Set SA_RESTART flag on SIGCHLD handler
Date: Thu, 21 Jun 2012 03:48:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1206210345050.3236@dr-wily.mit.edu>
References: <4F665E77.3060102@mit.edu> <20120319025201.GA24778@burratino> <4F66A6CA.4010002@mit.edu> <20120319033751.GA25237@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:63047 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751937Ab2FUHxq convert rfc822-to-8bit
	(ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 21 Jun 2012 03:53:46 -0400
In-Reply-To: <20120319033751.GA25237@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@packages.debian.org

It looks like this was never forwarded to the dash mailing list.  Any=20
thoughts from upstream?

Context: http://thread.gmane.org/gmane.comp.version-control.git.debian/=
147
(FTR, it did happen again.)

Anders

On Sun, 18 Mar 2012, Jonathan Nieder wrote:

> Anders Kaseorg wrote:
>=20
> > So I guess I=E2=80=99m willing to just hope for now that this doesn=
=E2=80=99t happen
> > again.  (Unless you think it=E2=80=99s a dash bug that EINTR isn=E2=
=80=99t handled
> > there?)
>=20
> Yes, I suspect it's a dash >=3D 0.5.6 bug.  On initialization dash se=
ts
> up a signal handler for SIGCHLD without the SA_RESTART flag, which ca=
n
> cause other dash code to fail at seemingly random times.  Similar
> problems would arise when scripts set up traps.
>=20
> diff --git i/src/trap.c w/src/trap.c
> index 17316c95..cd99596f 100644
> --- i/src/trap.c
> +++ w/src/trap.c
> @@ -259,7 +259,7 @@ setsignal(int signo)
>  		act.sa_handler =3D SIG_DFL;
>  	}
>  	*t =3D action;
> -	act.sa_flags =3D 0;
> +	act.sa_flags =3D SA_RESTART;
>  	sigfillset(&act.sa_mask);
>  	sigaction(signo, &act, 0);
>  }
>=20
