Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011428A3FA
	for <dash@vger.kernel.org>; Sat, 14 Feb 2026 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771046727; cv=pass; b=Kyx188rsSNq/cKcYXMZevzooYCAxMri6nIvMCq6PQH+eJsw0UrZnzwBkI0J8lnedhoAlmAP6FsZ7U646TySNM87JNbNbmOmw/D+uPFtgZ2xey+pI2X6yULddpiH9wW901x9i66whvctwEuyhTPBHcqRi9eIrrrGlMBpJqlZja2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771046727; c=relaxed/simple;
	bh=m828cIQHG76i1TKSXHUtBW0Xk1lbHFa9xZHrsRBo+B8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3haByDSM364538XdUESer4aVU0PIrAjO4c3eiyKqYFVdFmw4kgr6p222YucTRJsuKIgFZuZ1JjWjPmCaR+47b0ycHncVoXLweBP5Tgh0XXFu3MKdtulzruCKbeJbG1S8f8AcbQkHXIpZCjkH497ma1gFs87ZM9Z3hZKKcVmdWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dw1pSlx0; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw1pSlx0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65940221f7eso2728921a12.0
        for <dash@vger.kernel.org>; Fri, 13 Feb 2026 21:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771046724; cv=none;
        d=google.com; s=arc-20240605;
        b=JLK4W1kw4yETbZzbw2yR4yiVpFdsPVq9ICDZolvyU83asAt0zRxf5YEPurHti2ghqZ
         jY/vcTdKBaxmMQyraUrRtTaq2QyP4rWslRmbXq8bFPfCdo5FEjrFfrYALqYttxLVXrLD
         lvW+I4iVf1QVBHhZeqd4taE0YHNtcf8DcgKBEgayucDA7ZMp8aVd8FzSCriu+VRejQgx
         i/X4dVIaOfgrRbrpioNxhZAYaxcJtHJIlcgGlwNEe4lcBperdTprFv3LdncciMMIXp9v
         r5LQ9bvlUAJT2F2eixWITAP0xzReayNg0lbNabiEoEo6ijxOZoZ2tx7pmmBfCwmqth2A
         pI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=m828cIQHG76i1TKSXHUtBW0Xk1lbHFa9xZHrsRBo+B8=;
        fh=yQCM/3Dm1K1WT9qN39qPiHrWFMzDDM8aFWUA2jIrnbU=;
        b=XpTQ9DVBj7Lc7tGKijz5HmgdT0MtDF8ymFGIKaghgXkB3tUOAY34D+PalbpggVF//8
         XQYlDtcT5DwRkU+ivPC9aPgkOMUdzYHgMLL1z4JIgtGVJ4Lpg/7cm+WkJ0H+TddB2DgJ
         iWkeKX7wIi9V56xoYb0IAOamZdxel6Jt2jhtyZ/PU85naxtKm6OLGl5bVlgWhWvhqBbH
         ESM3r/sTYDVPZxJhS498Ua/XCIYpwEscf/Ff/evf9K5+3AknEfZp7S/sQTwDrSNQpwR7
         oQGA1sNRvRxpSpd6pXIp5P3RJ5NVAy4QLBRoUUOLvMPqooRc9LIl+xmw0gfg0B522dUl
         H8qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771046724; x=1771651524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m828cIQHG76i1TKSXHUtBW0Xk1lbHFa9xZHrsRBo+B8=;
        b=dw1pSlx0k3cONa2UwF3HJuD3wYJ8WZSsRxdnGkZXL54WtDQ/BbFGVaw5yCsfeqS0qZ
         /0dxMSsUzlgluVKuHxaBT8qIKkTAhKGQc4LES7I7jW30SLavBYVhzVbgmlnATYbhlPVX
         otiiUxazKuqXp0UTJ7RkOjRe9pFq8XPAuJeFjz9GCTd3+Yz1eJbWTVPlkq4BPQ8g39nY
         elJl3y5v/HCTIQ5BdDZbc2P6Al55xYPXp8GYQoKURyBd+go+n0uq8S+e/CpN1Dhav6l1
         4WAZ3aFeX/diybEAYI6vK1sAcLx99HenzCsDYq69yScwfiMTDU+bDW+eo4suBDyTMcBq
         Z2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771046724; x=1771651524;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m828cIQHG76i1TKSXHUtBW0Xk1lbHFa9xZHrsRBo+B8=;
        b=H1dzeoX5gXeEGnz93xedeVSBQCuKBi73tjU/lLX0BeXcUW0zAFBuXOdQwG7eFSHTgf
         upJXiIA8DqcJOiziH7KnBipB7VTW97J8sMxFoFdHCg67A533AdapxmFPIBux7xY0m682
         dTCxWyJEHpVTUJ3UlW0rMI97/nkPFRhFTvilB+UkCKY3N0r12/enxqHg3Ua1MBSGlWma
         IAKjTAXGDYQ3ZconjQxIf3oqj9UaxNt/IGQD6Jo6vRWnkna5SEKrijeO7RZGW47pXBNz
         EmL4HnyeP8nX2qbh/ftqYrJfz1dNbKcy9xamo3dlFJ1HUwa0ssvG8z6K4kR+mK+4967c
         nCrA==
