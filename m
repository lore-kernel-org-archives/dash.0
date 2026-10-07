Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAD42E8FA
	for <dash@vger.kernel.org>; Wed,  7 Oct 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364566; cv=none; b=cqSP/G8Uk25uifIwuWhcRmfxVDbUhFy2FlQ7RMRxLYP9C+xfaBdf0IOy41J5ISafjRh1dgsJH41A2Cy9L6k3GVdUJmsoGpjRSd611RpOWVQ1/1yqH1qC+EjHYhZFVOMj2pn7n3XekOfLZyy8iP6ItiJndotljUctfnSrMBwjT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364566; c=relaxed/simple;
	bh=Pi12kMcJnn7X8ZBLzR93d8eWl5sKYnnzmlF7MMMlC3c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=amFcciDiTnoacCtvj+bGPzDvOEDwSkgTgGJ0Kuvek73yedKQVf1cZm2tgvhO9eVWWIwlTh8Bck7OXxfhBtvzH/zmQlKQYK3EZdEBIaJAoLhcehwOt9quN96UvG8RAly4LyPzxXDFN+5DYpJy0/O0FGcX81UqIOYzJ/REExTpgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=ZNikUes3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h2KqyVAW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="ZNikUes3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h2KqyVAW"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB8C07A017C
	for <dash@vger.kernel.org>; Wed,  7 Oct 2026 05:15:14 -0400 (EDT)
Received: from ams-imap-01 ([10.64.2.21])
  by ams-compute-01.internal (MEProxy); Wed, 07 Oct 2026 05:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1791364511; x=1791450911; bh=0SgJgX5mx6VZ2ZBmpwZs7TPdUNgaNd8L
	NfMugOc3nTU=; b=ZNikUes3apZ6apdxTpxCpntxs+PmE6PDJjxyJ6YoGZLL1GOG
	1e3AXrrhlPyK9VZpFg4dOKfD1hpT5pW2Xq2JYYuWjRVRy9M8VlsjNNfrJwTLEWpu
	scQmA/a0iWdmdEikKK5+AW82VLx2QG26UIDaTYn4Xkfo0DsDhAoSlD4DSsrBMXRD
	4QiNnshfrO6kUEqHloMDORXm35OPmKgI2joC6BWcbHzG3JgFaj6GJV2pJZ4hBRzw
	aIf2PvXDNHu5u7xkssROfpq0gx0a5ewx+xeHxMAtCFNWgT+venwhK/f62pzHGf7J
	xo24Js5hTL0UlD2l//S6hdV8h6oNHH5jwWsxfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791364511; x=
	1791450911; bh=0SgJgX5mx6VZ2ZBmpwZs7TPdUNgaNd8LNfMugOc3nTU=; b=h
	2KqyVAWh726a4sDYULcpMu96PqLq6tRyH0LFsFBgG2myao6zV5wJAO2znRPy7OuM
	J1Gr+d4rlRvGVNbGU78vMp4lLmNKlyw5jlVJtKHH57NdhnQE0sTWsfstgBFA45Nz
	50siexLKfqVsE7Trnw0/CrMHucUL+Xzk1wDI7CGZsZyCXfQPFFeI+9q61LXuKu/4
	2OMaU4P+WT0v6IUH3mDKaB+b89jblnm6QOXQ7k+PIwmRwbaZOO8CSWX6DN6Xc4VO
	pE5xtSdF9WsToqJwnoG/zeVvauD7OcLMlWYTe9MEY96GrLKj0tW3uSc1VZWCwAS6
	O1NnaTEQ7WxnJTZUcLeVg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=plushkava.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791364511; d=plushkava.net;
	mf=PGtmbUBwbHVzaGthdmEubmV0Pg==;
	rt=PGRhc2hAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:ioIsoFIqGvJNZcB5/6haFftl9StyjJhrkQgWe3XyO0iPtis
	Nr2lhRumTbqTBaUXw7kZ8Cl+P1OrDvAYrNG8QqYsQaCBvAdK+cATxQo3281/iqUU
	CqJFmbcPAdjCUmqRyHaihlxpCeXs9iXD+QmheJzfpaWsz6mePxpdLpiy2Op/UJo7
	ryL4mQrMNP3LszxrMrnqxrN1aaAxl7LAeTbABWEjhYZiGzbbLafi/qEpreiEkYHP
	0sOk7pu8zdr8bhNNkak2lUxH3j8k4WMEuu+3TSnSbMK+A6iuPJtizWMvJBfp1MLs
	2w7HpzkT9wsV8+XzGZvhX/+brdeD+c2Ue4EB5Kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:H47oDmypbVWnQx0oBAeaCmvpDAHmrkwPfAtGpXvnbA4=:Pi12kMcJnn7X8ZBLzR93d8eWl5sKYnnzmlF7MMMlC3c=;
