Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B078C9C
	for <dash@vger.kernel.org>; Wed, 23 Oct 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712820; cv=none; b=g/IsQggP1eUnr3VCwkpn1O0moFiSE69jnb6Gk8n/nWtdJYojHw1nJAqvQ/r5QOquiyyJeowUM3FobO/0x87vNLb6+BFo0fkbt1WaWY0jN6ccL12pCElhGQNKu/cOjSvv/bpi/msW6Jsmg7dJmPzBo64izmko31jbbLhhzzRT00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712820; c=relaxed/simple;
	bh=NNVSlv9eIRrDfruleSNawWu05bX1MKB9YS+G+wc86dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hT8sOHd3NuYsTsieGiDO1xrKt2l+wKmSuyN+JE2MN/L9i6rUgtJgFOAyXW4+FZ+Dnz2vNAUvMjqqXvNiZRGrOKsxQPIcH31VzaRQQaraHs0y+OQlOFnxL6nIoaHlhAIHrykxTL/QaUEmvA2VEjB8LmhO+Z28q4pjDstj+J6Wpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwPC4Cmt; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwPC4Cmt"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso170927a91.2
        for <dash@vger.kernel.org>; Wed, 23 Oct 2024 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712818; x=1730317618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNVSlv9eIRrDfruleSNawWu05bX1MKB9YS+G+wc86dY=;
        b=HwPC4CmtJzqmAFkVfl6NqB9k6M2P4HMsY7rhZz1B/6WuJ//K/vgRAT2yk2skV1oFyj
         GVET8iLX3VTZ1PM4PCq4Ts5vPBxdQsKEaEWCktUxlO1X66AuFvbmYe5pxpy8KPahqwIk
         mS02eMcKM9etOzM2w7MJc8U6RoZtAOBsvHg1Oo/jbw6/9xG6NqE48AR35F7i95bnTnuU
         Kl7QhueXeywd7wSXXmpyHElhvXyu2aS4/4dOkP3vZK/tya26E4Otvvj3zl1ubharxnC6
         RVZ97wFAYiVTOtqeObbckz8rsm4KuMtun1tg80D/5cqg2Fh7yJ5x3v/DZEj30VRtK/7e
         J/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712818; x=1730317618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNVSlv9eIRrDfruleSNawWu05bX1MKB9YS+G+wc86dY=;
        b=TBnlEw2M2eR/PeyRD/fbHzH9AGDZg/NJW9y5d8CMiNaDsgJqZftCIL13G9nAYU0v2X
         P+IaBt2SySFh7avTaUEvQj81UOyCYvcjLUchWqmmsRlmb/AlPQiHQSaRRiY2D26WDCVw
         U20ZTfFSmrUYFJil793UHqw5g/GRAcYbVOQj1sAliw5HXM4iDsp4tC+dd5HyTtl+DDkr
         S72W0N+clx7WCTneVOajRYf9XYga0S1eXJ2v7SvVWTXUz6Wk6nYhNvbt1B8oUJcZyz1r
         5s3MIltphIUgTNHVIfoI+E7EbkV8XJlHkbU0VDQZuRmq7n3yxuWmF1DgphIdIBRj2R4f
         sPSw==
X-Gm-Message-State: AOJu0Yyh1+k9mhDOUFm21yfaEkemRdI0rd9gAQtgIxRQYJx++GBYXlnp
	5EjwuoVR9JaAvqCftUm+0RMt58RE6KvN7R2xMWesGn+pn71d0eD3RM11AmcwFD4GwmEXg6DA0fx
	UcYm2JtHkuDGzq0eLT2Rix8ocKg0=
X-Google-Smtp-Source: AGHT+IFVR2Lbm+5XHSkvCswV0UBCWs2mNJhlIXiqWfyOSh6i2YcTnrnZglRnaUu2qOQjX4YeerYRWklrZREwGHxMZsI=
X-Received: by 2002:a17:90b:4b85:b0:2e2:a029:3b4b with SMTP id
 98e67ed59e1d1-2e76b6d0054mr4274227a91.28.1729712818328; Wed, 23 Oct 2024
 12:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <273c031d242d7610e4da37ceb9413c876f0168e0.camel@scientia.org>
In-Reply-To: <273c031d242d7610e4da37ceb9413c876f0168e0.camel@scientia.org>
From: Mike Squire <mike.squire@gmail.com>
Date: Wed, 23 Oct 2024 20:46:46 +0100
Message-ID: <CAOn5hp+HSuut67JqqNXn9opCei4=aL-m+nrtFgRv7r8SjZqg-Q@mail.gmail.com>
Subject: Re: `jobs` within command substitution doesn't work
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2024 at 20:04, Christoph Anton Mitterer
<calestyo@scientia.org> wrote:

> but in dash:
> $ sleep 60 &
> $ jobs -p
> 140049
> $ echo $(jobs -p)
>
> $
>
>
> Not really sure whether that=E2=80=99s behaviour which POSIX would allow,=
 but
> at least it makes it more or less impossible to easily get the PIDs of
> and jobs within scripts.

$! will give you the PID of the most recently backgrounded process and
is part of the POSIX specification. So, using your example:

$ sleep 60 &
$ echo $!
1429004
$ jobs -p
1429004

I have often seen code like "some_command & pid=3D$!" to background a
task and get its PID. It also has the advantage that it only gives you
the PID of the most recently backgrounded task, not a list of all
currently backgrounded tasks (which "jobs -p" does).

HTH
--=20
Mike Squire
mike.squire@gmail.com
