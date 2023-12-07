X-Greylist: delayed 516 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 21:09:26 PST
Received: from bactrian.cherry.relay.mailchannels.net (bactrian.cherry.relay.mailchannels.net [23.83.223.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23CA4
	for <dash@vger.kernel.org>; Wed,  6 Dec 2023 21:09:26 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 56263501211;
	Thu,  7 Dec 2023 05:00:49 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 83DEC50142F;
	Thu,  7 Dec 2023 05:00:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701925249; a=rsa-sha256;
	cv=none;
	b=NTpIoIFx966CErzsJ9iCUZi16oSUviO7z5618jGxFP46Qf49BznKf+GFMOy6X8bRGAdNv/
	6a03puhfT4qJGEPz3XubyBmBa6bzJ7i9s1ZF6SJcYYxv1DnaCZrUJvJdEQlbNTUksdLezJ
	zxQQKwYN6b89WF+67LwCeEyXu+SbGNJgPRsO3LkQHr6McWRjJltpHhZkImgInMw+gWznDB
	QohhvVM0A7kDXzmrpOg60ZhunzW5R0v9VKLSauD1okwPhNGD7ZsMcGTKKvGq8DojAr9CnP
	N6oxwK3Jcw2jPYV4044IjmoCZNijhg6G+akrVqDW5ngRieHNwKAqGQkv3E4D3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701925249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8p9vX2kSzcY3VArzVlgnjF4be9LPGGewdI9Di/cl8A=;
	b=HU4f7cydqKfDnGeOcwMHkqC+usw1+dUPJpkDCjU83k4K7t985yCNMOqPXRAbR7ZzGwFJl6
	Gwb7iXenLe6ZYno/2AhsHn7pDkR9zwmPy0X+K2L+YszpG9VLTaKpVk1H01suj4RKJ4OQEc
	9xsL3JyY8qE/411jck4b/5xvUZvmzlMoNju8dQULFmNLRp/iVuL+zQMsN+h+StTB0hd9dA
	s3RUuislOj0Mh/t8y0Cqio6D+7CNt2os1Y+w9TQjvnK/hK+YnxfxMmEDmOo/wmIGn+kT99
	YHd98KAWwYzswJhiQDd0G0cilX8iyk/iQ+ZRLPV0idqFrKqCHVxvZl2Q8g0gLg==
ARC-Authentication-Results: i=1;
	rspamd-696ff67dc8-4w66l;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Junk
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Coil-Reaction: 21e6229d78a08002_1701925249154_654608418
X-MC-Loop-Signature: 1701925249154:4181843742
X-MC-Ingress-Time: 1701925249153
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
	by 100.118.12.6 (trex/6.9.2);
	Thu, 07 Dec 2023 05:00:49 +0000
Received: from p3e9c2e28.dip0.t-ipconnect.de ([62.156.46.40]:51704 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <calestyo@scientia.org>)
	id 1rB6V8-0004cp-1f;
	Thu, 07 Dec 2023 05:00:46 +0000
Message-ID: <6de0c5958bf8c0327b7d62ad681345417481f16a.camel@scientia.org>
Subject: Re:
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Emma Tebibyte <emma@tebibyte.media>, dash@vger.kernel.org
Date: Thu, 07 Dec 2023 06:00:41 +0100
In-Reply-To: <CXHTPZE1MOGN.2SN9MFXJNGCB0@tebibyte.media>
References: <CXHTPZE1MOGN.2SN9MFXJNGCB0@tebibyte.media>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

On Wed, 2023-12-06 at 21:40 -0700, Emma Tebibyte wrote:
> I found a bug in dash version 0.5.12 where when shifting more than
> ?#,
> the shell exits before evaluating a logical OR operator.

AFAIU from POSIX this is perfectly valid behaviour:

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#s=
hift

> EXIT STATUS
> If the n operand is invalid or is greater than "$#", this may be
> considered a syntax error and a non-interactive shell may exit; if
> the shell does not exit in this case, a non-zero exit status shall
> be=C2=A0returned. Otherwise, zero shall be returned.


Cheers,
Chris.
