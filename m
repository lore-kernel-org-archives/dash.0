Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E395515746F
	for <dash@vger.kernel.org>; Sat,  9 May 2026 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350986; cv=none; b=iNxg/mvy5Bx9juYnq5y4eRpyT6TCFcxpDdUvHTsn6ZcdBQb9wy5gfyXwIur3rlTigHN59N6U1dGdMAVv5vJ/P58FWCJn3PA3oKZljXETovJwu3t6DKfdMj957/c1xkzagLIyVxAQFzPq3uAgeLSKWrZ88HqgHrClHpqIKPwDgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350986; c=relaxed/simple;
	bh=ijITICyEqXzKDCfkOzzm+o40tej6U30N5kWWpYrMWRI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QncfR+VVFZ9GWxDsNQy/0hgiTRZvjwLlIk4u8wXD0Ygu8HHYW3Ik/p9CMfXYvOiHwKgFdrwbcB1B3uF1uUHcqc1CGWdAYXIssO9lDUi3Nol3Ox8OQSo2xUw1w9m9Bc47eKJb//liuNURrq+ITQ9cqxZLFCBmJYk5LAFlz3Xg9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVlzpL5b; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVlzpL5b"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b7ec7bedcbso13866186d6.2
        for <dash@vger.kernel.org>; Sat, 09 May 2026 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778350984; x=1778955784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1uEUzVKaN3X+9ZS9OL2SjHdI6WTnGXisDqNyhBoJXzE=;
        b=XVlzpL5bIY2LjSsklecvmQbncYmq9czBcrOhW+UGT/swd2m2ghPv9SZ19I/QFv12Ya
         df3rdoqQcVAP21adhBDQe5hmC9HxGMkpkAh9IDCuNV18975RpbFITRaGt/YHF7cnFQsb
         bXJUqcFytbC0/7mjnpY3m/FVpZk8QSop3FwA9xbaLbp8EtPTnvdeOJLqpnj5dMQzRYk7
         fzlyYt1MZmOTDWjPOZjuvQAkFcteipUQZOSrm77CdkHMU2/HhV+QUUm9MVbycf+KT8/m
         H6KwSXQu7TyP/uQKDlxk8kcA+D/E7fSrsfCvxyVfvW+eZnhfZzesQsUuOus/GYFdMMFz
         lLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778350984; x=1778955784;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uEUzVKaN3X+9ZS9OL2SjHdI6WTnGXisDqNyhBoJXzE=;
        b=RqBODPdi5DBe0XOppl8C5iAi0ffuyE/0g8DtxLHC+KP6P2e0FhIgbgtIAxfoitpxp4
         yBdHwT1eZHRHb4yQguPllCvQ7SlpQXz3d+uzh4eAc7J0FNKlte4qqsiayYpt8cgO+3ns
         hFUIU+BM8T7hWx1JaL9K9LWaS6tFZgmyKP0Z/U1ABeXUWFsvieD4u/wyt0NxPuQTXT2U
         NlOjXVQ4ZTt11dFf5MJCAT/V3JN4H1IRUjgC5u4O/7wG0GFsx6GK4l0b6xCG2BnQXPb2
         14clA6rt2BpGTeNkdGFl1P1MH6yKTPBp4Mbil4q/Hykp1BYnhvWMFHhC3PgZsIfx0+Dt
         2LCQ==
X-Gm-Message-State: AOJu0YxGD224Vq4ZJ4WMqer7GkGicL2rMAO3KkyRAQPmIHDNVXeMdI+9
	1jB2Z0tfveNjXwq+5vZB/yftOOSDZvYGHkyZYlKsaVttrz/LNsD1yQ4k1s0P9Q==
X-Gm-Gg: Acq92OHhnNNUHSILtzhRmrZNSOqgDrzPX9VH5pPrRXbbQ7+apjorV1KLu0J6jHjZqDb
	7a0/7ticLCoyI5IZ1tjkWR8aBdfVhBbf+0MxDM3lXjxZdXxVi4YTEhexh6kL2hA+KgtlcxWxcfz
	dGxtmbIM8vf/XwxbEspw/wKdZ7vmYenlwXLXWUgIXFu9GX/5IN3i7OjNFoA9rkklWmZYI1UCevN
	iCnvxP8DNYUReX4SZTpcYwaKOXE1L0/7UBoN7hzKIPNn0siMcNwbOn39usuffqBSFfy6zTv0Ism
	nIH5PwHExUJbd8qC8+DQ8OMF3vpCcmzKsKz0F3IJFYCZVquRlViyqD/QMkpEdyLfchnyO+SLBXr
	4AHOye6HZ354EOiAF0y2UNBfO+QSmym0B07vX31oaIICVxDSExuw/pIdLswpkAbXTekLounL6nf
	IGoqXcISCyTW5lUqBYDV8EQh2EbIQRnm20fs/Z6hbg0cBvZumtyTyl5h84hJxqPHoA3vXNPrVXx
	LU9GOr7rBsmSlEzobYwuLRh/nQ45NedVTOkZ69HmoFUdbG6W5cIgJOBugCvOuPN1xs=
X-Received: by 2002:a05:6214:5189:b0:8bd:6f62:5713 with SMTP id 6a1803df08f44-8bd6f80f70dmr197337016d6.13.1778350983810;
        Sat, 09 May 2026 11:23:03 -0700 (PDT)
Received: from HQ ([2607:fea8:ea1f:9fea:8a14:df76:3915:ffe1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a43665fsm49311596d6.20.2026.05.09.11.23.03
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:23:03 -0700 (PDT)
Date: Sat, 9 May 2026 15:23:01 -0300
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Subject: Re: [PATCH] Don't use groff(1) specific string syntax
Message-ID: <af97hfhK_nFKtQFY@HQ>
Mail-Followup-To: dash@vger.kernel.org
References: <20260418185421.28841-1-sebastien.peterson.boudreau@gmail.com>
 <af6gLe2f_jlMCofg@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af6gLe2f_jlMCofg@gondor.apana.org.au>

> I checked the NetBSD code and they replaced these with literals
> instead.  Any reason why we can't do the same thing?

As I mentioned, those are listed as "preferred" alternatives in
groff_mdoc(7); I wasn't sure if that document was specific to groff --
other "preferred" suggestions are strings that are unique to groff and
not portable -- therefore my concern was portability, but if NetBSD uses
them, it should be fine (and more readable!)

Thanks,
-- 
S.
