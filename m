Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F183D76
	for <dash@vger.kernel.org>; Thu, 15 Jan 2026 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486175; cv=none; b=SsmHnW9LqXOGpVRdiG2nlRM72w2HBARqV7k1LRsBh3yufmLGIZxdDAIncWQIw9Rq3Yq/NXhH2Vj4ESl3OdWLNrcDWLoSdTYcAuYAQTowg7r0XSqrteQCNtcvMBFaBG7C9yb5d67c2UGgQA1x3GPO3NhoVGQJZt0xroPb0LBtQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486175; c=relaxed/simple;
	bh=kONSO73MAaL5FQY6jRHt4gFoysCLum6MExUnl560pZY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MJrTQtIuI/jxqWxcV5ysOOEZpfCqKYHpeGZke8G73gBOOLXxMgo/wZbssgxD7D60i10nWIPcPPiQeRiBDq00BsFaBpffDxlKjo0vLjxKo2i+XfVSd1NmzeM6eLz5pcx+7uq78TJaZDG6yFYICvx4TsbeKTPuE+Cc6nSPru3fa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbCAYx1+; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbCAYx1+"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso764799d50.1
        for <dash@vger.kernel.org>; Thu, 15 Jan 2026 06:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768486172; x=1769090972; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GSLaYO2wcPh7MD1pcC8egvLyIKba8icQnDlEW1AFSzs=;
        b=LbCAYx1+ufevXgqdG69HKiBn48IBZIapebWnAINj1zQMy/tskoaVAWnadotIcE5kDE
         NVK0L7yB0VCN2AoJKFEzZnyvDcdGCDFolgqfvaO3iHMfVwE56DuX7pYsTFLxru8rRBVa
         Ugd/OOaB/LBYYFZXR45X/L6oUsn6YuoETgWXn9ZdEOXvrjvY96R2+lqqPAsHmLGERl08
         9A3NgiDJFp0yJ8GICLPPMT6+pyKP5n/UlsSBM9YLBIJZkHOYDFtlTeNk8SVIdbFgKs0v
         w5CZ08/9XAVtAsyJwFe/CB7XMdxZj928lbN4A08xB3h7OYPLSUr1y409UyeSjsMEvLXe
         d/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768486172; x=1769090972;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSLaYO2wcPh7MD1pcC8egvLyIKba8icQnDlEW1AFSzs=;
        b=GrrbK9XBg792jymhXEfAzoZ73BMZycbkH2UH7JypC+helfGXb+30J4hbOYnVXTbJSn
         Z7YORLE+Gt0LvP6omPH7qGSSxV5GyKnRTebf2I24OM9aQvz22aYdacErmQoMMMy2Qayi
         nptMBu/GgqwUnv7g3KEqL48xUGrcEOvcfSix0E00VCLuRyzg66rxWNBfAIreZqeAP4ps
         7qcU9mIMrSWQ5T4kZDeNzBpGlytG81QeJIoiaS2PoU1ATQzHYwg3+bqZ2jnJzYQbwSkK
         RsUs6dyHg/yaLnr8w5cE9LO7yjgef2bw4Wl3pmJWy8ytz0i7oc7WiwGtradcvIe4wWRw
         8Z+A==
X-Gm-Message-State: AOJu0YyHsYMUn8W70AuuBNdX6INR5NSxeIYLEi/hdu4C5UKIjF1g2y+4
	28oTu99vK6/zM7TAaA+ICQu9ZAcYOLfqdPiK1m1llFymj7fSrgcNY1G5ThQSnJzFKwPlHon7wNp
	bqzWT9OccyHVhSwV9fr+ZLyLR2w46uYi3MQ23ATs=
X-Gm-Gg: AY/fxX7I2Cnd5lu7AQzZX2p8Liks+uIXUAATl/H8zO4TB7HC8PFYIAlzUtx4UIpwKFq
	dr52ivzBGAIyvOpspVOOdiC4Xdzsq4ML7lgg+Ne9rwKVHSsCCUpHd4DAbX6aII/kgvi9T0UYO+e
	hirEdRbWd/c6FuuXt0s4VROV7EJAwGi5O2QlxgcI4T4pNGrAy6KE5ZixP1FKx0RHuAkKxh6kTMc
	Ko/aqbL8pH2t/uAItyRbPm50ijZqweVxYcZrhoIYFm+gXuTM4DvvPrXVkuZJJg7++JXODdxl3LN
	hUNCS1rfcu0KzEPS+Fcy2bC7Gw==
