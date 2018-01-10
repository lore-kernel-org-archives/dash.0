From: Joshua Nelson <jynelson@email.sc.edu>
Subject: [BUG] $PATH not fully searched
Date: Wed, 10 Jan 2018 13:36:18 -0500
Message-ID: <1997619.aMy8rkrhBo@debian-thinkpad>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3327101.lkzyEyX69e"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-co1nam03on0082.outbound.protection.outlook.com ([104.47.40.82]:38076
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751665AbeAJSgn (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 10 Jan 2018 13:36:43 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: cdaniels@fastmail.com

--nextPart3327101.lkzyEyX69e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

To the maintainers of the `dash` shell:

I've come across an error with the PATH variable in `dash`. Instead of full=
y=20
searching PATH for commands, dash will respond 'command not found' if `comm=
and=20
=2Dp <executable>` fails.  The same command works fine in Bash.

The following example was performed in a live cd of Debian 9.1 Stretch (run=
 in=20
a virtual machine), with dash version 0.5.8-2.4:

```bash
user@debian:~$ PATH=3D"~/my_bin:$PATH" dash
$ echo $PATH
~/my_bin:/usr/local/bin:/usr/bin:/usr/local/games:/usr/games
$ ls -l ~/my_bin/list
=2Drwxr--r-- 1 user user 18 Jan 10 17:42 /home/user/my_bin/list
$ list
dash: 3: list: not found
$ exit
user@debian:~$ PATH=3D"$PATH:~/my_bin" list
Desktop Documents Downloads Music my_bin Pictures Public Templates Videos
```

I believe but am not certain that this is related to the following patch:
https://www.mail-archive.com/dash@vger.kernel.org/msg01329.html

Thank you for your time,
Joshua Nelson

jynelson@email.sc.edu
B.S. Computer Science
College of Engineering and Computing | South Carolina Honors College
This message was sent with a PGP[1] signature.

=2D-------
[1] https://www.openpgp.org/

--nextPart3327101.lkzyEyX69e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEqDOwG0S92h7oDiYc5lWCPY2LEIgFAlpWXSIACgkQ5lWCPY2L
EIh3Ww//RkrUOom2sejvf6CTZxOsqelYEUDS0zQuVgusAWdxSn7EWc2J0zP5JGV6
HEpdyEVAwSxCD3i6MvtEYLCGCLLHN61liiBS193XJlsBZU/OfLs4e3x9GOjlvN7/
M0veES6gNKn25aQgsn5tEzMMmezb8pTZGY+k7pHvrLQbp7G6p7CqJhaodaG2UL2G
U2XCZAQsdj3rrjwwHUcmbkQPi+oMLyu0Xw8urQQcoUsSfyNnth1IurvEN+YMfrw+
1vN+WCxbSvenu2afjiah0CnKAfsjMlQeRUUPmk6tVvHgzkK0rU/jjAfOKsjPPTTa
sogrI/r9Ka6uezCxwhTp+/ziIO91gFgPz2Mgv2vM6bxKlcQb6QnPatE1N84GhDFk
GbGUASuP71+zKsMJUCGdYBgSD+RUtROQMtDwGbld0TR+Vja6M3w5MgRKpswWNWXb
IIoqg1d70pnCdq6Vo2eoNNWUkh/2U3bt7jxImJRiah5vZOvmWrb5+b7HOqxf+ynj
NSIz9sFWP729YO1jDCIofPOzUdPTckHdfzYUApYs+CWoT/4xs4kcFx8kvljtG7BX
P+axBWHqNiKBxGfl7uHptFaeRDtwMxXqIliLxQZD3im30TR2qxB6V/2u1nOW6gPL
9JQbIB27nKj1t+tABFMO8TM1i78vcgVadZ9KqyxJtasEB3wv+yU=
=VUHQ
-----END PGP SIGNATURE-----

--nextPart3327101.lkzyEyX69e--
