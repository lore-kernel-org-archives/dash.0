Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA1030DD1A
	for <dash@vger.kernel.org>; Sat, 20 Dec 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766248953; cv=none; b=dLeMmTuWpQYWSw0mFFcI8xeRZBZFSGExKFkEEGSyHfPtMuSMFY0ZqMoYukiKq/EUh9QDrrm6VfVzmshMTKLUCoal+7XmPDoyWUcMtq1YCVfeAHjVWpLMiyC0g6dv8iHDXauPEqkURo4guXA5OHiUIZUXF67gpW/EQIojXbS4KqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766248953; c=relaxed/simple;
	bh=qk2mDcpvpZEIztqqD0Yd8i5jWr1SU0to3s/Rd3L3AxM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iYROYSpI260w92tR/oSZJyFs14EMumsRPHUlEd77xMaDiQDoGt71r/3x/T7G6fK0KDwjzs72rTo6GL54jNUzo52evykkbDKF34ofexB8KFGInTiAE6cq4T9QIX5K+04cH+pxEURm6rPniBFdsnt4EBVTcKcwjXGngDSxCFGK2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lahteenmaki.net; spf=pass smtp.mailfrom=lahteenmaki.net; dkim=pass (1024-bit key) header.d=lahteenmaki.net header.i=@lahteenmaki.net header.b=WR8YWHkm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lahteenmaki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lahteenmaki.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lahteenmaki.net header.i=@lahteenmaki.net header.b="WR8YWHkm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee1e18fb37so24466641cf.0
        for <dash@vger.kernel.org>; Sat, 20 Dec 2025 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lahteenmaki.net; s=google; t=1766248950; x=1766853750; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qk2mDcpvpZEIztqqD0Yd8i5jWr1SU0to3s/Rd3L3AxM=;
        b=WR8YWHkm6iPhXC747M+xzdmhlIyJQcdUISqz3kLacJgyZS/GYkQJCK33hqBnlmGObZ
         1ODewp1MeaNyIXQY/UhEjtnQLFBb8b+IbWlgoqBxHzzAKaVGM9L+c8o8bzqIozV+nEa6
         r8mMqvv1jDm2F8NJWKUiH0YB6Wz45A83zJt1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766248950; x=1766853750;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qk2mDcpvpZEIztqqD0Yd8i5jWr1SU0to3s/Rd3L3AxM=;
        b=kDyj4LlQkFnIOBpMsBe3MC2JJYgBE2Kq5DVBnfGND8niuoACUifj0svSxpTQkLGaAD
         oK47XGbjM6x76GJd4YHT7/v/3xrGmnGWhDe9sX3uXBi2oyEpUAfn5Gxp4cAvIBUBlja4
         7pz2Ia3eoGWs6YUJ9/tLgPIZRRiqxrCHfE4n3MYBJfXcQFRLG0b0E9ai5pXUYJkfj4yJ
         nZl/hNRglom0mE2s30OVC7zaHMvxa2ygbci5PhGXbZQm2oYfRC8uAmsxbixCAmTtLCAH
         wkdKnq5oNUAKI7KSEgFuDUY6aQworlPwW9uUA9ff5fANUnlk6opJ67Qf9h0N27kpcjOg
         K61w==
X-Gm-Message-State: AOJu0YzIR9hJeWj+FIPlEB4PlbdO0ACe1UZaZWCs5pkXptlzchSt57lW
	VF5zMLu4cgk/QWBY9MwEMyyb5vfUxxnP6y02bA3O/JUaQ18vn9dlFp3YXUpihsKK8nfu/ggnVf+
	cb0Rj8e5JQ/R6Vr4lUkB6cmDyttjVefsGrm1MGEUJ/f/S6+xCjeEpzM3ArQ==
X-Gm-Gg: AY/fxX6TTHU4JXEx3rCpN4slWFBshxdxnc7ZgCSMgIeVkZe503ewyoebirsZgw/Sa+e
	Nv9k2fIRFY1nFqB9d31JxtzuDzHnvVdTnqxUm1+Rg3Ho5SunjVOr9zf7gE9KnOuHzSVMOHrsH+t
	6MINr/znefjJgQoW8TQVY6GhTJCt8zsOXgtKNwtaesL/WhR0BmywZUKzmJQaLObcGd7JV/O3a54
	UWApQ/huWD6ya0lSy3wC7pCWnHJbfemSgNsV7x8ZN+fUl1JEJ3zKg4r4lke0CJGXXb67b9t
X-Google-Smtp-Source: AGHT+IHCV9ygeqQs4ZdXe7nWm6uvnYaBgzVCAZRAKh1PogU3lQskbVCbr4rV6x3LzuDGgLyqhU9Lv5yObcwvuQlq97Q=
X-Received: by 2002:a05:622a:a11:b0:4ee:219e:e74 with SMTP id
 d75a77b69052e-4f4abde4c12mr97015561cf.77.1766248950561; Sat, 20 Dec 2025
 08:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SnlyaS1NYXR0aSBMw6RodGVlbm3DpGtp?= <jyri-matti@lahteenmaki.net>
Date: Sat, 20 Dec 2025 18:41:55 +0200
X-Gm-Features: AQt7F2rn2iVdEY-t_4AI6TuIeaBdIXfTPjz9khJTWg_hnOBYEWK76slY8_Io4uc
Message-ID: <CANhYXO9FwbqvSJba8B6p+dzL4AoeA5O85kRxXdzWRe19hMwVtQ@mail.gmail.com>
Subject: Behavior change in Dash pipes/read?
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

after upgrading from Dash 0.5.12 to 0.5.13.1 some of my scripts
stopped working. Here's a test case:

$ /nix/store/wy9ass74g4yc1x354ydbdlxkfkxxjv2x-dash-0.5.13.1/bin/dash
-c 'echo hello | { read -r x; echo "$x"; }'
$ /nix/store/4kjsgkcxqfadycyspzfrf9gg5n5bpc27-dash-0.5.12/bin/dash -c
'echo hello | { read -r x; echo "$x"; }' hello

(with 0.5.12 "hello" is printed, but with 0.5.13.1 it's not)

Can someone confirm?
Thank you!
