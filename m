Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tebibyte.media header.i=@tebibyte.media header.b="Omh0ShS4"
X-Greylist: delayed 529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Dec 2023 20:49:52 PST
Received: from mail.tebibyte.media (tebibyte.media [170.187.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882E126
	for <dash@vger.kernel.org>; Wed,  6 Dec 2023 20:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tebibyte.media;
	s=mail; t=1701924062;
	bh=1f5I+cC6fO5PWEfIW1ms+OwyvhAYZKxIOwWKc60Rh8U=;
	h=Date:To:Subject:From:From;
	b=Omh0ShS4+iAm8Av3olRC9GcFSFBn2FLyH/gJtEq4DgWq91bQ7nWn96SJhgBouWNRg
	 Uagg99trus4gotp6UWl2GraAtVUG15eTVDKzuyqwvzxeyfYicZSFtNw/ZYqH845mKY
	 fVNWEVmDVCTYzZX5NUy4qpGepI+YlexFxPpo4tk2poFizdfhqdaORw5TLfyv3tt2oY
	 WPQs72KQSl3jnwye9xkx35C+YRcIfO/w4V6f465il3rbMScI3nLcY6Sn4NguJSrBd6
	 4C5AvwYcjKRoFKRh9C6TQsYs1+68a1n82RaKqP1+qru8vCyIj9gfzbXVElvdBfyiYt
	 iIkSdcck33FwQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Dec 2023 21:40:42 -0700
Message-Id: <CXHTPZE1MOGN.2SN9MFXJNGCB0@tebibyte.media>
To: <dash@vger.kernel.org>
Subject: 
From: "Emma Tebibyte" <emma@tebibyte.media>
X-Mailer: aerc 0.15.2

Hi,

I found a bug in dash version 0.5.12 where when shifting more than ?#,
the shell exits before evaluating a logical OR operator.

To reproduce this issue:

	$ set -- 1
	$ shift 2 || printf 'meow\n'
	dash: 2: shift: can't shift that many
	$

This also occurs using if:

	$ set -- 1
	$ if shift 2; then
	> true
	> else
	> printf 'meow\n'
	> fi
	dash: 2: shift: can't shift that many
	$

Thanks,
Emma Tebibyte
