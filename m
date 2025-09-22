Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CA1FDA89
	for <dash@vger.kernel.org>; Mon, 22 Sep 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569699; cv=none; b=AHKtSxcP44etu+3FEoDstzL1RJJYDRrdx2Hdb/O08k2uOXPXM05zhCd8GR5s2DW0BBzaBReWYl3ZoK5xTsZhJ8RqngpTfedoWojV3kKhqBelpVdGpsmTJRyfVI3DnZnAf53Vkl1/6sItjZFiGWQ9IDA55s9/XkoULIOXiplAGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569699; c=relaxed/simple;
	bh=PJVH+JgUOC8Bs9GUDh65Giee2Q3XJfbe8iJ4amlNnFE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=a4uosKfyZfY1M6GTS1aRQzSOodSjeN4lfUtqH+42HyyFGnFlFtlM/BJOQwRGirp3DJFtrns1VWGXefMYaL1h6wQWLKDW5fb5plM5Jt6lYud6I6phh0jyrMyBk6u7EL44+mcbCIL0Vboe3gIVHqRy6biXM6KTAyR9Tz5fKcepGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com; spf=none smtp.mailfrom=reillybrogan.com; dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b=B/ONC0hF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b="B/ONC0hF"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-77dd76f6964so56481466d6.1
        for <dash@vger.kernel.org>; Mon, 22 Sep 2025 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reillybrogan.com; s=google; t=1758569696; x=1759174496; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THcYjrUu6Tn11eVkd4EdOUJQwf89Yh3x5dIOhGBlHUk=;
        b=B/ONC0hFizfh2EVOOFb4AXrF3pl72CpQeScC97vk7XB+Rt5L2UyHJLBzYMiTF6Hsqg
         idT+5+mANRfx5dcBFsDWThZi6bZvek9ZFhHXQehhwS2cNjOCjHh71TnZabXXe2qz/uHN
         I0gPCdHMDlgMDIxJOVh/QklkA6zaoNtZ374HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569696; x=1759174496;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=THcYjrUu6Tn11eVkd4EdOUJQwf89Yh3x5dIOhGBlHUk=;
        b=WYgjXxXUsPKQsBAU7aigxN9kzzfg0DeLY4HEQT2JGjFVrV9TunPUwncwVdHOb6+4qF
         GKT+4nFTb4pEU1g+HHI88Xg1xGspbToliol+N28uh0sGAqanp2qJg5jpzXVnXvVaW395
         gLRUirynDRpAOVyEAR3Rw0eozlyvD8NtT3nvEB3GzlxVpsQGQRRHf84etAK9T5RiSaFI
         wXg/EdkSYq7t0QBcWKYW2bOPnA4s/VZ/HE+OS7uMNWn5YH++XyLqg5hueHuem85H7QTc
         b3WJfgSNJJZ6cOr35xQ2k8Ut75+QuedNXLKIIy0MgpG0vpukFd8DPl34ojDb/S43aKKU
         0dRQ==
X-Gm-Message-State: AOJu0Yy7+oX6guvQppjPPqwaY56NH9ECihLzoZNErPnG5yq5GAGjnlSX
	Zeh6l9uY4nqxU8/Ml+pIP7B7bVXmHdAszY7aFxG1o4A9gNuayRKrqk7bZzw8frcM0XzcsicxVju
	hCYGLdD0=
X-Gm-Gg: ASbGncs08ftQlpdMgewX4NP9deYlRQ3QjMam/WXJcE1yAbIAB3QnGhrRbZcgpyLM9T2
	p0rHiWmkgNhAGz6VqGWWZ+hOTG1JA6KrRoFZ3pVIiSIhYIzXC8CZz6fq9gpDNII8+f649o+zZjT
	DdtNWWIx0P4SDch0+1y1101kP72B6vjWQmJfbE9ZDellpl8a2z73wsgf679uzuSkxYi8hZEOfCZ
	bc8AeXUqEsc8jbWD46sszuZJS9FI2gC1MaJbG8ERYoCZCTMv2sGCr7zaAhotPJCYbaFVixiHfNc
	uH1ELpPDW7npANj09MDEd00h4KxGRR9TxoSel9v+QwslbMVZLGmJxoPLamCf0FxIIETalRU4SNX
	g4ehdlde7lDcIq81dvu4TeGIV0zMrT9P3oG0NMwAgvydLQoHw3l1NdbIJs7Ldl55RtsWuAiWEKF
	6fTdQ=
X-Google-Smtp-Source: AGHT+IHQyW76ifaDMST0DMVZKQxfUDcVzzBW/gT6mVArT6uCPqnd0Msz6dtINgS20LiQGYSpMTlOBw==
X-Received: by 2002:a05:6214:2525:b0:78c:f62c:8eb1 with SMTP id 6a1803df08f44-7927a40b4d6mr179770826d6.26.1758569696534;
        Mon, 22 Sep 2025 12:34:56 -0700 (PDT)
Received: from [192.168.1.241] (24-152-154-74.fttp.usinternet.com. [24.152.154.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79344899b25sm79068246d6.7.2025.09.22.12.34.56
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 12:34:56 -0700 (PDT)
Message-ID: <105f1d0e-f7c4-431b-b95d-efad442aaa34@reillybrogan.com>
Date: Mon, 22 Sep 2025 14:34:55 -0500
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
Subject: bug: 0.5.13 regression in parsing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I upgraded the dash package on aerynos to v0.5.13 and started seeing 
some build failures in packages that previously built just fine.

Build error:
```
+ make -j 32
   GEN      src/extensions.c
   CC       src/libxcb_errors_la-xcb_errors.lo
./libtool: 369: Syntax error: "}" unexpected
```

And the relevant line in the libtool script:
```
archive_expsym_cmds="echo "{ global:" > $output_objdir/$libname.ver~
             cat $export_symbols | $SED -e "s/\(.*\)/\1;/" >> 
$output_objdir/$libname.ver~
             echo "local: *; };" >> $output_objdir/$libname.ver~
             $CC -shared $pic_flag $libobjs $deplibs $compiler_flags 
$wl-soname $wl$soname $wl-version-script $wl$output_objdir/$libname.ver 
-o $lib"
```
(I've uploaded the full libtool script at 
https://gist.githubusercontent.com/ReillyBrogan/9a4e6a02e5871fdbeb793a549131e197/raw/5a00be91f0cf38df7706eabc4c0eadcac74e84dd/gistfile1.txt)

Bisecting between 0.5.12 and 0.5.13 reveals that 
e878137f63e61926bbdff7062a558f0143ed5872 is the first bad commit.

Regards,
Reilly