X-Received: by 2002:a05:690e:b4d:b0:649:3e9:ceeb with SMTP id
 956f58d0204a3-64903e9d1f1mr3940858d50.23.1768486172123; Thu, 15 Jan 2026
 06:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksander Ushakov <retes672@gmail.com>
Date: Thu, 15 Jan 2026 17:09:18 +0300
X-Gm-Features: AZwV_Qh1TiZEfljZy4Wbv3m1wcH4AKIkHixhEhxh3zSh4J6WvuJO6eFrtiCEhsc
Message-ID: <CADdNFavvayk-kQPYNT0twBuWmGpqoiMTX+_RhRstNgC4AxM6uw@mail.gmail.com>
Subject: [BUG] global-buffer-overflow umaskcmd() src/miscbltin.c:275
To: dash@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000014f7fa06486dc6cd"

--00000000000014f7fa06486dc6cd
Content-Type: multipart/alternative; boundary="00000000000014f7f806486dc6cb"

--00000000000014f7f806486dc6cb
Content-Type: text/plain; charset="UTF-8"

Dear Dash maintainers,

I encountered a bug in Dash in commit f8aaaa (Also the behaviour repeats on
0.5.13 version of Dash) and would like to report
it. The details are provided below.
=================================================================
==42==ERROR: AddressSanitizer: global-buffer-overflow on address
0x5cdb8a98b660 at pc 0x5cdb8a392400 bp 0x7ffe75d79670 sp 0x7ffe75d79668
READ of size 1 at 0x5cdb8a98b660 thread T0
    #0 0x5cdb8a3923ff in umaskcmd /upstream/dash/src/miscbltin.c:275
    #1 0x5cdb8a35619e in evalbltin /upstream/dash/src/eval.c:960
    #2 0x5cdb8a358ada in evalcommand /upstream/dash/src/eval.c:908
    #3 0x5cdb8a350ae0 in evaltree /upstream/dash/src/eval.c:299
    #4 0x5cdb8a38b35b in cmdloop /upstream/dash/src/main.c:242
    #5 0x5cdb8a2683ab in main /upstream/dash/src/main.c:176
    #6 0x797d9d6ed249 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58
    #7 0x797d9d6ed304 in __libc_start_main_impl ../csu/libc-start.c:360
    #8 0x5cdb8a269490 in _start (/upstream/dash/src/dash+0x1a490)

0x5cdb8a98b660 is located 0 bytes to the right of global variable
'stackbase' defined in 'memalloc.c:107:20' (0x5cdb8a98b460) of size 512
SUMMARY: AddressSanitizer: global-buffer-overflow
/upstream/dash/src/miscbltin.c:275 in umaskcmd

Shadow bytes around the buggy address:
  0x0b9bf1529670: 00 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9 f9 f9 f9
  0x0b9bf1529680: 04 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
  0x0b9bf1529690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0b9bf15296a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0b9bf15296b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0b9bf15296c0: 00 00 00 00 00 00 00 00 00 00 00 00[f9]f9 f9 f9
  0x0b9bf15296d0: 00 00 00 00 01 f9 f9 f9 f9 f9 f9 f9 00 00 00 00
  0x0b9bf15296e0: 00 00 02 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
  0x0b9bf15296f0: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
  0x0b9bf1529700: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 f9 f9 f9 f9 f9
  0x0b9bf1529710: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 04 f9 f9 f9
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
==42==ABORTING

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
MTAwMAphCmVuZC0xCmEKZW5kLTIKYTp4CmVuZC1hCnUgbG9iOngKZW5kLWIKYzp4CmVuZC1jCmVu
ZC0zCmE6eAplbmQKYQpiCmMKZW5kLTEKYQpiCmMKZZFkLTIKYTp4CmE6eQphOnoKZW5kLWEKYjp4
CmI6eQpiOnoKZW5kLWIKYzp4c2V0CmVuYWJsZW5kLWMKZW5kLTMKYTp4+WI6eApjOngKZW5kCiRC
VkFSCiRCVkFSCiRCVkFSCiRCVkFSCmZvbwpiYXIKeHh4CjAwMjIKdT1yd3gsZz1yeCxvPXJ4CjAw
MDIKdT1yd3gsZz1yd3gsbz1yeAp1bWFzayAwMDAyCnVtYXNrIC1TIHU9cnd4LGcgZ29vZD1yIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKIyAgIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCiMKIyAgIFlvdSBzaG9hbmsgbGF2ZXd4LG89cngKdT1y
d3gsZz1yd3gsbz1yd3gKZW5hYmxlIC4KZW5hYmxlFToKZW5hYmxlIGsKZW5hYmxlZQpbbmFibGUg
ZXZhbAplbmFibGUgZXhlYwplbmFibGUgZXhpdAplbmFibGUgZXhwb3J0CmVuYWJsZSBybmx5CmVu
YWJsZSBybgplbmFibGUgdGV0CmVuYWJsZSB0CmVuYWJsZSBzb3VyY2UKZW5hYmxlIHQKZW5hYmxl
IHRyYXAKZW5ibGUgdW5zZXQKZW5hYmxlIC4KZW5hYmxlIDoKZW5hYmxlIGJyZWFrCmVuYWJsZSBj
b250aW51ZQplbmFibGUgZXZhbAplbmFibGUgZXhlYwplbmFibGUgZXhpdAplbmFibGUgZXhwb3J0
CmVuA+hsZSByZWFkb25seQplbmFibGUgcmV0dXJuCmVuYWJsZSBzZXQKZW5hYmxlIHNoaWZ0CmVu
YWJsZSBzb3VyYzs7IGVzYWMgO30KbWVzCmVuYWJsZSB0cmFwCmVuYWJsZSB1bnNldAplbmFibGUg
LW4gdGVzdCB3b3JrZWQKZW5hYmxlIHRlc3Qgd29ya2VkCnNwZWNpYWxuYW1lCi1zcGVjaQp1bWFz
ayAwMDAyCnVtYXNrIC1TIHU9cnd4LGcgYWxuYW1lCkZPQD1CQQoKc2V0IC1vIHBylomtCg==
=====================================================================================
Then do the action: base64 -d bs64.txt > myfile.txt
Or just take from attachments

