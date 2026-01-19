Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFD2C11DE
	for <dash@vger.kernel.org>; Mon, 19 Jan 2026 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843584; cv=pass; b=tPaX6RZ6zEarsQFzQkssnHsA8rqKdS4tM5NmkE6x67IwhkZ6utKwz9baUHvDtZtowScJBWzGzJXWBpiO+W7nHgAT7D0kRjtEE6QyT/2zeDkZa+MmDfhnjCsmEXUcsB4hHd4xzMNBQ1gewqIz2MXeFWa+sXdpnp4pQTD1WCOHT78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843584; c=relaxed/simple;
	bh=cPruqxJUECJAS91VBxhwckO4Az6NVHeEYC5c9vQrDvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DFBw43PMtMdcsD2lkoRoxNfISuGpFi/cXIoQJjAqsrRNnZnWA4MnANl4y8xdRYvhB0MOilMCjHG8HXGcB6aszfZ56/xGd0knsu6iwxNOG72F6Ai+rwGrd7YgqSDbH3pCUtTX8R2/98nJMIgVg3xnv41xvgujoWZlMdq7eWxZhyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1j1YIcx; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1j1YIcx"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6420c08f886so5888529d50.3
        for <dash@vger.kernel.org>; Mon, 19 Jan 2026 09:26:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768843582; cv=none;
        d=google.com; s=arc-20240605;
        b=V7SOAxm5LnNXAVmZZzMGUxTnSJkehWmYo4adluSE/IdlsqWaqnG8PSxBIakr2Iyw3Z
         NWjjWtWPcd9hgGQTsDLeRHSzzu9qtrTBVhoLXYyJ8jnXEUTnBOy3qpR+R2vB7kAQqXVe
         Dt8qIXaVBDlSLrKEfmJBheOpqGgSLFO1Via3lfHJTiSG/QFritTrPist5aNTCQRR01l8
         +BbqUepuJOAjwUdLs92ZSYX/RvyzXLjSwcRvYRLAoPPqqp96rbSA6ORo0WouYkDJKrsj
         PiL+xp2t7QnS/gpA7p+Zr8+A1q1XMJuDWl7CZUp37LU6V51FebU8m6UCQcNpcO+lKQSd
         B4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aF97hJ0NxCDTTDrCCPTTw4japEoftUSZAtmS5kqGE8=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=EDdwW1U6TC7vk2UcDVz+d8wrI5OM/rtHasK+Qjtl4Esqgs1nHfykndE6EwVB1MOOuK
         n+RFdt69WjCs4F8yteL4Q0Osxt7uZFp0m7dT7NIttRhgPRecmUDwbd372sKiXxi46VG/
         dMnxMjnC5LaQQ/Uoff2m4wghvrllpygEkNJdgPiSGOewjdjLiawZJJaikSjdfPEHsaRa
         tGCKY6kxmXFZsSFdfq4FoVHX37jsCPNnAFAfIVdr2xUFs4j0aLrLzd33ObY8FoR1fPWu
         XN+NoA/m5p22pIe1z7QYOLXwcLfqG7oF7/gIBU2e09Q45jHtAxnqbSp2zb5AAHGJRtsq
         xjVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768843582; x=1769448382; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aF97hJ0NxCDTTDrCCPTTw4japEoftUSZAtmS5kqGE8=;
        b=j1j1YIcxJkN2Gdlvo4/oIQXnnJfNM37By/5Cn6Jjp7SQJmLKQjR1q7VyS2DoUVvjrT
         fQlPqQNgwqOS5AbOBwh+c5X8TZLABW97cdnzrsWgTii3eq6xuLucIRfM5afJY0M4A/Eq
         GeNZYu7zk966YSews6Z3syi+J3lFPNmfiDL/tdZ7jofJOOMw/teYwGGKFDeujh4s0CJn
         q//MyaxyuH/jB7WEji+jxTpIox9FXX33e7CuExaVIAPAA7cToQY8g2G3w9A3Z2Op3twh
         eiEE2hPW+pt2IdljLFnKMCXUTvN4sj7JH+W8OaGZ/Er3T6OXy2kJQKzBZ1kVYQO2Rg57
         H8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768843582; x=1769448382;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aF97hJ0NxCDTTDrCCPTTw4japEoftUSZAtmS5kqGE8=;
        b=WoJBCrlwsV0rcXBsI2LUjgh+S+c/+tHptwnhTD8AO7YOJpS+tdhpCg8ugABScq/mpg
         S1IhBD4allj3XqBhnd1+mr/WfQDpd6pGeHRd0K73T/UwzelSe1vk7MBTA0ERJBX0KT9z
         1XvfE+hZ6oPWPalIdp/N9zNJA3wNaQUsnrcH3nazl+BDsdd30xMrr3917/jG0zMjPsIj
         ml0H+EckXLmu9HiW7L1h9srCLEU3/OCkmnyTAVkQuDOS457eox7rUg3/Gut6vNtwLZCt
         n4X5i+ZHEmkjT2kJv7ZEtyzfDOAdPIiTopxU53W3mYDqpojU9hisQaJhyDEdc2qYN/t7
         lI/Q==
