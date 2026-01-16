Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3457260D
	for <dash@vger.kernel.org>; Fri, 16 Jan 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590985; cv=none; b=kLuj167shR9t5tG/dmKf4V/LIwMCHx8B+5uKhCD9DKpp02PD17VZmysPntXOcmvI04/eormQMxnyLUci3XkJTqVc5j9EEjXIAixtJ0Cds9up4wRoeeDb0x/BX6PH3th3ncJRqh8/82eOk1CBiIm5VSzWWc/wKlQNM22j5CN9J0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590985; c=relaxed/simple;
	bh=mfQnEb9KTfVv+TO1TZJl8SfTKMqKowBc6muy/j5D0uk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=C5NmiacHxLqiyEWDXzHLMDIOsO7uejyzFCroG1o1GuPbQ9wMTbvg3GXKb86HmROowGorQxpa3Q6PcCOXhwDT5mbNjiKYkhIC6DwJOakwA6dS8hUwcsdcLig0R6lXlG9YVgy1RF49bxUF4hTov4pyoYCgKaTjiLhl2Er0bbG+Rpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Baw8PHSN; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Baw8PHSN"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64472ea7d18so1965441d50.2
        for <dash@vger.kernel.org>; Fri, 16 Jan 2026 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768590983; x=1769195783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/G/9jJgawPlyuboXoM4CerB9pxobPyLQ4QOf+kGUlKw=;
        b=Baw8PHSN6EU3Hw4WIgzDl/DoCmQOhXpS5JI9xQrUV47M/gruJHTDMtRAAT/toeZ1SZ
         BLlPmjuAEnbM+rFTIfkRDOAdlYmGEZZqoEC20Fo5OnHqCXabGHmzuGZ7srH5O1TVmgUO
         9Fn09b7ospM04MGYKfANnsXaCXR9Zdf80vcb1P1dA1niRE/jEW+2Z5VDbQ0eSP9TUqIp
         Fvno5vjQDO3COqVHaMF6zp0r5/0jcBUr3pI/V3sY9XXJocSsOVsO9wVakAKB8EdHWwK+
         vCI44j8eKihJJbBw/82cYUCBxjdCHNxv3IIPle/EtG1OUnZOHNmASKbucM05E9RQg+VM
         tB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768590983; x=1769195783;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/G/9jJgawPlyuboXoM4CerB9pxobPyLQ4QOf+kGUlKw=;
        b=kvJwArs1IB47zVjOFq8TopSYmSS2ZLiOGcsvtw9RMvjYHBk9Gs+PjObQmjIpXMrg63
         etq66pSoZGk9MWo/p/XtJTe5ldqWm2GmOZZJtUWteYsgUWjyN9zZWuzChYe5Tsuo7KFY
         CJ1/eZ/zNmuag+fSefn6GBIrfk5TZLAhBKtx7H7yPfWCpJqWEwdHaAEnsVKBN2528NkL
         7ApwaGlmz8fL1k0PlXcPrkHixb50aBYaHbocs7CQ7KxYwwV/CPAvI9a7i5Jt9X1+exxB
         LLtAZ+E2m6FcZeHeiy4WetMAY6x20Vw4aJlBMrV1hm/Q5RsHWjilAOgto1L/6jWmqgGa
         mvfQ==
X-Gm-Message-State: AOJu0Yw500OwLo1pRueSq6vYY5FXrwHcgdzdDlMfWDKIY1PWr2X3eOLC
	+9nsrm06UY5ISePR+AtH66lmaHl61zYH7qHh/rmZLdCtNiiVfNchRbUgRMqx5YAHVHy1Hn4Wdsh
	iv4e0GdI00dqQgqKLiQ0rtVdikDtDcRNe2LPnx/w=
X-Gm-Gg: AY/fxX7h8SBhOrivRXqSUQ8IUw1iRicMQiWT1ldUK/l1e5ALRBR95045N+2uRwGv/95
	emVztG+tp6z+2fIi9+UBavy6koD2KNpVeIC4zfMrDJPx1t7u3bOoQA0uGz3B4W+bWViQku4U3fA
	Qwbzqshrff7R7vGuqzYatKxV9G4fC2ejEVEZ/ZDd6fcYSOricdHWqBuJYV3o+Qm7xNIga6OlRem
	66A37mshzIIeAn9VHTy6+BIymwWC5PfXft8c7g5pmfmRtZMVIy7GECAYStkZMLD9S1zCHTQUCwo
	c/2hTLWdaY/tJE8ec8kEN8xWKg==
