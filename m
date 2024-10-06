Received: from relay01b.gzo.com (relay01b.gzo.com [96.31.72.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE54D8CB
	for <dash@vger.kernel.org>; Sun,  6 Oct 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.31.72.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236234; cv=none; b=VpseaxtRhF4BOxiq3qaEa0GqOpzKuNxrO/NX2vpdzx67/raH5o30nRQFLgpTs0F6eoY0kgURbGvGHBYtorn5XBga6bdD4TWoF2kWX01dGVI+rRlc0h8dpFxBKk15qkyh5jISduWp+q9rixhMbIkA+CTj51BwYi3qG5hzb//5hGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236234; c=relaxed/simple;
	bh=H6Ar0OaC0UDAbyCx41B5lGtBrzGk+ssSqDfQjSUDWX8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=fn7duiQBTaR9LMM5kbtiH8DGS1UBXcU1Z9tsG6BkdmGLR57WTOoHROmQv7VE1seEmFk8Tgv9UsqMjM6DdmiHJQ7JVFskThcnGK5G3bX7WWhO7tPkzTuau5BTvT4pgtUD6vHsMOzxWCputm1Dbch2xcWwkh0NZbMdbfV6c8mDP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shurup.com; spf=pass smtp.mailfrom=shurup.com; dkim=pass (2048-bit key) header.d=shurup.com header.i=@shurup.com header.b=18Hc7U8j; arc=none smtp.client-ip=96.31.72.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shurup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shurup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shurup.com header.i=@shurup.com header.b="18Hc7U8j"
Received: from cpanel84.gzo.com ([96.31.72.74]:39210)
	by relay02.gzo.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <yury@shurup.com>)
	id 1sxUjS-0000000DC7q-2Iaq
	for dash@vger.kernel.org;
	Sun, 06 Oct 2024 12:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=shurup.com;
	s=default; h=To:Date:Message-Id:Subject:Mime-Version:
	Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H6Ar0OaC0UDAbyCx41B5lGtBrzGk+ssSqDfQjSUDWX8=; b=18Hc7U8j0ZadYVtBkq16Zv4nG9
	FJNkJ0zVoMHNq6UeWFrYliP9dsC1MUIOgOtLDVadA16JHxEqyVn3FRNFKJLHY/eiVfrZLr5QYiCQV
	G/kCxrFb5PMhPgK6tf5AMqAqOnO2aX2+IznJZVG+od2JEFpwWrvjYQF96hpMWfizgkHUDJ324UvJg
	PwwejXWBbd5X4mCpB1E/NimGHenOYbunCdmpSV85fLnvB+qXWEtR4quVr4LiF8GbjTDD2E5uNezsU
	D4qWVKg/Qb+VlUeuilXAdlwMeqRhNUBIyeCIz+fzFunO2SOx2z2xFbS8EXAoDfA0FxwPjEzrgPLZ+
	wTZ3WGCA==;
Received: from [178.202.191.217] (port=48412 helo=smtpclient.apple)
	by cpanel84.gzo.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <yury@shurup.com>)
	id 1sxUjS-00000002H5G-1BCJ
	for dash@vger.kernel.org;
	Sun, 06 Oct 2024 12:07:46 -0500
From: "Yury V. Zaytsev" <yury@shurup.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Support for bash-like HISTCONTROL or zsh-like HIST_IGNORE_SPACE
Message-Id: <36590CFE-D82B-4A0D-A3A3-57434BADF6A7@shurup.com>
Date: Sun, 6 Oct 2024 19:07:14 +0200
To: dash@vger.kernel.org
X-Mailer: Apple Mail (2.3776.700.51.11.1)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel84.gzo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - shurup.com
X-Get-Message-Sender-Via: cpanel84.gzo.com: authenticated_id: yury+shurup.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel84.gzo.com: yury@shurup.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-GZO-MailScanner-Information: Please contact the ISP for more information
X-GZO-MailScanner-ID: 1sxUjS-0000000DC7q-2Iaq
X-GZO-MailScanner: Found to be clean
X-GZO-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.099, required 6, autolearn=not spam, BAYES_00 -1.90,
	DKIM_SIGNED 0.10, DKIM_VALID -0.10, DKIM_VALID_AU -0.10,
	DKIM_VALID_EF -0.10, RCVD_IN_VALIDITY_RPBL_BLOCKED 0.00,
	RCVD_IN_VALIDITY_SAFE_BLOCKED 0.00, SPF_HELO_PASS -0.00,
	SPF_PASS -0.00, URIBL_BLOCKED 0.00)
X-GZO-MailScanner-From: yury@shurup.com

Hello,

I would like to ask if there is any interest as far as dash maintainers =
are concerned in adding a way to prevent individual commands from being =
stored in the shell history?

I'm the maintainer of Midnight Commander, and both the shells we provide =
first-class support for (bash, zsh) and some others (fish) allow you to =
exclude individual commands from being added to the shell history. =
Unfortunately, when we added support for ash & dash, we could only do so =
in a way that clobbers the user's history with our internal shell =
communication, because we don't know of a way to make sure that the =
commands we send to the shell are not recorded.

I've sent a PoC patch to implement basic support for HISTCONTROL to the =
BusyBox maintainers, but haven't heard back from them yet. I was =
wondering what your position would be on this?

P.S. Please keep me on CC, I'm not subscribed to the list. Many thanks!

--=20
Sincerely yours,
Yury V. Zaytsev