X-Gm-Message-State: AOJu0YzkN7kh/vJNNtIvcJdSN9/2qJznrARA8vHPa6agwEDEiA0vzP30
	BiMuSY7W2YCkeck6pFUSjftAMMQGFNz5kPpp8mgEkGweweGpIjDUVEQbVjCTv7tsdM4fB3b2ed7
	+s2JQ6frJODFRBHL9DrBMh9gzYTd9ekzgAiUpy6Y=
X-Gm-Gg: AZuq6aIagtPvfL+sLxYJcReEAoggzhcAtv003rXWupeusEN8qX/DwNF2rrWAdHec9it
	BXIJhhRMd/Ysl4nEcMlH7XMEE9CtGW4nF7pAHZqY5ngMLKeHIU2GdpZlxoHAPDEg9BF883uJCLf
	GX/RuKQ/pIjL2BVYNK8d5Y3fZTun9ariXHtofibmulCQevX49Zg4QA/tbwqGWKaSV5NMK7MHqoC
	QOyYWx6kRLURtbBvASIjo12lXAKOgz4F38EuGJ6x4lzyOnrPdhUVLqvL5QVp8gxTIPrKAIpczZL
	FrMgExxm3MK3f35tCH7csIkENQ6koD3mhdol
X-Received: by 2002:a05:690e:4101:b0:648:f591:fd70 with SMTP id
 956f58d0204a3-64917736b6dmr8010667d50.73.1768843581779; Mon, 19 Jan 2026
 09:26:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADdNFavDzUUfEUDpXBTdrSOXxxOZvbcb+sXHcCcGx3bKLasteQ@mail.gmail.com>
In-Reply-To: <CADdNFavDzUUfEUDpXBTdrSOXxxOZvbcb+sXHcCcGx3bKLasteQ@mail.gmail.com>
From: Aleksander Ushakov <retes672@gmail.com>
Date: Mon, 19 Jan 2026 20:26:08 +0300
X-Gm-Features: AZwV_Qh9wbcMKnnuUjBpOhil_FpPtQEUw_ud5kBjBXiKmWOND6jXOOjrxSF_q_8
Message-ID: <CADdNFauHj_tYhNzD1pr7j1OSVYK8u0T1aKyrc9PibhKd-9JCaA@mail.gmail.com>
Subject: Re: [BUG] heap-buffer-overflow(read) pmatch() src/expand.c:1630:18
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's fixed here: 4595bd6549344c90ce7e8e90f1034cec724884db

