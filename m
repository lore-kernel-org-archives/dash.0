Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700034D4EE
	for <dash@vger.kernel.org>; Fri, 16 Jan 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589081; cv=none; b=ucwLdc9YWyaikhKOC5utMI27Qh0iFkQdDN97OwH7WWj8ficH514Yvkazq/rfO/RzKJ4/mKx4SugVOPb3vnSkvTHJhEceZyusLOCWHpF8zmwOszUda7wvHrub8ttKzMidJSxAES/oRqGmhfgXkIrO/ehDOGBNaPHSBGk4rQzfljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589081; c=relaxed/simple;
	bh=TIZtgKYhz2CYGsMmPhPRkUb95MzOWE0rRCU8FofyN1Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SIOJK/0R/4qFTNYjGdFtWaBOgHid6HgIxVpwObHsoO7xNQ2GEzMzDmk/VEXMA310bmkE//Ck/mCnkAm4W5bBWUP0ezpcT7DifaDxsSBP1IJxs+gV/93DhGvRJ3BTeprOIl2MMlYhxe469GGNkCfWGlG4+bk9rcr4B5l6aeOLEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA6FkJtH; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA6FkJtH"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-644715aad1aso2776948d50.0
        for <dash@vger.kernel.org>; Fri, 16 Jan 2026 10:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768589078; x=1769193878; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+efbF/CFXOOYF2hUCgu4KT2kmS/BkJdnVPhcpEgHUJk=;
        b=eA6FkJtH+3/kB5p9Tgha1/rbkwuJVdLDdTmNhantxu+6tcSBZsz++oW+KWSmXCQS4Z
         mDjh44yo5K9UaEinAi5eY5ruGjRDOBefr4IVJFkHNbdq+7bJRLP2xLauYhgi6zNKfVFN
         PfVQTyoCUw3TQ7jalB/mcawUO4mXUub+Lzkmc7yDD+bm9Nk2xNJ2vak3hv32NhEAUVpa
         BNY+/vknbg0AdU4v8y6DChF4DuQlUZPCITssNPeVY1BNZp7HJgnHojtkoVobrlRJa2q7
         SJEQ8fH/YjoW/5Nmr7SjFmNx/8KEH8dVASuOs4RGtynrV+rRTbaUHRWCf1ySOh+nhQWE
         58Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768589078; x=1769193878;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+efbF/CFXOOYF2hUCgu4KT2kmS/BkJdnVPhcpEgHUJk=;
        b=f3qYN+V7zTog6lLpzvHcPta7P0thq7mKX3xbR79PXCR6FQZMLjZyIUwEOhv5YdLEN0
         JkkFRq7b/D2UQdB/7iLcEcZoE+JTqRNzfXFA7S420Xf0udLr9gRZbb25Ic4kvEZVnsob
         l3vaTylqimNXGZuBhZ1dBdyqBV6LGnXBMH7H9tBgmZ1fnj9Ro/j4SZFtYcJ0Fttun8Ii
         8RIJdCC7b4At25ekSs4rBOsMQVdf0p39cN38jMQwjyJ3JwOTsK6Gd4V5SYfYmcelO1S8
         WBxhQUg2vfh69jTbicsDJ+l0/hd9+SX/FXcvVVqUo4icf3Hxm0mbZttTHj6K6QB30QyT
         VG+Q==
X-Gm-Message-State: AOJu0YzWCvNVXRFzehZYNYQEAACSbuXX1Gfph7y3b7IFPEO5P9SxbZsO
	tptsBfoU6tJb8bhTKeFt0RoqF/JykQ/LNMIE65tWJThkp+FijoRAx/MBqbC23LWGbGIO8XQms90
	mjpJfX2Wy2fOtYLfskqeJbHZVY8JT61qEYdapmy0=
