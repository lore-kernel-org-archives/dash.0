From: max ulidtko <ulidtko@gmail.com>
Subject: [BUG] Improper 8-bit parsing because of signed overflow
Date: Sat, 15 Jan 2011 21:24:37 +0200
Message-ID: <1295119477.12334.78.camel@ulidtko>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60679 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab1AQPAX (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 17 Jan 2011 10:00:23 -0500
Received: by fxm20 with SMTP id 20so6129242fxm.19
        for <dash@vger.kernel.org>; Mon, 17 Jan 2011 07:00:21 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

In parser.c there is a function readtoken1() which fails to properly
parse some 8-bit (i.e. UTF-8) tokens (filenames). Consider the followin=
g
test:

$ cat < =D1=82=D0=B5=D1=81=D1=82
sh: cannot open =D1=82=D0=B5=EF=BF=BD=D1=82: No such file
$ echo "=D1=82=D0=B5=D1=81=D1=82" | od -b
0000000 321 202 320 265 321 201 321 202 012
0000011

Here "=D1=82=D0=B5=D1=81=D1=82" is four Cyrillic characters which get e=
ncoded in 8 bytes of
UTF-8. The third character (sixth byte, \201, to be exact) fails to be
parsed by dash.

The reason is signed overflow. The parser uses syntax tables to
determine the class to which a given byte (assuming it's a whole
character) belongs. The lookup is done like this:
	switch(syntax[c]) {
But the variable c is declared as int. So instead of looking up the
character \201 (129 in decimal) the parser uses signed index -127 to
look up garbage which happens to be not equal to 0 (=3D=3DCWORD). As a
result, the output token becomes corrupted.=20

Here is some gdb output:
(gdb) next
884				switch(syntax[c]) {
8: syntax[c] =3D 12 '\f'
7: out =3D 0x8061659 ""
6: stacknxt =3D 0x8061654 "=D1=82=D0=B5", <incomplete sequence \321>
5: (char)c =3D -127 '\201'
(gdb) print syntax[129]
$42 =3D 0 '\000'
(gdb) print syntax[(unsigned char)c]
$43 =3D 0 '\000'
(gdb) print syntax[c]
$44 =3D 12 '\f'

I would note that *any* 8-bit characters are being looked up in syntax
tables incorrectly. Though only some cases lead to user-visible
breakage, this is definitely a bug which needs to be fixed.

But, due to the too lowlevel-ish style of the code I was unable to
figure out working fix. My first suggested change to syntax[(unsigned
char)c] didn't work.


------
Regards,
max ulidtko

