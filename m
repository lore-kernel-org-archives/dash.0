Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7853C3BADB9
	for <dash@vger.kernel.org>; Thu, 23 Apr 2026 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776911964; cv=none; b=pqwDpP8qK/sfB6Ra9psPYIPurT+xZrwESO+DycZoUSKwZx6SlROF8w63wd12H/0f0+dXjRGMcPbLf/XNjrNwVYldNG3TBUZmfgF9TLtaJDwI4SoGu9ybOVDeMOc6kv74uGtl6TUV6eH+odoSKaVNVgBMxEqWdKUqFpkIJD9hz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776911964; c=relaxed/simple;
	bh=Hjfghnfz7W1i2CMKifcy2yGsTciUWBE71M9kZP8m1b0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TrBllOcZdvtT91rKpwSf+5GChe9Ahmo6dtti0aU+8JqlZ2l5zYDCsFRE0L86/26x4aaYqe0Dv75PD2vNPEH0sX7HnNf6z6FygWaBXHr1kIIWWtMR9hnBTbY6ijCXfUsNdpSNzlgMo4N26Ho/PXJp4+5+CQ7U7/Tp+tGrkI2pgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAIz4qjB; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAIz4qjB"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ec9f099fc6so369277185a.0
        for <dash@vger.kernel.org>; Wed, 22 Apr 2026 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776911962; x=1777516762; darn=vger.kernel.org;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22kRlVV8y9206MYbG/rr14t20ZqZgB97IqWJ89xFTqw=;
        b=TAIz4qjB5z8eE9DzhuknO++P+MBB384/L6Ra7rTxR8ak6Xoeoak8uD2eJo9IwTJfa2
         fKS48EWR2qzYu8dY/P+1XvgukZwtr/yt9Xcbx0AJMo9+LQtBCNi/Pjm7vg4CHzkx70wL
         uLhkKr1Z/jocGJbwLd28FZwEFS1Xm5QKt/A5/duuRgqYNiNwLYFzYK93TfHUvTV1X1KT
         8ANvEavNDrjzf2NJ34MmYOyp6pD+NW1c7jXeWY/fvq5ObYv4i7a4lcETExycDsEL+CHP
         xkhf4KaJACBI3UPu6GrovrNeCz1Qcchq38WdEKILXrTMe88EvoaRT9VdVO+paY2CNbp2
         g0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776911962; x=1777516762;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=22kRlVV8y9206MYbG/rr14t20ZqZgB97IqWJ89xFTqw=;
        b=bEoAyOp7AWC7cyrftCdxMnFlY9T7qZ4TRtL9pFsl+GkyriT9ruG+o182Qb15DlBBHb
         mWNe6C7NzuiQx5apenPELovtwkSDPCPm8iLdbdGiMQVqh0LjMyHt1NpGWwLZDq0z4Ah0
         w6IuCU0M8dtaL6xmi8bC8nas3Bxmd6uh9vtELH5teVdDZzZbWjUReplKOXxJyWxCalWf
         pFRFyumAzK4i3H9PQHrMCpBs4a+kk2C8rUZYQw1/TcT75jNj6yHqkwLLKD340uBjNTti
         zoEwZV+pZY8Qmo5AZz10UYGh4d5jj6LLxOgrTAYyCjMqFB26sHRpaTsvO2ux+8kIuBUo
         4rNQ==
X-Gm-Message-State: AOJu0YxgkiKVPnVafacJEeROt9/mmkG0oj3953uZaU08cV49CBoLjr9Z
	byRZdEfo+GryqDQoMG1IZSL9wfQk5kTz7Ip963/qUROUZOAJPc8zQBsaMao4Tw==
X-Gm-Gg: AeBDies/YoyVcgfs0Dd1gu7c98EsZt70J4/hVdNilDIhFk0sF0Qf780m32U4BcabQZx
	ie24+EROWCxuokck2qmIHFG/B5EVMQ3eIM/54ZYnenQaH9xhvBXVC7ftkBnnhDOY4WrAiUkp2R0
	ZFcutf6blduCGYCKqBBjLV/h9S2L7NDtm/Uw/QUe5+nhVaZQ/biX+TbpfxIO0tnzapPnmPtr4gL
	QtbKXJP2rl/dkCdmUxNAVlGycoptCsH/3W6KoyH5bMxyBRBdgv0Sh58ACAUZd0hhiQhQD4vFpmq
	L3qgi00EhMTw/Bxet9CojOn8CxPilS9STQfJC4eawPb92Y6U35I9YrQDgLF4dqlcUSh36OQZwGL
	xpLZxFcsRDXUWsy5DfbZCqSl6A1g3JkGRMHG/V43KBo52MxDwv2ynlskaLLzRnS2tYvdxXgTqK1
	0BdCg3UhKb7ePVppdMwJaljCGDRYtUN4yErX5VbWMYEuwrHXIBCxVPDBgSxrVPCK1fgVipzODMI
	WXwGTnBPaBktkny0VavvP0kQS4CSFnBWQ==
X-Received: by 2002:a05:620a:471e:b0:8ee:f43a:bb6b with SMTP id af79cd13be357-8eef44a040dmr1263547385a.10.1776911962505;
        Wed, 22 Apr 2026 19:39:22 -0700 (PDT)
Received: from HQ ([2607:fea8:ea1f:9fea::7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm993386085a.34.2026.04.22.19.39.21
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 19:39:22 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:39:19 -0300
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Subject: stty -echo doesn't work?
Message-ID: <aemGV--9_pn_ABU2@HQ>
Mail-Followup-To: dash@vger.kernel.org
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

apologies if this has been posted before.

I just noticed that the following command

	$ stty -echo

does not work in an interactive dash(1) shell.
Initially I thought it was an issue with my terminal
but I tried in bash(1) as well and it works fine.

If this is a known issue and there is some work
around (i.e., I'm doing something wrong?), I'd love
to know how to fix it, but if it is a genuine bug I
will take a look and send a patch if/when I fix it
:)

Thanks!
-- 
S.