X-Received: by 2002:a05:690e:1a51:b0:63f:c4f4:e1a3 with SMTP id
 956f58d0204a3-6491648c507mr2754931d50.13.1768590982431; Fri, 16 Jan 2026
 11:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksander Ushakov <retes672@gmail.com>
Date: Fri, 16 Jan 2026 22:16:10 +0300
X-Gm-Features: AZwV_QgQzmbMTNiy1fJocp9esWw63Qq7CjWY-eVaOTXmi4GG6ik75T15Hp0XB9A
Message-ID: <CADdNFavDzUUfEUDpXBTdrSOXxxOZvbcb+sXHcCcGx3bKLasteQ@mail.gmail.com>
Subject: [BUG] heap-buffer-overflow(read) pmatch() src/expand.c:1630:18
To: dash@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004306970648862d0b"

--0000000000004306970648862d0b
Content-Type: multipart/alternative; boundary="0000000000004306950648862d09"

--0000000000004306950648862d09
Content-Type: text/plain; charset="UTF-8"

Dear Dash maintainers,

I encountered a bug in Dash in commit f8aaaa and would like to report
it. The details are provided below.

=================================================================
==4318==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x5030000003e3 at pc 0x652f51dd63bf bp 0x7ffd65724250 sp 0x7ffd65724248
READ of size 1 at 0x5030000003e3 thread T0
    #0 0x652f51dd63be in pmatch /upstream/dash/src/expand.c:1630:18
    #1 0x652f51dd74d8 in expmeta /upstream/dash/src/expand.c:1391:7
    #2 0x652f51dd1cc1 in expandmeta /upstream/dash/src/expand.c:1271:3
    #3 0x652f51dd0c2c in expandarg /upstream/dash/src/expand.c:206:3
    #4 0x652f51dc866b in evalcommand /upstream/dash/src/eval.c:806:4
    #5 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
    #6 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
    #7 0x652f51de1dd2 in cmdloop /upstream/dash/src/main.c:242:8
    #8 0x652f51de19de in main /upstream/dash/src/main.c:176:3
    #9 0x74bc543e8249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #10 0x74bc543e8304 in __libc_start_main csu/../csu/libc-start.c:360:3
    #11 0x652f51ce3530 in _start (/upstream/dash/src/dash+0x38530)
(BuildId: 7f6a58087379909d6c654473930c3998f14e8e99)

0x5030000003e3 is located 0 bytes after 19-byte region
[0x5030000003d0,0x5030000003e3)
allocated by thread T0 here:
    #0 0x652f51d827cf in malloc (/upstream/dash/src/dash+0xd77cf) (BuildId:
7f6a58087379909d6c654473930c3998f14e8e99)
    #1 0x652f51de24d4 in ckmalloc /upstream/dash/src/memalloc.c:55:6
    #2 0x652f51dd2a8a in _rmescapes /upstream/dash/src/expand.c:1687:8
    #3 0x652f51dd55e3 in preglob /upstream/dash/src/expand.c:151:9
    #4 0x652f51dd1c81 in expandmeta /upstream/dash/src/expand.c:1266:7
    #5 0x652f51dd0c2c in expandarg /upstream/dash/src/expand.c:206:3
    #6 0x652f51dc866b in evalcommand /upstream/dash/src/eval.c:806:4
    #7 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
    #8 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
    #9 0x652f51de1dd2 in cmdloop /upstream/dash/src/main.c:242:8
    #10 0x652f51de19de in main /upstream/dash/src/main.c:176:3
    #11 0x74bc543e8249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: heap-buffer-overflow
/upstream/dash/src/expand.c:1630:18 in pmatch
Shadow bytes around the buggy address:
  0x503000000100: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00
  0x503000000180: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00
  0x503000000200: 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa
  0x503000000280: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00
  0x503000000300: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00
=>0x503000000380: 00 00 fa fa 00 00 03 fa fa fa 00 00[03]fa fa fa
  0x503000000400: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x503000000480: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x503000000500: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x503000000580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x503000000600: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==4318==ABORTING

////////////////
Place in code
////////////////
                                        if (chr == c)
                                                found = 1;
                                }
                 ---->} while ((c = *p++) != ']');
                        if (found == invert)
                                return 0;
                        q++;


////////////////
My environment:
////////////////

Debian-12, x86-64, clang-19 compiler

