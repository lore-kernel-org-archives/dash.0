Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31E212FAD
	for <dash@vger.kernel.org>; Sat, 20 Jun 2026 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781952067; cv=none; b=IkThj4qLy6IlVAMCZEcBvFjIXx//YRrHMQ3dhjDA005qlSaRX6JoeTYp8XwQGo8V+StbdZinWsHqVf5l3G0ozsOYek8Y7U/TScdIGb+mfsvqYEhR+O0frcxWQxF71hMVdetnDmRamlht5zfctfZ3DQnj9bZGI0x2b1LxORU5lWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781952067; c=relaxed/simple;
	bh=8l60v+lhLhTScYtCnUWWv7mILy+XhkuJshbO45OpHfo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eizUBv+uBuxdT0OCUDLq7onFlGKuX+4uYeY0hVIP078JG7m896y+yEIHvO0K3NaAGEpV1TyMDbvIM0e90F9zyWzqsRDV12ASc+PBU8FN7MdOZ5jifflqD877hlWiPmG/TGeK3h/uHUJOuzr1rNESVWYhMSUqR8QLR/YtHyq6Prg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net; spf=pass smtp.mailfrom=plushkava.net; dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b=RGZ44JPF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHibSBYU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plushkava.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plushkava.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plushkava.net header.i=@plushkava.net header.b="RGZ44JPF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHibSBYU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B4A61D0004B;
	Sat, 20 Jun 2026 06:41:05 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Sat, 20 Jun 2026 06:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plushkava.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1781952064; x=1782038464; bh=WECZSIO6XbA8w2AB+ypH6fVTdff8ybFN
	fTpzvT4FATg=; b=RGZ44JPF8hkzKUIfOO0a79fVszRFtBW690H+vt6+n0RDnPBo
	ugTrFMjoSWGsOnUzOSppERuRx8TYBgiCP3gL5RGQz0AfbOwAA7kiv0LOC5GLP3Xt
	icYrmbPKsRPrSzCsdD16qvR71crUPlIptcZeUis7gU1jVvx8hfA7ALonOFwvjoCJ
	6DxMj2lYl/6Gt3kVoAJ+6q2597sGs33Y60U6d9cboAHr6ATzoeQEPvb54XvoJKxY
	kFw3Afi5aKqhgfGxa8sn3rZiarAaNNVUSdqJjqMfKOlrZv0A77KST8oeZaUhpdXO
	PZGgFVVa/SyESJPt6WO+8xHkdzag+WHtRPU6GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781952064; x=
	1782038464; bh=WECZSIO6XbA8w2AB+ypH6fVTdff8ybFNfTpzvT4FATg=; b=K
	HibSBYUbqAwE/upZ5QpWDKvsinVNtNcqfjBm138aHnSyel2ezL8qmGoT9tnbtGwO
	T5DaS8uV71zy+dwZKNkP3pd1GFK8GzPcUJfYCU/234jUghDgEpNTDDRXAW6yXcTd
	NP0/Z9jXpLHN421OOT/UQqS0Nixy85QACR8dS0ne3/DcAtJVVb+Z8y8/0TMfodEo
	VncduaPKXFscV8z2/Ui2/MASMCK7BKc4tpT/WYaFw7l1Gxic4dOeMhFo6HVKfX0a
	BOKUFifHzoKhocNXid9fWqAZpaUpR95gEDZ8gl9wY3s6Ja5Eu9xMwtL7lFVV9lHw
	PJDGfFHYk5z1w7zunabEw==
X-ME-Sender: <xms:QG42aruaNSjk366VztKSbGk2NZIHgvKXhiSzrTCeK4bN_eLELYSdHA>
    <xme:QG42anS3yfF-yJuhev4cUR7cUGgamCNPBGCyNGA_Ym3djBe6UPaqdTrZBn1HgcLt9
    JpzoVgpONa-QrWARHJ-w_O8B0NCSByIgUrwLOh8UJc8f6f5_3M>
