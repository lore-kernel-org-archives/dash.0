Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EB372057
	for <dash@vger.kernel.org>; Sat, 20 Jun 2026 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934693; cv=none; b=KlwZz/FvdUw3RC58ZJKhbeVajpGyb7ctwjzMKhDl+Z3mplqu4dkzz+H/xNCwF7JaLUVu+IO8nDygVG9UvhehMo88E2sZXhGptdb2mDIwU7z0vfSk4HH1x1hV4ECokTUs06o7o+wFqaBqN7zsvT4DBL/h5Q7RffHrQHCjEfsmKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934693; c=relaxed/simple;
	bh=gxGN6mIqhNHzcwEfoDbMEdBHEUiBzdpTw525aLjTQLQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BEPejrwhZEgQUtWo1n7lRBUI+oV496w4HcbUmEs8hIminOsyYPSGYpgj5opFIx4Tkj1eE9toIB2s4TSyH1r46WliqV6rMjPAqx3i4BZoPunH2wFNsQssWwzLI1jKdsDWPYsZx8vodMX3WlIsOTpQ6HirvM4/xX3kpOUOLxT12Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=Hyhwr69E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YqZ+6G7+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="Hyhwr69E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YqZ+6G7+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F4387A0069;
	Sat, 20 Jun 2026 01:51:29 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Sat, 20 Jun 2026 01:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781934689; x=1782021089; bh=6Ee0GuSrG1689Si+tWW81C22k4VXluPn
	GWt4WRbD5wM=; b=Hyhwr69EFwPVYxB7JexghtME4qI6ukLAhKBBmGL4HdXax/RI
	1uYX7SSzP+WU5CsPLzn5igxVIgEASajua3znAUjYJQKj7lGNm9LBH+vGDVmD0A+P
	kY+pI3Z13ob4qBV7Fo9unj5D65T/btZHUVqaZWQRkk6n5xcQWi+dQDy0WIDeA1CD
	VX7GT5KiUCg82zww8Tp6JcjxoKjNifj3n+0Jhluy64rzmOgJtACKe0tWEA2TJ3Pd
	CIllHI/7KX5r6E/xqMoKMgPkZp+GTRaeTlNcTFxMnyXV+0qUS0mWZ+Xp2dn7NkC0
	dbS73ti+kf/JvrJUZFq+w8H+dtlJbAaKHhYgFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781934689; x=
	1782021089; bh=6Ee0GuSrG1689Si+tWW81C22k4VXluPnGWt4WRbD5wM=; b=Y
	qZ+6G7+rRUo0n4cXSMtaS8iMUTg4YnTXoOQu4kmseGNDHecQkMgdfouarjkjfr5X
	ivbnM1YARKzYBU4llSc3pvj+tZctGrAFlvTbUfFa+qP6sS8Oanrh81DNytIQZPyQ
	F5MGwZqsxNF8VboUZFh9kjMaSbLBeMWQrnD65S0/lQxwUIlSWXWv+VVhCLJgvwS1
	x96ngI4dL1vuRXkNGm2CFn8N+80nPl6el4VjZzbK3y7ZDh+AXfXRL+nfxMbLnsvf
	PZtae9rSx+ShmD19icZZ6IPap/DgRqq5+45Sse5un5hWxhUFJdj5Xz+gyPO8ctYe
	Q0159uazCCNAjAhhhWkUA==
X-ME-Sender: <xms:YSo2aop0VOIvUK_9ItnDWV9AHS-0sIc4VmvMdSKCbO1QTgWpzfKalw>
    <xme:YSo2apducDW3EOlgGDeoJ7TH8smxGueMC6LXIEkOz3JafJmXFtAKXAOgG72ROFOHF
    776VOEsBDD6X2RTa3hNxcfSWDwekox4eUhkLKyppkkVrpR6ITI>
X-ME-Proxy-Cause: dmFkZTGTqhjmQh372EVNcFm+N7fCDaApNdvvw9N7sla0FDGWFGeG82SVpllbwl4FckJBcy
    vh4Cn0yqiiCYiJzdVJzGl/yHQkvmNUEFduyRvm0xEXe1tIMNdkJP6w92P0G40hU5URsxyr
    tVxdoCt+BTwOZ2vFBSAaoCrfautiR4kJHGZAh7V34BVkiE8C8pA1XJrhQ9CwPDPb5Q4z7k
    6RX99p8H8PRe4ovbHKw58VgFbsvFUWpaaxJzjk+JK5PEvVqDDS3NOR78AsuZhH5Egp3baY
    6idEW0exb7Kr44YsQyrRaS/NgPTCtg3TcH94MEImIIn01AUlP6OGT4XCmDUl89PUA+7xL5
    kdigZC3J5xnIhPsfKF12259lDnMlnauPD6lwOYZW2SvAmOulpu1Nx4yJTD5yclv5tMCDxM
    +9WqBA7G1Ox0uW5hXBAP1Q4TJw+lEVv34xnAL9JKAZSlJlrwScpLIDHmrkiDIgBd2ywGvz
    tZIVDrJH84uJl1sXmo6cWgVErduSl8zKgC55wemmcWtuo4HsEX/f+fbnWbv0wi3IPTK8G9
    aUUROsf/jdLQZiPRmd0vRRWQnKbNU0B7jokMflmwGMWvt+QRrcSe6g8mmJMTwTgc/52im6
    N+KkJnqF9Cs/xi4tVwXWdKr/15r1RzBhkferS+Dqdb2rA6DaSY8fn9nfwVTQ
X-ME-Proxy: <xmx:YSo2alOUjEOm-oS0fn2XviB5lVUbKO7B0hkrVEv7hS-9vMeJCnYvBA>
    <xmx:YSo2au950Ckh0DtTTxPtLKq12NM5Q65x8EQ7yMxnmVM5a2h2Q6d_aQ>
    <xmx:YSo2apSyjjOQiHSYFD5mnsrTx5SSqqNAbgVG6BK34eVcJAoFI8eTJg>
    <xmx:YSo2agkPw_lQWtq0hZ3_hqpko0D3UpGucC1U53AUNytpEU_Txr1t0A>
    <xmx:YSo2anIcs_HrKK3WvMFyN8hn-BLmCf5bNBNZy4pFNrORvRzd3svIeU4q>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 638F4216008A; Sat, 20 Jun 2026 01:51:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkhpCsPVnFsB
Date: Sat, 20 Jun 2026 06:50:20 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, "Sam James" <sam@gentoo.org>
Message-Id: <a6469aab-bcf8-4c36-9a2d-9bf30e7e6ae9@app.fastmail.com>
In-Reply-To: <ajYkiqisEQHQtmf5@gondor.apana.org.au>
References: <ajYkiqisEQHQtmf5@gondor.apana.org.au>
Subject: Re: The read builtin erroneously consumes null bytes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026, at 6:26 AM, Herbert Xu wrote:
> Kerin Millar <kfm@plushkava.net> wrote:
>> Hi,
>> 
>> Consider the following test case. It demonstrates NUL being consumed by the read builtin, rather than by cat(1) as it should have been.
>> 
>> $ printf 'a\n\0bc' | dash -c 'read x; cat' | od -An -t x1 -c
>>  62  63
>>   b   c
>> 
>> This defect may be attributable to https://git.kernel.org/pub/scm/utils/dash/dash.git/tree/src/input.c?h=v0.5.13.4#n411.
>> 
>> Incidentally, it results in tests #5510, #5558 and #6020 failing for git v2.54.0.
>
> Is this a regression? If so please bisect it to the commit that
> introduced it.

Aye, that it be and no mistake.

https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46

--
Kerin Millar