/////////////////
Steps to reproduce:
/////////////////

$ aclocal && autoheader && automake --add-missing && autoconf
$ CC=clang CFLAGS=" -Wno-everything -fsanitize=address -g -O0" ./configure
--disable-fnmatch --disable-lineno --disable-glob
$ make
$ cd src
$ ./dash < myfile.txt

//////////////////
Steps to get myfile.txt:
//////////////////

copy the text into file bs64.txt (between ==== and ======):
=====================================================================================
PkA3OyRCLWdlIFuFaZs/PwJlc3Nzc3Nzc3Mt
=====================================================================================
Or just take from attachments:

--0000000000004306950648862d09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Dash maintainers,<br><br>I encountered a bug in Dash =
in commit f8aaaa and would like to report<br>it. The details are provided b=
elow.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=3D=3D4318=
=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0x5030000003=
e3 at pc 0x652f51dd63bf bp 0x7ffd65724250 sp 0x7ffd65724248<br>READ of size=
 1 at 0x5030000003e3 thread T0<br>=C2=A0 =C2=A0 #0 0x652f51dd63be in pmatch=
 /upstream/dash/src/expand.c:1630:18<br>=C2=A0 =C2=A0 #1 0x652f51dd74d8 in =
expmeta /upstream/dash/src/expand.c:1391:7<br>=C2=A0 =C2=A0 #2 0x652f51dd1c=
c1 in expandmeta /upstream/dash/src/expand.c:1271:3<br>=C2=A0 =C2=A0 #3 0x6=
52f51dd0c2c in expandarg /upstream/dash/src/expand.c:206:3<br>=C2=A0 =C2=A0=
 #4 0x652f51dc866b in evalcommand /upstream/dash/src/eval.c:806:4<br>=C2=A0=
 =C2=A0 #5 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12<br>=
=C2=A0 =C2=A0 #6 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:1=
2<br>=C2=A0 =C2=A0 #7 0x652f51de1dd2 in cmdloop /upstream/dash/src/main.c:2=
42:8<br>=C2=A0 =C2=A0 #8 0x652f51de19de in main /upstream/dash/src/main.c:1=
76:3<br>=C2=A0 =C2=A0 #9 0x74bc543e8249 in __libc_start_call_main csu/../sy=
sdeps/nptl/libc_start_call_main.h:58:16<br>=C2=A0 =C2=A0 #10 0x74bc543e8304=
 in __libc_start_main csu/../csu/libc-start.c:360:3<br>=C2=A0 =C2=A0 #11 0x=
652f51ce3530 in _start (/upstream/dash/src/dash+0x38530) (BuildId: 7f6a5808=
7379909d6c654473930c3998f14e8e99)<br><br>0x5030000003e3 is located 0 bytes =
after 19-byte region [0x5030000003d0,0x5030000003e3)<br>allocated by thread=
 T0 here:<br>=C2=A0 =C2=A0 #0 0x652f51d827cf in malloc (/upstream/dash/src/=
dash+0xd77cf) (BuildId: 7f6a58087379909d6c654473930c3998f14e8e99)<br>=C2=A0=
 =C2=A0 #1 0x652f51de24d4 in ckmalloc /upstream/dash/src/memalloc.c:55:6<br=
