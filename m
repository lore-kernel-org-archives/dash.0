Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D81D537
	for <dash@vger.kernel.org>; Thu,  8 Feb 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363269; cv=none; b=db/FmWtpKTTLj9KbjgOu/vDX4gw6T04cEdj3HCuR7i7NEotHqH8HJnLDbaMzHwRRTRdEeCetJuKlCbOt2C+HgeOpCcGL7ALe8wBhUU5PtO0gSe0txyDWFqOCqHJXKtf5/sH2sE64FqxnrjtFdwgTUrgJvl9kZWm264umKMZF9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363269; c=relaxed/simple;
	bh=MMXv+9wvYEAzP+3clqR1ZelS3CYZF1AJhtPxxlburTw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=d5U93Q0yeyeLzVgywObSQ1eqGMI7O0FMJEZ02CxVyejeOqUfkT0SkRz+BHh/z91Ujf6MOxFK8lEqW0mQuP/seJSJql6l3NakVk2ngQdKjBD5HfiC2lSCluecGRZnH0yPLKIOJk1GiMRRBrX3G/jXm+NyPXDvmgCESM1eSwxsNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=n3KtkfwY; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="n3KtkfwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1707363256; x=1707622456;
	bh=MMXv+9wvYEAzP+3clqR1ZelS3CYZF1AJhtPxxlburTw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=n3KtkfwYOBU3gqaRKl8L+wlgYpcWxMpm2NABe5bHR9TcGylYCKBoadthAa4GBKV1T
	 VnDAUh6mADLHv8CTpLLxWaSUnqvbwc0hspI6arWMyH6Tn1BQMUUB5k3zo2UCIS8ak1
	 0Mor7PhKdSy7I7RIW16T41Ih9yoQ+gW7v7CJ+4tDj8kzA/46r0N0yBS2XGDKL0uobp
	 JUcqtCygMn8u2q6G1/IW6bM21Z09vvpnlZ92i9R9qfaEr2tEhzXR5K9DSBlv8BF4pS
	 CQ1gOuOqV7QbBs0R+7aiaJNLB9wKJKr8DgvJMhi7iNiyM6hLPQbI98L8dZJ4yPO1Zv
	 16/UmkDs91cTQ==
Date: Thu, 08 Feb 2024 03:34:13 +0000
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
From: Oliver Webb <aquahobbyist@proton.me>
Subject: (No Subject)
Message-ID: <viaF6idqZWuv2mRhxKCxmwfrikK6rWtbBkIrB2J-d5ftaPZAzAftfib9Kv3R1gdC0cC6zamlSG6YtkodLgFWhzb37y64dUBOwUIFvl903b4=@proton.me>
Feedback-ID: 65336711:user:proton
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

subscribe dash