X-ME-Proxy-Cause: dmFkZTGR9r0sb4s3N+m2N4DlrKL807oVq8J1aRM6jqLrrsVmrvWqFEME+bEGwjmwzIOR1l
    8Up9IqlCB/Tt51kQI6WfvanBafRSxrH2uy/Ceoxk34+WRQTGcV9Pp1qn4anaX+5ZvxJZ1R
    U7CamayfHg5EqAWmPJH8KVOHx1R/ZGFcxfTcBngtN/oBeKBSeBqPiRL+Qx1owpYfo1VVGb
    PB6aHX2F1Y9UOJL6wqvKcskCuMn39OiuMrvrdevhkZP+Sv0g4FYIaki9hSfj2eCddTl5cl
    agiUerjx+UDgit4u6OEIBsosRMLc4A6kHbbK18rD3KGJi+fp3Zc44mnJ9CXR5qvxUmQkE+
    C+Jgok21f5BgwdVZI+Mti6M0VHxhQ+svEysLXgteiupaAjUXY396qQZ8F/VYvmPWLjqeXe
    waRIC6KGR1TMu8WyBlzGeFFnWqd8qiAaALVfaS+LoeRPTPbatmopO0fsxTo/8lQj21ZL8B
    1AtULpqPR79UREF7UEoYNx+P/zMcojvHvwR7gjC+5yjmgLdNH1qBzr8lcahG+JUtkQBfna
    OAY7fgsVrdRJy6Tx3Ng2R5k1Tev1BFi057lP6zaG2ivPK/B13I2jcD4zSBgvQXN+5u8k/B
    +B3eNKoBMih3VGtrpXlPp30LO/xTHZx4SnP5HN2UAh8ABUfT5R5YWFeF/Bmw
X-ME-Proxy: <xmx:QG42aswyprfsDVYMlwtLduGZ7FmayJqEfZunx0bb7rYYavQ1KtD0Rw>
    <xmx:QG42anSppaIVG8jLvrmX-8jxknVfQ3ic5mK_Sdkf6HC26l2wIzIMjw>
    <xmx:QG42ajVsoVM_JpK6-mDf-eIjq59IrVIIxbKMI0cWTIQ4BujQ-77oZQ>
    <xmx:QG42apa-7jJ1A5Py9OBnTNqzIdtq2pViMTFydkJZ0K6HDgiK9Xr0xA>
    <xmx:QG42avvBEXgzMr0JS1tr-xGCal-VLpKCK5-j84697C2O4rW3MeDs9H9z>
Feedback-ID: i2431475f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7A651216008A; Sat, 20 Jun 2026 06:41:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKqVAQSKm92o
Date: Sat, 20 Jun 2026 11:40:44 +0100
From: "Kerin Millar" <kfm@plushkava.net>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, "Sam James" <sam@gentoo.org>
Message-Id: <ccd69fc0-b800-4eb0-ae12-24b50736117d@app.fastmail.com>
In-Reply-To: <ajZcEl4ySM87RjOS@gondor.apana.org.au>
References: <ajYkiqisEQHQtmf5@gondor.apana.org.au>
 <a6469aab-bcf8-4c36-9a2d-9bf30e7e6ae9@app.fastmail.com>
 <ajZcEl4ySM87RjOS@gondor.apana.org.au>
Subject: Re: [PATCH] input: Fix overeager NUL deletion in SMALL mode
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026, at 10:23 AM, Herbert Xu wrote:
> On Sat, Jun 20, 2026 at 06:50:20AM +0100, Kerin Millar wrote:
>> 
>> Aye, that it be and no mistake.
>> 
>> https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46
>
> OK this patch should fix the problem:

I can confirm that, with the patch applied, dash is able to pass the git test suite, along with a slew of tests conducted by myself.

--
Kerin Millar