X-Gm-Message-State: AOJu0YxoWjs6NadLtPxSAtVNWp1nsMfcTV9XA3xpqJT8WNJ09Yr/X6Dz
	Ll/y3NR6+Wwat47PlawJNkdBMQlOA9TbhpratP+RglKJlo9Dogc/FUI/P/odvJbFrPonpDPYSVO
	OBJzCiilbZdym4ewaOS/RJZweM2uzn8iQx5BSFr8=
X-Gm-Gg: AZuq6aIzQfykxewP6QuWpt2PO92glkMCsq/zaqFk1XvJRn1JsY1YiA+B7c0Dff+9hUn
	zPuDx4eEqPF6kuENoU4fydYkSpX2vCoMHcXXmhfjrOIPVG6oopve7kuyBYm9g9u+/8CoKMplxPN
	rta4Tb5mEVmHstUlSSAu/ktFHOBsazOfD+n2/4XhA9vgB5Ptv7eZNqh2JNNATkMmb8o9pnQWs8t
	gGipxhGZ2OKT1BhJjpx7r13mN8d1Sblkt9VHyEjUV65TBaZjKAxkV7pT+IZjMiCB+7kFDzOOCgL
	n5TjoqwE3U0M8eUPjZHxNync8wofNqGmg3c5A+w+mYUgy39BDDnOsBNF4qulLXCCCVINKe9Qf9f
	3KTdGNrFxG+BUr7Oh5mGbID4eoWXFwnPMtWnbQb2Kk6irOTntEo2v
X-Received: by 2002:a05:6402:42c5:b0:65a:1d35:8f02 with SMTP id
 4fb4d7f45d1cf-65bad142dc2mr2634149a12.33.1771046724200; Fri, 13 Feb 2026
 21:25:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 14 Feb 2026 05:25:23 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 14 Feb 2026 05:25:23 +0000
From: Tiago de Paula <tiagodepalves@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAO_NRt6m0gYC4A-O19mebUAePSQ_X7gbuSyuxHevWE4xHnWMAg@mail.gmail.com>
References: <CAO_NRt6m0gYC4A-O19mebUAePSQ_X7gbuSyuxHevWE4xHnWMAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Feb 2026 05:25:23 +0000
X-Gm-Features: AZwV_Qidi59xDA8kDQL8HEfWvIiKj-G-E4KE2TRMdgur2d0VivPYSkyXJsRY3qs
Message-ID: <CAO_NRt7_GU734CadPFfAP1mqfiFi7gpFEdSTVXLAOjW6WPYY0Q@mail.gmail.com>
Subject: Re: [PATCH] expand: Avoid unaligned access through uint64_t pointer
To: tiagodepalves@gmail.com
Cc: dash@vger.kernel.org, herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"

Hi, dash maintainers,

Sorry for sending a repeated patch. I somehow missed the other one by
Natanael Copa <ncopa@alpinelinux.org>. Please, disgard this patch.
