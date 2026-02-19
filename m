Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D1148850
	for <dash@vger.kernel.org>; Thu, 19 Feb 2026 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771474260; cv=pass; b=MdqUYjPVJjX5mgylAihXsvf3QBOuHOGoo9HiyDxyyHmginGDBgW4U+sFZmPdkIogYsO3wMa1kIHWyWD6oiPAA5zGkk1SqbN08PHnge0iikdklbJW6C3dZH6Jo/xuZzRWf+aoa4Xo9c2ieyHc71KcFPlkmFO7ykeEnUbhCPUEna4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771474260; c=relaxed/simple;
	bh=w24JgJpRtaBoSxF6TLeBFvseYp+bALVXCIcvFxB2GIw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdHkzn42dsIx2thzh2oFmDYo1+LOi1qnH8PRSQc99K2FJEhep4fDDa1YdWGhPJ762dQoAZ357iNpvO+0Dop9JzT35pZcw3OWhX1De6c7Fqh7Ys1hHkvTUMOnPNjsVFpJdWc06wtieAp7J7rBzAYyYaRtsREqrC6k+slxefbOBlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdi6yYFT; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdi6yYFT"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso958922a12.1
        for <dash@vger.kernel.org>; Wed, 18 Feb 2026 20:10:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771474257; cv=none;
        d=google.com; s=arc-20240605;
        b=Q2zJV8eOWFJLSXsGwtoCJFb50up08zs3EJ3CkKOpKHw5HfPPWrf0Tl6XBjR7JKAmdM
         ZUEDneqcQu8WJPU3TSy2B9QxA8u16jaKgU/opcgLmjM4XJWDANWAw5UHB/eUrHY5I2XU
         LMpNdaltDBxsSrYuIpaYhnI0wr4T8tE/S75Ela8UAi4MDZYHmba6wYXCIi6LO104DTqG
         tP8uCARYApC0P/X55kCZxB+sHk+fcoHTxqmYvaVYjJ6UQhz6IZx2A/85Gl5RjojIyQaY
         ODDiMnHXttBdax4u0P28GtamDP0WvbVeKxdSZb21zu8XdBdo6tYsrhX9eGNFQDWHH1wD
         5aMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=w24JgJpRtaBoSxF6TLeBFvseYp+bALVXCIcvFxB2GIw=;
        fh=m8PbQo1Gd+ajBfnhn5xdTCPvG72V62GYL4PW6UQRav0=;
        b=bAqwmbomGHfjycoxGEeoG5kgE79lTDs2kBzyISgqy6tbdZDWP5FRNJ0b1YgDhKzFrh
         nbz6cm95wdMTCyoCTMS/dZS1o1EC7pITdMdmOcJT2cvbRHMA8vJxEofGWHERlqrTf1Ko
         YEUwjKnek0v5jWnXVsJgI6T+Bc30padSEfvA4x4fEIQjxTHjpbZlFE+/WdfIfXwczvaK
         C3r0bZYXpJQCQPf65rSK+c3J32D4S7byU8CLG61wQVxuVn05CjsRTxRg+hE8CoWs8esW
         0MCDhXLybnOAoWmXeXnIYA9egOuTj12C/qVJClFZ6oTlxGoGB2VHkEKljZkJh4ONj2b0
         Y7aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771474257; x=1772079057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=w24JgJpRtaBoSxF6TLeBFvseYp+bALVXCIcvFxB2GIw=;
        b=Rdi6yYFTAMlM1WZ+jASjxWbv8xnNh/AqQ7WzfqUqvgF0q/98N6LHcYHgVMXzUsj1Ti
         koTi0+EmSq4I7Qc6v7mM02phiWOJrb89LU3djmW5LB8EwzQfsZBoyuvhmc3rnpTgCC1/
         ZPtSFw12ZeMnFNi+F/87HiFZhbJ5GCW+9mJBFlkY+nSerrq9aNIr1l94c+nwqHXSnsuU
         fv6BOa11sUoF5WoC8SZ2zsOFixH8PuGu2tUI//zqq+R1XUXom5koAeTbwKbfaG+9J+L/
         SOTDOsOtQumqtgUbnWmLS43D0he3hAgE6tHvupjonxxyq+zD3anM5CoHfJGf/9OaoQdN
         vKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771474257; x=1772079057;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w24JgJpRtaBoSxF6TLeBFvseYp+bALVXCIcvFxB2GIw=;
        b=ZtQLk/7DAZXLBqVTpYLYyrEhItRtG1lJcO6lDrQw+hd9gG9eawW3cJNzrqtxNJ277X
         rZLUkSr+bQ1MIYnvkSqGhyxnExzzOkt+KM2d7YMS2zWuQhU/M89i9997i44wkynAUvVo
         q63ZvNfuj2Qy6qbjBo7twhhh+0NpxymLFEOJ4E+v+wvTqzN2sA1nDQgg+5g1sCyT5YHf
         4cqdbfQeWCycySlYJ3gTHohrWsMm0qn7rYbQlmIDO2XwZIXZcdIA35bihhOfNfp+m2Pm
         42GxnDMTFsvzCwZfcuZd1uI2+pGep4Yc9FrpvWjaT6tPJpaFdp7BX3LED5yAw6F2oITk
         MQXw==