X-Gm-Gg: AY/fxX6a6IoN+3F6BZTBpDBYoDrjar74l32V6iZf8nV6dN8QN3jpWkK9vf0jItIb8JQ
	6h8xlQMw4TomOz3PtmJqPbsHCxAirph8zAtbnS3bc/l+D8L9j4LtWyp2gG4dM6BMrPENK2hL+hP
	WlDHtDWD/BzWU2Y5K0iFCDE3fsmqDj/1SHDQ8h0nqR7TVawuAR46ghhesyNUuymIXHKJKZAjhy2
	cKc48KOODecDqe2VbzEYG+5Btj6Fiyo1BTmMMSpbaWznWEg1rBBsW6T0p3prfafT9PfbOcom9cP
	Q71t3nG8c3nIMF3bHocrlOs3cQ==
X-Received: by 2002:a05:690e:400c:b0:641:f5bc:6952 with SMTP id
 956f58d0204a3-64916b7d81emr2867818d50.35.1768589078056; Fri, 16 Jan 2026
 10:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksander Ushakov <retes672@gmail.com>
Date: Fri, 16 Jan 2026 21:44:26 +0300
X-Gm-Features: AZwV_QiUYt9Z_rXhq50aybaTZPZFTjvI-fIclBTH5wUBLMIfn367u3-cJRDAYos
Message-ID: <CADdNFavLY8Y38ToK97iPJye8xqUtr4kbNkzbN=PdoTuwTJoZOQ@mail.gmail.com>
Subject: [BUG] misaligned-pointer-use memtodest() src/expand.c:964:17
To: dash@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c088d8064885bb53"

--000000000000c088d8064885bb53
Content-Type: multipart/alternative; boundary="000000000000c088d7064885bb51"

--000000000000c088d7064885bb51
Content-Type: text/plain; charset="UTF-8"

Dear Dash maintainers,

I encountered a bug in Dash in commit f8aaaa (Also the behaviour repeats on
0.5.13 version of Dash) and would like to report
it. The details are provided below.

expand.c:964:17: runtime error: load of misaligned address 0x608e5f3d3fa3
for type 'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x608e5f3d3fa3: note: pointer points here
 00  20 00 04 64 61 73 68 2d  74 74 74 00 00 00 00 00  41 87 34 02 00 00 00
00  19 00 00 00 00 00 00
              ^
    #0 0x608e45209c1b in memtodest
/upstream/z/dash-0.5.13/src/expand.c:964:17
    #1 0x608e4520f17e in expmeta /upstream/z/dash-0.5.13/src/expand.c:1737:4
    #2 0x608e452052b9 in expandmeta
/upstream/z/dash-0.5.13/src/expand.c:1562:3
    #3 0x608e452027b2 in expandarg
/upstream/z/dash-0.5.13/src/expand.c:246:3
    #4 0x608e451fafdd in fill_arglist
/upstream/z/dash-0.5.13/src/eval.c:680:3
    #5 0x608e451f4e81 in evalcommand
/upstream/z/dash-0.5.13/src/eval.c:788:13
    #6 0x608e451f407c in evaltree /upstream/z/dash-0.5.13/src/eval.c:305:12
    #7 0x608e452201ac in cmdloop /upstream/z/dash-0.5.13/src/main.c:247:8
    #8 0x608e4521fe6e in main /upstream/z/dash-0.5.13/src/main.c:181:3
    #9 0x7566db7b9249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #10 0x7566db7b9304 in __libc_start_main csu/../csu/libc-start.c:360:3
    #11 0x608e451c2930 in _start (/upstream/z/dash-0.5.13/src/dash+0x42930)
(BuildId: f5787a810ed7cf088639c548c8ff13ea66dcb3e3)

SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use expand.c:964:17
Aborted (core dumped)

////////////////
My environment:
////////////////

Debian-12, x86-64, clang-19 compiler

/////////////////
Steps to reproduce:
/////////////////

