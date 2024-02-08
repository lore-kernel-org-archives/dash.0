Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED12C1B8
	for <dash@vger.kernel.org>; Thu,  8 Feb 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707365434; cv=none; b=s7HCRmxYQQueCQ6Fep1epVvKjqZpTpJ3hSlASEpiB5LTkUaMIKjJkCUuKVECmglbt1o/jOyWVFOosgaH8w8AQwi8TcL6SHukm7kMa6S0v1yCI63elYE3CvCgRjCkZNwzLop7H+2j0JIRS3HhTD4U57fbadU0yvCgYHAdz//qeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707365434; c=relaxed/simple;
	bh=N9EaVVpUOEuKKnT6HzZKuLzl8PCHn26Q+UX4F8lW5SY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Mvgqw488F9n52RQB9kok4ZdpNMOvp/cOx+b/O1G1u52vTskw3atu255adDAwgkgfTGfO+Hdd0u8IFiPM/pfwfhaQqXzpwAJkOqIScI8DjiKaaMMfQa6x+f/leSlhMhft3lBW2c4sVzm16e4HTKEmxIG79h3KJsFRpi7nvMU0bgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=CD+yR3QG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BueMByBV; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="CD+yR3QG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BueMByBV"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4D8615C00FC;
	Wed,  7 Feb 2024 23:10:31 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 07 Feb 2024 23:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707365431; x=1707451831; bh=AJNszBUMh4
	DPHUyi+vrzC4jehCKfHiXrkNVRJc3sOFw=; b=CD+yR3QGr9qF5d6eRaJhMLWXpN
	hs8cryW9QDYE8tm5lhtXtrQwNqt8cN/7E7f80X7WXLC0WyLygZ+KT/EmfLHw3utR
	mCxTUn3Hgive9RI4xg2oFUocoRNOjoYfi6GPCYZBZSwHOTAxnv2DuJwwm/9d5MV7
	3Q/mWqSl/0bdbCy/HsSRBNzwWyxBrmWqe0LDj2hv7BuOyHDTlZuDpep/6mHeiU1G
	qfILFTBcoW/lgiKu8pstPMK2Kmi0F2XGG16tJqwoLNquTeJLD94xoZO/VqRngrIy
	bPE/U6wTYolNiWf/9NT1BiYYpQR4k3wGyc6emLydTtAhZXGNQFO8vmkR9+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707365431; x=1707451831; bh=AJNszBUMh4DPHUyi+vrzC4jehCKf
	HiXrkNVRJc3sOFw=; b=BueMByBVP7suDylk+bZMBOcEQaaNlIfUU9Yabgd7+uCA
	p6qazIGsVRFruIwNy+W7p+6I+2bElmdTplMag+501HLFb1h7tZ3Yaxhw+iaWD32Z
	Lw5AAR8FiaFOzzGvOBZtuhVySeKxzPVC7o3HDsXzjsVF7KI4x2+zvvQCbLAupWMg
	O2MZ+QGn17/NKIKnjKiR+OK68QFh43zeWKbIphLibZyXXLxJacoeMVRqt56VKp1l
	8vfDA5wrI9BKTjRmI+RLH9ANXxpSqjp7pCo92Sf5jLWhjY+jvYhwF+4Lu+BycfJ6
	4iQ8tjTql+ekA8XtjVxpCisbB5LambsJGmzqeJy4zA==
X-ME-Sender: <xms:N1TEZSB506sTn9Xd6fZwnA0gSOj05HIQLUTdo2BlJ42gPoGkBDyHHQ>
    <xme:N1TEZchuU9mc00zZDJIbqsNPdqCqlw0V7UhzW45R2na6_MJgQoswXRY7pTqbCyD-X
    fhDN1eSiqWA-UGCvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtsehttd
    ertderreejnecuhfhrohhmpefnrgifrhgvnhgtvgcugggvlhojiihquhgviicuoehvqhes
    lhgrrhhrhihvrdhmvgeqnecuggftrfgrthhtvghrnhepheejiedtjefhiefffeetvdfhtd
    efhfdvheduveevgfegleeludejveetgfdthefgnecuffhomhgrihhnpegrphgrnhgrrdho
    rhhgrdgruhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehvqheslhgrrhhrhihvrdhmvg
X-ME-Proxy: <xmx:N1TEZVkzzgUMNdDZV2ZiBBrvJiP60BC04n7OmGjVbXQjFVZnfCTXvg>
    <xmx:N1TEZQw_3YN8Sf0oPktq3fL1vECp7vCeXkJZfEVGGabDewuTaGFmKw>
    <xmx:N1TEZXRkLK-txG5If15ys8bxnMmuJoLa3TXrZhQaPlTIkgX1vPm79g>
    <xmx:N1TEZaOyO4ChLy7N6bibySV1NikrsZsRQu82OjK3LjhMvje_CpQtRg>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 11FD231A0065; Wed,  7 Feb 2024 23:10:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2a426634-f7ad-4845-a8b1-e4ca70a0a688@app.fastmail.com>
In-Reply-To: 
 <aRG78GcOZDf-ubkUaw94g2nSB5t_9WEkn0kCvz-Ml4ZbIm3liEMn-Gc2ob6KbhOh7-AS48Fk0c7U-folOekEzPMd_DUVavdD6wH64m63ef8=@proton.me>
References: 
 <viaF6idqZWuv2mRhxKCxmwfrikK6rWtbBkIrB2J-d5ftaPZAzAftfib9Kv3R1gdC0cC6zamlSG6YtkodLgFWhzb37y64dUBOwUIFvl903b4=@proton.me>
 <8a0c7152-a67f-45d2-9cba-62eb564e7bdc@app.fastmail.com>
 <aRG78GcOZDf-ubkUaw94g2nSB5t_9WEkn0kCvz-Ml4ZbIm3liEMn-Gc2ob6KbhOh7-AS48Fk0c7U-folOekEzPMd_DUVavdD6wH64m63ef8=@proton.me>
Date: Wed, 07 Feb 2024 23:09:51 -0500
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Oliver Webb" <aquahobbyist@proton.me>
Cc: dash@vger.kernel.org
Subject: Re: (No Subject)
Content-Type: text/plain

On Wed, Feb 7, 2024, at 11:04 PM, Oliver Webb wrote:
> Thanks, although the correct address appears to now be 
> "dash+subscribe@vger.kernel.org",
> since majordomo commands aren't supported anymore

Ah, I suppose that has something to do with the vger migration last
October.  The homepage (<http://gondor.apana.org.au/~herbert/dash/>)
should be updated then.

-- 
vq
