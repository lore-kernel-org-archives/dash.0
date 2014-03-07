From: Eric Blake <eblake@redhat.com>
Subject: Re: command lookup and POSIX
Date: Fri, 07 Mar 2014 16:44:00 -0700
Message-ID: <531A59C0.6050303@redhat.com>
References: <20140307194318.GA2317@home.jasonmmiller.org> <531A3FE2.8050109@redhat.com> <20140307224821.GA22435@home.jasonmmiller.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fdbUWnX5mnk6sb04WCWCnOwnUR3xREekI"
Return-path: <dash-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbaCGXoE (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 7 Mar 2014 18:44:04 -0500
In-Reply-To: <20140307224821.GA22435@home.jasonmmiller.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jason Miller <jason@milr.com>
Cc: dash@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fdbUWnX5mnk6sb04WCWCnOwnUR3xREekI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 03:48 PM, Jason Miller wrote:
> On 14:53 Fri 07 Mar     , Eric Blake wrote:
>> On 03/07/2014 12:43 PM, Jason Miller wrote:
>>> Reading this:
>>>
>>> http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.h=
tml#tag_02_09_01_01

By the way, this is the Issue 6 version of POSIX (2001, updated via
technical corrigendum 1 and 2 through 2004).  You want to be looking at
Issue 7 (2008, with technical corrigendum 1 in 2013).

>>>
>>> Any built-in other than the special built-ins, or listed in the table=

>>> there should not be run unless it is present in the PATH.
>>>
>>> dash however doesn't follow that:
>>>
>>> PS1=3D"% " dash
>>>
>>>     % PATH=3D
>>
>> Stop right there.
>>
>> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.htm=
l#tag_08
>>
>> "If PATH is unset or is set to null, the path search is
>> implementation-defined."
>>
>> Therefore, you have triggered implementation-defined behavior, rather
>> than exposing a bug in dash.
> Okay same question with PATH=3D/foo (dash's behavior is the same)

Still a problem in your script - POSIX says that you have a
non-compliant environment if you do certain things to PATH, at which
point dash can do whatever it wants.  Basically, if PATH ever lacks any
directories in 'getconf PATH', you have left the realm of POSIX
compliance.  See also the application usage for command:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fdbUWnX5mnk6sb04WCWCnOwnUR3xREekI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJTGlnAAAoJEKeha0olJ0NqsVYH/1xSsg3LoSIffp6WYLGdI3qO
nElbx1EaDpRaxz5VCq3crVK6Joy20HfAKmb9AzGVmcHUiYXK9jAoRoorgTK+hHz4
65PUvB/zfQsZ2x52CzjqQ2iO6wpfwXTMLkmd9izU2L8behj0b97aEYdJuPtczx3I
LiT1ZOQOUrWZZu2GkJXmf8P8N0ZqObP44Hk1inzQK/Ecv+2joo2NCQamOvhI1vH+
vHIL9N+9TyB/VKOmS9M0vgGZH0bAuNCLXtMxVaPyiHnVLY/0kqaxINX/zxbEh2L3
8kUEb/MRc761VPgf+qNxWVI1EkdO5uq0PHF4OpBwDySEvdTGj8iF+pzuUsSw4Ss=
=79dc
-----END PGP SIGNATURE-----

--fdbUWnX5mnk6sb04WCWCnOwnUR3xREekI--
