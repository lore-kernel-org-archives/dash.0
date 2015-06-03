From: Martijn Dekker <martijn@inlv.org>
Subject: [BUG] ${#var} returns length in bytes, not characters
Date: Wed, 03 Jun 2015 13:29:33 +0200
Message-ID: <556EE51D.8080100@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:33523 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752283AbbFCL3g (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 3 Jun 2015 07:29:36 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

POSIX:
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_06_02
> ${#parameter}
> String Length. The length in characters of the value of parameter
> shall be substituted. [...]

dash does not expand the length in characters; it expands the length in
bytes instead. That is invalid for locales that include multi-byte
characters, such as the now ubiquitous UTF-8 set.

Test case:

$ locale
LANG=3D"nl_NL.UTF-8"
LC_COLLATE=3D"nl_NL.UTF-8"
LC_CTYPE=3D"nl_NL.UTF-8"
LC_MESSAGES=3D"nl_NL.UTF-8"
LC_MONETARY=3D"nl_NL.UTF-8"
LC_NUMERIC=3D"nl_NL.UTF-8"
LC_TIME=3D"nl_NL.UTF-8"
LC_ALL=3D
$ word=3D'b=E8tatest'	# length: 8
$ echo ${#word}
9

Expected output: 8
Got output: 9

(bash, ksh93, mksh, and zsh all do this correctly.)

- Martijn
