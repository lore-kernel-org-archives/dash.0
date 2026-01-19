Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168B326D69
	for <dash@vger.kernel.org>; Mon, 19 Jan 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830551; cv=pass; b=dfAFg9LXUdQ2IuRaWrZxMWCF8aBw0yDFhvbpVDhc6jrWYj0xcFsM/EGsN/fjuhgamr9wtqXWPddDmjFf+lCpWMK8YQwGMupqmSgJ3IluwjIkPtuwD1Ph691xEYdYx8tnqGwDPd6+w6B4QAoukkhZvhC2NgmUw5umwl3unOsiJFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830551; c=relaxed/simple;
	bh=WimO38ouh28I1TkwCWPXwWKEvFtmFHkJALg/P4LfVL0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KAJRLQqf51W8hZLqbzsbMRVXKAiF/6ZsCK4/PTiV2h29uMaAPv1QyLjKqMUtksIlaDytq8cHYansZsoV0ug1U7uPGfcsegoPr/JSx8dVPd4gpPfNVv/19Naj6qFXFtNTuEjYA7KegR8u1K0PnABgrSsneo7yOb+LOwK7M/EQHY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIYd5HaS; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIYd5HaS"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64472c71fc0so3633631d50.0
        for <dash@vger.kernel.org>; Mon, 19 Jan 2026 05:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768830549; cv=none;
        d=google.com; s=arc-20240605;
        b=ebLScTIpSHXj/eOPnxRx/0UOdnUMYwuSPfd4uC73laM6IR2G/UhJChjHiD995C2LZi
         vsW17jIemv39xGymLw8b9gYvyMlt1ZDZDLk9k10oQvFXSjKeQNXjUTQ5P1J0XWM31xn/
         D1uj8tPbiTA8QMEn2wj5DkxoM/SNv9/NfppL1mGmC6c1r2quJjj+vwHGpcRllNsyV2ik
         yIbbDdiSM32Yw0PpZBiS6JIQMrqh0Yn+IJF7546LgsdwW/gJpUy/iJGkM0YH7V+OOSna
         FDnykYqlfr3Iepmj7VdjHiQkL9Th1p1pyv2fgDIVBvsTYHldKPfdlpzaBXZ9mYrj+pQU
         em8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/ORgPQz5mHHFLEtEXHT5/hCGZZ8SAA4q0zcI0DzRyLc=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=D/35YcIT8S3r7Uj+mYaOtrYDZTtOadTNF5GtYIJ+rEjqO2Pu8W+a1Zz3geOkeHcpg9
         3rdfT4tgKz0N8qbTDPb6OND9NJjRV+xeOeXRGb79HYFuR4HeTnkwyJZME7CZNe/LCMtK
         uZfP0h6V1YdR6l8yoDk/oQjQ2BkdabzXIo+fiH4mgBMHfDY5X/wr1toaZg8QZCreo6jF
         X8Q7x0D8vlS/qKmVSg3EECHhRlly87cCl2D4mjCpooaI6xvRAHo6LqmLWef5gbJpi85f
         i+wDkM2wpSr2pNXou1MiwzKuaSNc/6iGIDl02s6LqGLYasW8/ErJ9I1+lbFZsMcVObod
         Q7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768830549; x=1769435349; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ORgPQz5mHHFLEtEXHT5/hCGZZ8SAA4q0zcI0DzRyLc=;
        b=FIYd5HaSb8LkCv4YH5QKNcBHl9AVs52Lj8fazyP1CMeppWQzJPW+I5V6vfYCrKGcdT
         NI7xK+rHEm1zLZVQ6+m62HALyCQmc7E8vFCZyksvIwwahQVSl3oqCayEMoeFFUKzHgd4
         VqMkUkxuFbv2SvXV/Jg/q70pC3djG3UdnbAC0hRls2/EnYpncR4ROfsqMfOjDwCj+ALK
         lIdgHEG44poabx3AqxX3NeGCyrgP0TnZ5awKdLkyTCs8pQCbl+2FXXWuzI7pol8Hgi2S
         DtYxgxsP3XuMnGK3iUsvHi9MjY+47i/KOMtoiA9abe670kSn6Db5VlB+pyEOV2x0kVX5
         Hwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830549; x=1769435349;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ORgPQz5mHHFLEtEXHT5/hCGZZ8SAA4q0zcI0DzRyLc=;
        b=dFAFvpk0pI5f8GtK4PmN7okYrBpoSln8R2eq9gfGD634lfqWRaCslt9ljLWqGJW3M/
         nSj2AJKfvH8osvcHXKR6kHoJcsrDZnYQl7dGR9vcSrikHve4+PhsmCk0zQ6eCzP2prVL
         69L5VNwfkr3Xz7G5/Zgwhie44g1auiJq/V7arWnEV5b7T5RHm2pngyigQ4NKHwkXS0dF
         CMCHflOyd14Rd5IYFQ3aLlyMMIcXnV30lJ4KsFjMuZMfMvxpkEvJn/0mCQAk6zR8T8+/
         pRKqZrccMUPFVR2RtpdplaF7Z5mDHCOAXEj9x3p0Au1/4CiHDPkDGbHd7wgFgjDQWCMF
         GBtg==
