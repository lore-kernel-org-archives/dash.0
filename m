Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB33A1D2
	for <dash@vger.kernel.org>; Fri, 26 Sep 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903320; cv=none; b=pJOodHozzDAu5HQhRoD6ymXJOHh0k2G3ZdsqqLNVD5raYpEoxIbAWk/FSwmjuFOfBLvyy4XPayu3WDtc6IWWjc9tCTqL6fQJfr9jjsqK1TrlhX8BcAjCt34iMtuXy5FOYXXdWVq9Y8qzBMlL5qstsIQ9SSrFaWF1npDHz5hI/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903320; c=relaxed/simple;
	bh=65jNP74IrpQfLPwaS9dLYXe+HucT/zz1dMfaB2IPx/Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OXH7LEs7GgPs2BZ6EsfmqoKWLsBREIdjmtGzaxcvgyZcyopUd3gbLYt+wcYxwfAgaPrbRYsG1D1AmG7RFadpWKaTNKsqV2iPga6f6LalhH+THYSY5Ts6L3/AqOQWnH2SV9kkix0OQ0fX7cBZxr1WwePmRTQIXzv50NdFrvTmAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com; spf=pass smtp.mailfrom=reillybrogan.com; dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b=JSmREb5T; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b="JSmREb5T"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b7a8ceace8so23873411cf.3
        for <dash@vger.kernel.org>; Fri, 26 Sep 2025 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reillybrogan.com; s=google; t=1758903317; x=1759508117; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdmAQbeGr3Fe6YzkjmU4HvlcGiF8bfnrOXt+XLU6we0=;
        b=JSmREb5T8VMt7Ef2V3lZEkexE+X58FgTTFWL+0ex1nuI1Sw6KO7L+L1ReDkfieHz6Z
         Yo+BNQgYa+oA+bsICSEm7tlniIN2UcBFmF490Bg5E4wJ9tC1g45iBI4ZYEJrVfkTRYyy
         X3vhAnAdC5vhCfRLNhixF54R5aYCISW5w5rHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903317; x=1759508117;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdmAQbeGr3Fe6YzkjmU4HvlcGiF8bfnrOXt+XLU6we0=;
        b=DA+m5Z2+a4GAxbvNCFJfjwVMX08UrGNNLY1xphWOfUYvNsSkFfN2MNsFMAOGmGKzqf
         +YiPNrpl8ljVAjAUlNgyuPr3yZuJRPe0WEUk8zwKgN3GTARBOnpbz8ilDAh5DKEC3EjS
         d0Z6Lv6zHYIUVIJzm1/CYvSYRNbQIuhoHFz7R9+A1tSSAxOuZHe0+no4dfnx3mojQX+i
         DWFMkdVGlO4ACGLrARAzlUS0iV1bXI0i0SiG/HDmQkj1cNFdUfY32cF08lJeBpJVQtrE
         CBTGbAVXSnv3w7KzqGxR0W2sPPI4BYL0YSiwYgVIPJ//CLHm7UNTlgTFHmrnTmjg9FXK
         divA==
X-Gm-Message-State: AOJu0YzDZELo7SvNXMzORooYMOa4GN5f3eBmUWCThstvxgXGRUejZlYi
	3gAxTSg8mDRC5y5aNTrdofHFYuxlIP0qsrFoOIjReL9Z/kRdo2oN+CUXKVZjnUXtceppaCleCRE
	1yWdrMHA=
X-Gm-Gg: ASbGncujB5/UoiWN2mTGXMsqwEvnGJeyse23gf6eNWwKV+07qGoV4fuF9xrlKqXWa7t
	N/U/xKdncCYmHqm5hi8oPQyRowDFU2CV+ID8sx/E5oC4J68LJ8+IuaWxd5ug3dvTeSvBRRND9H4
	EEVU8c00qlixCIoql5h5fVvdbzP9F/aDGRGT9DzCFUDLxX59P21WE3cLLd38YzBmcuKQadzFgvx
	fvO3gjy4acncoFZXI1DzjY7ROvqe1uD0RDdBvAfQ3nNyI763/LB6uB0kF8uv5OuuQfAEBsThdTh
	Nu6QnU2hziozNH0Ooz+zLpUTzHmy1eXqA2MAgVWEL4jr0rVTU9dLUmL+oCdXTFuEJDkPClpMTxp
	F16MkcKwPyQ6ZPRTqjtm2iYrDQzAFARdrCrx3+2SkbxxBi9+bPGMpB5eCOCfSWe4i372I
