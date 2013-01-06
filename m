From: jca+dash@wxcvbn.org (=?utf-8?Q?J=C3=A9r=C3=A9mie_Courr=C3=A8ges-Angl?=
	=?utf-8?Q?as?=)
Subject: Re: patch for dash
Date: Sun, 06 Jan 2013 18:37:34 +0100
Message-ID: <87bod2fc0x.fsf@moo.wxcvbn.org>
References: <87a9sms281.fsf@asrock.chizhovka.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <dash-owner@vger.kernel.org>
Received: from coloc.wxcvbn.org ([80.67.177.44]:31543 "EHLO moo.wxcvbn.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756120Ab3AFRoR (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 6 Jan 2013 12:44:17 -0500
In-Reply-To: <87a9sms281.fsf@asrock.chizhovka.net> (Aleksey Cheusov's message
	of "Sun, 06 Jan 2013 19:30:54 +0300")
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Aleksey Cheusov <vle@gmx.net>
Cc: dash@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aleksey Cheusov <vle@gmx.net> writes:

> Hi. The following patch fixes dash build failure on Solaris
> where /usr/bin/nl (which is in default PATH) is not POSIX compatible.
> POSIX-ly correct version is in /usr/xpg4/bin but I think it's easier
> to fix use of nl(1).

Hi.  I'd like to submit this slightly different patch that uses awk
instead of nl.  This is useful for example on OpenBSD, which doesn't have
nl in the base system.

Regards,
--=20
J=C3=A9r=C3=A9mie Courr=C3=A8ges-Anglas
GPG Fingerprint: 61DB D9A0 00A4 67CF 2A90  8961 6191 8FBF 06A1 1494


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=patch-src_mkbuiltins
Content-Transfer-Encoding: base64

LS0tIHNyYy9ta2J1aWx0aW5zLm9yaWcJU2F0IFNlcCAyOSAyMToxMTowNCAyMDEyCisrKyBzcmMv
bWtidWlsdGlucwlTYXQgU2VwIDI5IDIxOjI1OjQ5IDIwMTIKQEAgLTk3LDggKzk3LDkgQEAgY2F0
IDw8XCEKICAqLwogCiAhCi1zZWQgJ3MvCS1bYS16XSovLycgJHRlbXAyIHwgbmwgLWIgYSAtdiAw
IHwgTENfQ09MTEFURT1DIHNvcnQgLXUgLWsgMywzIHwKLXRyIGFiY2RlZmdoaWprbG1ub3BxcnN0
dXZ3eHl6IEFCQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaIHwKK3NlZCAncy8JLVthLXpdKi8vJyAk
dGVtcDIgfCBhd2sgJ3sgcHJpbnRmICIlNmRcdCVzXG4iLCBOUi0xLCAkMCB9JyB8CisJTENfQ09M
TEFURT1DIHNvcnQgLXUgLWsgMywzIHwKKwl0ciBhYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5eiBB
QkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWiB8CiAJYXdrICd7CXByaW50ZiAiI2RlZmluZSAlcyAo
YnVpbHRpbmNtZCArICVkKVxuIiwgJDMsICQxfScKIHByaW50ZiAnXG4jZGVmaW5lIE5VTUJVSUxU
SU5TICVkXG4nICQod2MgLWwgPCAkdGVtcDIpCiBlY2hvICcK
--=-=-=--
