From: Thomas DEBESSE <thomas.debesse@gmail.com>
Subject: problem with utf8 name completion
Date: Tue, 8 Nov 2016 04:37:23 +0100
Message-ID: <CALpuBKxcOLBXGx81ZheagX75GSh4d63M1SYnjwTWHjM3m3VJpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35546 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbcKHDid (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 7 Nov 2016 22:38:33 -0500
Received: by mail-yw0-f181.google.com with SMTP id i145so66293441ywg.2
        for <dash@vger.kernel.org>; Mon, 07 Nov 2016 19:37:24 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: DASH mailing list <dash@vger.kernel.org>

Hi, I discovered dash has problems with some UTF-8 characters, I'm
running dash 0.5.8
See this proof of concept:

$ echo $LANG
C.UTF-8

$ cat proof.sh
#! /bin/sh

listO () {
    # latin 'o'
    echo 'o'
    # greek 'o' (omicron)
    echo '=CE=BF'
    # cyrillic 'o'
    echo '=D0=BE'
}

for i in $(listO)
do
    for j in $(listO)
    do
        for k in $(listO)
        do
            touch "${i}${j}${k}"
        done
    done
done

ls -1 [o=CE=BF=D0=BE][o=CE=BF=D0=BE][o=CE=BF=D0=BE]

#EOF

$ dash proof.sh
ooo

$ bash proof.sh
ooo
oo=CE=BF
oo=D0=BE
o=CE=BFo
o=CE=BF=CE=BF
o=CE=BF=D0=BE
o=D0=BEo
o=D0=BE=CE=BF
o=D0=BE=D0=BE
=CE=BFoo
=CE=BFo=CE=BF
=CE=BFo=D0=BE
=CE=BF=CE=BFo
=CE=BF=CE=BF=CE=BF
=CE=BF=CE=BF=D0=BE
=CE=BF=D0=BEo
=CE=BF=D0=BE=CE=BF
=CE=BF=D0=BE=D0=BE
=D0=BEoo
=D0=BEo=CE=BF
=D0=BEo=D0=BE
=D0=BE=CE=BFo
=D0=BE=CE=BF=CE=BF
=D0=BE=CE=BF=D0=BE
=D0=BE=D0=BEo
=D0=BE=D0=BE=CE=BF
=D0=BE=D0=BE=D0=BE

The expected result is the one provided by bash, as they are 3
different characters.

--=20
Thomas DEBESSE
