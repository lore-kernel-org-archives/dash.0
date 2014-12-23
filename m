From: Vadim Zeitlin <vz-dash@zeitlins.org>
Subject: Re[2]: Possibly wrong handling of $_?
Date: Wed, 24 Dec 2014 00:33:32 +0100
Message-ID: <E1Y3YxI-0004Qg-GA@smtp.tt-solutions.com>
References: <E1Y3Y2d-000276-SL@smtp.tt-solutions.com> <5499F8E5.205@gigawatt.nl>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="529402582-41-1419377612=:9020"
Return-path: <dash-owner@vger.kernel.org>
Received: from sunset.tt-solutions.com ([82.240.17.225]:42844 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaLWXdd (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 23 Dec 2014 18:33:33 -0500
In-Reply-To: <5499F8E5.205@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Harald van Dijk <harald@gigawatt.nl>

--529402582-41-1419377612=:9020
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

On Wed, 24 Dec 2014 00:21:09 +0100 Harald van Dijk <harald@gigawatt.nl> wrote:

HvD> On 23/12/2014 23:34, Vadim Zeitlin wrote:
HvD> >   Hello,
HvD> >
HvD> >   I'm not exactly sure if this is a bug because I didn't find any
HvD> > specification about how is this supposed to behave (to my surprise it
HvD> > turned out that $_ was not in POSIX), but please consider this:
HvD> >
HvD> > 	% zsh -c 'echo -n foo && echo $_'
HvD> > 	foofoo
HvD> > 	% bash -c 'echo -n foo && echo $_'
HvD> > 	foofoo
HvD> > 	% dash -c 'echo -n foo && echo $_'
HvD> > 	foo/usr/bin/dash
HvD> 
HvD> This does come across as somewhat confusing, but $_ is really not a 
HvD> special variable at all in dash.

 Ah, this does explain it, thanks!

HvD> If dash did something special with $_, then I agree it would be nice if 
HvD> it would be somewhat compatible with other shells. If dash simply does 
HvD> not implement a feature, that feature is not required by any standard, 
HvD> and that feature is not widely used, then I suspect there won't be a lot 
HvD> of interest in implementing that feature.

 Yes, I understand, somehow the idea that dash didn't implement it at all
just didn't occur to me, but clearly adding a non-standard new feature is
not nowhere near as important as fixing [what looked like] a bug. I'm not
sure about the "not widely part", but I don't have any non-anecdotal
evidence one way or the other.

HvD> Don't be put off by that, though. You are free, of course, if you feel 
HvD> so, to attempt to convince people $_ is an important feature that all 
HvD> shells should implement. If you have compelling use cases, if it solves 
HvD> real problems, and if many other shells already implement it, you might 
HvD> even get it standardised. I have never seen a need for it, but that's 
HvD> just me speaking from personal experience, others may feel differently.

 FWIW my initial problem started with using

	builddir := $(shell mkdir -p some-long-make-expression && echo $_)

in a makefile, which seemed like a nice way to assign the value to the
variable only if the directory was successfully created. This can, of
course, be done in a myriad of other ways, but this one just seemed like
the most elegant to me. Whether this counts as a "need" or not is not for
me to say.

 Personally I'd say the main argument for adding support for "$_" to dash
would be to avoid mysterious problems like the one I just had because dash
silently (i.e. without giving any errors) behaves differently from the
other shells, which in my case resulted in the makefile misbehaving only
under Debian (where dash is used as /bin/sh) but not under systems.

 Anyhow, thanks again for your explanation!
VZ

--529402582-41-1419377612=:9020
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAlSZ+8wACgkQBupB3k9sHobMLQCeNhNZUk8r2rkntXvJEev3lh+j
gxEAn31jLmP+UizbWA50+/sZQn0aItuG
=JJrA
-----END PGP SIGNATURE-----

--529402582-41-1419377612=:9020--