$ aclocal && autoheader && automake --add-missing && autoconf
$ CC=clang CFLAGS=" -Wno-everything -fsanitize=undefined -g -O0"
./configure --disable-fnmatch --disable-lineno --disable-glob
$ make
$ cd src
$ ./dash < myfile.txt

//////////////////
Steps to get myfile.txt:
//////////////////

copy the text into file bs64.txt (between ==== and ======):
=====================================================================================
Y2QgLwpwd2QKaGVscCA+Ji0KcHdkCnB3ZAplY2hvIyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOLWRHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQojICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMyBv
ZiB0aGUgTGljZW5zZSwgb3IKIyAgIChhdCB5b3VyIG9wIGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CiMKIyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdp
bGwgYmUgdXNlZnVsLAojICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3QHRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YKIyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlAAB0aGUKI2QtMQphCmVuZC0yCmE6eAplbmQtYQpi
OngKZW5kLWIKYzp4CmVuZC1jCmVuZC0zCmE6eAplbmQEYQpiCmMKZW5kLTEKYQpiCmMKZW5kLTIK
YTp4CmE6eQphOnoKZW5kLWEKYjp4CmI6eQpiOnoKZW5kLWIKYzp4CmM6eQpjOnoKZW5kLWMKZW5k
LTMKYTp4Cnd4MTAwOF09LGc9cngsbz1yeAowMDAyCnU9cnd4Yjp4CmM6eAplb2QKJEJWQVIKJEJW
QVIKJEJWQVIKJEJWQVIKZm9vCmJhcgp4eHgKMDAyMgp1PXJ3eDEwMDhdPSxnPXJ4LG89cngKMDAw
Mgp1PXJ3eCxnPXJ3eCxvJHJ4CnVtYXNrIDc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
NwA3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
NzdtbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbTc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzcgJ1slc11cbicgZm9vICRACnByaW50ZiAnWyVzXVxuJyBm
b28gIiRAIgpwcmluAAAAQGZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmICdbJXNdXG4nIGZvbyAn
JyRACnByaW50ZiAnWyVzXVxuJyBmb28gJyciJEAiCnByaW50ZiAnWyU=
=====================================================================================

Then do the action: base64 -d bs64.txt > myfile.txt
Or just take from attachments

--000000000000c088d7064885bb51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Dash maintainers,<br><br>I encountered a bug in Dash =
in commit f8aaaa (Also the behaviour repeats on 0.5.13 version of Dash) and=
 would like to report<br>it. The details are provided below.<br><br>expand.=
c:964:17: runtime error: load of misaligned address 0x608e5f3d3fa3 for type=
 &#39;uint64_t&#39; (aka &#39;unsigned long&#39;), which requires 8 byte al=
ignment<br>0x608e5f3d3fa3: note: pointer points here<br>=C2=A000 =C2=A020 0=
0 04 64 61 73 68 2d =C2=A074 74 74 00 00 00 00 00 =C2=A041 87 34 02 00 00 0=
0 00 =C2=A019 00 00 00 00 00 00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^ <br>=C2=A0 =C2=A0 #0 0x608e45209c1b in memtodest /upstream/z/d=
ash-0.5.13/src/expand.c:964:17<br>=C2=A0 =C2=A0 #1 0x608e4520f17e in expmet=
a /upstream/z/dash-0.5.13/src/expand.c:1737:4<br>=C2=A0 =C2=A0 #2 0x608e452=
052b9 in expandmeta /upstream/z/dash-0.5.13/src/expand.c:1562:3<br>=C2=A0 =
=C2=A0 #3 0x608e452027b2 in expandarg /upstream/z/dash-0.5.13/src/expand.c:=
246:3<br>=C2=A0 =C2=A0 #4 0x608e451fafdd in fill_arglist /upstream/z/dash-0=
.5.13/src/eval.c:680:3<br>=C2=A0 =C2=A0 #5 0x608e451f4e81 in evalcommand /u=
pstream/z/dash-0.5.13/src/eval.c:788:13<br>=C2=A0 =C2=A0 #6 0x608e451f407c =
in evaltree /upstream/z/dash-0.5.13/src/eval.c:305:12<br>=C2=A0 =C2=A0 #7 0=
x608e452201ac in cmdloop /upstream/z/dash-0.5.13/src/main.c:247:8<br>=C2=A0=
 =C2=A0 #8 0x608e4521fe6e in main /upstream/z/dash-0.5.13/src/main.c:181:3<=
