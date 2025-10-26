Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736E3611E
	for <dash@vger.kernel.org>; Sun, 26 Oct 2025 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440230; cv=none; b=hfFD3VS54X4Y7hagaZ6VqFfPpGJk4aaUlTxuu53Vqp4zI3+E6o257joMJ6carj0zMf0RNiX4gBVl/anCQZhvIwnSS9lyWeWkRXchRLH9iysxUYQ2OfY7mrTS3k2omah2cTPcBPM0oLWqXZwXAt8vJEChQOZDbOvJON/iXS/GbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440230; c=relaxed/simple;
	bh=jnGL4VppkkfYJdhyVhKhYZJbak4j0g7PE1BwWTRo8k0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HmYPn+WI4CGdYZxRVkCb42bkKOmerCzP6TbNqcmYS6xInkoMkulEX7oana0p5/Tg1vDXU/dcwTWugjDqTLaaRypLRLhqer2i4bFQut010Y5ZYE077rqJONwEYY6lDWLQ8yLCbMHoorzgQp7bWNCtdpCJUOPYvb6Fn5z07dk9mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com; spf=pass smtp.mailfrom=reillybrogan.com; dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b=n3FpW4A7; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b="n3FpW4A7"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e7ece3025so130414539f.1
        for <dash@vger.kernel.org>; Sat, 25 Oct 2025 17:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reillybrogan.com; s=google; t=1761440227; x=1762045027; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UenAKKfxIb1bv9pfIpBYADRCtVxcmoPcxfwZ3QjVydA=;
        b=n3FpW4A7MbBQkzDZy0OuDke/xp2SMNPorU722VX2B3l8JRB+8t5mcZFOWUbLV5TJCL
         vA8JATgxEbauBQ2PNZVnre8K4+8U2ilyC0d8qLSk9cS6gLRblriWyUuxEW4ZA8gHTPn3
         gca51x7ef9K+Ft3rV9wWphiw+VXTySOpaMQI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440227; x=1762045027;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UenAKKfxIb1bv9pfIpBYADRCtVxcmoPcxfwZ3QjVydA=;
        b=QxsKXsDhR7nKnMQfOkZ2QjQaEDos9AX32tLlfpG4f0It/FdWpRjPPXecdBKq5KH3KT
         qZxEmNp5WTQKY6ldYYA+X0VWGBbN/AFk0T1xZMOLMY/KnigU4G/frWWVP+xlirAe6wcI
         4HL0dkYP142zjBIyPoH7FYPL+gbM7yvQM6KwVChMfYM9zSOpUydFzAZCxyYxj5DQNla+
         ohTAYdKuBFsY17h/Xi19wbhxvGVshLPWsVqyptUUCvHAmStno1u6QB2FA4IT4EFu66h2
         ChQpelS9PPl+wrlVljDSm7wCGPAXa74tNADY5QdIwwu6QY0HJXFAnRa2nb66v4UkpU7Q
         OmZw==
X-Gm-Message-State: AOJu0YynIpWoqZrA2+cZ3EDj60kYzvL3DCIA/yJkkdAkqq795q2v+NZN
	WA+VBEMr2cKa3mRQm1K/DOnk+VgnBNnH4lX+U4Nt5lmyM7r52abs6Z267HGI+gRDgHAJyBHQ/pT
	VfO0c
X-Gm-Gg: ASbGncukZQqwQDCs2g8p7cLc2yzeZjjHZKYhom24taBLp0PdEG7bXWFmzi7Pud3yhtZ
	Z6FI+1OGR5VJRgyG1rZ4OWSEbOvICS2Ov8yahdHbxh+WMLU0kQ2Gd5ai4+mKA1SPZC6B3Nn9X8E
	AMdt7QzcD9Loi6l5Kvq8rJAI8pRMH4tGCA+rjc0lTf1Cs6t8DKVelwXM6ezMsI+01L5M1yNAlL9
	bjT99RtJzxTiQWWO0Or6heK60zGFBC5rJKfa9qnzKrD+cj7rUYJz7LT4/99xquBpK3pi0VHCrxu
	tRtgLbr/uIYiJr+6XVmvQfE1VPZ1nnmeovmiyAZkLBHnPNGDm49MhgXCofSY4aEra6V6i0ku6rM
	ZUUiZrcw7f5J1KFyzcmrHdlcaILZxlAyE/e9eRdAS+nGM0oKQBvU+LDMNi6NFiXORMhYisW+5fn
	Xyy/eoMcDnPWBfImblDoMV4G6XFhSqeg/vLO89G1Z7yuQPoIdFKLOFXPph
X-Google-Smtp-Source: AGHT+IET/DL83apTbP/DbZvn/c9G1RteQiQsIfN8Sx5bYBvOd4coO8NYOS5aGN1y8cUZTrJ+58f+ag==
X-Received: by 2002:a05:6602:2d8e:b0:941:370:8e35 with SMTP id ca18e2360f4ac-941eeb9c733mr1100752539f.3.1761440227251;
        Sat, 25 Oct 2025 17:57:07 -0700 (PDT)