--00000000000014f7f806486dc6cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Dear Dash maintainers,<br><br>I encounter=
ed a bug in Dash in commit f8aaaa (Also the behaviour repeats on 0.5.13 ver=
sion of Dash) and would like to report<br>it. The details are provided belo=
w.<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=3D=3D42=3D=3DERROR:=
 AddressSanitizer: global-buffer-overflow on address 0x5cdb8a98b660 at pc 0=
x5cdb8a392400 bp 0x7ffe75d79670 sp 0x7ffe75d79668<br>READ of size 1 at 0x5c=
db8a98b660 thread T0<br>=C2=A0 =C2=A0 #0 0x5cdb8a3923ff in umaskcmd /upstre=
am/dash/src/miscbltin.c:275<br>=C2=A0 =C2=A0 #1 0x5cdb8a35619e in evalbltin=
 /upstream/dash/src/eval.c:960<br>=C2=A0 =C2=A0 #2 0x5cdb8a358ada in evalco=
mmand /upstream/dash/src/eval.c:908<br>=C2=A0 =C2=A0 #3 0x5cdb8a350ae0 in e=
valtree /upstream/dash/src/eval.c:299<br>=C2=A0 =C2=A0 #4 0x5cdb8a38b35b in=
 cmdloop /upstream/dash/src/main.c:242<br>=C2=A0 =C2=A0 #5 0x5cdb8a2683ab i=
n main /upstream/dash/src/main.c:176<br>=C2=A0 =C2=A0 #6 0x797d9d6ed249 in =
__libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58<br>=C2=A0 =
=C2=A0 #7 0x797d9d6ed304 in __libc_start_main_impl ../csu/libc-start.c:360<=
br>=C2=A0 =C2=A0 #8 0x5cdb8a269490 in _start (/upstream/dash/src/dash+0x1a4=
90)<br><br>0x5cdb8a98b660 is located 0 bytes to the right of global variabl=
e &#39;stackbase&#39; defined in &#39;memalloc.c:107:20&#39; (0x5cdb8a98b46=
0) of size 512<br>SUMMARY: AddressSanitizer: global-buffer-overflow /upstre=
am/dash/src/miscbltin.c:275 in umaskcmd<br><br>Shadow bytes around the bugg=
y address:<br>=C2=A0 0x0b9bf1529670: 00 f9 f9 f9 f9 f9 f9 f9 04 f9 f9 f9 f9=
 f9 f9 f9<br>=C2=A0 0x0b9bf1529680: 04 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 =
00 00 00<br>=C2=A0 0x0b9bf1529690: 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00<br>=C2=A0 0x0b9bf15296a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00<br>=C2=A0 0x0b9bf15296b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00<br>=3D&gt;0x0b9bf15296c0: 00 00 00 00 00 00 00 00 00 00 00 00[f9]f9 f=
9 f9<br>=C2=A0 0x0b9bf15296d0: 00 00 00 00 01 f9 f9 f9 f9 f9 f9 f9 00 00 00=
 00<br>=C2=A0 0x0b9bf15296e0: 00 00 02 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 =
