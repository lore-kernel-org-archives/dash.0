Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794410455;
	b=VHVtD2qEluM+1dwVdsEBH8+WIFGx4TPhi7JHgu2tKdzI7a3dXTC0NoAK48fXs5z/NMod
	 jdMZrI6t24A7XVaXDI5qudxF3MxUei01dIOS65MkvU3l8v3GOaNm/VqWNPqJhCVw6IW5Q
	 TvwD909a2rPo0vk4er8QfwG4N3CrMcrj5iPZp3u4WoUTajQHSKC0NwNLoli534QqXW1pA
	 Bh+/n2YDIrjRITB30Dvt+Uc/4iA5RZh16S79XP7S7h8K2w9BAmyBvxGaaksvQQYPx6urk
	 c2SzRRsIOxarTAbHYbBh/ni7LhAXdxid14G7BudKaygaNHqdbMbRk7p/9ZqZb7MUf8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+ywp2mUQi+14J94FNioA8/gzVV5V9hb7/9kkQaII/CU=;
	b=W/GPowNs0YAa06SXlTA9z8Jx3ue3uuQi30e2yufkGPALUfpwvvdZE73P4AEeNKyFJKon
	 zo894jbt1OoEcRT/s6d6Dy8QXWBNUcygRAjM/d6sTum/KElJaHhlBFORDHJiWU7KVL5xn
	 hDpvM0Mm1ewl4YTgPScjSfkRJbK30csShM8pHxYonp425eeuzEi6HOHycMZ7huqkxrq7y
	 4/RZGThhVhT7E1wFrDekZJHRGsgjEKR/q527g3J0vp7Xdhlik+LCTZsd6jbi+fLKodylU
	 RVo7qm8y9x6T+HZ0lfJQXs569dhH/AFxopYQ5VD2i3I/h2qPmMLwvV5yTD6pJl7HldQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZPKxX6P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13F606A333
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 15:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B13F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wZPKxX6P
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so19625215e9.0
        for <dash@vger.kernel.org>; Wed, 11 Nov 2026 07:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794410453; cv=none;
        d=google.com; s=arc-20260327;
        b=FtG00N5in/lN62CrwZF8OwJM95/MQFJO3nadnAl1jEilv0oKa21Ft0ukIwsWNX6/WA
         lXUfQ+g8/m29Q+O5E6vxH+BmTqksG9UZJo+h5chNREJniF9p/KJ9un63X5HmrlmFawpz
         zOe4A+AogRGJwVpnvgZlM0uUJywfISlaWXKsLZV77bxVFhptIPdVTg1b7tl+ZdjJsVA0
         THFFAeYCMAn4d9YUlwgkLF+K4H2C0l0bjin+1iRAPQ6sFOvScmsZFqULgFgsA7x/rRve
         v7QuGEl7f/1YksT4rWW5ntvZenKAKkMQWYuKLvwYy/ZYcmTKuiDFlsvR2p7uD8YQcDgL
         oUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+ywp2mUQi+14J94FNioA8/gzVV5V9hb7/9kkQaII/CU=;
        fh=x4uP82BJkIsL4XiJCZauYgDyRPWbmOdfzrsTMXIC1gQ=;
        b=QU2JUjjJ5ySy13Jj5U0XBpIM+4aFe2GK/1fCZ0z1O5E5Rvb4/sxeb36Pvb0N/LUjGx
         rPPlvhhyl8iBEipSJbZgXl89FkasUfF83VRvTHBFRcfYSjcvAQpsg2CBgGLJF8UnNjvj
         8SzqNCZZSJWsY61nC+7MYQNMdCCGjs8hj398pUQWxxmaH2fIbmts1G/2UvKTy85Ad1Xn
         EP+IFNra2MaidXsquwfjYJDWlsevkUmqBHsg3Hc/t/EM3YOc4C/r3bTz45o/atKdDuce
         vFjRmzrPCs2VTAQLQpnJMMaBuP5ehg2kVkx6iWXjtOJMF25eMAWA52pI+8KTfvlJnVaD
         JLHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794410453; x=1795015253; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ywp2mUQi+14J94FNioA8/gzVV5V9hb7/9kkQaII/CU=;
        b=wZPKxX6PuoeqT/ew/F9kO2w8rAO9qAOcfts5fIOOru6RljTAJa9JyOxdgMvPOXWtWq
         htyHsQyHAPXJVeIvvsa79zCP8xrhUpkbEWg6b0mb3ED1Bv43h3FdDB/AmUdwKcOmdONV
         Y0if/Wx8CCZFMpyOUvoC4J5ok2PG+6CZrddsjYjzR3FL2zJBkqFiUqlyjOGGdutIM8n5
         gBva/ygPlIvMiQjFmFjw6lkGFkJ+BBmwMeloH+gu0mSrwnaXNSlLQEtJoTSwC9zZjac8
         TRd5q8HqZtxd3C6Fs7yvpIASc/j5bN/OBEyqnVoscY+US+dbwSvYtWoi6XfJW39B0rtE
         swRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410453; x=1795015253;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+ywp2mUQi+14J94FNioA8/gzVV5V9hb7/9kkQaII/CU=;
        b=J5o76SFGxxv0d9YF8HMcvoq7RvKhXST9uoD4oKhozLz4u0iC0TZu0p7H7+nZWduYDW
         KuB9HCmuTiFKWjKD2MW03bfAxjlbV44XEYHJ/27zLNdnwWQP70Hi311oS4T9jfBHIjqS
         p9DXqyG/FEePtcJhgcym6fiUWVzfaxy7ENJtgvh1Ej56W0uK1XhBW/MhX/Pnpsy9fxDJ
         DPbyvuZ8J+mgQePKEwHOdUWJ5cya0RhUiaiVI6En5ga+t+Yc+7BkGxiUd9cBrGWuMGvI
         YJn3WioDxDb59mHiO8ANwROu0VEgvXNWqU8XVVr98hM6STJILKRidIZ8SdRE3aAqoAq0
         GMXQ==
