From: Felix Dietrich <felix.dietrich@sperrhaken.name>
Subject: [MAN] Fix description of getopts when last argument reached
Date: Tue, 02 Jun 2015 22:55:19 +0200
Message-ID: <87r3pt6dag.fsf@sperrhaken.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:60893 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbFBUzO convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 2 Jun 2015 16:55:14 -0400
Received: from localhost ([85.181.63.192]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0M4NmW-1ZIm2s3HuW-00ykH9 for
 <dash@vger.kernel.org>; Tue, 02 Jun 2015 22:55:10 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

---
When I read the getopts description in the man-page I got stumped by th=
e
following part:

    getopts optstring var

        [..]

        If there are no remaining arguments, getopts will set var to
        special option, =E2=80=9C--=E2=80=9D, otherwise, it will set va=
r to =E2=80=9C?=E2=80=9D

        [..]

After I was unable to get getopts to store "--" in var, I asked for hel=
p
on comp.unix.shell [1] where it was pointed out to me that actually the
POSIX description of getopts [2] does not include a special option "--"=
;
dash's behaviour of setting var to "?" after the last argument is
correct and that this is most likely an error in the documention.

In case this is not an error: Under what circumstances will var be set
to "--"?  Could you provide an example?

[1] https://groups.google.com/forum/#!topic/comp.unix.shell/BIR9dDgKZvg
[2] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/getopts.h=
tml

 src/dash.1 | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 693c970..832eae7 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -1402,14 +1402,9 @@ By specifying a colon as the first character of
 .Va optstring
 all errors will be ignored.
 .Pp
-A nonzero value is returned when the last option is reached.
-If there are no remaining arguments,
+After the last option
 .Ic getopts
-will set
-.Va var
-to the special option,
-.Dq -- ,
-otherwise, it will set
+will return a non-zero value and set
 .Va var
 to
 .Dq \&? .
--=20
2.1.4