Received: from [192.168.1.241] (24-152-154-74.fttp.usinternet.com. [24.152.154.74])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359efe149sm114662639f.13.2025.10.25.17.57.06
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 17:57:07 -0700 (PDT)
Message-ID: <cecc45a4-ba27-455a-b8a4-b69c713f2384@reillybrogan.com>
Date: Sat, 25 Oct 2025 19:57:06 -0500
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
Subject: 0.5.13 regression: Coredump
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi! I have a new regression to report which doesn't seem to have been 
caught by anyone else yet. This is a coredump that happens when building 
gmp 6.3.0 with dash 0.5.13.1 (with the additional patch from Juergen 
Daubert's issue report). The coredump is as follows:
```

#0  __pthread_kill_implementation (threadid=<optimized out>, signo=6, 
no_tid=0) at pthread_kill.c:44
#1  __pthread_kill_internal (threadid=<optimized out>, signo=6) at 
pthread_kill.c:89
#2  __GI___pthread_kill (threadid=<optimized out>, signo=signo@entry=6) 
at pthread_kill.c:100
#3  0x00007fa18f043b4e in __GI_raise (sig=sig@entry=6) at 
../sysdeps/posix/raise.c:26
#4  0x00007fa18f025291 in __GI_abort () at abort.c:77
#5  0x00007fa18f02631a in __libc_message_impl 
(fmt=fmt@entry=0x7fa18f1f0895 "%s\n") at ../sysdeps/posix/libc_fatal.c:138
#6  0x00007fa18f0b2ee5 in malloc_printerr (str=str@entry=0x7fa18f1f3c78 
"malloc(): invalid size (unsorted)") at malloc.c:5892
#7  0x00007fa18f0b59cc in _int_malloc (av=av@entry=0x7fa18f224ac0 
<main_arena>, bytes=bytes@entry=2017) at malloc.c:4211
#8  0x00007fa18f0b726a in _int_realloc (av=av@entry=0x7fa18f224ac0 
<main_arena>, oldp=0x563190df2340, oldsize=oldsize@entry=1024,
     nb=nb@entry=2032) at malloc.c:5093
#9  0x00007fa18f0b8a49 in __GI___libc_realloc (oldmem=<optimized out>, 
bytes=<optimized out>) at malloc.c:3672
#10 0x000056317f02fda9 in ckrealloc (p=0x1809, nbytes=6153) at memalloc.c:77
#11 0x000056317f02ffad in growstackblock (min=<optimized out>) at 
memalloc.c:227
#12 0x000056317f030078 in makestrspace (newlen=<optimized out>, p=0x1809 
<error: Cannot access memory at address 0x1809>)
     at memalloc.c:289
#13 0x000056317f034215 in readtoken1 (firstc=<optimized out>, 
syntax=<optimized out>, eofmark=0x0, striptabs=0) at parser.c:1032
#14 0x000056317f036225 in xxreadtoken () at parser.c:843
#15 0x000056317f0326ad in readtoken () at parser.c:711
#16 0x000056317f03238e in list (nlflag=1) at parser.c:181
#17 0x000056317f02fa34 in parsecmd (interact=<optimized out>) at 
/mason/build/x86_64/dash-0.5.13.1.tar.gz/src/parser.c:167
#18 cmdloop (top=1) at main.c:224
#19 0x000056317f02f57f in main (argc=<optimized out>, argv=<optimized 
out>) at main.c:181
```

This is using dash built with clang 21.1.4, and the configure script for 
gmp invoked as `/usr/bin/dash ./configure --prefix=/usr 
--bindir=/usr/bin --sbindir=/usr/sbin --build=x86_64-aerynos-linux 
--host=x86_64-aerynos-linux --libdir=/usr/lib --mandir=/usr/share/man 
--infodir=/usr/share/info --datadir=/usr/share --sysconfdir=/etc 
--localstatedir=/var --sharedstatedir=/var/lib --libexecdir=/usr/lib/gmp 
--enable-cxx`

I attempted to bisect this however was only able to get a range of 
possible bad commits due to the gmp configure script exiting earlier 
with `configure: error: cannot run /usr/bin/dash ./config.sub`. The 
three commits it could be are the following:
```
# only skipped commits left to test
# possible first bad commit: [44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46] 
input: Use tee(2) for stdin pipe
# possible first bad commit: [b1864ee9f2418f84d918ef101dab972ecf4f852f] 
input: Use lseek on stdin when possible
# possible first bad commit: [a065467315dc5f2f312f7e6f1d2e9d05a77b3cb7] 
input: Move newline loop into preadbuffer
```

Regards,
Reilly

