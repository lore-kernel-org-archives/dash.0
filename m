From: Jeroen van Dijke <jeroen@vandijke.net>
Subject: Bug in man page
Date: Sun, 9 Mar 2014 12:11:43 +0100
Message-ID: <B9BC530A-2542-409D-AA48-2B9E3B7906A1@vandijke.net>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:2451 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaCILWd convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 9 Mar 2014 07:22:33 -0400
Received: from [10.0.1.16] (dhcp-077-250-130-229.chello.nl [77.250.130.229])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id s29BBi8X006478
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sun, 9 Mar 2014 12:11:47 +0100 (CET)
	(envelope-from jeroen@vandijke.net)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

There seems to be a bug in the dash man page, at least in 0.5.7. It rea=
ds:

            Precision:
                    An optional period, `.', followed by an optional di=
git string giving a precision which specifies the number of digits to a=
ppear after the decimal point, for e and f formats, or the maximum numb=
er of *characters* to be printed from a string (b and s for-
                    mats); if the digit string is missing, the precisio=
n is treated as zero;

dash behaves cuts to the number of bytes

$ length=3D10; printf "%.${length}s\n" "eeeeeeeeeeeeeeeeeeeeeeeee"
eeeeeeeeee
$ length=3D10; printf "%.${length}s\n" "=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=
=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=EB=94
=EB=EB=EB=EB=EB


The  POSIX specification (2008) says:

precision Gives the minimum number of digits to appear for the d, o, i,=
 u, x, or X conversion specifiers (the field is padded with leading zer=
os), the number of digits to appear after the radix character for the e=
 and f conversion specifiers, the maximum number of significant digits =
for the g conversion specifier; or the maximum number of *bytes* to be =
written from a string in the s conversion specifier. The precision shal=
l take the form of a ( '.' ) followed by a decimal digit string; a null=
 digit string is treated as zero.

So it seems to me that =93characters=94 should be changed to =93bytes=94=
=2E

Kind Regards,

Jeroen van Dijke