f9<br>=C2=A0 0x0b9bf15296f0: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f=
9<br>=C2=A0 0x0b9bf1529700: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 f9 f9 f9 f9 f9=
<br>=C2=A0 0x0b9bf1529710: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 04 f9 f9 f9<=
br>Shadow byte legend (one shadow byte represents 8 application bytes):<br>=
=C2=A0 Addressable: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00<br>=C2=A0 Partial=
ly addressable: 01 02 03 04 05 06 07 <br>=C2=A0 Heap left redzone: =C2=A0 =
=C2=A0 =C2=A0 fa<br>=C2=A0 Freed heap region: =C2=A0 =C2=A0 =C2=A0 fd<br>=
=C2=A0 Stack left redzone: =C2=A0 =C2=A0 =C2=A0f1<br>=C2=A0 Stack mid redzo=
ne: =C2=A0 =C2=A0 =C2=A0 f2<br>=C2=A0 Stack right redzone: =C2=A0 =C2=A0 f3=
<br>=C2=A0 Stack after return: =C2=A0 =C2=A0 =C2=A0f5<br>=C2=A0 Stack use a=
fter scope: =C2=A0 f8<br>=C2=A0 Global redzone: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0f9<br>=C2=A0 Global init order: =C2=A0 =C2=A0 =C2=A0 f6<br>=C2=A0 Po=
isoned by user: =C2=A0 =C2=A0 =C2=A0 =C2=A0f7<br>=C2=A0 Container overflow:=
 =C2=A0 =C2=A0 =C2=A0fc<br>=C2=A0 Array cookie: =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0ac<br>=C2=A0 Intra object redzone: =C2=A0 =C2=A0bb<br>=C2=A0 =
ASan internal: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fe<br>=C2=A0 Left alloca =
redzone: =C2=A0 =C2=A0 ca<br>=C2=A0 Right alloca redzone: =C2=A0 =C2=A0cb<b=
r>=3D=3D42=3D=3DABORTING<br><br>////////////////<br>My environment:<br>////=
////////////<br><br>Debian-12, x86-64, clang-19 compiler<br><br>///////////=
//////<br>Steps to reproduce:<br>/////////////////<br><br>$ aclocal &amp;&a=
mp; autoheader &amp;&amp; automake --add-missing &amp;&amp; autoconf<br>$ C=
C=3Dclang CFLAGS=3D&quot; -Wno-everything -fsanitize=3Daddress -g -O0&quot;=
 ./configure --disable-fnmatch --disable-lineno --disable-glob<br>$ make<br=
>$ cd src<br>$ ./dash &lt; myfile.txt<br><br>//////////////////<br>Steps to=
 get myfile.txt:<br>//////////////////<br><br>copy the text into file bs64.=
txt (between =3D=3D=3D=3D and =3D=3D=3D=3D=3D=3D):<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>MTAwMAphCmVuZC0xCmEKZW5kLTIKYTp4CmVuZC1hCnUgbG9iOngKZW5kLWIKYz=
p4CmVuZC1jCmVu<br>ZC0zCmE6eAplbmQKYQpiCmMKZW5kLTEKYQpiCmMKZZFkLTIKYTp4CmE6e=
QphOnoKZW5kLWEKYjp4<br>CmI6eQpiOnoKZW5kLWIKYzp4c2V0CmVuYWJsZW5kLWMKZW5kLTMK=
YTp4+WI6eApjOngKZW5kCiRC<br>VkFSCiRCVkFSCiRCVkFSCiRCVkFSCmZvbwpiYXIKeHh4CjA=
wMjIKdT1yd3gsZz1yeCxvPXJ4CjAw<br>MDIKdT1yd3gsZz1yd3gsbz1yeAp1bWFzayAwMDAyCn=
VtYXNrIC1TIHU9cnd4LGcgZ29vZD1yIEZP<br>UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZ=
SB0aGUKIyAgIEdOVSBHZW5lcmFsIFB1YmxpYyBM<br>aWNlbnNlIGZvciBtb3JlIGRldGFpbHMu=
CiMKIyAgIFlvdSBzaG9hbmsgbGF2ZXd4LG89cngKdT1y<br>d3gsZz1yd3gsbz1yd3gKZW5hYmx=
lIC4KZW5hYmxlFToKZW5hYmxlIGsKZW5hYmxlZQpbbmFibGUg<br>ZXZhbAplbmFibGUgZXhlYw=
plbmFibGUgZXhpdAplbmFibGUgZXhwb3J0CmVuYWJsZSBybmx5CmVu<br>YWJsZSBybgplbmFib=
GUgdGV0CmVuYWJsZSB0CmVuYWJsZSBzb3VyY2UKZW5hYmxlIHQKZW5hYmxl<br>IHRyYXAKZW5i=
bGUgdW5zZXQKZW5hYmxlIC4KZW5hYmxlIDoKZW5hYmxlIGJyZWFrCmVuYWJsZSBj<br>b250aW5=
1ZQplbmFibGUgZXZhbAplbmFibGUgZXhlYwplbmFibGUgZXhpdAplbmFibGUgZXhwb3J0<br>Cm=
VuA+hsZSByZWFkb25seQplbmFibGUgcmV0dXJuCmVuYWJsZSBzZXQKZW5hYmxlIHNoaWZ0CmVu<=
br>YWJsZSBzb3VyYzs7IGVzYWMgO30KbWVzCmVuYWJsZSB0cmFwCmVuYWJsZSB1bnNldAplbmFi=
bGUg<br>LW4gdGVzdCB3b3JrZWQKZW5hYmxlIHRlc3Qgd29ya2VkCnNwZWNpYWxuYW1lCi1zcGV=
jaQp1bWFz<br>ayAwMDAyCnVtYXNrIC1TIHU9cnd4LGcgYWxuYW1lCkZPQD1CQQoKc2V0IC1vIH=
BylomtCg=3D=3D<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Then do the action: bas=
e64 -d bs64.txt &gt; myfile.txt<br>Or just take from attachments</div></div=
>

