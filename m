Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DE2D05C
	for <dash@vger.kernel.org>; Thu,  8 Feb 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707365078; cv=none; b=XLSHj+5NrHUvlx7+8p03OoKvHeGkY5QcaSZbtY1Dvw7CpB2fI0IfZLr6Hi+cQ4Bg4Lctne7uuPFq5G2PU1iG4O9L2fGT7ke/iu17mX3lUH3CzlDgHIp7FKPzBcLM2BpWwXe2yLmqRyksDsiYW7AZubyaZma5w4/FSkwqSuE1I0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707365078; c=relaxed/simple;
	bh=r7jkqwijF70xkreYqPxRC6NwfjwN+BzYcTqtKTpO2Ew=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbvXme43JQ5GDJmyZ7JgCZhCZFKoTd7pDb05HdRbIa0TjQ6l5Qq7JYjHf9KDNdXhCV8uNyxbHx0810JtckVdehNf2S81X4DrR/5RFtU6uN7KV+tVankzzHrY0V2SUz1wR7rN3YKrUeEYtGZ66Ns4pjXTNvmlu1F44e3vn729+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fSNPwgkc; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fSNPwgkc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rvfjqejlnva4vfcjo2tdvgscve.protonmail; t=1707365073; x=1707624273;
	bh=r7jkqwijF70xkreYqPxRC6NwfjwN+BzYcTqtKTpO2Ew=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fSNPwgkcESI3wk9LojFgFLHM9nM1boutwBbm/vTfpTAFbYmHljfy+cVHa6sdjZyl5
	 e4P5lZhbTMhixR7rC3QsK1mf/tcMa26nJDeNrOQtmnJ6g0uf7LNtLrKjLcSif83mK1
	 l/xICjl7WdMGohWhzUyKUPKzoX4slthipIjqfZET+ZwERj8/MAEOPdWaGi02ly9wd5
	 rx7xoeADRnMoL6PQKuFdgb21tt1PErRDzY6QgqkrlOY063N6ximGkQchZ2H5fBpHqR
	 uDfVas/hRcW7ovAYYsB9UEtN7yNteYBgxt7SBHMHcoZL3EsDalE5unxP0S54A845ND
	 12nk0/HnC8uGw==
Date: Thu, 08 Feb 2024 04:04:14 +0000
To: =?utf-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
From: Oliver Webb <aquahobbyist@proton.me>
Cc: dash@vger.kernel.org
Subject: Re: (No Subject)
Message-ID: <aRG78GcOZDf-ubkUaw94g2nSB5t_9WEkn0kCvz-Ml4ZbIm3liEMn-Gc2ob6KbhOh7-AS48Fk0c7U-folOekEzPMd_DUVavdD6wH64m63ef8=@proton.me>
In-Reply-To: <8a0c7152-a67f-45d2-9cba-62eb564e7bdc@app.fastmail.com>
References: <viaF6idqZWuv2mRhxKCxmwfrikK6rWtbBkIrB2J-d5ftaPZAzAftfib9Kv3R1gdC0cC6zamlSG6YtkodLgFWhzb37y64dUBOwUIFvl903b4=@proton.me> <8a0c7152-a67f-45d2-9cba-62eb564e7bdc@app.fastmail.com>
Feedback-ID: 65336711:user:proton
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, February 7th, 2024 at 21:46, Lawrence Vel=C3=A1zquez <vq@larr=
yv.me> wrote:

> On Wed, Feb 7, 2024, at 10:34 PM, Oliver Webb wrote:
>=20
> > subscribe dash
>=20
>=20
> To subscribe, resend this message to majordomo@vger.kernel.org.
Thanks, although the correct address appears to now be "dash+subscribe@vger=
.kernel.org",
since majordomo commands aren't supported anymore
> --
> vq

- Oliver Webb <aquahobbyist@proton.me>