>=C2=A0 =C2=A0 #2 0x652f51dd2a8a in _rmescapes /upstream/dash/src/expand.c:=
1687:8<br>=C2=A0 =C2=A0 #3 0x652f51dd55e3 in preglob /upstream/dash/src/exp=
and.c:151:9<br>=C2=A0 =C2=A0 #4 0x652f51dd1c81 in expandmeta /upstream/dash=
/src/expand.c:1266:7<br>=C2=A0 =C2=A0 #5 0x652f51dd0c2c in expandarg /upstr=
eam/dash/src/expand.c:206:3<br>=C2=A0 =C2=A0 #6 0x652f51dc866b in evalcomma=
nd /upstream/dash/src/eval.c:806:4<br>=C2=A0 =C2=A0 #7 0x652f51dc7855 in ev=
altree /upstream/dash/src/eval.c:299:12<br>=C2=A0 =C2=A0 #8 0x652f51dc7855 =
in evaltree /upstream/dash/src/eval.c:299:12<br>=C2=A0 =C2=A0 #9 0x652f51de=
1dd2 in cmdloop /upstream/dash/src/main.c:242:8<br>=C2=A0 =C2=A0 #10 0x652f=
51de19de in main /upstream/dash/src/main.c:176:3<br>=C2=A0 =C2=A0 #11 0x74b=
c543e8249 in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_mai=
n.h:58:16<br><br>SUMMARY: AddressSanitizer: heap-buffer-overflow /upstream/=
dash/src/expand.c:1630:18 in pmatch<br>Shadow bytes around the buggy addres=
s:<br>=C2=A0 0x503000000100: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 0=
0<br>=C2=A0 0x503000000180: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00=
<br>=C2=A0 0x503000000200: 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa<=
br>=C2=A0 0x503000000280: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00<b=
r>=C2=A0 0x503000000300: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00<br=
>=3D&gt;0x503000000380: 00 00 fa fa 00 00 03 fa fa fa 00 00[03]fa fa fa<br>=
=C2=A0 0x503000000400: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa<br>=
=C2=A0 0x503000000480: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa<br>=
=C2=A0 0x503000000500: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa<br>=
=C2=A0 0x503000000580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa<br>=
=C2=A0 0x503000000600: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa<br>S=
hadow byte legend (one shadow byte represents 8 application bytes):<br>=C2=
=A0 Addressable: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00<br>=C2=A0 Partially =
addressable: 01 02 03 04 05 06 07 <br>=C2=A0 Heap left redzone: =C2=A0 =C2=
=A0 =C2=A0 fa<br>=C2=A0 Freed heap region: =C2=A0 =C2=A0 =C2=A0 fd<br>=C2=
=A0 Stack left redzone: =C2=A0 =C2=A0 =C2=A0f1<br>=C2=A0 Stack mid redzone:=
 =C2=A0 =C2=A0 =C2=A0 f2<br>=C2=A0 Stack right redzone: =C2=A0 =C2=A0 f3<br=
>=C2=A0 Stack after return: =C2=A0 =C2=A0 =C2=A0f5<br>=C2=A0 Stack use afte=
r scope: =C2=A0 f8<br>=C2=A0 Global redzone: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0f9<br>=C2=A0 Global init order: =C2=A0 =C2=A0 =C2=A0 f6<br>=C2=A0 Poi=
soned by user: =C2=A0 =C2=A0 =C2=A0 =C2=A0f7<br>=C2=A0 Container overflow: =
=C2=A0 =C2=A0 =C2=A0fc<br>=C2=A0 Array cookie: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ac<br>=C2=A0 Intra object redzone: =C2=A0 =C2=A0bb<br>=C2=A0 A=
San internal: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fe<br>=C2=A0 Left alloca r=
edzone: =C2=A0 =C2=A0 ca<br>=C2=A0 Right alloca redzone: =C2=A0 =C2=A0cb<br=
>=3D=3D4318=3D=3DABORTING<br><br>////////////////<br>Place in code<br>/////=
///////////<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (chr =3D=3D c)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 found =3D 1;<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0----&gt;} while ((c =3D *p++) !=3D &#39;]&#39;);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (found =3D=3D invert)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn 0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 q++;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br><br>////////////////<br>My environment:<=
br>////////////////<br><br>Debian-12, x86-64, clang-19 compiler<br><br>////=
/////////////<br>Steps to reproduce:<br>/////////////////<br><br>$ aclocal =
&amp;&amp; autoheader &amp;&amp; automake --add-missing &amp;&amp; autoconf=
<br>$ CC=3Dclang CFLAGS=3D&quot; -Wno-everything -fsanitize=3Daddress -g -O=
0&quot; ./configure --disable-fnmatch --disable-lineno --disable-glob<br>$ =
make<br>$ cd src<br>$ ./dash &lt; myfile.txt<br><br>//////////////////<br>S=
teps to get myfile.txt:<br>//////////////////<br><br>copy the text into fil=
e bs64.txt (between =3D=3D=3D=3D and =3D=3D=3D=3D=3D=3D):<br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>PkA3OyRCLWdlIFuFaZs/PwJlc3Nzc3Nzc3Mt<br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Or just take from attachments:<br><br></div>

--0000000000004306950648862d09--
--0000000000004306970648862d0b
Content-Type: text/plain; charset="GB18030"; name="atta.txt.txt"
Content-Disposition: attachment; filename="atta.txt.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mkh9brm50>
X-Attachment-Id: f_mkh9brm50

PkA3OyRCLWdlIFuFaZs/PwJlc3Nzc3Nzc3Mt
--0000000000004306970648862d0b--