--00000000000014f7f806486dc6cb--
--00000000000014f7fa06486dc6cd
Content-Type: text/plain; charset="CP932"; name="attach.txt.txt"
Content-Disposition: attachment; filename="attach.txt.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mkfizjy50>
X-Attachment-Id: f_mkfizjy50

MTAwMAphCmVuZC0xCmEKZW5kLTIKYTp4CmVuZC1hCnUgbG9iOngKZW5kLWIKYzp4CmVuZC1jCmVu
ZC0zCmE6eAplbmQKYQpiCmMKZW5kLTEKYQpiCmMKZZFkLTIKYTp4CmE6eQphOnoKZW5kLWEKYjp4
CmI6eQpiOnoKZW5kLWIKYzp4c2V0CmVuYWJsZW5kLWMKZW5kLTMKYTp4+WI6eApjOngKZW5kCiRC
VkFSCiRCVkFSCiRCVkFSCiRCVkFSCmZvbwpiYXIKeHh4CjAwMjIKdT1yd3gsZz1yeCxvPXJ4CjAw
MDIKdT1yd3gsZz1yd3gsbz1yeAp1bWFzayAwMDAyCnVtYXNrIC1TIHU9cnd4LGcgZ29vZD1yIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKIyAgIEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCiMKIyAgIFlvdSBzaG9hbmsgbGF2ZXd4LG89cngKdT1y
d3gsZz1yd3gsbz1yd3gKZW5hYmxlIC4KZW5hYmxlFToKZW5hYmxlIGsKZW5hYmxlZQpbbmFibGUg
ZXZhbAplbmFibGUgZXhlYwplbmFibGUgZXhpdAplbmFibGUgZXhwb3J0CmVuYWJsZSBybmx5CmVu
YWJsZSBybgplbmFibGUgdGV0CmVuYWJsZSB0CmVuYWJsZSBzb3VyY2UKZW5hYmxlIHQKZW5hYmxl
IHRyYXAKZW5ibGUgdW5zZXQKZW5hYmxlIC4KZW5hYmxlIDoKZW5hYmxlIGJyZWFrCmVuYWJsZSBj
b250aW51ZQplbmFibGUgZXZhbAplbmFibGUgZXhlYwplbmFibGUgZXhpdAplbmFibGUgZXhwb3J0
CmVuA+hsZSByZWFkb25seQplbmFibGUgcmV0dXJuCmVuYWJsZSBzZXQKZW5hYmxlIHNoaWZ0CmVu
YWJsZSBzb3VyYzs7IGVzYWMgO30KbWVzCmVuYWJsZSB0cmFwCmVuYWJsZSB1bnNldAplbmFibGUg
LW4gdGVzdCB3b3JrZWQKZW5hYmxlIHRlc3Qgd29ya2VkCnNwZWNpYWxuYW1lCi1zcGVjaQp1bWFz
ayAwMDAyCnVtYXNrIC1TIHU9cnd4LGcgYWxuYW1lCkZPQD1CQQoKc2V0IC1vIHBylomtCg==
--00000000000014f7fa06486dc6cd--
