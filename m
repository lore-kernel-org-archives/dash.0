Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D64086A
	for <dash@vger.kernel.org>; Sat,  7 Feb 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770491033; cv=pass; b=S1Ei+QwFs3LIE++NsqpEd3oz6VNE6/UIgE8ifJ02dYMR82TmmfvExarKIWpd+wFijZMrnCrV/WTEnuOodJLlGRX0ZZqm5mVBS4XcVcbcW5IewbLDi92eZ0GGrLXWFxc2p0piBCaYXQbAB0TrwS9KzCdNbMdZp6AwLri8zU1TiQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770491033; c=relaxed/simple;
	bh=4giJ1AqwyCVfqtoqKhBdPY0QtQJOSpvOgzmTfh/oW1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghKDwAhuCfuVWe0HUMLe7cR+1UEWzk2SBkaujDHro21EcaKBmOfWCcpZxMpgMIJiUvWZXiiYlmaas3XZ7b0xLiR71b4sngTjK81gRzCQ07z6ZPjjoSaZIf68jzmZaLzgHRQIM0ndLlUYIPAt9nWRJfzvbQiNTm6Dhe3ErGl3rVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lahteenmaki.net; spf=pass smtp.mailfrom=lahteenmaki.net; dkim=pass (1024-bit key) header.d=lahteenmaki.net header.i=@lahteenmaki.net header.b=MFcjoWFE; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lahteenmaki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lahteenmaki.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lahteenmaki.net header.i=@lahteenmaki.net header.b="MFcjoWFE"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a367a1dbbso33507516d6.0
        for <dash@vger.kernel.org>; Sat, 07 Feb 2026 11:03:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770491032; cv=none;
        d=google.com; s=arc-20240605;
        b=B9taydGy0Uk/LphVwNuK25njWFrngd+uCtte8rXPVbQ12oYInLGYWGPc+3VJhHnAe4
         xKpJAyAe0RmNBSKS8AVpVUvOD0rq0SLRr+80o+xjxlLlRbEe+pKEzSivWulf2cayoxXS
         GdcSSjj8ha4XNU9jLG9KXm9jsg4vKyqYmuullGGQnXZjuZxjUx/A1Hw3S4nnMdxGcPfp
         YmYVNg+9eNEY3Dgtyj0+osTE3maKit010lL4dhXzqu8zA89afSVt9jv0yEPKtygnRvFS
         OXnb1CgEyqs8sg4W7Ae3mTyIdQzxsS7zKTu+wGbS6omxAEvZb4C+HqwUq1WWQDlSWeju
         icag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4giJ1AqwyCVfqtoqKhBdPY0QtQJOSpvOgzmTfh/oW1Y=;
        fh=x4uP82BJkIsL4XiJCZauYgDyRPWbmOdfzrsTMXIC1gQ=;
        b=XMDRiZRXckJQlB73voEth3fc46xwCFv8tBJ7NReZv41caf5N08ltBChWYZX7+zqyXD
         bTFT0ziri/AOTsV9OWhq5pRQGM9COs9zy+VmhS329ARkU247QKjYAYAbCaeLsZb1d8yG
         0x2OQ/1o9zBCwJDZoX9DiPvfr6zNpnFtMcdfm5AUkSs7nN35Wi7hkr76Xsh/SeDmKN0q
         fWuL2DIDYHgdv/oI4YH4dSGLJA8hyARk2O2lPrzRmntzu46SNeq9ZG528OqeepHXxvMb
         FBaos1pdcPtLuqyX+Q0pfwm+OlEyL/eXoRTjbWflEOx88t7gRgRCwJYNOk7HC+DjmYgr
         R6sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lahteenmaki.net; s=google; t=1770491032; x=1771095832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4giJ1AqwyCVfqtoqKhBdPY0QtQJOSpvOgzmTfh/oW1Y=;
        b=MFcjoWFEqB82FLpwE6NE0ahC3Q6dLKvtdoxfqqsG5y011GOfhVgCSyCgjrCcZjoQq7
         0hO4ydIJNELO4eHTNY7clE6zmaa3CgqhU8eN7nlntCCIqIpC5/G/hVDyMayVJO2F169i
         +8KQJR6cMZC0FDUqSkvIPic+WDn86QEotDNB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770491032; x=1771095832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4giJ1AqwyCVfqtoqKhBdPY0QtQJOSpvOgzmTfh/oW1Y=;
        b=UElIJDAJlKMkixDsXfETj9LYjkcrV0BhRCp5VuAfSJZ21Bms49HMl5q+SUefwtS0dR
         ZKxhMTBxQ6bXvQ+9AVu4tdQ447G/JFjYBUvrNUzSHG6SwP/BIaRC6CdKvE/lO8Jy1307
         t+P+AfSsX/yqNhsBj9EjYf1dkUWVEVxji6WY8U6ePPK3XIpA8I8IDW6zbtzkyAlu4oLH
         wI2rR1t3h22lSRaHqxrFPayB6KDOfbV05Vg9/0w4KkMg/F3WheKuN3dR/OaDvGyb9Z9Y
         PK2l9ZJylLCqSQesx1oKQ5pW8Gp26P6MAckeubh1PBdpqFBxVl6bUSf7aFV9pIVFfqau
         zTkA==
