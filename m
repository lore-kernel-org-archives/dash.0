From: Oleg Verych <olecom@gmail.com>
Subject: about coding style (Re: exit-ing in a trap handler uses the wrong
 exit code)
Date: Sun, 26 Sep 2010 03:03:11 +0300
Message-ID: <AANLkTi=Hj4obZf2HDd7Sde9=LykRA3nMHGpW2UJcredb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40530 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab0IZADM convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 25 Sep 2010 20:03:12 -0400
Received: by qyk33 with SMTP id 33so5821438qyk.19
        for <dash@vger.kernel.org>; Sat, 25 Sep 2010 17:03:11 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?UTF-8?B?TG/Dr2MgTWluaWVy?= <lool@dooz.org>
Cc: Jilles Tjoelker <jilles@stack.nl>, dash@vger.kernel.org

Hi.

2010/9/26, Lo=C3=AFc Minier <lool@dooz.org>:
> On Sat, Sep 25, 2010, Jilles Tjoelker wrote:
>> You are certainly right that POSIX requires this to be handled
>> differently, but there are various other shells that are non-complia=
nt
>> in the same way as dash and it is easy to avoid the behaviour, so I
>> would not recommend depending on it.
>
>  I don't know why it was put there in the first place, but my first
>  reaction was to send patch to remove the use of exit in the trap
>  handler:
>     http://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01803.htm=
l
-trap "rm -f $TMPC $TMPO $TMPE ; exit" EXIT INT QUIT TERM
+# NB: do not call "exit" in the trap handler; this is buggy with some =
shells;
+# see <address@hidden>
+trap "rm -f $TMPC $TMPO $TMPE" EXIT INT QUIT TERM
>  but the discussion led me to report this bug against dash

1) IMHO doing cleaning in a `trap` is bad coding style in the first
place. Here i think about, how much one allowed to do in signal
handlers in C? The `trap` for me is like *try / catch* exception
handling:

trap 'echo "unexpected error in script block xyz,
please send console messages and log files to devs@example.org"' EXIT

# critical part
script
block
xyz

trap "" EXIT
# ordinary part
=2E...

2) So, when "fine POSIX" changes rules of `exit` inside `trap`, this
is even worse game playing style. While `dash` doesn't do much about
stepping over POSIX, this case shows, that standards are inflexible,
to say least, and `dash` went its own way here.

3) After dealing with 1), 2) and pipes, conclusion is that exit status
code is a very weak information source. For example, when program is
failing to free (e.g. TMP) resources, this *is* another problem, like
checking errno after close() in C -- somebody cares, the most don't.

Thus, like in many good scripts, I would have do_exit() with all kinds
of cleanup (console, files, logs etc.). And `trap` lines would have
`echo =E2=80=9Cunexpected error #xyz=E2=80=9D ; catch_xyz || do_exit 1`

>  Thanks for your detailed reply!  Am I also expected to log this issu=
e
>  somewhere for tracking?

Tracking what? After many years, I think, `dash` will remain such
features unchanged.
--=20
sed 'sed && sh + olecom =3D love'  <<  ''
-o--=3DO`C
 #oo'L O
<___=3DE M
