Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=larryv.me header.i=@larryv.me header.b="ZhWw39Z5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSGCM3dV"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393FCD44
	for <dash@vger.kernel.org>; Wed,  6 Dec 2023 21:31:42 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 40DFE3200A62;
	Thu,  7 Dec 2023 00:31:41 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 00:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=larryv.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701927100; x=1702013500; bh=FLu3itFCf57WZ9uLs9QomyljDGPvKjcTf8T
	1291bbXQ=; b=ZhWw39Z5iuYIb8QPhR/6dJ+6cqbJAid4tyAULsIbhg1vihuDDHZ
	bF1kqJG6aAibx1RuuEvH5dnc/wCfPM4zPOqUBiQK9fH77XfT2kVHGegYxRsyZRok
	b0C8LS9n9sjNQ9iqY+MCxvPYIzKDVY2/7Y9F4Zwa1u3N3KQWIq4NIFHDd//lu/rQ
	P9Jp6hmEaEnr6ohYda0oZ55oMfpVvzXVl6xqzj34ENQN7Evkbbx4dGKl738osytA
	M7WFDZKl6y77IQ1hMarC9fkwRQF75HXXy/o/h93htzfUBpNXhVxwv/5V0QaC8+BE
	p+XOO/Qy3/2a2YC2pAYe2R9UYAq/94zNdPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701927100; x=1702013500; bh=FLu3itFCf57WZ9uLs9QomyljDGPvKjcTf8T
	1291bbXQ=; b=GSGCM3dVsEU4kA8qvQJNt219h4owih9F+tB+tZxp+J+kwdwNqKl
	mL1QuhZJSlO3r0dTRjHqIeJ968kU0Hicl2m5XTGPm2ppYNJNKP+bfni6Faj43jrM
	HbYS/n/BQ/05NPi/fAxtXyTPk0oDJ6uaOpmrOIqI1J3WuFRUCCtiKOexe8Gp1d85
	KXg80+6XHaEnGEDIZZp4z48bUuNTNPCIKjkPGJ7Lw3cXajM6wMEb2KDUjKE4PNjV
	bZIYMCT/GZI0horM+6/lc+gSIXvZIiNGxR0jUOvPJ5EazL58vYsebhHYCquhNbUT
	MaivviNt+JzBejTB44Xdtn/mEt7nSrUYHgw==
X-ME-Sender: <xms:vFhxZYHuPGMv7mGYrfqJS_0EmT27EP28KvD9xukYES0hCEmEO1DdnA>
    <xme:vFhxZRWPGwSIvuQrZfm0XPoSAUjUCKcnWOoh1lP2jtSWHQfW8qKRCsu4_DchGqN4E
    xB7QUrfme1Uvn2zlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepnfgr
    fihrvghntggvucggvghljoiiqhhuvgiiuceovhhqsehlrghrrhihvhdrmhgvqeenucggtf
    frrghtthgvrhhnpeegveeuteekvdehkeeivdejgfdttdeljedvteekleejteehtdeufedu
    heeghfdvhfenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvqheslhgrrhhrhihvrdhm
    vg
X-ME-Proxy: <xmx:vFhxZSIiBZczQa51Ync_QeDfDeXj7Z0FJdhtIoD6dJsfh5vLvBihlw>
    <xmx:vFhxZaGAFSK8EYiflgmuA0gef8wMmoG86Oxv3pqs_V2r3D0qENFfAA>
    <xmx:vFhxZeUuaENVijvl5PQbudI_1eWLyrTdNMFN1YmaQLZRm5yuQUnftw>
    <xmx:vFhxZXehE911fN3hpx8Vof_G73lqjWcBaQU95IGnPqSXjDU4xPZ1yw>
Feedback-ID: i0b2842c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8B97331A0064; Thu,  7 Dec 2023 00:31:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e6c9620-8e39-49de-ab17-717d370abec9@app.fastmail.com>
In-Reply-To: <6de0c5958bf8c0327b7d62ad681345417481f16a.camel@scientia.org>
References: <CXHTPZE1MOGN.2SN9MFXJNGCB0@tebibyte.media>
 <6de0c5958bf8c0327b7d62ad681345417481f16a.camel@scientia.org>
Date: Thu, 07 Dec 2023 00:29:57 -0500
From: =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?= <vq@larryv.me>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Emma Tebibyte" <emma@tebibyte.media>
Cc: dash@vger.kernel.org
Subject: Re: 
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023, at 12:00 AM, Christoph Anton Mitterer wrote:
> On Wed, 2023-12-06 at 21:40 -0700, Emma Tebibyte wrote:
>> I found a bug in dash version 0.5.12 where when shifting more than
>> ?#,
>> the shell exits before evaluating a logical OR operator.
>
> AFAIU from POSIX this is perfectly valid behaviour:
>
> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.h=
tml#shift
>
>> EXIT STATUS
>> If the n operand is invalid or is greater than "$#", this may be
>> considered a syntax error and a non-interactive shell may exit; if
>> the shell does not exit in this case, a non-zero exit status shall
>> be=C2=A0returned. Otherwise, zero shall be returned.

See also Section 2.8.1 [*], which states that interactive shells
shall not exit on special built-in utility errors and that:

	In all of the cases shown in the table where an interactive
	shell is required not to exit, the shell shall not perform
	any further processing of the command in which the error
	occurred.

[*] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02=
.html#tag_18_08_01

--=20
vq