X-Gm-Message-State: APuU4Z/s+kQPZ0j9bcKRw3miAAvWb3dd/lFGbYVrpNpmQe7nVihLTuxa
	ZMlsO0o9dyNSoWkyy7H4rIxQGHqDxdH8+VYzvNe+sEik0i0sqIyvwDIoGT+qX+HPDm21qPxtSzH
	Mcq3uJ0+Oc5oAnNnAyke4QSfUs1hEFYaMxuKgP7FE9w==
X-Gm-Gg: AYBFou2DDN1ZMrhOVZsnivnQRGNRXnJxNHOH1WJjZg6XWkqyHX2mksbO1O9Fk/tm9hc
	KKeSBHRiehL5f7BAThKVLinqSH/WkVCWyJ8crVNq0AE9ptG7jN32fzbMV6QdS5gK9McA8wvq/Fv
	de8BKhPYqyHuhxZgwn0DvJZ22mRop31FqG6+Kb1gOzOsskWPJySWQMf3ssBWbft9MJBUzVOk2Fc
	YszwroAkZynPl/cjUV/YPwZ6ccGLLM+x6t9LrRvcOigb07KukP9tC1RLIb9c4Gm21s6G9PIP1DA
	jYF7P2koJxNpmTheXPReQGVCXk9gtyPBwgmZcMI0uGoWeV+v9uO4CrA18sdWx3o9Tq1urNc+q8M
	QeOVRsNuHIBKaqvs2rafvbp4X0gzdeQoPeaKp114/ZxTj6K7JNCcOw0YZla6dScbvE5K5DvPUao
	W0hz9Ih6lQX1Bej7sQAWYym06rF5eaoi8u
X-Received: by 2002:a05:600c:1f93:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4ba0938124fmr56156945e9.16.1794410453282; Wed, 11 Nov 2026
 07:20:53 -0800 (PST)
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALwy4xJPUYmHJkBvwAr02zp9HfMp0h2upeRxc4NnyXT5ELn4CA@mail.gmail.com>
 <avQmFhHfN3ijdQKZ@gondor.apana.org.au>
In-Reply-To: <avQmFhHfN3ijdQKZ@gondor.apana.org.au>
From: vvkj <lueqit@gmail.com>
Date: Wed, 11 Nov 2026 23:20:07 +0800
X-Gm-Features: AclHuK9s6abPcg1OI7q9oT-lPx-Rixswt-yBGLSfTf8IVlHrIV6JUdRqhiWeI3M
Message-ID: <CALwy4xL6iAF9Wr8NCBSAtaSoGioHfuCBV-BwnwinEnJGpxq_oQ@mail.gmail.com>
Subject: Re: [BUG] dash: command substitution leaks 0x81 (CTLESC) across
 128-byte boundaries
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I cannot reproduce this on 0.5.13.5.  Please try that version.

Tested against 0.5.13.6.
The 128-byte boundary corruption is completely gone.

Thanks for the quick hotfix.