X-Google-Smtp-Source: AGHT+IEIOpXKSHKUHLpX2p6JuLMX24t22WRHe2wXQUk5X4n/Y6pjJZP7jyZ0kTgNd9BP+KKqA6dUCA==
X-Received: by 2002:a05:6214:cc7:b0:81c:ded8:7099 with SMTP id 6a1803df08f44-81cded874f8mr41243186d6.58.1758903316993;
        Fri, 26 Sep 2025 09:15:16 -0700 (PDT)
Received: from [192.168.1.241] (24-152-154-74.fttp.usinternet.com. [24.152.154.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80166e2f320sm28411596d6.37.2025.09.26.09.15.16
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 09:15:16 -0700 (PDT)
Message-ID: <d3a79537-be6a-4e5d-afe6-8b8d9dd57955@reillybrogan.com>
Date: Fri, 26 Sep 2025 11:15:15 -0500
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dash@vger.kernel.org
From: Reilly Brogan <reilly@reillybrogan.com>
Subject: bug: 0.5.13 regression (bisected)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi! I've gotten a new build failure with gcc 15 (using git source) with 
dash 0.5.13. This is unrelated to the previously reported regression as 
our 0.5.13 has the patch that was provided to fix that one.

This build fails during the configure step when the script is ran with 
dash as `/usr/bin/sh`

```

# ../configure --build=x86_64-aerynos-linux --host=x86_64-aerynos-linux 
--prefix=/usr --libdir=/usr/lib --libexecdir=/usr/lib --disable-libssp 
--enable-cet --enable-checking=release --enable-default-pie 
--enable-default-ssp --enable-gnu-indirect-function 
--enable-host-bind-now --enable-host-pie --enable-link-serialization 
--enable-linker-build-id --enable-multilib --enable-plugin 
--enable-shared --enable-threads=yes --with-arch=x86-64-v2 
--with-arch_32=x86-64-v2 
--with-bugurl=https://github.com/AerynOS/recipes/issues 
--with-build-config=bootstrap-O1 --with-gcc-major-version-only 
--with-gxx-libcxx-include-dir=/usr/include/c++/v1 --with-isl 
--with-linker-hash-style=gnu --with-multilib-list=m32,m64 
--with-pkgversion=AerynOS --with-system-zlib --with-tune=ivybridge 
--with-tune_32=ivybridge --enable-bootstrap 
--enable-languages=c,c++,cobol,fortran,rust
checking build system type... x86_64-aerynos-linux-gnu
checking host system type... x86_64-aerynos-linux-gnu
checking target system type... x86_64-aerynos-linux-gnu
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln works... yes
checking whether ln -s works... yes
checking for a sed that does not truncate output... /usr/bin/sed
checking for gawk... gawk
checking for libatomic support... yes
checking for libitm support... yes
checking for libsanitizer support... yes
checking for libvtv support... yes
checking for libphobos support... yes
checking for libgcobol support... yes
checking for x86_64-aerynos-linux-gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for gcc option to accept ISO C99... none needed
checking whether we are using the GNU C++ compiler... yes
checking whether g++ accepts -g... yes
checking whether g++ accepts -static-libstdc++ -static-libgcc... no
checking for x86_64-aerynos-linux-gnatbind... no
checking for gnatbind... no
checking for x86_64-aerynos-linux-gnatmake... no
checking for gnatmake... no
checking whether compiler driver understands Ada and is recent enough... no
checking for x86_64-aerynos-linux-gdc... no
checking for gdc... no
checking whether the D compiler works... no
checking for cargo... cargo
checking how to compare bootstrapped objects... cmp --ignore-initial=16 
$$f1 $$f2
checking for objdir... .libs
checking for the correct version of gmp.h... yes
checking for the correct version of mpfr.h... yes
checking for the correct version of mpc.h... yes
checking for the correct version of the gmp/mpfr libraries... yes
checking for the correct version of the mpc libraries... yes
checking for isl 0.15 or later... yes
checking whether to enable libgdiagnostics... no
checking for library containing dlopen... none required
checking for library containing pthread_create... none required
../configure: 9961: .: cannot open ../gcc/cp/config-lang.in���M�U: No 
such file
```

I've bisected this failure to a9012f4078be32012f240c6208c3df53db3b6086, 
but unfortunately I'm not able to test 0.5.13 with that reverted as it 
has non-trivial merge conflicts (well, non-trivial to me at least).

Let me know if you have any further questions or troubleshooting steps 
you'd like me to try.

Regards,

Reilly

