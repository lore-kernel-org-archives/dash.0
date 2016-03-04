From: Martin Lucina <martin@lucina.net>
Subject: Re: Dash commit 46d3c1a (in 0.5.8+) breaks BSD make
Date: Fri, 4 Mar 2016 16:48:41 +0100
Message-ID: <20160304154841.GD2457@nodbug.lucina.net>
References: <20160304140635.GB2457@nodbug.lucina.net>
 <56D99A91.2010901@rumpkernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp.lucina.net ([62.176.169.44]:38273 "EHLO smtp.lucina.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbcCDPse (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 4 Mar 2016 10:48:34 -0500
Content-Disposition: inline
In-Reply-To: <56D99A91.2010901@rumpkernel.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, rumpkernel-users@freelists.org

On Friday, 04.03.2016 at=A014:24, Antti Kantee wrote:
> On 04/03/16 14:06, Martin Lucina wrote:
> >Commit 46d3c1a ([VAR] Sanitise environment variable names on entry)
> >restricts exported environment variables actually set by dash on ent=
ry to
> >those reported as valid by endofname(). While this is technically co=
rrect
> >and matches IEEE Std 1003.1, it breaks BSD make which uses '.' as a
> >separator in variables exported via the environment to a sub-make.
>=20
> I wouldn't go so far as to say it breaks BSD make.  Rather, it breaks=
 a rare
> pattern where variables containing "." (where "." follows a certain
> convention) are passed to submakes via the shell (i.e. ".export" in t=
he
> Makefile).
>=20
> >Would the dash maintainers consider replacing 46d3c1a with a fix tha=
t
> >performs the name validity check at "export -p" time instead? If yes=
, I can
> >try my hand at a patch.
>=20
> There are probably enough deployments of dash with this behaviour so =
that we
> need in any case need to remove the use of variables containing "." c=
oupled
> with ".export" from Makefiles.  Changing dash doesn't sound useful to=
 me.

You're right -- I spoke too soon and thought this behaviour was a gener=
al
property of nbmake rather than our specific usage of it. Still, the
maintainers may want to note in dash documentation that sanitizing expo=
rted
variables can cause some applications depending on the non-POSIX behavi=
our
to fail.

