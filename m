Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C80724A19
	for <dash@vger.kernel.org>; Thu,  8 Feb 2024 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364015; cv=none; b=sdg4KfKglKd1eIkq3s1vBM4+erbU31hEMU0r+Trr+zJj9ASyOGD5Fba5AWfuTYFH1v1E0Kgcc1XmmQRT0jVC8q3T+gedlu9AQ24bkY7oekXVSUyoc1MSPadBV1liqz2oancYFVHEJ36Xv9z7Rrv3VB46uOrPhSoZxnsH3HcZBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364015; c=relaxed/simple;
	bh=YI+axnQmMwpMYUMIPm6YkpgdnNKNYlp3v54lfPuGHFk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tWxZnHSPRoc/dOAIF4HJ+Ze2F+F7KFRiCZjzSgfN9BV/FgmEQHE7mPA8NR/PyX6/5tkx4OBmrN6E5zN3O6BNbIyVY8SQVSAyJmBcbsYTY8OJyX1KJ1Nu5Nez12x1DTtynnG4JcIunXsA2ZM8yCgE4XxiP10iKPu1zCNV6/Z3aVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me; spf=pass smtp.mailfrom=larryv.me; dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b=YJe+khWn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bn3zSoJO; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=larryv.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=larryv.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="YJe+khWn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bn3zSoJO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 84ABA5C00A1;
	Wed,  7 Feb 2024 22:46:52 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Wed, 07 Feb 2024 22:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707364012; x=1707450412; bh=qpQwKGOM11
	Ro8dOrF+6y1gAhf+ZG0rbCpu8YsS1bUuA=; b=YJe+khWnRE9XC+TWdajTGLQ1eI
	2sZOMJsms32Ha8nmGhTYuaTy4mKSiDH2fvwggmTYn5J8VhWOIO1LehV9mv9XLXIl
	8d8MNJENPVC9hBYejq811QgvsYHrwdUPN70eKw5bNSChpQMdcqDhz/6cdqATrcNb
	0szhb87hMRFZVT5qEayyOnRxKvpqaKNHhWGJKlMQHxZyehRGW5CzHTCi7+CUAn2X
	XJXUusOr5gt4sAH0EgTaitMUwdqEgOgSKiLNMAz6jGxxfrTfDaru4k4npY35Fccp
	VQwfA8hWFmtruNhuhlJdKw8SReoVGpG/NogstlLJcJJOAQpr50HbVAXcpkug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707364012; x=1707450412; bh=qpQwKGOM11Ro8dOrF+6y1gAhf+ZG
	0rbCpu8YsS1bUuA=; b=bn3zSoJOTLaY6kiaXBO3/bMAOe+GT/zT5TBXchQ1I5/G
	dct5zjk5GVEd4EgsO+vo8ppK+1lmCwneKkWYFkNOACh6OlvYjjNNrggPuunCYjRB
	8HWtIL9UfcVYvL7CUwCxas8TcjmyAo8zCH6snh8QqY3jBMHaI7bljoa4cJYcAcZt
	S1t3gocKiiaPRrftwMe57oFHFw8Ka46Z7FezN/u8S/DuTeCqCNG+M50ZPrklC3jv
	3nh47xkjAwP1suJcfiqJKMdYIu5lllpM+Iho94bsRMApz3F+VycUiogZjYSG3fYv
	fv8+lhigUg4iLzptzDWVRzQkrWEsqriB9LWAbEJ0Vw==
X-ME-Sender: <xms:rE7EZVzTMdA2sHfW85dRcriLcxRvyYJvv5ItHnBqjGolZQ9rA7XtHw>
    <xme:rE7EZVTC4VEIoEb806cPIDf2lM-nFNH5PnlIPDSdl5AO5v1mp5GO7IBs0JVnHRgpI
    0WOnp2FLv9QUSLd4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtsehttd
    ertderreejnecuhfhrohhmpefnrgifrhgvnhgtvgcugggvlhojiihquhgviicuoehvqhes
    lhgrrhhrhihvrdhmvgeqnecuggftrfgrthhtvghrnhepfffhheeujeduudelfeeuveehte
    ekgfegvdfgvdeuhfeiudeiteffheeljeevieelnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepvhhqsehlrghrrhihvhdrmhgv
X-ME-Proxy: <xmx:rE7EZfWNh6ZdGhNIfL3BqtRftrAt4R_OgscxO4LjtrlfHNpov584Dg>
    <xmx:rE7EZXj7AEokbTB8Y8-Q1zxZiMApZ7a8jLbN36l_gmb6qViDjUPN5w>
    <xmx:rE7EZXCmPIO0pNTdRdD_OCi1PkrklzQAbb-BnGTaENCEInkWSQMzyw>
    <xmx:rE7EZa9rtHeZhdDU4yjgXQwYpauQS1F1zP3MIbD-9SaR9eGuGYCpVQ>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4951031A0065; Wed,  7 Feb 2024 22:46:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a0c7152-a67f-45d2-9cba-62eb564e7bdc@app.fastmail.com>
In-Reply-To: 
 <viaF6idqZWuv2mRhxKCxmwfrikK6rWtbBkIrB2J-d5ftaPZAzAftfib9Kv3R1gdC0cC6zamlSG6YtkodLgFWhzb37y64dUBOwUIFvl903b4=@proton.me>
References: 
 <viaF6idqZWuv2mRhxKCxmwfrikK6rWtbBkIrB2J-d5ftaPZAzAftfib9Kv3R1gdC0cC6zamlSG6YtkodLgFWhzb37y64dUBOwUIFvl903b4=@proton.me>
Date: Wed, 07 Feb 2024 22:46:30 -0500
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Oliver Webb" <aquahobbyist@proton.me>
Cc: dash@vger.kernel.org
Subject: Re: (No Subject)
Content-Type: text/plain

On Wed, Feb 7, 2024, at 10:34 PM, Oliver Webb wrote:
> subscribe dash

To subscribe, resend this message to <majordomo@vger.kernel.org>.

-- 
vq
