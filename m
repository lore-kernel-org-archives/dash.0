From: Shware Systems <shwaresyst-YDxpq3io04c@public.gmane.org>
Subject: Re: heredoc and subshell
Date: Wed, 24 Feb 2016 07:27:17 -0500
Message-ID: <153133f6f0b-66ff-2f8@webprd-a36.mail.aol.com>
References: <56cd8cd1.LdVYbpfe+0tQMm8I%Joerg.Schilling@fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_985_1580994579.1456316837641"
Return-path: <austin-group-l-request-7882/jkIBncuagvECLh61g@public.gmane.org>
In-Reply-To: <56cd8cd1.LdVYbpfe+0tQMm8I%Joerg.Schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org>
Resent-Message-ID: <"Cxfgp.A.OTF.uGazWB"@Phoebe.vpn.opengroup.org>
Resent-To: austin-group-l-7882/jkIBncuagvECLh61g@public.gmane.org
To: oleg-BA2faJl1U0pBDLzU/O5InQ@public.gmane.org, eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dash-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, austin-group-l-7882/jkIBncuagvECLh61g@public.gmane.org, Joerg.Schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org
List-Id: dash@vger.kernel.org

------=_Part_985_1580994579.1456316837641
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Near as I can tell, from 2.3, io_here has precedence over string concatenat=
ion of normal tokenization so the output of bash should be:
A:echo line 1
Syntax error: Missing right paren
Syntax error: Missing closing double quote

as the list production terminates at the first newline, and a new one doesn=
't start until after the second line with XXX to satisfy the second io_here=
. It can be argued provisions for trying to find the end of an open string =
should continue after the io_here body, but Item 7 of 2.3 has the newline t=
erminating it.

The first newline is the one left after line joining has been done. Before =
tokenization starts the input file position should be pointing to the chara=
cter after it so the first io_here can immediately start reading the body f=
rom there until the first XXX line, and that advances it so the second migh=
t be processed, and the line after starts a new list, not continues as if n=
o io_here was present. The syntax error detection happens before the second=
 block gets consumed, but the presence of the operator while scanning for t=
he right paren reserves it.



On Wednesday, February 24, 2016 Joerg Schilling <Joerg.Schilling-8LS2qeF34IoQrrorzV6ljw@public.gmane.org=
nhofer.de> wrote:
Eric Blake <eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> > --- code
> > prefix() { sed -e "s/^/$1:/"; }
> > DASH_CODE() { :; }
> >=20
> > prefix A <<XXX && echo "$(prefix B <<XXX
> > echo line 1
> > XXX
> > echo line 2)" && prefix DASH_CODE <<DASH_CODE
> > echo line 3
> > XXX
> > echo line 4)"
> > echo line 5
> > DASH_CODE
> >=20
> > --- bash 4.3.42 output:
> > A:echo line 3
> > B:echo line 1
> > line 2
> > DASH_CODE:echo line 4)"
> > DASH_CODE:echo line 5
>
> So, it looks like bash is interpreting this as "first newline that is
> not in the middle of another shell word), and parses the entire $(...)

I would like to get an explanation on what I should understand by:

=09"first newline that is not in the middle of another shell word)


BTW: If I replace $(..) by `..` and feed the code to the original SVr4 Bour=
ne=20
Shell, I get the same output as you got from bash. I would guess that the b=
ash=20
output you added above is correct.

Note that the command substitution is part of a " quoted string and even=20
without that, it would need to be parsed first.

The POSIX version from ksh88 (seen on Solaris) behaves the same with $(..) =
and=20
the `..` variant and the same as bash.

The fact that ksh93 behaves different with $(..) and the `..` variant makes=
 it=20
obvious that ksh93 has a bug.

J=C3=B6rg

--=20
EMail:joerg-lSlhzV3CM+2sTnJN9+BGXg@public.gmane.org (home) J=C3=B6rg Schilling D-13353 Berlin
joerg.schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org (work) Blog: http://schily.blogspot.com=
/
URL: http://cdrecord.org/private/ http://sourceforge.net/projects/schilytoo=
ls/files/'


------=_Part_985_1580994579.1456316837641
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Near as I can tell, from 2.3, io_here has precedence over st=
ring concatenation of normal tokenization so the output of bash should be:<=
br>
A:echo line 1<br>
Syntax error: Missing right paren<br>
Syntax error: Missing closing double quote</p>
<p dir=3D"ltr">as the list production terminates at the first newline, and =
a new one doesn't start until after the second line with XXX to satisfy the=
 second io_here. It can be argued provisions for trying to find the end of =