br>=C2=A0 =C2=A0 #9 0x7566db7b9249 in __libc_start_call_main csu/../sysdeps=
/nptl/libc_start_call_main.h:58:16<br>=C2=A0 =C2=A0 #10 0x7566db7b9304 in _=
_libc_start_main csu/../csu/libc-start.c:360:3<br>=C2=A0 =C2=A0 #11 0x608e4=
51c2930 in _start (/upstream/z/dash-0.5.13/src/dash+0x42930) (BuildId: f578=
7a810ed7cf088639c548c8ff13ea66dcb3e3)<br><br>SUMMARY: UndefinedBehaviorSani=
tizer: misaligned-pointer-use expand.c:964:17 <br>Aborted (core dumped)<br>=
<br>////////////////<br>My environment:<br>////////////////<br><br>Debian-1=
2, x86-64, clang-19 compiler<br><br>/////////////////<br>Steps to reproduce=
:<br>/////////////////<br><br>$ aclocal &amp;&amp; autoheader &amp;&amp; au=
tomake --add-missing &amp;&amp; autoconf<br>$ CC=3Dclang CFLAGS=3D&quot; -W=
no-everything -fsanitize=3Dundefined -g -O0&quot; ./configure --disable-fnm=
atch --disable-lineno --disable-glob<br>$ make<br>$ cd src<br>$ ./dash &lt;=
 myfile.txt<br><br>//////////////////<br>Steps to get myfile.txt:<br>//////=
////////////<br><br>copy the text into file bs64.txt (between =3D=3D=3D=3D =
and =3D=3D=3D=3D=3D=3D):<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Y2QgLwpwd2Q=
KaGVscCA+Ji0KcHdkCnB3ZAplY2hvIyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv<br>ZnR3YX=
JlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgICBpdCB1bmRl<br>c=
iB0aGUgdGVybXMgb2YgdGhlIEdOLWRHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl=
<br>ZCBieQojICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24=
gMyBv<br>ZiB0aGUgTGljZW5zZSwgb3IKIyAgIChhdCB5b3VyIG9wIGlvbikgYW55IGxhdGVyIH=
ZlcnNpb24u<br>CiMKIyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZ=
SB0aGF0IGl0IHdp<br>bGwgYmUgdXNlZnVsLAojICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ=
OyB3QHRob3V0IGV2ZW4g<br>dGhlIGltcGxpZWQgd2FycmFudHkgb2YKIyAgIE1FUkNIQU5UQUJ=
JTElUWSBvciBGSVRORVNTIEZP<br>UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlAAB0aGUKI2=
QtMQphCmVuZC0yCmE6eAplbmQtYQpi<br>OngKZW5kLWIKYzp4CmVuZC1jCmVuZC0zCmE6eAplb=
mQEYQpiCmMKZW5kLTEKYQpiCmMKZW5kLTIK<br>YTp4CmE6eQphOnoKZW5kLWEKYjp4CmI6eQpi=
OnoKZW5kLWIKYzp4CmM6eQpjOnoKZW5kLWMKZW5k<br>LTMKYTp4Cnd4MTAwOF09LGc9cngsbz1=
yeAowMDAyCnU9cnd4Yjp4CmM6eAplb2QKJEJWQVIKJEJW<br>QVIKJEJWQVIKJEJWQVIKZm9vCm=
Jhcgp4eHgKMDAyMgp1PXJ3eDEwMDhdPSxnPXJ4LG89cngKMDAw<br>Mgp1PXJ3eCxnPXJ3eCxvJ=
HJ4CnVtYXNrIDc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>Nzc3Nzc3Nzc3Nzc3=
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>Nzc3Nzc3Nzc=
3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>NwA3Nz=
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>N=
zdtbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t=
<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1=
tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW=
1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tb=
W1tbW1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t=
bW1tbW1tbW1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1=
tbW1tbW1tbW1tbW1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW=
1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tb=
W1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t=
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t<br>bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1=
tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t<br>bW1tbW1tbTc3Nzc3Nzc3Nzc3Nz=
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>Nzc3Nzc3Nzc3Nzc3Nzc3N=
zc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>Nzc3Nzc3Nzc3Nzc3=
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>Nzc3Nzc3Nzc=
3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>Nzc3Nz=
c3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3<br>N=
zc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3=
<br>Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzcgJ1slc11cbicgZm9vICRACnByaW50ZiAnWyVzXVx=
uJyBm<br>b28gIiRAIgpwcmluAAAAQGZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm=
ZmZmZmZmZm<br>ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmICdbJ=
XNdXG4nIGZvbyAn<br>JyRACnByaW50ZiAnWyVzXVxuJyBmb28gJyciJEAiCnByaW50ZiAnWyU=
=3D<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Then do the action: base64 -=
d bs64.txt &gt; myfile.txt<br>Or just take from attachments</div>

