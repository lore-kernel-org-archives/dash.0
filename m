Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC9A25F7AD
	for <dash@vger.kernel.org>; Tue, 29 Apr 2025 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963283; cv=none; b=EIDkwSpt/IlrRCS4Vbq+dwFd5lwp80uFgKfMOdRAyfJOBIKo87VYyMFEZ3ZxRrWTz5K0RUpBTI+kNqC69ggSUPbMhMcs2ykM8hgIKtMnVV/0b9nCHCBpboKoQholcuSIxGROeY6QhZ0bCCm23ZcdV7gsOES3drceCYaZmsKnzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963283; c=relaxed/simple;
	bh=XELhG571FaTemXjT4gYcf2abmeX7RL90NRPekX4LPH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1VwQ2/xK9tiQq9da4Uq0i/ZgVG5RgTuTxgW0SF0He1rEQmh9itbFuv5wkXF/3y7hoW4aBnz8a9IK3Gn1HFCdyBEAhD00GW+4U/sV5sA0ePUxo7H/OCz5jKr157W9mjErtqLdBEvVjHJFIDgLDGTpM2TlFuCKKzu0Cb3QKDdQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKqxI70p; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKqxI70p"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so1282730966b.2
        for <dash@vger.kernel.org>; Tue, 29 Apr 2025 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745963280; x=1746568080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/MLpaglspoReaf6Sam7Ts8jtOzFCXLKRLZHpUNsG5Oo=;
        b=ZKqxI70pojblEtxzcjyuxkwewAfCJy+mItDTmY4BVEzy4QHgu7gTRVnp9DqZcBbr74
         xkMS7R7echarNCr154O/pYA24AydEfQuXRDB5vx2zQqrTYTqS1UzJ4QfQbQkKnK6nfNl
         FsJAmbGGp4SUhKXPkKzCReYvVrvEO0HHRlVPMJcI+BJ7IBr5h8KPhUY8LWKZs92Io+XN
         n654VDUqfal2OeYDOW59qYhetFPKJu+KZCleEudUCPuGvscAJCHRYWI5g71TtxgF3ZxI
         QzOnBhiwKPNRDmq/wBZCzltVeXURaL/2QzINXSnImBFT+WVhGWzKmgSd4jIfD8UtTOqK
         7fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963280; x=1746568080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MLpaglspoReaf6Sam7Ts8jtOzFCXLKRLZHpUNsG5Oo=;
        b=GAmr8kFtz2MS+k0AZjC08eD2UdIMu/1WJh7xgqT1tjSWR7dJubA9ZAebio183GTo+3
         gVbRQqx0JdhHm01Qq6KesYBZprFK96qQzlE2Yi67v/HjnxlLKis4vmyyccCiWwUYcW1m
         v5QWzKkMCMiFwbTjIWpKpS/14vt4Mxk+kjWfHn+Kh06T/J0TtUFOrMayhjTEkAfWlo+h
         DCQIrXcF+EO+8izIqOMQUgUYoHh30UBrs06Ko1HRV3mQi0/4Mg8r5EAiE52AAUVtJL/d
         2n4U92Z4DucSuauWtMqWzieMWlUnVtSqYKv6ADvitRm3NPmGpw2PEMASS5zO7MK7vieb
         iP+g==
X-Gm-Message-State: AOJu0Yxv/QDOLRg43k8y+HjimkLJx9p9aJseOKT2vKForgS8QoQ8Rl9G
	XIvy38pTlUurnaohy34LsfbVWPeg+cE/mDZHtAOXdahlhth+F67DHK+FDA==
X-Gm-Gg: ASbGncvmXSupOWq6IgzkA+x1n0udJdcAbhp92LcKBR3BWgiJUynYoUZ26vAnx31TXal
	t8LaTRKqd6LDfeJpqeXnEu3OjnDuNISDCJRVXSz3qYji4QF+fj7r3+iFBrXhivhYHuvjBDb6tnW
	2RO/98RVNGGoUOEEX+A65O38soE7oVTOpfj3/5zbQb8e4ajcfxeOlhka0fC0ShfiO7QFJHKptKw
	OmT2tdeh5l5+oDSBPj2tlO++byOoJSLpYXyYBQG/skhaK9ZHGhnbL7Mg0NQ6qbQrpqehxZaUE5B
	vmc9tTleV8DXeJFZa/bERxhX+cyBJ0QhLi8mvaLdxKAG9MoR4o0HJbcVlz8muvEs7oL1EOQn6sD
	rtC0EiK3S2gpLcQ==
X-Google-Smtp-Source: AGHT+IGpfgSu52uK61fxNLv0CSKjwoYYA6oY4+4jpceqCmErAjo0cs9ATydFVBMAyuKNoeI1tpcFCg==
X-Received: by 2002:a17:907:961f:b0:aca:a334:2d21 with SMTP id a640c23a62f3a-acedc6ffbc9mr88870666b.43.1745963279481;
        Tue, 29 Apr 2025 14:47:59 -0700 (PDT)
Received: from localhost.localdomain (92-70-146-242.biz.kpn.net. [92.70.146.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1abdsm850984266b.177.2025.04.29.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:47:59 -0700 (PDT)
From: Zurab Kvachadze <zurabid2016@gmail.com>
To: dash@vger.kernel.org
Cc: Zurab Kvachadze <zurabid2016@gmail.com>
Subject: [PATCH 0/2] Fix two buffer overflows
Date: Tue, 29 Apr 2025 23:47:30 +0200
Message-ID: <20250429214732.22390-1-zurabid2016@gmail.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This little patch series fixes two memory bugs in dash. One was reported by Kate
Deplaix and the second one was accidentally found upon testing a potential fix.

Zurab Kvachadze (2):
  expand: Fix negative size parameter to memmove in subevalvar()
  expand: pmatch(): Fix buffer overread caused by passing array of chars
    as string

 src/expand.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.45.3