an open string should continue after the io_here body, but Item 7 of 2.3 ha=
s the newline terminating it.</p>
<p dir=3D"ltr">The first newline is the one left after line joining has bee=
n done. Before tokenization starts the input file position should be pointi=
ng to the character after it so the first io_here can immediately start rea=
ding the body from there until the first XXX line, and that advances it so =
the second might be processed, and the line after starts a new list, not co=
ntinues as if no io_here was present. The syntax error detection happens be=
fore the second block gets consumed, but the presence of the operator while=
 scanning for the right paren reserves it.</p>
</br></br><div class=3D"device_aol_et_org_dt_dd_quote"></div><hr style=3D"b=
order:0;height:1px;color:#999;background-color:#999;width:100%;margin:0 0 9=
px 0;padding:0;"></hr><span style=3D"font-size:14px; color:#999999;">On Wed=
nesday, February 24, 2016 Joerg Schilling &#60;<span style=3D"color:#0000A0=
">Joerg.Schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org</span>&#62; wrote:</span><br></br>Eri=
c Blake &lt;<a href=3D'mailto:eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org'>eblake-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; =
wrote:<br/><br/>&gt; &gt; --- code<br/>&gt; &gt; prefix() { sed -e &quot;s/=
^/$1:/&quot;; }<br/>&gt; &gt; DASH_CODE() { :; }<br/>&gt; &gt; <br/>&gt; &g=
t; prefix A &lt;&lt;XXX &amp;&amp; echo &quot;$(prefix B &lt;&lt;XXX<br/>&g=
t; &gt; echo line 1<br/>&gt; &gt; XXX<br/>&gt; &gt; echo line 2)&quot; &amp=
;&amp; prefix DASH_CODE &lt;&lt;DASH_CODE<br/>&gt; &gt; echo line 3<br/>&gt=
; &gt; XXX<br/>&gt; &gt; echo line 4)&quot;<br/>&gt; &gt; echo line 5<br/>&=
gt; &gt; DASH_CODE<br/>&gt; &gt; <br/>&gt; &gt; --- bash 4.3.42 output:<br/=
>&gt; &gt; A:echo line 3<br/>&gt; &gt; B:echo line 1<br/>&gt; &gt; line 2<b=
r/>&gt; &gt; DASH_CODE:echo line 4)&quot;<br/>&gt; &gt; DASH_CODE:echo line=
 5<br/>&gt;<br/>&gt; So, it looks like bash is interpreting this as &quot;f=
irst newline that is<br/>&gt; not in the middle of another shell word), and=
 parses the entire $(...)<br/><br/>I would like to get an explanation on wh=
at I should understand by:<br/><br/>=09&quot;first newline that is not in t=
he middle of another shell word)<br/><br/><br/>BTW: If I replace $(..) by `=
..` and feed the code to the original SVr4 Bourne <br/>Shell, I get the sam=
e output as you got from bash. I would guess that the bash <br/>output you =
added above is correct.<br/><br/>Note that the command substitution is part=
 of a &quot; quoted string and even <br/>without that, it would need to be =
parsed first.<br/><br/>The POSIX version from ksh88 (seen on Solaris) behav=
es the same with $(..) and <br/>the `..` variant and the same as bash.<br/>=
<br/>The fact that ksh93 behaves different with $(..) and the `..` variant =
makes it <br/>obvious that ksh93 has a bug.<br/><br/>J&ouml;rg<br/><br/>-- =
<br/> EMail:<a href=3D'mailto:joerg-lSlhzV3CM+2sTnJN9+BGXg@public.gmane.org'>joerg-lSlhzV3CM+2sTnJN9+BGXg@public.gmane.org</a>       =
             (home) J&ouml;rg Schilling D-13353 Berlin<br/>       <a href=
=3D'mailto:joerg.schilling-8LS2qeF34IpklNlQbfROjRvVK+yQ3ZXh@public.gmane.org'>joerg.schilling-8LS2qeF34Iod0jSqLZi3Fg@public.gmane.org=
hofer.de</a> (work) Blog: <a href=3D"http://schily.blogspot.com/" target=3D=
_blank>http://schily.blogspot.com/</a><br/> URL:  <a href=3D"http://cdrecor=
d.org/private/" target=3D_blank>http://cdrecord.org/private/</a> <a href=3D=
"http://sourceforge.net/projects/schilytools/files/'" target=3D_blank>http:=
//sourceforge.net/projects/schilytools/files/&#39;</a><br/><br/>
------=_Part_985_1580994579.1456316837641--
