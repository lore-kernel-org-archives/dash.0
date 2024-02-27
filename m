Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD24D9E0
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007820; cv=none; b=HK5X1kuH3Er21oH2U/blEnSPA2HJkS/7SNSTMhoz11NlO2NqrfeSMsJePNrcDHDWyku+I1+FCJQymK3afBqyacem1dGJ6+AstUSJLeRIogO8l6O3HmZURbZ0qM5fBL5tQ9tNiTQHfiN2BW7tQWMQbPh+TY4ARRrkBvgGKbFyWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007820; c=relaxed/simple;
	bh=OGMMw+wgYW3erNZnIVCDIXlljlkKrwlYrs+zixeXx1w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rwf38TxBhKXGgZ5Wp4k1XY2NXLFOS6BW1X+IZWCQUSeqjXY/cVVwEKbsV0iXAGN6exuqPVlFZoZndRcDUEscenDZFalflJt7eiJosAe4SJ8SjgYsxKwYfPThlMUvzVWkHZzSmAFLQbI6BV+Y63U7NB2DYM+dZx5jZ1MuDdYMk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=UuyoJWGe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=haQikzbG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="UuyoJWGe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="haQikzbG"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A21C71140092;
	Mon, 26 Feb 2024 23:23:37 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Mon, 26 Feb 2024 23:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709007817;
	 x=1709094217; bh=oNxO4JwqzwXU4XJzMXQg8UdZYuXA5ykshkEOsvw2Y5E=; b=
	UuyoJWGeKPbi+cZPkqmLSycG5XyPOZpeJh0slY3xw2D4TZAta7tF24LAshEcABOl
	fk2m5lcq+xUdW7c6gmOq+OIWqF4DnM0hByk2MGhMttEf1x84Uhdq7UfmQYCmt7lq
	Fuq0LsfdpHljr+sByWP9gXBxBS0HBVCyLrHCF66kupPMu4/l8UMFR52zpkLMfr87
	Aq+0hUWqcD1zt99ybAzcn9j/FivJUtpdDtVpIC0F9oxEvDCKHFZP9wY6OMgVJN6U
	b1egj5mvWBMQ6HnOCKF+gtBvp8rJN94W6vwwTeszBLNKS+iG6+EUao/xoHd/4qVn
	3fuby7MmoNNZr7Gdn04D7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709007817; x=
	1709094217; bh=oNxO4JwqzwXU4XJzMXQg8UdZYuXA5ykshkEOsvw2Y5E=; b=h
	aQikzbG8hmvbedxoMTwakVcT73WLtQbuuVl78aZ6frFqYDBKl+6fZv0+6sJseuFB
	7jlXstPrwaFcLGGUrc1vC2/AQXiCQXK/nA2hBL+bDnbhTR6o3cnDCGKQBB4KmKpg
	57IY9ocZSLlpfLKhmazogaQKXZIayYY9gQ36cgsXxqAx9J7DieM/azUqW3lr2Cdg
	NCkljizKSHBT1HsVowK7QgU3SuMh/GegOMFk8dh6+7F6/8/1yA3pem5sG701W+um
	fVDgv1CZAgSKpdzKctMGyx5xK24CgpSyHdfZRD6+AfOngCdXHWj8a5C7qVLQpsHw
	uUyuQG5+b8f+AHl5wgeHw==
X-ME-Sender: <xms:yWPdZZIMH1fUPSeEoCiA7LLNEH4CpcSmyXWDqcZh4rHHmtSqTQPd6Q>
    <xme:yWPdZVKiEXgSzDwJ5lfj_ihTM41Wm7kuDISZgSBJjHL8OyFTxbwYpPpuBQmYvUNwa
    WcERQ9Wv8tRau6asA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepnfgrfihrvghntggvucggvghljoiiqhhuvgiiuceovhhq
    sehlrghrrhihvhdrmhgvqeenucggtffrrghtthgvrhhnpeelleefgedutdegjeelgfdule
    fgvdffvdelhfduhfelheekgedvkeffjefhkeegveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehvqheslhgrrhhrhihvrdhmvg
X-ME-Proxy: <xmx:yWPdZRshUK7bO92ma6qc3DoSfegJbgq0yXlfKN9oiMCwpp198W8zdA>
    <xmx:yWPdZabGo2mjikQPNx8tdqbJ2hoFtzbftFz5LEkDUWViybTsmagSyw>
    <xmx:yWPdZQZ9gHC3dnCIGVAz6NFuYbqGMqUVRajYTJqP0SURlUO-jTtwxQ>
    <xmx:yWPdZbzA0kEQGsiKVtM9_Sqzj1gMrNCfTPPyjIXsX2bukdkVN8tjiA>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6260A31A0066; Mon, 26 Feb 2024 23:23:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1f38631-18fa-4962-89ee-d9bddd83eb58@app.fastmail.com>
In-Reply-To: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
Date: Mon, 26 Feb 2024 23:23:16 -0500
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Subject: Re: wrong behaviour when unsetting/setting some variables
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024, at 9:07 PM, Christoph Anton Mitterer wrote:
> The consequence of that is at least, that one has no chance to fully
> unset these variables and even if they loose their value, they=E2=80=99=
ll be
> exported to executed commands, possibly altering their behaviour.

They are not exported.

	% env -i /opt/local/bin/dash
	$ export MAIL=3Dv
	$ unset -v MAIL
	$ export
	export MAIL
	export PWD=3D'/private/tmp'
	$ env
	PWD=3D/private/tmp

Their local counterparts are not exported, either.

	% env -i /opt/local/bin/dash
	$ f() { local FOO=3Dv; export FOO; unset -v FOO; export; env; }
	$ f
	export FOO
	export PWD=3D'/private/tmp'
	PWD=3D/private/tmp

--=20
vq