=D0=BF=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2026=E2=80=AF=D0=B3. =D0=B2 22:16, Ale=
ksander Ushakov <retes672@gmail.com>:
>
> Dear Dash maintainers,
>
> I encountered a bug in Dash in commit f8aaaa and would like to report
> it. The details are provided below.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D4318=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address =
0x5030000003e3 at pc 0x652f51dd63bf bp 0x7ffd65724250 sp 0x7ffd65724248
> READ of size 1 at 0x5030000003e3 thread T0
>     #0 0x652f51dd63be in pmatch /upstream/dash/src/expand.c:1630:18
>     #1 0x652f51dd74d8 in expmeta /upstream/dash/src/expand.c:1391:7
>     #2 0x652f51dd1cc1 in expandmeta /upstream/dash/src/expand.c:1271:3
>     #3 0x652f51dd0c2c in expandarg /upstream/dash/src/expand.c:206:3
>     #4 0x652f51dc866b in evalcommand /upstream/dash/src/eval.c:806:4
>     #5 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
>     #6 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
>     #7 0x652f51de1dd2 in cmdloop /upstream/dash/src/main.c:242:8
>     #8 0x652f51de19de in main /upstream/dash/src/main.c:176:3
>     #9 0x74bc543e8249 in __libc_start_call_main csu/../sysdeps/nptl/libc_=
start_call_main.h:58:16
>     #10 0x74bc543e8304 in __libc_start_main csu/../csu/libc-start.c:360:3
>     #11 0x652f51ce3530 in _start (/upstream/dash/src/dash+0x38530) (Build=
Id: 7f6a58087379909d6c654473930c3998f14e8e99)
>
> 0x5030000003e3 is located 0 bytes after 19-byte region [0x5030000003d0,0x=
5030000003e3)
> allocated by thread T0 here:
>     #0 0x652f51d827cf in malloc (/upstream/dash/src/dash+0xd77cf) (BuildI=
d: 7f6a58087379909d6c654473930c3998f14e8e99)
>     #1 0x652f51de24d4 in ckmalloc /upstream/dash/src/memalloc.c:55:6
>     #2 0x652f51dd2a8a in _rmescapes /upstream/dash/src/expand.c:1687:8
>     #3 0x652f51dd55e3 in preglob /upstream/dash/src/expand.c:151:9
>     #4 0x652f51dd1c81 in expandmeta /upstream/dash/src/expand.c:1266:7
>     #5 0x652f51dd0c2c in expandarg /upstream/dash/src/expand.c:206:3
>     #6 0x652f51dc866b in evalcommand /upstream/dash/src/eval.c:806:4
>     #7 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
>     #8 0x652f51dc7855 in evaltree /upstream/dash/src/eval.c:299:12
>     #9 0x652f51de1dd2 in cmdloop /upstream/dash/src/main.c:242:8
>     #10 0x652f51de19de in main /upstream/dash/src/main.c:176:3
>     #11 0x74bc543e8249 in __libc_start_call_main csu/../sysdeps/nptl/libc=
_start_call_main.h:58:16
>
> SUMMARY: AddressSanitizer: heap-buffer-overflow /upstream/dash/src/expand=
.c:1630:18 in pmatch
> Shadow bytes around the buggy address:
>   0x503000000100: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00
>   0x503000000180: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00
>   0x503000000200: 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa
>   0x503000000280: 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00 00 00
>   0x503000000300: fa fa 00 00 00 00 fa fa 00 00 00 00 fa fa 00 00
> =3D>0x503000000380: 00 00 fa fa 00 00 03 fa fa fa 00 00[03]fa fa fa
>   0x503000000400: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x503000000480: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x503000000500: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x503000000580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x503000000600: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
> =3D=3D4318=3D=3DABORTING
>
> ////////////////
> Place in code
> ////////////////
>                                         if (chr =3D=3D c)
>                                                 found =3D 1;
>                                 }
>                  ---->} while ((c =3D *p++) !=3D ']');
>                         if (found =3D=3D invert)
>                                 return 0;
>                         q++;
>
>
> ////////////////
> My environment:
> ////////////////
>
> Debian-12, x86-64, clang-19 compiler
>
> /////////////////
> Steps to reproduce:
> /////////////////
>
> $ aclocal && autoheader && automake --add-missing && autoconf
> $ CC=3Dclang CFLAGS=3D" -Wno-everything -fsanitize=3Daddress -g -O0" ./co=
nfigure --disable-fnmatch --disable-lineno --disable-glob
> $ make
> $ cd src
> $ ./dash < myfile.txt
>
> //////////////////
> Steps to get myfile.txt:
> //////////////////
>
> copy the text into file bs64.txt (between =3D=3D=3D=3D and =3D=3D=3D=3D=
=3D=3D):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PkA3OyRCLWdlIFuFaZs/PwJlc3Nzc3Nzc3Mt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Or just take from attachments:
>