--000000000000c088d7064885bb51--
--000000000000c088d8064885bb53
Content-Type: text/plain; charset="GB18030"; name="att.txt.txt"
Content-Disposition: attachment; filename="att.txt.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mkh88t870>
X-Attachment-Id: f_mkh88t870

Y2QgLwpwd2QKaGVscCA+Ji0KcHdkCnB3ZAplY2hvIyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNv
ZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiMgICBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOLWRHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hl
ZCBieQojICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbiwgZWl0aGVyIHZlcnNpb24gMyBv
ZiB0aGUgTGljZW5zZSwgb3IKIyAgIChhdCB5b3VyIG9wIGlvbikgYW55IGxhdGVyIHZlcnNpb24u
CiMKIyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdp
bGwgYmUgdXNlZnVsLAojICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3QHRob3V0IGV2ZW4g
dGhlIGltcGxpZWQgd2FycmFudHkgb2YKIyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlAAB0aGUKI2QtMQphCmVuZC0yCmE6eAplbmQtYQpi
OngKZW5kLWIKYzp4CmVuZC1jCmVuZC0zCmE6eAplbmQEYQpiCmMKZW5kLTEKYQpiCmMKZW5kLTIK
YTp4CmE6eQphOnoKZW5kLWEKYjp4CmI6eQpiOnoKZW5kLWIKYzp4CmM6eQpjOnoKZW5kLWMKZW5k
LTMKYTp4Cnd4MTAwOF09LGc9cngsbz1yeAowMDAyCnU9cnd4Yjp4CmM6eAplb2QKJEJWQVIKJEJW
QVIKJEJWQVIKJEJWQVIKZm9vCmJhcgp4eHgKMDAyMgp1PXJ3eDEwMDhdPSxnPXJ4LG89cngKMDAw
Mgp1PXJ3eCxnPXJ3eCxvJHJ4CnVtYXNrIDc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
NwA3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
NzdtbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1t
bW1tbW1tbTc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3
Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzcgJ1slc11cbicgZm9vICRACnByaW50ZiAnWyVzXVxuJyBm
b28gIiRAIgpwcmluAAAAQGZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmZmICdbJXNdXG4nIGZvbyAn
JyRACnByaW50ZiAnWyVzXVxuJyBmb28gJyciJEAiCnByaW50ZiAnWyU=
--000000000000c088d8064885bb53--