X-Gm-Message-State: AOJu0YxvcwQQPlVxXonTB46n3gHmUcw5uEWVDJmJTuaFjHBYPrQSSPD+
	EWXC/FKgBj04H+AcKYdRb09eWsMQSTQpoqUA59UClp94mWMdNc76LpVJiVtEVPQvWNoWFyt0qsn
	QSyI2Cm5tvT8ADs5/NxSSB70qDxJ5nmdA9cUa+72wQw==
X-Gm-Gg: AZuq6aJK47C7fiEFMjGVYPyaA3fcDut5X253Uu4eAttroXr66XO3CK88J+3jk1Xzpc7
	plrnKAQIskFb2YRx7BblBcwYWjWWuSGdQiCsBf/E10QaJSkjvZIP5qpINwCkGOpCDlLWWCYRF6Y
	3Wk5gNZg3IklNgQYJ1Utiz8q3D/o6cx0GyuZV2wHyGbCbTFQGvevYlTeTOoNsL+jF8cuBeladzY
	DZi3i68TezScwxgrr7xyPuSoSJwww3ACI05gH82zHWJAJLZUb96aiDJ4+gGNjpTGTM8DwNvX2F0
	CsOmy0Y=
X-Received: by 2002:a05:622a:1193:b0:501:5284:c49b with SMTP id
 d75a77b69052e-50639942fc2mr83314201cf.39.1770491031979; Sat, 07 Feb 2026
 11:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANhYXO-M=zNN3XDN9V3O2XaOvA=3wc1vkogSfyRUWhVCP9_iGA@mail.gmail.com>
 <aYMOgmK_puMi2J3N@gondor.apana.org.au>
In-Reply-To: <aYMOgmK_puMi2J3N@gondor.apana.org.au>
From: =?UTF-8?B?SnlyaS1NYXR0aSBMw6RodGVlbm3DpGtp?= <jyri-matti@lahteenmaki.net>
Date: Sat, 7 Feb 2026 21:03:16 +0200
X-Gm-Features: AZwV_QjGrzd6Qv73Ri_pfYjfGXvHKlzM0FqfwtFmhmHnI0tVI7aXY2L-7Tqsgdo
Message-ID: <CANhYXO9A5Y=TJi-TbEvv3ASPFjPjdd+pEfhmjqeMMXOCEoCpzw@mail.gmail.com>
Subject: Re: Fwd: Behavior change in Dash pipes/read?
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

already tried that but it didn't work. I'm guessing strace-macos
doesn't pass stdin to the spawned process.
Figured I could try attach-to-process approach, are these of any help?

> cat test.sh
echo $$
sleep 10
read -r x
echo "$x"

> echo hello | /nix/store/4kjsgkcxqfadycyspzfrf9gg5n5bpc27-dash-0.5.12/bin/=
dash ./test.sh
8914
> strace -p 8914
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
read(0, "h", 1) =3D 1
read(0, "e", 1) =3D 1
read(0, "l", 1) =3D 1
read(0, "l", 1) =3D 1
read(0, "o", 1) =3D 1
read(0, "\n", 1) =3D 1
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
write(1, "hello\n", 6) =3D 6
read(10, "echo $$\nsleep 10\nread -r x\necho ...", 1024) =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0

echo hello | /nix/store/kra243nir1p3pyc50312w3nmirbcbxr0-dash-0.5.13.1/bin/=
dash
./test.sh
8931
> strace -p 8931
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
ioctl(0, TIOCGETA, 0x100498498) =3D -1 EPERM (Operation not permitted)
lseek(0, 0, SEEK_CUR) =3D -1 EPERM (Operation not permitted)
pipe() =3D 0
fcntl(3, F_DUPFD_CLOEXEC, 10) =3D 11
close(3) =3D 0
fcntl(4, F_DUPFD_CLOEXEC, 10) =3D 12
close(4) =3D 0
read(0, "h", 1) =3D 1
read(0, "e", 1) =3D 1
read(0, "l", 1) =3D 1
read(0, "l", 1) =3D 1
read(0, "o", 1) =3D 1
read(0, "\n", 1) =3D 1
read(0, "\n", 1) =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
write(1, "\n", 1) =3D 1
read(10, "\nread -r x\necho \"$x\"\n\0\0\0\0\0\0\0\0\0\0\0...", 1024) =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0
sigprocmask(SIG_BLOCK, 0x0, "[]") =3D 0

--- Jyri-Matti L=C3=A4hteenm=C3=A4ki

ke 4.2.2026 klo 11.16 Herbert Xu (herbert@gondor.apana.org.au) kirjoitti:
>
> Jyri-Matti L=C3=A4hteenm=C3=A4ki <jyri-matti@lahteenmaki.net> wrote:
> >
> > The results are as attachments. But
> > https://github.com/Mic92/strace-macos says it doesn't follow forks, so
> > I guess the interesting parts are missing?
> > Running /nix/store/wy9ass74g4yc1x354ydbdlxkfkxxjv2x-dash-0.5.13.1/bin/d=
ash
> > -c 'echo hello > hello; { read -r x; echo "$x"; } < hello' seems to
> > work correctly.
>
> OK try running strace inside the script:
>
> echo hello | strace /path/to/dash -c 'read -r x; echo "$x"'
>
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