X-Gm-Message-State: AOJu0Ywmn0v3pnltYDT1QBVBsN/WdJDwCxBhZXSRaa+9Km4iPAbNGbzZ
	Kvv+HxL7bVGNW13QyCbPg0xmscDoulVAs7Jf9DK/Uvpi899133qpvMmzrN9qQGv4dszrCHKW9fJ
	ocruwBdjgw9rTx9OsVo32NtgMm/+Lh65vQ8KpwB0=
X-Gm-Gg: AZuq6aJboe8M4NzawIeRBXQN1zhYUtpCPSs+b4MrU7FpubbVHG9LP0RVLeXdgnoT/0+
	FNMhAfZV3hlM+lNeh8whiuLLOKNxNjh2NtAKCSZAHP5oFQIw0MDxYCqudEaSCRXKaVJhlyqVFOU
	KGmbPIWLadVL8H9Skariu8wdSLfmrzeMztRMmUo353HcweJryBHlfx9VxnlKkWL/KwZDaJtE6we
	kOAhwFSdqlFdj6rKHtOEvx3LOymQDKgu5VYe/QMCjWrwbVC00AJhQ5xqO44uyklHMny5pQOJoJG
	wemCFInQCl53iRc8xSLXYu8hXQ==
X-Received: by 2002:a05:690e:4191:b0:63f:bb53:fe2f with SMTP id
 956f58d0204a3-649176c603amr8717734d50.3.1768830548314; Mon, 19 Jan 2026
 05:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksander Ushakov <retes672@gmail.com>
Date: Mon, 19 Jan 2026 16:48:55 +0300
X-Gm-Features: AZwV_Qhx2pnYJ7YspFRa1inM2iOxpACmBvZwitQntIHyEuQ0gpkt0DLmn-QPXBU
Message-ID: <CADdNFauVF91SguPkBT7FUPuKLBbwTod=EeLAibqosujYRv01BQ@mail.gmail.com>
Subject: [BUG] memcpy-param-overlap _rmescapes src/expand.c:2129:8
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Dash maintainers,

