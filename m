Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792645595;
	b=GN8unQkTWmd4VeYs2fBTtmNthAI2utT97n+ktQotfCfFRQxuXGhDfV/CkVSb0XyvgDxb
	 xRpyMVtcThKQsy4Tt7zDl2KLXwcp2+kwgLfDeRWEBP4hCzvfynsx4VPlF3jbFfdpkhZ1D
	 pX/aI01zoCEWgwTn6vh8qTRvFYKH96MfCUCmqw8BC4RFareoHenhB0KS2M+g123t8W+31
	 XoEZPiPBRB/c1wmNXjZ7OCXicz/oowo4PkU7tj5ZMFvDLydBSskAKihpufBuS5iIet6er
	 ZnyS8raL2rNGUej1131xavwBoQxedmxSMoQRb23VjvdhN6BIMJn/WqL4nGY+QiAzkPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=t9V5go6jO/r19TXc7m1Cdk98p8OI4YcG9F+qCAgpMkU=;
	b=gDzy3j6/fadL4w0Qje9uSTmuhov38ELiTz6MPxHyYFVTI9bjsGDp7hTQtTqNlxXSSrkW
	 p2yERIXZdN/bmAq1CZ4j1Sr9T6Wzx/KJWokQSI6tPcVZBVrCo5j4BDw14ZR6eHY4oZDuj
	 yJLenfa14lQQaynggRbShPJ6VfvV3H7+mcc83WvDPqAY5VWyhGCMf73hsBHEHxxgz4In/
	 xYHZgb38Ts/SV1m5TvDbYhtmpAx1QQSbPBZKhehTFToYX79Xe6wQk22qoXachlUMQQO7Q
	 mH6vgjEL7ZUG8zcRpsQAHzD2ezWkNbiuttjxF3Qd9ys+pinN7g4v+om5stoKke4Xc2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=mwfBKSAz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F0606A319
	for <dash@vger.kernel.org>; Thu, 22 Oct 2026 05:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1F0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20251104 header.b=mwfBKSAz
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0a45e0fc2so629377b3.1
        for <dash@vger.kernel.org>; Wed, 21 Oct 2026 22:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792645594; cv=none;
        d=google.com; s=arc-20260327;
        b=dUR/pheAzOj28f5HPpp2nMjZC8WG9VNrxQOOgs5k74IDXQPw7gSgaj1KKhUfDwHhzu
         z4k3rMaCrpscaDW4wEFET3vh9A3B8in8nEuMpCJXDdrMAYWBOKUVq6Sf36PLsTPC0Sn1
         PVnMNci+9xwNdL9RQckhZXUhbtCawctLu3TjBIri3HeK4pOHAdDpbhUet0tTbsN4sVFs
         xPeDuHoeb2xzoeL9ny9yVICi/ehdzwl84frYALx/eOzOWO8dCi9kUEA4Wr8AM76cZBYG
         ySiVl6qy2zA7aGM1UKM0Fs0hvyM0EaRKBw3b+xNrh8jyfXOFcrqCqaRBsOn8ZK6lW1K7
         j/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=t9V5go6jO/r19TXc7m1Cdk98p8OI4YcG9F+qCAgpMkU=;
        fh=8ViJBE7khi76CnJqQzrAav0OoHrBlpLAVTsfTw9REA8=;
        b=D2SngIeSMn+biwWz3nzKtbYy2d2K7YrFSzU2ZT1cCWzVZ6uCXf0StS5Pf/iNM4JDHt
         7B88+hvgh7dgiK/aIMVDHpjyIOjmutzdMgiXSGRMnuPHPgBbVxbJiHFTggLPeoVN2zTT
         xbS1W9D6v31uQDKRX7+a9G7e7nAB4bJ1OW5YiPOaq4u78bPsxvGUsWHM0qOlyoPL2zSD
         Fs4qPc8FmbqpdWP1ZwF2eKkjA1tsh6qt+JFm8niXB6foxlAYHPKKr8BZtnhPmErdhV0k
         BmxQeHDFbf8bGvTxZTvXWMOpvFPtheppb2V8EpfBWtnr+vJg0PFSGbTCRtsEf8TIA0GP
         Z+Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1792645594; x=1793250394; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=t9V5go6jO/r19TXc7m1Cdk98p8OI4YcG9F+qCAgpMkU=;
        b=mwfBKSAz3w1wYzIrBndLmJCiTue+tU0LstdEGGu/RD/TDVRvhmRjX0cwcSRQfgWOeY
         T3uK9NqpolRu927gKxRVYpOTcwWcJq1fu3je57BdKPD7zxSu1+tFdvTUvpMifWQJUsSP
         7d9nXUA19NYNQgn7EA2oNeZ1lOO6R2q9EWqcuKbJ8pbDgalsRtOXc9TLBz6GQGGCi6uY
         dlLl6NilSgkg5mUl2JKEfQFe/hSljZmjxR8z/3xIpBJbFQ+2z6n7jUdaKWr7fhyLlGy2
         HD/9py8F2ZvEdnjCFFlQ9Q+93h5ezIhFGO2sjiQ1puiB1HBj+j2IFX6LvZOy/0BQ0cXi
         bhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645594; x=1793250394;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9V5go6jO/r19TXc7m1Cdk98p8OI4YcG9F+qCAgpMkU=;
        b=cVFbmFGn7DSnu2JQudoI2Kw696jyVThnx/tgvTrNnsJ1d0q472u9ejjtvzKPBtZnvV
         6U+OooDlXXLWm+qp1Vkk8ZVwY8xOim4Ol72D6j6lyEiuLQK1q7S3oFQqkK7fvX9+FZEl
         WEekQ1Q+JxUltsdfTzNfDnDdgNzyuhVIhxavPgeqUilleCpilf+/zqw19k0OVu6P/ZVB
         pXHi2pgmozcEBD2qAwqjn0pil/endoR+0yhtjU/OOrUsCK8xW97T/+33xMb0gYwym5Pn
         KPdCueb5qyrfreJMeE1X+h1cI2SBFVZgEXGWWDe0zEgTIEjX+e1SA95Cu/bYGs3u4Gci
         s+6Q==
