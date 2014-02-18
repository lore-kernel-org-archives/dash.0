From: Steffen (Daode) Nurpmeso <sdaoden@gmail.com>
Subject: Re: dash and ANSI escape sequences
Date: Tue, 18 Feb 2014 14:16:50 +0100
Message-ID: <20140218131650.GVs8So50xSwAsO/JevRUS0/D@dietcurd.local>
References: <ldvhl7$ns2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:42970 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbaBRNRB convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 18 Feb 2014 08:17:01 -0500
Received: by mail-ee0-f47.google.com with SMTP id d49so7757558eek.34
        for <dash@vger.kernel.org>; Tue, 18 Feb 2014 05:17:00 -0800 (PST)
In-Reply-To: <ldvhl7$ns2$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alex Waite <alexqw85@gmail.com>
Cc: dash@vger.kernel.org

Alex Waite <alexqw85@gmail.com> wrote:
 |I come here in search of someone who understands dash/portable script=
ing=20
 |better than I do. Today, my Google-foo is failing me.
 |
 |I am in the process of cleaning up someone else's semi-portable shell=
=20
 |script (originally written on FreeBSD). The original script uses colo=
rs,=20
 |in the form of
 |
 |echo -e "\e[1;32mpassed\e[0m"
 |
 |"echo" should be avoided in general and any option passed to "echo" i=
s=20
 |non-portable. In bash, I can easily port this to printf
 |
 |printf '%b' "\x1b[32;1mpassed\x1b[0m\n"
 |
 |However, this approach does not work in dash. I have read both the ec=
ho=20
 |and printf sections of the dash manual, and it seems that both "\e" a=
nd=20
 |"\x" are unsupported. Using "%b" allows additional backslash-escape=20
 |sequences, but only \c and \0.
 |
 |I know the purpose of dash is to provide an efficient POSIX compliant=
=20
 |shell. Is there really no POSIX compliant way to use color? It seems=20
 |so... 80s. Dash's manpage does state that it supports "backslash=20
 |notation as defined in ANSI X3.159-1989 (=93ANSI C89=94)", but I can'=
t find=20
 |a copy of ANSI C89 online to confirm whether it includes display=20
 |attributes. ANSI C89 is old, but still... too old for color?

Colours have nothing to do with the C programming language, they
are an attribute of ISO 6429/ECMA-48 capable terminals.

 |Am I somehow missing some hidden functionality in printf, or is there=
=20
 |really no POSIX compliant method of printing colors, or is Dash simpl=
y=20
 |incomplete with its POSIX support in this regard?
 |
 |Any insight is most appreciated.

  $ /usr/bin/dash -c 'printf "=1B[32;1mpassed=1B[0m"'

(i.e., the plain control character U+001B, ESCAPE) works for me,
also on mksh(1), ksh(1), bash(1), and old Bourne shells that
effectively go through my /usr/bin/printf.

 |---Alex

--steffen