X-Gm-Message-State: AOJu0Yz1Mhx3KvtE2docGlQJsB+fU2G8C0Hdlvz0QuunHcQU8n2oBWRN
	s+VueMjnNWhvBmaHMDB2uRJ492bjM2PCpakZ9f22xkStlQmHh8IQYMSvfj8rD86uAjl9DrX2eA0
	bkOfw27MilJD5WTzex3g4g1jpfFXsfD0=
X-Gm-Gg: AZuq6aKrQiWaHIPSVebibCQ7QoXvnwwH2jkIwLH4pn7Vecn/ZQeMx9ii48L5/MdmgWp
	+/SQTXSb1OC3uKMs5yqR+RbU/2eFTyUtBLVyo+efN51b38c+v5b8wuKUKxNCeVhzidTWEaSG+jH
	Iwp+AAHkOsMBJrfi4cIvCgNLx1YKsL6aHNHW+DMYyecsiH7jyjzwAoneT35SQe9FqFac0CHSGpo
	gr9v48oK/OjNSbUzoP3sioPS5mtDnkbqcbdjQ8H4XsDpPvH+N40RDlAJ3rFznKZ5Vj9JuTN+QlZ
	L0ORFf+WuxRESodVTDElsjqO8d8ItPGoSnFb6ifm1MUI8d0HHP+M8GLz39ycOfF5SMx5rzgGe2K
	lUEgyTKeAl9keihkrLFmvWMXbKUjG9K4pQV+MTUY4qAZGa11RXO+r
X-Received: by 2002:aa7:c1d8:0:b0:64a:86db:526a with SMTP id
 4fb4d7f45d1cf-65e4f13578emr150460a12.4.1771474257228; Wed, 18 Feb 2026
 20:10:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Feb 2026 20:10:56 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Feb 2026 20:10:56 -0800
From: tiagodepalves@gmail.com
References: <20260116205645.19074-1-ncopa@alpinelinux.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260116205645.19074-1-ncopa@alpinelinux.org>
Date: Wed, 18 Feb 2026 20:10:56 -0800
X-Gm-Features: AaiRm50tTrKlySxtBQibY53X5moZHutMlI6Cvdl-DNstYISWjCMCzepSNGC9yz4
Message-ID: <CAO_NRt67P+61s4T0AY0GwgbdPKQSKH7HHKC80mnVTpBB0N=PSw@mail.gmail.com>
Subject: Re: [PATCH v2] expand: fix SIGBUS due to unaligned access
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Jan, 2026 at 09:55:39PM +0100, Natanael Copa wrote:
> Replace direct uint64_t dereference with memcpy() to avoid
> SIGBUS on armv7 when p is not 8-byte aligned.
>
> Fixes crashes in dash during IFS splitting on strict-alignment
> architectures.

Hi, just wanted to mention that the issue also affects x86-64 when
compiled with '-march=x86-64-v2 -O3' (requires both), causing dash
to crash constantly. It would probably affect distros that provide
binaries for microarchitecture revisions, like CachyOS [1] if they
had upgraded dash.

In any case, your patch fixes the issue for me, even when compiling
with '-march=native -mtune=native -O3' on AMD Zen 4. Thanks!

[1]: https://packages.cachyos.org/package/cachyos-core-v4/x86_64/dash
