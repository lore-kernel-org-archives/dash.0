From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] Improved LINENO support
Date: Thu, 11 Nov 2010 21:32:07 +0059
Message-ID: <4CDC52DF.1090205@gigawatt.nl>
References: <4CD85E90.6000308@gigawatt.nl> <20101110220008.GC17871@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from 541F7301.cm-5-8b.dynamic.ziggo.nl ([84.31.115.1]:53447 "HELO
	boostbox.lionra.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753148Ab0KKUbU (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 11 Nov 2010 15:31:20 -0500
In-Reply-To: <20101110220008.GC17871@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Jilles Tjoelker <jilles@stack.nl>

On 10/11/10 22:59, Jilles Tjoelker wrote:
> What I was thinking of was adding a lineno field to narg instead of t=
o
> all command types. The lineno variable would then be set by expand.c.=
 I
> think that leads to a smaller patch and it should still give a sensib=
le
> value for almost all errors.  Downside is a few more int-to-ascii
> conversions. A few divisions is not that bad relative to other things
> that are done but printf in modern libcs is bloated and slow and migh=
t
> slow down things measurably.

I made an attempt at this, but managed to keep the printing in one plac=
e=20
by making LINENO a special variable, which is stored in an int and set=20
in expandarg. When $LINENO is evaluated, the code checks to see if the=20
variable is LINENO, and if so, converts the value to a string. This is=20
one simple pointer comparison in the common case in lookupvar:
   if (v =3D=3D &vlineno && v->text =3D=3D linenovar)
and avoids sprintf in scripts that don't use LINENO.

> FreeBSD's code subtracts the function's starting line number in the
> parser rather than at run time. I wonder which is best. (FreeBSD
> neglects to save and restore the value, so nested function definition=
s
> may lead to incorrect line numbers, but that could be fixed.)

I used this approach in my updated patch, by resetting plinno to 0 in=20
simplecmd, and restoring it after calling command().

> I think this patch will increase dash's code size at least a little,
> which is always a consideration here.

The code size varies little: the current limited LINENO support gives a=
n=20
executable size of 67680 bytes (default configure settings, no libedit,=
=20
gcc 4.5.1, CFLAGS=3D-Os, strip after compilation), my previous patch gi=
ves=20
67688 bytes, my latest patch gives 67704 bytes. I do not think 24 bytes=
=20
should be a problem.

> I can also look at getting this
> into FreeBSD sh.

That would be great.

I will send the updated patch when I can properly test it. Basic testin=
g=20
shows it works, but more extensive testing fails. As it turns out, this=
=20
is unrelated to my changes: current git, unmodified, has a problem:

$ cat test.sh
echo
cat <<_ACEOF
$0 $@
_ACEOF
echo
$ src/dash test.sh wtf

test.sh wtf
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
$

I had not noticed it with my earlier patch, because I actually did my=20
testing with modified 0.5.6.1 sources.

Thanks for the comments.

Cheers,
Harald
