From: Oleg Verych <olecom@gmail.com>
Subject: Re: Output redirection to block-defined filehandle
Date: Tue, 9 Feb 2010 14:43:23 +0200
Message-ID: <8499950a1002090443rd390c4fs33496944a068412e@mail.gmail.com>
References: <46a038f91001281410g54a000darc5b7c87e9012d53e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36537 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab0BIMnZ convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 9 Feb 2010 07:43:25 -0500
Received: by bwz19 with SMTP id 19so764010bwz.28
        for <dash@vger.kernel.org>; Tue, 09 Feb 2010 04:43:23 -0800 (PST)
In-Reply-To: <46a038f91001281410g54a000darc5b7c87e9012d53e@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
Cc: dash@vger.kernel.org

2010/1/29 Martin Langhoff <martin.langhoff@gmail.com>:

Hallo, Martin.

> The flock binary in modern linuxes (from util-linux-ng) supports
> flocking a filehandle that is handled by the shell. Combining this
> with per-code-block filehandles / io redirection, it is an incredibly
> useful construct to protect a code block with a lock.
>
> The resulting code looks like this (from man flock on Fedora 11):
>
>      (
>         flock -s 200
>         # ... commands executed under lock ...
>       ) 200>/var/lock/mylockfile
>
> I am now discovering that this works in bash, but not in dash.

What about implementation of the race-condition protection or locking
using this scheme:
* `umask 777` -- lock situation using file to be created
* `{ echo =E2=80=9Ccreating file using =E2=80=98>=E2=80=99 in a working=
 block=E2=80=9D ; do_the_task ;
} > lock_file`
* paralel / concurrent task: `echo =E2=80=9Cchecking file for access us=
ing
=E2=80=98>=E2=80=99=E2=80=9D > lock_file && go || echo 'error: access d=
enied' >&2`
* `{ mv lock_file || rm lock_file || =E2=80=A6. ; } && chmod 666 lock_f=
ile` --
releasing the lock (order matters)

--=20
sed 'sed && sh + olecom =3D love'  <<  ''
-o--=3DO`C
 #oo'L O
<___=3DE M
