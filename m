From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] [EVAL] with set -e exit the shell if a subshell exits
 non-zero
Date: Mon, 28 Jun 2010 07:16:38 -0600
Message-ID: <4C28A0B6.5010305@redhat.com>
References: <20100614095603.27834.qmail@728ec0bb900c60.315fe32.mid.smarden.org> <20100628070231.GA26558@gondor.apana.org.au> <1006280909240.5913@somehost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigC56CBB59BE201B0AFE67C1FC"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0F1NRs (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 28 Jun 2010 09:17:48 -0400
In-Reply-To: <1006280909240.5913@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC56CBB59BE201B0AFE67C1FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2010 01:22 AM, Cristian Ionescu-Idbohrn wrote:
>> Has bash's behaviour changed recently (I'm using an ancient
>> version)?

Yes - bash 4.1 tries harder to be compliant with the recent Austin Group
interpretations (and more like ksh).

>=20
> bash 3.2.39 and 4.0.37 are behaving as dash without the suggested
> patch.  Still.  What is the correct behaviour?  That should be the
> essential matter IMO, not what others do.  So, why should this fail:
>=20
> 	$ dash -c 'set -e; false; echo here'
>=20
> and this succeed?
>=20
> 	$ dash -c 'set -e; (false); echo here'

According to the Austin Group:
http://austingroupbugs.net/view.php?id=3D52

the desired behavior is:

Replace the description of -e with:

  -e When this option is on, when any command fails (for any of the
      reasons listed in [xref to 2.8.1] or by returning an exit status
      greater than zero) the shell immediately shall exit with the
      following exceptions:

      1) The failure of any individual command in a multi-command
          pipeline shall not cause the shell to exit. Only the
          failure of the pipeline itself shall be considered.

      2) The -e setting shall be ignored when executing the compound
          list following the while, until, if, or elif reserved word,
          a pipeline beginning with the ! reserved word, or any
          command of an AND-OR list other than the last.

      3) If the exit status of a compound command other than a
          subshell command was the result of a failure while -e was
          being ignored, then -e shall not apply to this command.

      This requirement applies to the shell environment and each
      subshell environment separately. For example, in

          set -e; (false; echo one) | cat; echo two

      the false command causes the subshell to exit without executing
      echo one; however, echo two is executed because the exit status
      of the pipeline (false; echo one) | cat is zero.

Per these rules, both 'set -e; false; echo here' and 'set -e; (false);
echo here' are silent in bash 4.1.  The fact that dash is not silent
when a subshell exits with non-zero status is at odds with the above
Austin Group ruling.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigC56CBB59BE201B0AFE67C1FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJMKKC7AAoJEKeha0olJ0NqwhMH/R4yNfuXV+1eYjauhY9WeY1M
vNopkKaPgNGwn9ccs3EcnUPudgPlqqNpOQQ59AzNSiPc4E2PGUd/wQwtAFN0mn+G
2GYhoJjTK/Yjb29tlyeAqpj/Ep4c37/PC3FWvMWa4rjnjwF5xR/Z7Bh0PaQeItjd
AmFXsVMc1QBNLA0HbDl473s94461DnDplsJOYZRGC/K9QnKFHhIa2hC6g5EnwcRN
q/SKy2PbQfZRSRBQKiOuPXwCfVdz7qk7l3/y+Ol7Gs01isasIluBhjHu2cos+bbq
ekG+y5ztYrTp1GMB5H/FekSuTK1EjRGSIazVvZtjsQiy4JZV0++LwG8qZSX5+j8=
=eQ/g
-----END PGP SIGNATURE-----

--------------enigC56CBB59BE201B0AFE67C1FC--
