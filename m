From: Eric Blake <eblake@redhat.com>
Subject: '>;
	' redirection operator [was: [1003.1(2008)/Issue 7 0000530]: Support
	in-place editing in sed  (-iEXTENSION)]
Date: Thu, 22 Dec 2011 14:03:26 -0700
Message-ID: <4EF39B1E.80709@redhat.com>
References: <201112221539.pBMFdlaj011933@penguin.research.att.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------enig447785FD82D8B64D0B172457"
Return-path: <bug-bash-bounces+gnu-bug-bash-2=m.gmane.org@gnu.org>
In-Reply-To: <201112221539.pBMFdlaj011933@penguin.research.att.com>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-bash>,
	<mailto:bug-bash-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-bash>
List-Post: <mailto:bug-bash@gnu.org>
List-Help: <mailto:bug-bash-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-bash>,
	<mailto:bug-bash-request@gnu.org?subject=subscribe>
Errors-To: bug-bash-bounces+gnu-bug-bash-2=m.gmane.org@gnu.org
Sender: bug-bash-bounces+gnu-bug-bash-2=m.gmane.org@gnu.org
To: David Korn <dgk@research.att.com>, austin-group-l@opengroup.org
Cc: zsh-workers@zsh.org, miros-discuss@mirbsd.org, Bash - Bug <bug-bash@gnu.org>, dash <dash@vger.kernel.org>
List-Id: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig447785FD82D8B64D0B172457
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[cc'ing bash, dash, mksh, and zsh developers; feel free to avoid
cross-posted replies on content not relevant to all the groups]

On 12/22/2011 08:39 AM, David Korn wrote:
> Subject: Re: Re: [1003.1(2008)/Issue 7 0000530]: Support in-place editi=
ng in sed  (-iEXTENSION)
> --------
>=20
> There are many commands other than sed that want the output to replace
> an input file.  That is why I added the >; redirection operator to ksh9=
3.
>=20
> With >; you can do
> 	sed -e s/foo/bar/ file >; file
> to do in place sed.  The >; operator generates the output in a temporar=
y file
> and moves the file to the original file only if the command terminates
> with 0 exit status.

I agree that engineering a single fix into the shell that can apply to
multiple situations, rather than chasing down a set of applications to
add an in-place editing option to each, is a much more flexible and
powerful approach.  Can we get buy-in from other shell developers to
support '>;' as an atomic temp-file replacement-on-success idiom, if
POSIX were to standardize the existing practice of ksh93 as the basis?

I assume on the ksh implementation that the temp file is discarded if
the command (simple or compound) feeding the redirection failed?  If the
redirection is used on a simple command, is there any shorthand for
specifying that the destination name on success also be fed as an
argument to the command, to avoid the redundancy of having to type
'file' both before and after the '>;' operator?  I assume that this is
like any other redirection operator, where an optional fd number can be
prepended, as in '2>; file' to collect stderr and overwrite file on
success?  What happens if there is more than one '>;' redirection in the
same command, and both target the same end file (whether or not by the
same file name)?  What happens if the command succeeds, but the rename
of the temp file to the destination fails?  Are there clobber ('>|') or
append ('>>') variants?

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig447785FD82D8B64D0B172457
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJO85seAAoJEKeha0olJ0NqtCMH/0CD/JEF2k2PEqr3xy+t/Ke7
/4HeEckh151YlAu+urp+18GDi+WLLuahfJ8sSuipo8k28wSRcqrp/Mxnb2zqYxZk
P9vmeWbXkRQrKlAWv/huad1NniatJDnb+tPzoOWNRbJwOvGrdSkJ+tQHYpnTkGN6
PxjIrpx7pF93nca2jqzNV2SH/oWL/JaS5qwaSSUZZyW11nyA3OD5awuD3MAZdhC1
2fQmbScbmzneO1tEWqXVJM+vCFC6AGUateR9KqQuuA+0vKaEYY2Kk6Tj1O9ilO7g
TFXkjIqs1k2t4TfKtCVV6KWTaNQOZXys6CpPbZB46dwKPl6ig4gVRWtZBAfMFjQ=
=5pGz
-----END PGP SIGNATURE-----

--------------enig447785FD82D8B64D0B172457--
