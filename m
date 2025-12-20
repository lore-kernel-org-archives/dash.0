Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18A2EA749
	for <dash@vger.kernel.org>; Sat, 20 Dec 2025 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766252492; cv=none; b=QDpUA2M4IyfBmNzrf7cPzsZCpWawi72dTDGs6iY26jEFeCWvS6BXyRd4/iFnKLSznuSfC79/V02qejWAj7oOsJPLjqCukyMOfyzNf2Gi+DzIy6Y9MuNJ5ATWQ9J2y1IqbBlyHjO1jaU53VBFGceHhB3OMuvxQbz7tLdny8IK8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766252492; c=relaxed/simple;
	bh=Yzws8cfHmglifoOn8w53PaOoNhgwK1qM03wwpHN50XM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=TcS3p3wqN8ZdeoCmzIH5zCOq65+PRSjlS9D+orZs6nFJ8O9d7r0UWS5dh+tvqtSlFU8vevPb5KNEyAuJPQdECRy1byWtIJJAioIwNs5e+6HUPcybubF2i3oNTt6HjXg0Z/JqiG5wXMOHNS39OrZyCg33idskkd6Sl+SkD1PJDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=d8cdFRkG; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="d8cdFRkG"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0102E240027
	for <dash@vger.kernel.org>; Sat, 20 Dec 2025 18:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766252127; bh=Yzws8cfHmglifoOn8w53PaOoNhgwK1qM03wwpHN50XM=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=d8cdFRkGEvI+NKorQnhuqeP30ltUrWQOsoF76n4KUS1fiC71cGhryP8Yp0kDP3HyZ
	 rb2a83rLrJaqTjb7hzfkQSrf5Uxaw85J568h5YdFKuL6J5iOO2esmByECkbb5cQuQX
	 K+KAqD2C77BKNxqaoHxlFtUQlyAnZYLkeqxSA7Jgm2lq9KdgnaDVuxwJ7rD0BAD7UH
	 F2bOoFGdxAAHj+XIua+unSW3scqkNZ8MBOo7c/15fX1ZZb/P52IFFjNEJVuuh46+9I
	 eDyr3dMp9TprFyRA3wdRoVihPT8vuVAGYVucjLhFYolBBdl1bbk9/9RnhykCS2wZUR
	 9NMuCIkPtTLWQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dYWl22ZBhz9rxK;
	Sat, 20 Dec 2025 18:35:26 +0100 (CET)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 20 Dec 2025 17:35:26 +0000
From: j.daubert@posteo.de
To: =?UTF-8?Q?Jyri-Matti_L=C3=A4hteenm=C3=A4ki?=
 <jyri-matti@lahteenmaki.net>
Cc: dash@vger.kernel.org
Subject: Re: Behavior change in Dash =?UTF-8?Q?pipes/read=3F?=
In-Reply-To: <CANhYXO9FwbqvSJba8B6p+dzL4AoeA5O85kRxXdzWRe19hMwVtQ@mail.gmail.com>
References: <CANhYXO9FwbqvSJba8B6p+dzL4AoeA5O85kRxXdzWRe19hMwVtQ@mail.gmail.com>
Message-ID: <a5a6026d689dbb91b5ede440416ee5f0@posteo.de>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

use these additional patches, published after the 0.5.13.1 release:

https://marc.info/?l=3Ddash&m=3D175976339511457
https://marc.info/?l=3Ddash&m=3D176121885702468
https://marc.info/?l=3Ddash&m=3D176188900609643

Greetings
Juergen

Am 20.12.2025 17:41 schrieb Jyri-Matti L=C3=A4hteenm=C3=A4ki:
> Hi,
>=20
> after upgrading from Dash 0.5.12 to 0.5.13.1 some of my scripts
> stopped working. Here's a test case:
>=20
> $ /nix/store/wy9ass74g4yc1x354ydbdlxkfkxxjv2x-dash-0.5.13.1/bin/dash
> -c 'echo hello | { read -r x; echo "$x"; }'
> $ /nix/store/4kjsgkcxqfadycyspzfrf9gg5n5bpc27-dash-0.5.12/bin/dash -c
> 'echo hello | { read -r x; echo "$x"; }' hello
>=20
> (with 0.5.12 "hello" is printed, but with 0.5.13.1 it's not)
>=20
> Can someone confirm?
> Thank you!