X-Gm-Message-State: AFq9FYKcPocNatu6mdLq82lv0NNsyvUdWzvW9aFUfPULgGgQaAxNBJrB
	uzj5M+cSwomnqR9kNqoU1+Nk/fDn5FMtN0eXzqJJjvOw2sOX6hq08B0bhSPmSA0FcRopqbg2hj+
	q5DE9tO87LgK0IJrQmEDn44qoNzRs30ZqzmFEmXY=
X-Gm-Gg: AYBFou2Yj/Z1BODeac/PizxNLfl1SdA+CLyQ4hvNt22FHRzsRzBo10/Zar73Tkmj/zI
	+WoSlstTz6ajtYD2DqM82LFGEmIvL6ODXIzyh0AE1HCUgLjVVo0VGCPKREjJiO3HHt/Txv+DDzr
	cRUXJg9ZwPHKesPTH/vTi9aohE9GA38nsNwLt/VFxeZNbbTsO7OCo3yfym53pyEOC/3Sopm5JQa
	XZNizsIzN6M0dAdAFIHsuRLfr8EF8GCJhlLO4Z/UcFEfcCQG3xHIBIJt4a78WnBQLpybpLoigiX
	NjyA2bcxSE009vIKmc8BRCaL1GZ3XvDNDSr9pNYR3yH/rF8PGIfki5TxfMmxC2Za1/bQutejoq6
	mmsTHqAh4XM8x6sLPCGiMrJKDSjsfIesTa69QighZdtLPACKkAKTrlM6m
X-Received: by 2002:a05:690e:e85:b0:677:b7a7:ba35 with SMTP id
 956f58d0204a3-67a0e1c291cmr4089344d50.1.1792645594137; Wed, 21 Oct 2026
 22:06:34 -0700 (PDT)
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Thu, 22 Oct 2026 07:06:22 +0200
X-Gm-Features: AclHuK-Pu6cD3aOz4VXfc_l6FLD9Vb4m4JeiNVzmir0neIDg4wcVSZ_KObIRqXA
Message-ID: <CAK1hOcMy+=6SAKRA02z_DWtLG8OkyDLO3udzrnKdpfuq+C=d-g@mail.gmail.com>
Subject: struct var::flags never has VSTACK bit?`
To: DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Good day,

I can't find where VSTACK bit is ever set.
Is it unused?