I encountered a bug in Dash 0.5.13 and would like to report
it. The behaviour is the same for ASAN error in Dash 0.5.12 and I
reported it here (https://www.spinics.net/lists/dash/msg02856.html).
So steps to reproduce are similarly for 0.5.12 and 0.5.13. The ASAN
errors have some differences but the problem may be the same. The
details are  provided below.

==4385==ERROR: AddressSanitizer: memcpy-param-overlap: memory ranges
[0x5e9360717719,0x5e936071771c) and [0x5e936071771b, 0x5e936071771e)
overlap
    #0 0x5e935fced469 in __asan_memcpy
(/upstream/z/dash-0.5.13/src/dash+0xd6469) (BuildId:
e987025fc7a0e719d6f6413a475e27117a9dee0e)
    #1 0x5e935fd40db9 in _rmescapes /upstream/z/dash-0.5.13/src/expand.c:2129:8
    #2 0x5e935fd3f25b in expandmeta /upstream/z/dash-0.5.13/src/expand.c:1572:4
    #3 0x5e935fd3dcec in expandarg /upstream/z/dash-0.5.13/src/expand.c:246:3
    #4 0x5e935fd3570b in evalcommand /upstream/z/dash-0.5.13/src/eval.c:819:4
    #5 0x5e935fd348f5 in evaltree /upstream/z/dash-0.5.13/src/eval.c:305:12
    #6 0x5e935fd51892 in cmdloop /upstream/z/dash-0.5.13/src/main.c:247:8
    #7 0x5e935fd5149e in main /upstream/z/dash-0.5.13/src/main.c:181:3
    #8 0x721fde258249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #9 0x721fde258304 in __libc_start_main csu/../csu/libc-start.c:360:3
    #10 0x5e935fc505d0 in _start
(/upstream/z/dash-0.5.13/src/dash+0x395d0) (BuildId:
e987025fc7a0e719d6f6413a475e27117a9dee0e)

0x5e9360717719 is located 409 bytes inside of global variable
'stackbase' defined in '/upstream/z/dash-0.5.13/src/memalloc.c:110'
(0x5e9360717580) of size 512
0x5e936071771b is located 411 bytes inside of global variable
'stackbase' defined in '/upstream/z/dash-0.5.13/src/memalloc.c:110'
(0x5e9360717580) of size 512
SUMMARY: AddressSanitizer: memcpy-param-overlap
(/upstream/z/dash-0.5.13/src/dash+0xd6469) (BuildId:
e987025fc7a0e719d6f6413a475e27117a9dee0e) in __asan_memcpy
==4385==ABORTING

////////////////
My environment:
////////////////

Debian-12, x86-64, clang-19 compiler

/////////////////
Steps to reproduce:
/////////////////

$ aclocal && autoheader && automake --add-missing && autoconf
$ CC=clang CFLAGS=" -Wno-everything -fsanitize=address -g -O0"
./configure --disable-fnmatch --disable-lineno --disable-glob
$ make
$ cd src
$ ./dash < myfile.txt

//////////////////
Steps to get myfile.txt:
//////////////////

copy the text into file bs64.txt (between ==== and ======):
=====================================================================================
IyBtYWFyYWN0ZXJzIGRv5id0IGludGVyZmVyZSB3aXRoIHRoZQojIHNwYWNlIHNlbnRpbmVsICMg
ICBUaGlzIHByb2dyYW0gaXMgf3JlZSBzb2Z0d2FyZTogeW91IGNhbiBiZWRpc3RyaWJ1dGUgaXQg
YW5kL29yIG1vZGlmeQoj/38AbmRlciB0aGUgdGVyZHRlc3QKCnNldCAtbyBub2Nsb2JiZXIKCiN0
aGlzIHNob3VsZCB0ZXN0CnRlc3QgIiR7ZW1wdHktYmFkfSJzIG9mIHRoZSBHTlUgR2VuRXJhbCBQ
dWJsaWMgTGllc3Qgd2hldGhlciBvciB0CnQgdGVtcG9yYXJ5IGVudmlyb25tZW50dAoKc2V0IC1v
IG5vY2xvYmJlcgoKI3RoaXMgc2hvdWxkIHRlc3QKdGVzdCAiJHtlbXB0eS1iYWR9InMgb2YgdGhl
IEdOVSBHZW5FcmFsIFB1YmxpYyBMaWVzdCB3aGV0aGVyIG9yIHQKdCB0ZW1wb3JhcnkgZW52aXJv
bm1lbnQgYXNzaWdubWVudHMgYXJlIGV4cG9ydGVkCiMgaW4gcG9zaUxpY2Vuc2UgYXMgcHVibGlz
aGUZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZ
GRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRlkIGJ5CiMgICB0aGUgRnJoZXIgdmVy
c2lvbiAzIG9mIGlmeQojICAgbmVwYWwgUHVibEljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CiPN
ICB0aCMgbV0gICAgICAgICAgICAgICAgICAgICAgICAgICBpYXNlcyB0aGF0IGVuZCBpbiBtdWx0
aWJ5dGUgY2hhcmFjdGVycyBkb24ndCBpbnRlcmZlcmUgd2l0aCB0aGUKIyBzcGFjZSBzZW50aW5l
bCBhbGlhcyBleHBhbnNpb24gYWRkczsgcHJuYmxlbSB0aHJvdWdoIGJhc2gtNS4xCnNobyBiIGFi
Ly4uL3///ycnJycnJycnJycKZF9BTEw9ZW5fVVMuVVRGLTgKCmFsaWFzIG1ha2Ugc3VyZSBhbGlh
c2VzIHRoYXQgZW5hMT0ncHJpbnRmICI8JXM+XFxuIiDDoWEnCmExCgphbGlhcyBhMj0nMDBcMjAw
XDIxMicgJycKZG9sbApkZWNsYXJlIC1BIGZvb2ExIyAgIFRoaXMgcCAvClBBVEg9JFBBVEhuACVy
ZmVyZW9vCmJhcmR4eHgKMDAyMgp1PXJ3eCxnPXJ4LW89cngKIHdpdGggdGhlCiMgc3BhY2Ugc2Vu
dGluZWwgYWwgIyAgRElHSVQgVEhpYXMgZXh1cmNlCmVuYWJsZSB0CmVuYWJsZSB0cmEgLXgKCmVj
aGhoaGhoaGhobyAxCmVNaCBhIGIgYwpzTEFOR11lbl9VUy5VVEYtOAkjIHNhZmVzc/M6ICR7VE1Q
RElSOj0vdmFyL3RtcH0KSE9NRT0ke1RNUERJUn0KCm1rZGlyIH4v4LKH4LKzc3VyZSBhbGlhbXV0
Zf9AaGFyYWN0ZXJzbHRpYnl0ZSBjb3VjaCB+L+Cyh+BkaG8gfi/gsoeys+Cyv+CyleCzhuCyl+Cy
s+CzgS97YSxifS50eHQKZWRobyB+L+Cyh+CyteCyv+CyleCzhuCyl+Cys+CzgS8qL3R4dCA+cApl
bmgtNS4xIHOBb3B0IC1zIGV4cGFuZF9hbGlhc2V0aGUgTGljZW5zYWH19fX19fX1IC1mCmSAZmVj
ZW5zZXMvPi4KIwo6ICR7VE1QRElSOj0vdG1wfQoKZXhwb3J0Igp0ZXN0ICIke2VtcHR5Oi1va30i
ID0gb2sgfHwgdGVzdGZhaWwgInIgY29sb24iCm5ld3Rlc3QKdGVzdCAiJHtlbXB0eS1iYWR9IiA9
ICIiIHx8IHRlc3RmYWlsICJnb3QgIExDX0FMTD1DCmV4cG9ydCBMQU5HPUMKCiMgY2F0Y2gtYWxs
IGZvciByZW1haW5pbmcgdW50ZXN0ZWQgCgplY2hvIGFiYyA+IC90bXAvcmVkaXItdGVzdApAYXQg
L3RtcC9yZWRpci10ZXN0CgpzZXQgLW8gbm9jbG9iYmVyCgojdGhpcyBzaG91bGQgdGVzdAp0ZXN0
ICIke2VtcHR5LWJhZH0iID0gIiIgfHwgdGVlZWVlcmVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVl
ZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVlZWVl
ZWVlZWVlZWVlZWVlZWVldCAvdG1wL3JlZGlyLXRlc3QKCnNldCAtbyBub2Nsb2JiZXIKCiN0aGlz
IHNob3VsZCBiZSBhbiBlcnJvcgplY2hvIGRlZiA+IC90bXAvcmVkaXItdGVzdApjYSBhc3NpZ25t
ZW50cyBhcmUgZXhwb3J0ZWQKIyBpbiBwb3NpTGljZW5zZSBhcyBwdWJsaXNoZRkZGRkZGRkZGRkZ
GRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZGRkZ
GRkZGRkZGRkZGRkZGRkZGRkZGRkZGWQgYnkKIyAgIHRoZSBGcmhlciB2ZXJzaW9uIDMgb2YgaWZ5
CiMgICBuZXBhbCBQdWJsSWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKI80gIHRoIyBtXSAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlhc2VzIHRoYXQgZW5kIGluIG11bHRpYnl0ZSBjaGFyYWN0
ZXJzIGRvbid0IGludGVyZmVyZSB3aXRoIHRoZQojIHNwYWNlIHNlbnRpbmVsIGFsaWFzIGV4cGFu
c2lvbiBhZGRzOyBwcm5ibGVtIHRocm91Z2ggYmFzaC01LjEKc2hvIGIgYWIvLi4vf///JycnJycn
JycnJwpkX0FMTD1lbl9VUy5VVEYtOAoKYWxpYXMgbWFrZSBzdXJlIGFsaWFzZXMgdGhhdCBlbmEx
PSdwcmludGYgIjwlcz5cXG4iIMOhYScKYTEKCmFsaWFzIGEyPScwMFwyMDBcMjEyJyAnJwpkb2xs
CmRlY2xhcmUgLUEgZm9vYTEjICAgVGhpcyBwIC8KUEFUSD0kUEFUSG4AJXJmZXJlb28KYmFyCnh4
eAowMDIyCnU9cnd4LGc9cngtbz1yeAogd2l0aCB0aGUKIyBzcGFjZSBzZW50aW5lbCBhbCAjICBE
SUdJVCBUSGlhcyBleHVyY2UKZW5hYmxlIHQKZW5hYmxlIHRyYSAteAoKZWNoaGhoaGhoaGhvIDEK
ZU1oIGEgYiBjCnNMQU5HXWVuX1VTLlVURi04CSMgc2FmZXNz8zogJHtUTVBESVI6PS92YXIvdG1w
fQpIT01FPSR7VE1QRElSfQoKbWtkaXIgfi/gsofgsrNzdXJlIGFsaWFtdXRl/2NoYXJhY3RlcnNs
dGlieVRIbgAlcmZlcmVvbwpiYXIKeHh4CjAwMjIKdT1yd3gsZz1yeC1vPXJ4CiB3aXRoIHRoZQoj
IHNwYWNlIHNlbnRpbmVsIGFsICMgIERJR0lUIFRIaWFzIGV4dXJjZQplbmFibGUgdAplbmFibGUg
dHJhIC14CgplY2hoaGhoaGhoaG8gMQplTWggYSBiIGMKc0xBTkddZW5fVVMuVVRGLTgJIyBzYWZl
c3PzOiAke1RNUERJUjo9L3Zhci90bXB9CkhPTUU9JHtUTVBESVJ9Cgpta2RpciB+L+Cyh+Cys3N1
cmUgYWxpYW11dGX/Y2hhcmFjdGVyc2x0aWJ5dGUgY291Y2ggfi/gsofgZGhvIH4v4LKHsrPgsr/g
spXgs4bgspfgsrPgs4Eve2EsYn0udHh0CmVkaG8gfi/gsofgsrXgsr/gspXgs4bgspfgsrPgs4Ev
Ki90eHQgPnAKZW5oLTUuMSBzgW9wdCAtcyB0aGUgaW1mIHRoZSBHTlUgR2VufnJhbCBQdWJsaWMg
TGljZW5zZQojICAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW0nJycnJycnJycnCmRfQUxMPWVuX1VT
LlVURi04CgphbGlhcyBtYWtlIHN1cmUgYWxpYXNlcyB0aGF0IGVuYTE9J3ByaW50ZiAiPCVzPlxc
biIgw6FhJwphMQoKYWxpYXMgYTI9JzAwXDIwMFwyMTInICcnCmRvbGwKZGVjbGFyZSAtQSBmb29h
MSMgICBUaGlzIHAgLwpQQVRIPSRQQVRIbgAlcmZlcmVvbwpiYXIKeHh4CjAwMjIKdT1yd3gsZz1y
eC1vPXJ4CiB3aXRoIHRoZQojIHNwYWNlIHNlbnRpbmVsIGFsICMgIERJR0lUIFRIaWFzIGV4dXJj
ZQplbmFibGUgdAplbmFibGUgdHJhIC14CgplY2hoaGhoaGhoaG8gMQplTWggYSBiIGMKc0xBTkdd
ZW5fVVMuVVRGLTgJIyBzYWZlc3PzOiAke1RNUERJUjo9L3Zhci90bXB9CkhPTUU9JHtUTVBESVJ9
Cgpta2RpciB+L+Cyh+Cys3N1cmUgYWxpYW11dGX/Y2hhcmFjdGVyc2x0aWJ5VEhuACVyZmVyZW9v
CmJhcgp4eHgKMDAyMgp1PXJ3eCxnPXJ4LW89cngKIHdpdGggdGhlCiMgc3BhY2Ugc2VudGluZWwg
YWwgIyAgRElHSVQgVEhpYXMgZXh1cmNlCmVuYWJsZSB0CmVuYWJsZSB0cmEgLXgKCmVjaGhoaGho
aGhobyAxCmVNaCBhIGIgYwpzTEFOR11lbl9VUy5VVEYtOAkjIHNhZmVzc/M6ICR7VE1QRElSOj0v
dmFyL3RtcH0KSE9NRT0ke1RNUERJUn0KCm1rZGlyIH4v4LKH4LKzc3VyZSBhbGlhbXV0Zf9jaGFy
YWN0ZXJzbHRpYnl0ZSBjb3VjaCB+L+Cyh+BkaG8gfi/gsoeys+Cyv+CyleCzhuCyl+Cys+CzgS97
YSxifS50eHQKZWRobyB+L+Cyh+CyteCyv+CyleCzhuCyl+Cys+CzgS8qL3R4dCA+cAplbmgtNS4x
IHOBb3B0IC1zIHRoZSBpbWYgdGhlIEdOVSBHZW5+cmFsIFB1YmxpYyBMaWNlbnNlCiMgICBhbG9u
ZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIDBmIG4KIyAgIE1FUkNIQU5UQUJJTElUWSBvdS5vcmcvbGlj
ZW5zZXMvPi4KIwpvbGRkaXI9JFBXRAo6ICR7VE1QRElSOj0vdmFyL3RtJFRNUERJUi9lbXB0eQoK
c2hvcHQgLXMgZ+BvYnN0YXIKcygpCnsKICBwcmludGYgJz09IDwlcz4gPT1cbicgIiRAIgp9CnAo
KX5+fn5+fn5+fn5+fn5+fnN+fn5+fn5+IH4KewogIHByaW50ZiAnPCVldmVuIHRoZXE+XG4nICIk
QCIKfQoKbWtkaXIgLXAgJEVNUFRZL2EvYS9hCmNkICRFTVBUWQoKIyBnb29kCnAgKioKcCAqKi8q
KgpwICoqLyoqLyoqCgoBACAtcmYgYQpta2RpciAtcCAkRU1QVFkve2EsYn0ve2EsYn0ve2EsYn0v
e2EsYn0KY2QgJEVNUFRZCgoj35iQkJv1jHRoZXIgdmVyc2lvbiAzIG9mIHRoZSBMaWNlbnNlLCBv
cgojICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KIwojICAgVGggb3BlcmF0
aW9uIG9mIHRhYiByZW1vdmlzIHByb2dyYW0gaXMgTGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhh
dCBpdCB3aWxsIGJlIHVzZWZ1bCwKI3sKICBldCBXSVRIT1VUIEFOWSBXQVJSQU5UIyAgICBpcyBm
cmVlIHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3JpZnkKIyAgIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlz
aGVkIGJ5CiMgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXJpdmVyc2lvbiAz
E29mIHRoZSBMaWNlbnNlLCBvcgojICAgKGF0IHlvdXIgb/////9uKSBhbnkgbGF0ZXIgdmVyc2lv
bi4KIwojICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHQKMDAyMgp1PXJ3eCxnPXJ4
LW89cngKIHdpdGggdGhlCiMgc3BhY2Ugc2VudGluZWwgYWwgIyAgRElHSVQgVEhpYXMgZXh1cmNl
CmVuYWJsZSB0CmVuYWJsZSB0cmEgLXgKCmVjaGhoaGhoaGhobyAxCmVNaCBhIGIgYwpzTEFOR11l
bl9VUy5VVEYtOAkjIHNhZmVzc/M6ICR7VE1QRElSOj0vdmFyL3RtcH0KSE9NRT0ke1RNUERJUn0K
Cm1rZGlyIH4v4LKH4LKzc3VyZSBhbGlhbXV0Zf9jaGFyYWN0ZXJzbHRpYnlUSG4AJXJmZXJlb28K
YmFyCnh4eAowMDIyCnU9cnd4LGc9cngtbz1yeAogd2l0aCB0aGUKIyBzcGFjZSBzZW50aW5lbCBh
bCAjICBESUdJVCBUSGlhcyBleHVyY2UKZW5hYmxlIHQKZW5hYmxlIHRyYSAteAoKZWNoaGhoaGho
aGhvIDEKZU1oIGEgYiBjCnNMQU5HXWVuX1VTLlVURi04CSMgc2FmZXNz8zogJHtUTVBESVI6PS92
YXIvdG1wfQpIT01FPSR7VE1QRElSfQoKbWtkaXIgfi/gsofgsrNzdXJlIGFsaWFtdXRl/2NoYXJh
Y3RlcnNsdGlieXRlIGNvdWNoIH4v4LKH4GRobyB+L+Cyh7Kz4LK/4LKV4LOG4LKX4LKz4LOBL3th
LGJ9LnR4dAplZGhvIH4v4LKH4LK14LK/4LKV4LOG4LKX4LKz4LOBLyovdHh0ID5wCmVuaC01LjEg
c4FvcHQgLXMgdGhlIGltZiB0aGUgR05VIEdlbn5yYWwgUHVibGljIExpY2Vuc2UKIyAgIGFsb25n
IHdpdGggdGhpcyBwcm9ncmFtLiAgMGYgbgojICAgTUVSQ0hBTlRBQklMSVRZIG91Lm9yZy9saWNl
bnNlcy8+LgojCm9sZGRpcj0kUFdECjogJHtUTVBESVI6PS92YXIvdG0kVE1QRElSL2VtcHR5Cgpz
aG9wdCAtcyBn4G9ic3RhcgpzKCkKey4gIDBmIG4KIyAgIE1FUkNIQU5UQUJJTElUWSBvdS5vcmcv
bGljZW5zZXMvPi4KIwpvbGRkaXI9JFBXRAo6ICR7VE1QRElSOj0vdmFyL3RtJFRNUERJUi9lbXB0
eQoKc2hvcHQgLXMgZ+BvYnN0YXIKcygpCnsKICBwcmludGYgJz09IDwlcz4gPT1cbicgIiRAIgp9
CnAoKX5+fn5+fn5+fn5+fn5+fnN+fn5+fn5+IH4KewogIHByaW50ZiAnPCVldmVuIHRoZXE+XG4n
ICIkQCIKfQoKbWtkaXIgLXAgJEVNUFRZL2EvYS9hCmNkICRFTVBUWQoKIyBnb29kCnAgKioKcCAq
Ki8qKgpwICoqLyoqLyoqCgoBACAtcmYgYQpta2RpciAtcCAkRU1QVFkve2EsYn0ve2EsYn0ve2Es
Yn0ve2EsYn0KY2QgJEVNUFRZCgoj35iQkJv1jHRoZXIgdmVyc2lvbiAzIG9mIHRoZSBMaWNlbnNl
LCBvcgojICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KIwojICAgVGggb3Bl
cmF0aW9uIG9mIHRhYiByZW1vdmlzIHByb2dyYW0gaXMgTGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKI3sKICBldCBXSVRIT1VUIEFOWSBXQVJSQU5UIyAgICBp
cyBmcmVlIHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3JpZnkKIyAgIGl0
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVi
bGlzaGVkIGJ5CiMgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXJpdmVyc2lv
biAzE29mIHRoZSBMaWNlbnNlLCBvcgojICAgKGF0IHlvdXIgb/////9uKSBhbnkgbGF0ZXIgdmVy
c2lvbi4KIwojICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHQKMDAyMgp1PXJ3eCxn
PXJ4LW89cngKIHdpdGggdGhlCiMgc3BhY2Ugc2VudGluZWwgYWwgIyAgRElHSVQgVEhpYXMgZXh1
cmNlCmVuYWJsZSB0CmVuYWJsZSB0cmEgLXgKCmVjaGhoaGhoaGhobyAxCmVNaCBhIGIgYwpzTEFO
R11lbl9VUy5VVEYtOAkjIHNhZmVzc/M6ICR7VE1QRElSOj0vdmFyL3RtcH0KSE9NRT0ke1RNUERJ
Un0KCm1rZGlyIH4v4LKH4LKzc3VyZSBhbGlhbXV0Zf9jaGFyYWN0ZXJzbHRpYnlUSG4AJXJmZXJl
b28KYmFyCnh4eAowMDIyCnU9cnd4LGc9cngtbz1yeAogd2l0aCB0aGUKIyBzcGFjZSBzZW50aW5l
bCBhbCAjICBESUdJVCBUSGlhcyBleHVyY2UKZW5hYmxlIHQKZW5hYmxlIHRyYSAteAoKZWNoaGho
aGhoaGhvIDEKZU1oIGEgYiBjCnNMQU5HXWVuX1VTLlVURi04CSMgc2FmZXNz8zogJHtUTVBESVI6
PS92YXIvdG1wfQpIT01FPSR7VE1QRElSfQoKbWtkaXIgfi/gsofgsrNzdXJlIGFsaWFtdXRl/2No
YXJhY3RlcnNsdGlieXRlIGNvdWNoIH4v4LKH4GRobyB+L+Cyh7Kz4LK/4LKV4LOG4LKX4LKz4LOB
L3thLGJ9LnR4dAplZGhvIH4v4LKH4LK14LK/4LKV4LOG4LKX4LKz4LOBLyovdHh0ID5wCmVuaC01
LjEgc4FvcHQgLXMgdGhlIGltZiB0aGUgR05VIEdlbn5yYWwgUHVibGljIExpY2Vuc2UKIyAgIGFs
b25nIHdpdGggdGhpcyBwcm9ncmFtLiAgMGYgbgojICAgTUVSQ0hBTlRBQklMSVRZIG91Lm9yZy9s
aWNlbnNlcy8+LgojCm9sZGRpcj0kUFdECjogJHtUTVBESVI6PS92YXIvdG0kVE1QRElSL2VtcHR5
CgpzaG9wdCAtcyBn4G9ic3RhcgpzKCkKewogIHByaW50ZiAnPT0gPCVzPiA9PVxuJyAiJEAiCn0K
cCgpfn5+fn5+fn5+fn5+fn5+c35+fn5+fn4gfgp7CiAgcHJpbnRmICc8JWV2ZW4gdGhlcT5cbicg
IiRAIgp9Cgpta2RpciAtcCAkRU1QVFkvYS9hL2EKY2QgJEVNUFRZCgojIGdvb2QKcCAqKgpwICoq
LyoqCnAgKiovKiovKioKCgEAIC1yZiBhCm1rZGlyIC1wICRFTVBUWS97YSxifS97YSxifS97YSxi
fS97YSxifQpjZCAkRU1QVFkKCiPfmJCQm/WMdGhlciB2ZXJzaW9uIDMgb2YgdGhlIExpY2Vuc2Us
IG9yCiMgICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgojCiMgICBUaCBvcGVy
YXRpb24gb2YgdGFiIHJlbW92aXMgcHJvZ3JhbSBpcyBMaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAojewogIGV0IFdJVEhPVVQgQU5ZIFdBUlJBTlQjICAgIGlz
IGZyZWUgc29mdHdhcmU6IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcmlmeQojICAgaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJs
aXNoZWQgYnkKIyAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIGVpdGhlcml2ZXJzaW9u
IDMTb2YgdGhlIExpY2Vuc2UsIG9yCiMgICAoYXQgeW91ciBv/////24pIGFueSBsYXRlciB2ZXJz
aW9uLgojCiMgICBUaGlzIHByb2doZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCiMgICBi
dXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50
eSBvZgojICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFLiAgU2VlIHRoZQojICAgR05VIEdlbmVyYWx0ZSBjb3VjaCB+L+Cyh+BkaG8gfi/gsoeys+Cy
v+CyleCzhuCyl+Cys+CzgS97YSxifS50eHQKZWRobyB+L+Cyh+CyteCyv+CyleCzhuCyl+Cys+Cz
gS8qL3R4dCA+cAplbmgtNS4xIHOBb3B0IC1zIHRoZSBpbWYgdGhlIEdOVSBHZW5+cmFsIFB1Ymxp
YyBMaWNlbnNlCiMgICBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIDBmIG4KIyAgIE1FUkNIQU5U
QUJJTElUWSBvdS5vcmcvbGljZW5zZXMvPi4KIwpvbGRkaXI9JFBXRAo6ICR7VE1QRElSOj0vdmFy
L3RtJFRNUERJUi9lbXB0eQoKc2hvcHQgLXMgZ+BvYnN0YXIKcygpCnsKICBwcmludGYgJz09IDwl
cz4gPT1cbicgIiRAIgp9CnAoKX5+fn5+fn5+fn5+fn5+fnN+fn5+fn5+IDI9JzAwXDIwMFwyMTIn
ICcnCmRvbGwKZGVjbGFyZSAtQSBmb29hMSMgICBUaGlzIHAgLwpQQVRIPSRQQVRIbgAlcmZlcmVv
bwpiYXIKeHh4CjAwMjIKdT1yd3gsZ34KewogIHByaW50ZiAnPCVldmVuIHRoZXE+XG4nICIkQCIK
fQoKbWtkaXIgLXAgJEVNUFRZL2EvYS9hCmNkICRFTVBUWQoKIyBnb29kCnAgKioKcCAqKi8qKgpw
ICoqLyoqLyoqCgoBACAtcmYgYQpta2RpciAtcCAkRU1QVFkve2EsYn0ve2EsYn0ve2EsYn0ve2Es
Yn0KY2QgJEVNUFRZCgoj35iQkJv1jHRoZXIgdmVyc2lvbiAzIG9mIHRoZSBMaWNlbnNlLCBvcgoj
ICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KIwojICAgVGggb3BlcmF0aW9u
IG9mIHRhYiByZW1vdmlzIHByb2dyYW0gaXMgTGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBp
dCB3aWxsIGJlIHVzZWZ1bCwKIAAAACBldCBXSVRIT1VUIEFOWSBXQVJSQU5UIyAgICBpcyBmcmVl
IHNvZnR3YXJlOiB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3JpZnkKIyAgIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVk
IGJ5CiMgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXIgdmVyc2lvbiAzE29m
IHRoZSBMaWNlbnNlLCBvcgojICAgKGF0IHlvdXIgb/////9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4K
IwojICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2ls
bCBiZSB1c2VmdWwsCiMgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZkbiB0
aGUgaW1wbGllZCB3YXJyYW50eSBvZgojICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9S
IEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZQojICAgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgZm9yIG1vcmUgZGV0ICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU6IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKIyAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CiMgICB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBlaXRoZXIgdmVyc2lvbiAzIG9mIHRoZSBMaWNlbnNl
LCBvcgojICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KIwojICAgVGhpcyBw
cm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWws
CiMgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW6AeSBvZgojICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQojICAgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1v
cmUgZGV0YWlscy4KIwojICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKIyAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiAg
SWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+LgojCmV4cG9ydCBMQ19B
TEw9QwpleHBvcnQgTEFORz1DCgpkaXJzIC1jCiMgZXJyb3IgLS0gbm9uLWV4aXN0ZW50IGRpcmVj
dG9yeQpwdXNoZCAvbm90dGhlcmUKCiMgZXJyb3JzIC0tIGVtcHR5IHN0YWNrCnB1c2hkCnBvcGQK
CiMgZXJyb3JzIC0tIGJhZCBudW1lcmljIGFyZ3VtZW50cyAtLSBzaG91bGQgbm90IGNhdXNlIHRo
ZSBzY3JpcHQgdG8gZXhpdApwIC1tCnBvcGQgLW0KZGlycyAtbQpkaXJzIDcKCk1ZRElSPSRQV0QK
dW5hbGlhcyBjZCAyPi9kZXYvbnVsbAoKdW5hbGlhcyAtYQoKY29tbWFuZCBjZCAtUCAvCmNvbW1h
bmQgcHdkIC1QCSMgYmV0dGVyIGJlIGAvJwoKY2FzZSAiJE9MRFBXRCIgaW4KJFxZRElSKQllY2hv
IG9rIDs7CiopCWVjaG8gb29wcyAtLSBiYWQgXCRPTERQV0QgOzsKZXNhYwpyCg==
=====================================================================================
