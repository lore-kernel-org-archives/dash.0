From: Eric Blake <eblake@redhat.com>
Subject: where to obtain dash 0.5.9.1?
Date: Wed, 15 Feb 2017 15:07:15 -0600
Message-ID: <24cd7280-3c78-f612-34b6-ac66c4240134@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="k9bixaXxl0xQqG9mpONcGED0CFnGUS1u0"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750719AbdBOVHS (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 15 Feb 2017 16:07:18 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 020393A7697
        for <dash@vger.kernel.org>; Wed, 15 Feb 2017 21:07:19 +0000 (UTC)
Received: from [10.10.123.249] (ovpn-123-249.rdu2.redhat.com [10.10.123.249] (may be forged))
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v1FL7IsS006195
        for <dash@vger.kernel.org>; Wed, 15 Feb 2017 16:07:18 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k9bixaXxl0xQqG9mpONcGED0CFnGUS1u0
Content-Type: multipart/mixed; boundary="OsUXPm5Tjn8tlqxGCj0G3dkWTFiqrQPVF";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: dash <dash@vger.kernel.org>
Message-ID: <24cd7280-3c78-f612-34b6-ac66c4240134@redhat.com>
Subject: where to obtain dash 0.5.9.1?

--OsUXPm5Tjn8tlqxGCj0G3dkWTFiqrQPVF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I see in dash.git checked out from
git://git.kernel.org/pub/scm/utils/dash/dash.git that dash 0.5.9.1 was
released several months ago.  But all my attempts to connect to
http://gondor.apana.org.au/~herbert/dash/files/ (as recommended by
google) to obtain the official tarball are timing out. Is there another
location that mirrors the official dash tarballs?  Has the project
website moved somewhere, and google just not caught up to the new
location?  Or is it a transient failure that will be fixed soon now that
I've called attention to it?  Or am I expected to build from git rather
than from tarball these days?

Thanks in advance for any answers you can give.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--OsUXPm5Tjn8tlqxGCj0G3dkWTFiqrQPVF--

--k9bixaXxl0xQqG9mpONcGED0CFnGUS1u0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpMMDAAoJEKeha0olJ0NqzWwH/0ErX1fxc6c091RBZnfmEd1P
tNFZCRycfvl77MqimHrkhIYjc8boVu1M649uIpFSzXJvXteKyF2vPHIBooVqP8IC
upefPLqrSLIJfHT04dy3me5xZaHI7l9OdTG5Olk7H+xhhSjgXTPIw3d4MxhxndFB
atEBkiT9RhoQIN4i9xQM+ZfbYoKaBbQfPGwXSTh7p0t0+iLG3nPbdJfqvHIzGg6G
vwGY3mCkJpiDdCBkY1sVVVtzN6g6TLfQuGxGS970ywNlFEmJqO45dBG9X9NfA/LL
eWpe+qzduEByYqJ21KPEAoHQxD+QyFCMG612xukAT5dKMfDGg5V7B0xzIDmPHv8=
=Caiz
-----END PGP SIGNATURE-----

--k9bixaXxl0xQqG9mpONcGED0CFnGUS1u0--
