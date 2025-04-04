Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89E1DA53
	for <dash@vger.kernel.org>; Fri,  4 Apr 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772224; cv=none; b=JmelhUQboftL1VW+89qtm9gTL+zjNNZ2b2+ZdENC4MMhTg54RbZ4Bf8/pGWNZpoGNpOQvSRLdmuVDucHAGdSf0fhuZXHc0knZyDClxy4fksddYRw04Hxqra3MsXfmT4qsDzfJMcEOlfRl5FnY1IipeDmB4EHqi6UUBzjGa6v7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772224; c=relaxed/simple;
	bh=uyJGdSFa6INy5sFy3WS5U4xJgKNYdwLY4ivAC0USsqs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QU6QK6LWTZAiiXAr/BBNP57LFk81eWC/ztYypjeGuXV63UvhjqxcGqUBu3xzXU9EYLrgcLNKxnMoCFeYKxLmmcKGqGD+I5FJOdaV27ZSrvWG5leTDp7+bFQD4VhlUW0q28D6rDi22fAnSChVmvDz3+uoLGPfYKUvHeKfEo3T54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmBI+0PK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmBI+0PK"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so1822457a91.1
        for <dash@vger.kernel.org>; Fri, 04 Apr 2025 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743772223; x=1744377023; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a+lyKWbCWcFOk0nSfR/zinwenWLNvUnI8DM43zjaltE=;
        b=gmBI+0PK5u+wvWJRH+JipDg/+hGX2wySTR0rkj9LEmVBMKhK8CHb3onTs+ahY3QixR
         iJaoxHuld8+iA4hqVwpFbx7TGVgCNlqGZ8fIFVf5XzKvC3paGNnhHilRQ0YdWmxtYOa1
         lMpwPpASYnCStwCW8Po+X2CMLccGqT7PrEKJ8daxXXCIAEgSqe4Xk/Yw83QVhaEXaPYK
         mVo84+0VB9C1WlRRCrDRc9u29b8RAD/t4uDCp9CN7oDwZkHKLfVvcsPJLvx+ngphsYey
         I9lFt49babN7XubkbRYBYmChY3wB4vgtNx7KHKAdJV8SGdZut9TWzxcfRoGBTMFCAOsJ
         hgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743772223; x=1744377023;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+lyKWbCWcFOk0nSfR/zinwenWLNvUnI8DM43zjaltE=;
        b=efLkdp4Z//fn/6r9wn2hUBhn1gF0mUaxHylpAqGobVEvHrTqaxTVBkOV7+ijwJ2TBT
         8Y/Km6+zdJdCh3uFozkEdZnTtwymokXOZzRsCt0PgEFnOXgcRY/gPOuSGL8nFgd7STkh
         qg0BrOTHfh6U+NI2Ufr2ppOLkeGw43Kmc2r/Z1pzIFtTNXOn0f1XQ91wmq2c5fWbAmWy
         oHoE+WF/1q7ZKwbGCqhlNp6j3MZQkiGz3KvMZ3L1BMs1XbSoOre2ka311/9PTmGfFV18
         i8OIIx/tonvFCpSe7iB9gGLJAiLomWe8aqG/yWqcUL0rpxnw6G0CG0cZOfDaCR4V1N59
         aBtA==
X-Gm-Message-State: AOJu0YxIiU5z0i47NOxBnYEz16ZiWzsdX3PMjRFBYdsSbLRODnaeIHGl
	u38y5tOucMTlKztO6kr99idn6NFRBz4kDr8fvkqzZY+93CbswyDsx5QJbMOG0CsrqzWrDpoxIYh
	NviB2Hw39pSA6u4g96PW1NMEDyM64l11a
X-Gm-Gg: ASbGncsQeWUHnEGGeyG4XaWyB5/GJJyr+2kc8xQrdLM9YygtqBp8X9VfQsQlBqLBF31
	96Pfqg1S1roQGOwpbRmsgVVwpFv+bKAXoF5g5C9dp7RUrcFjhURz+q3duabTcuF7PO3rNh2aUsi
	M4B4OCmKFWBrBG9ks4vRRv3Fl/ZnrH8bAdVeu2
X-Google-Smtp-Source: AGHT+IEQUl/f/x3iXMCZZRWcoGuh2PFjGz2UIcMPUjd20EQpS51WkMdbJ3WFDu+WWmT5OzoT8MkTQxJzKfMdMlAo1qk=
X-Received: by 2002:a17:90a:c2d0:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-306a48d19fbmr4985388a91.28.1743772222722; Fri, 04 Apr 2025
 06:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Fri, 4 Apr 2025 08:09:46 -0500
X-Gm-Features: AQ5f1JoIg5OcrepKXeqQLXbRRKoxzNZZl_iAd7NoCHbx7gWo1oq3hV_-TyhNgVE
Message-ID: <CALaQ_hoenH-y1+vh1M8dYyBMvPoanBXLumHi3o=Rq2MYghLU7g@mail.gmail.com>
Subject: Automatic Termination After Background Job Completes
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Setting an emacs/vi flag when starting dash, and using an external
command for a background job, the shell terminates once the job
completes.

1) Good (builtin command)
$ exec dash -E
  $ (printf "hello) &

2) Good (external command)
$ exec dash
  $ sleep 5 &

3) Bad (external command)
$ exec dash -E
  $ sleep 5 &