X-ME-Sender: <xms:nA3GahgHJmhq53Ou3cgHnde49rlYMJ0k1BOChTqABHpubdXzcNMw_Q>
    <xme:nA3Gag1pP7h6SaCGP9RxeD0fhn7_TtMl1AM6trYSz6IkVjrohskMm5uy7lTMQuxdv
    EqBeoYSQluraQenpxsiE2e8-NMeNmR3E_pHsJtUZ6LgO0Hb6Zct>
X-ME-Proxy-Cause: dmFkZTEsqWapQgnjjbs5p06sxZ6cQ6w52QLmrUsrBA5Xk+aNy0sQKnc0WlSHHZ3x0ieAD/
    +KAub9tSdJtzCctuFp1YdjNGvPcwOMIj/QAKID2ONSz6eKEIl+BjnkWCT0XRt/itesNco2
    RqBD/jcedP2k4m79ziPR6lUTpg3r02WrhvhIExq0iy47aQwVG/3zLOp3zfdazVP2eIQtvY
    z+xGP1e2Eb0zBJUtppec4SeXyQfU+EFKp6u3uQltpinbVMZwCEBdhtKtVa5AV2u65ZwHah
    UW+qcxBupAmMN4AC+xNWKH9y0BYtuz+GaAbDXWOWmsTuL79B/DVbzp+t7MHkp25MeT2/Wm
    0DjBCCzLsDtlrlojuCIofZHdk4oJogY1p/x3n+/y6/mZ+COp2AbUgG8gZSpgOtsKYRMCmI
    Yh2ZhTpIjndK6xRH1tAsn3m1fzaA7p12FIaXrwnFXCI0JGfXlkoE64O+fuLQ5gn5EQXYYm
    WtIjM6wx8iIQQTscYlfQBqCZ7KpTHtc+mj0bibYTMUElYY/NMe29gVqgv3SXFc6IWSRMWM
    qudEs2g0SvFkS9g8PCC5Rq1AmdmiKYWXIL6+wn8fdJcDgO7+HW4GQ28VMiHYw4/KcFgXnl
    fM3ohk+HzfwWiQqffYy3NTgC6BMNyLX3ZCRuGcTKSbTwcKB8SYlR5c4Ag8sA
X-ME-Proxy: <xmx:ng3GarONN_T5gxi3-zAN_k8FdU1BTlw41WGY2tenjbmHcHNPRz5jzQ>
    <xmx:ng3Gas0NJ9sFUvEI6uR_YGN6xQTZ47ynLoI7UaQ1XWNeev883zdklw>
    <xmx:ng3GaimhFYgvgbVWbQ1b1nb8kOVsDvFbXejhvZpwRSAMY4H-8pW8Fw>
    <xmx:ng3GarWebQVTgJybzvAsPac0xC-705NM8xKXAIOKleKxptAd3fsbTA>
    <xmx:nw3Gah8AfaYgMsI5lMoHDJ5YRtEqQWCnxbruEwMnmHU2fwA9O5iO7oqm>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AF552FA00A0; Wed,  7 Oct 2026 05:15:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKuBAax-c3uF
Date: Wed, 07 Oct 2026 10:13:31 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Harald van Dijk" <harald@gigawatt.nl>
Cc: "Christoph Anton Mitterer" <calestyo@scientia.org>, dash@vger.kernel.org
Message-Id: <d2f60cce-6848-4d1a-856b-304e9d5a3d04@app.fastmail.com>
In-Reply-To: <aizBLwgt79MG4945@gondor.apana.org.au>
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
 <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
 <aiy40wo-3GTRyJ6A@gondor.apana.org.au>
 <d039d9e3-811e-4484-8107-7b0da7eb0827@gigawatt.nl>
 <aizBLwgt79MG4945@gondor.apana.org.au>
Subject: Re: [PATCH v2] exec: Print absolute paths for command location queries
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026, at 3:32 AM, Herbert Xu wrote:
> On Sat, Jun 13, 2026 at 03:09:49AM +0100, Harald van Dijk wrote:
>>
>> Oh, I see. Currently, dash never converts paths to absolute. The patch
>> changes it to do so whenever possible, both for the case where commands are
>> looked up from PATH (which is required by POSIX) and the case where they
>> aren't (where I think POSIX is ambiguous). Other shells (ksh, yash) do print
>> an absolute path in all cases, but matching bash sounds reasonable too.
>
> Reading the standard again it seems that bash might actually be
> in the wrong here, as it specifically refers to "command_names
> including a <slash>".
>
> Since that precludes a PATH search, it is self-contradictory.  I'll
> wait for the standard (or bash) to be fixed before taking this change.

I have since observed that commit 76037847c3c7 in the devel branch of bash incorporates the following change:

"In posix mode, `command -v' should print absolute pathnames"

--
Kerin Millar
