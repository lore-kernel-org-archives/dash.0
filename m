Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367A17E4
	for <dash@vger.kernel.org>; Thu, 18 Sep 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155691; cv=none; b=Z1iOd19AwEqivnj4XXUgFUY2RpDUWgCjT97/fsKwWxTbQEEmgcBNAHe+j1mT4twZ5qyVxeAHryWf/LO3fcqDu+17KnCQWwVWL1b4JD/Zwquk0qUg+ZXm4X8bLccnbTeDbMNMfV8Sxv0hGyUXKNznoeGSHa3XRXCGlQK+AnpIPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155691; c=relaxed/simple;
	bh=9Az2fdLyOG8L5K8vmsPUWVchA2yDg1mshbP/ym7KR4k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N4O5tK6IMwoDLcknIWIloo+uCZGiunrpA/4ixpYJ2Hb+5dp+/Oeq9t0fzp+Wd53ztI6xKElBpni2tb7eEOcAWf6XcGX9JDMZvXO+MVX/c1Fwmi/zVuext79Q5eeUn6+gJ31sLygUcB/uDfue8HVl7NhiCoqYJeRrQJNjao3HlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adzjTjFz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adzjTjFz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04ba3de760so49323366b.0
        for <dash@vger.kernel.org>; Wed, 17 Sep 2025 17:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758155687; x=1758760487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Az2fdLyOG8L5K8vmsPUWVchA2yDg1mshbP/ym7KR4k=;
        b=adzjTjFzKNuLYnH/X52xUq9shol+/f8zC8Usy4CNqb5uPQjn2qPvhKe10CtHXx0ggC
         ealqAj5AUUqznzXBJzqmdWroyGoy+wHKcTUioG6I6I0MA5kZGEP/rbAqrlJQkdnDWAmy
         XI85a35xJaYgc2hxh7BOE1+2fIl7S6ASsTPBZMgqR9TaDvq69EivcK1qiFBWMQNZVsA2
         74sIuZ5LQMBkq6bCr9GjGd+PgYVx7qJHcphbRJhCzl+lCwC/8VoZl6RJSHs3zU8R6ghn
         W11svUCwAG60b/M5S2BMqlb2cZAKM6Qm4C2MPgxN2GPC+P7NapCrExk6yjp1TP2OjaUE
         ForA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155687; x=1758760487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Az2fdLyOG8L5K8vmsPUWVchA2yDg1mshbP/ym7KR4k=;
        b=Ljxyon636UEbqyx3P3oUQHXPfUyCfCeqhxx8fXkTXmPlsqpTvZJ+G4rHXwYvrp83L8
         7RZlG82cCOFnc9Npf1WdoMvJam2EJCiZommasgoyLEsAnFk8C9pCg2JF185ZX0/dN4Z2
         rCMR7ODCYjwXKHU6gcePRa2i1ucVxZFVExN8B8pnbdzDL3LvJU7Tp/5bZp1doLBGi61m
         1GDl04WQYmwq3/YVqhVdOULywP0AYVHAw94Fo0tj0wYG+ahnQk38fL3OApS5023PvKHo
         +pz2Yolw+19lzo/knfOAjQA0W9rKmGHEWNjmfUdmXNqly263bu0R1zI0oQW71hbc0XC0
         thPA==
X-Gm-Message-State: AOJu0YwYRJgBYL7UtHrYDifKDrxpvreGe5bnqDEvdU9n5joxGZapHS9m
	XOw/UW8gDg3MXvdp/DBW28a8og+nO7HBI/jZdVoXc96TLYn++Tda2iWK9rM4C4Gv
X-Gm-Gg: ASbGncuCtCm/orBf1Xs9ve8GQIL6ycmrf7bes3UqkD6WjK384obgK8pA3PZlJyRnpFJ
	Y77EsG4SywjSxODNut9asVKloGbvhDeUukZ7gxciVajwyGszR100h3DvCer0xBSYL5lZenQJBeY
	J5vIJx5ggm9uex0ziZAqkDqst5CWl15jmrvP9dobby93fiCLIsDs/43K2yGCWzpqPImJhHS9YhQ
	YYzMT5ZGbo6vmlUu2hLIoVN3zK+18uT2kkdXH+E7fBKY+3SbOFVWyKSrR2KFVh6YbYmwPwgQYJ9
	eN/qRPwn1iBpgqvbkcEeDk0qRIunUt0YCM/gUbUPn1SA4CPU1L+NL8UeexH0IJNeYg+xwHAk/uD
	s0K3HPuOzNJTe01i4HaEKXr4twuTBSZi5vthYraXuRuKDV6DP0c36N3VRK5eSaf9qmg035hMC9/
	N0Mn7w5JkJofQ=
X-Google-Smtp-Source: AGHT+IFmnt3xV0KkxkUPEVpBlXD2HGM1l7zDqbOq/wKM87hYoSHQLdr1nUpmykaeUvcBMNhLv6etlg==
X-Received: by 2002:a17:907:6091:b0:b04:5a74:b675 with SMTP id a640c23a62f3a-b1bb086da65mr433088666b.9.1758155687426;
        Wed, 17 Sep 2025 17:34:47 -0700 (PDT)
Received: from Al-T400 ([169.224.9.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44fb5sm73895266b.16.2025.09.17.17.34.46
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 17:34:47 -0700 (PDT)
From: Abdullah <3bd3bdr@gmail.com>
To: dash@vger.kernel.org
Subject: Incorrect detection of EOF with interactive editline
Date: Thu, 18 Sep 2025 03:33:57 +0300
Message-ID: <20250918003435.11162-1-3bd3bdr@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an interactive shell (with editline) has a trap signal set
(e.g., [1]) and the signal is caught AND there's nothing on the input
line, the shell (or at least editline), after executing the trap
handler, treats the empty line as EOF.

Try [1] with interactive editline, have a clean line input line,
and change the size of your term, then your shell would die.

Also, we should call el_resize on WINCH, because we have not set
the EL_SIGNAL option (and we shouldn't set EL_SIGNAL, that would mixup
with trap handlers).


[1] $ trap 'echo "WINDOW CHANGED! New size:"; stty size' WINCH
