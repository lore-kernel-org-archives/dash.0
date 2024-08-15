Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E521EB31
	for <dash@vger.kernel.org>; Thu, 15 Aug 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.240.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706059; cv=none; b=Di9dRPIdYTYJkESAPNx/4laWJ0tQN7ChnK6qUMIqxqZCj/8mcrjlwXMK/My998DAVmogjNhJ8J82UJyN/CuXimPMYKuhYZuYsrlZYmbi+t6GCQVsCUyEzPZbKuag5qQHUYGeEyyNfHnJSw1M+wyMUEM4/tl/GrXOmmJV1bKNq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706059; c=relaxed/simple;
	bh=G6tS5hLlxxOnacPNXmD1M4roibGclTpcNOG40cfC+XM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DI5CmAob0xhn2g9xwgnK9/2JlYaFlWjYx8cejR8Uqi3ubyPkFtXKH/1WDQzlZoQZk0xeVwouR1JB3VURq0fZ7g4TVMb+pGpQbyS1xdzojZPzNYGPTfUuoxtrF0d1xjP0DWR58eckfnSNUEf+ewFsrFTRHzGQzsQHXvXXYSF62f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr; spf=pass smtp.mailfrom=unistra.fr; dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b=FL4HbOvw; arc=none smtp.client-ip=194.254.240.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b="FL4HbOvw"
Received: from zmtaauth01.partage.renater.fr (zmtaauth01.partage.renater.fr [194.254.240.25])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id 915E768A45;
	Thu, 15 Aug 2024 09:14:03 +0200 (CEST)
Received: from zmtaauth01.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth01.partage.renater.fr (Postfix) with ESMTPS id 7AD79140004;
	Thu, 15 Aug 2024 09:14:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth01.partage.renater.fr (Postfix) with ESMTP id 6815E140055;
	Thu, 15 Aug 2024 09:14:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth01.partage.renater.fr 6815E140055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
	s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1723706043;
	bh=7j8N8My9MqTv2xVQfW0HSx/H2K925HlXo2aJjUc08j8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=FL4HbOvwDUgBLviXKGXHQTOkQvt225fbkcYMpdMpwnnOmxK4JcW0xUfu1IUG9RO88
	 s0hBfr1lq++Z7UiFsSq3DyDUzEKTitN6MckCHstB0PdXODzVYiOhiAz2hy8SFQkAmt
	 QLmBLJR5cuuFe7zcR0lqJzDszFgqBPobSroW5AwRklG8pIZlxpw5lP7MKUhQS040uo
	 56RQWpnRwEWQga6ebwwCfF3vcUlByI2FA+oYTaTV5qDgH+2rgdj+x73obacDm9k5ZZ
	 dMPLaZcKfPtsoUJ0BCgbXB1RC8x1jvnLIhWPQ+rPi87ra1YjnK5fc/npH9FyuM1RPc
	 O/bfcV41/sOqg==
Received: from zmtaauth01.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth01.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lkFH7_u8FwWd; Thu, 15 Aug 2024 09:14:03 +0200 (CEST)
Received: from 82.67.52.52 (unknown [194.254.241.250])
	by zmtaauth01.partage.renater.fr (Postfix) with ESMTPA id 302A0140004;
	Thu, 15 Aug 2024 09:14:03 +0200 (CEST)
Date: Thu, 15 Aug 2024 09:14:02 +0200
From: Marc Chantreux <mc@unistra.fr>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
	Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <Zr2qunm18NGdJ_Bx@prometheus>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <ZrwTnBvk8_2mdQUS@wooledge.org>
 <ZrxzCOnZv-HffFuB@prometheus>
 <Zryv5acNkrImASKj@wooledge.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Zryv5acNkrImASKj@wooledge.org>
X-Virus-Scanned: clamav-milter 0.103.8 at clamav03
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeforghrtgcuvehhrghnthhrvghugicuoehmtgesuhhnihhsthhrrgdrfhhrqeenucggtffrrghtthgvrhhnpeeuvdeivdevffelhfdugefgueelgeeltdeukeelhfefjedutdevvdefleffffduudenucfkphepudelgedrvdehgedrvdeguddrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvhedtpdhhvghlohepkedvrdeijedrhedvrdehvddpmhgrihhlfhhrohhmpehmtgesuhhnihhsthhrrgdrfhhrpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepuggrshhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghushihsghogiessghushihsghogidrnhgvthdprhgtphhtthhopegsuhhgqdgsrghshhesghhnuhdrohhrghdprhgtphhtthhopehsthgvfhhfvghnsehsuggrohguvghnrdgvuh
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 09:23:49AM -0400, Greg Wooledge wrote:
> The most obvious would be to treat "$@$@" as if it were "$@" "$@",
> generating exactly two words for each positional parameter.
>=20
>     <A> <B> <C> <A> <B> <C>

Thanks for this. My two cents:

if I want "$@" "$@", i write it litterally. "$@$@" kinda tricks me
in that case because it's not consistent with the other cases I already
used ("$foo$@", for exemple).

> If there are *two* instances of $@ within the same word, then the final
> parameter of the *first* $@ is supposed to be "joined with the last
> part of the original word".  But the "last part of the original word"
> is another list expansion, not a string!  What does it even mean for
> the final parameter to be "joined" with a list expansion?

good point: that's ambigious. zsh has the explicit twigil $^ (inspired
by the rc operator, I think) to make the distribution explicit (like a
brace expansion) but as dash lack both those features, I still think
my proposal both more consistent and doing something different.

> So, neither of these results would shock me:
>     <A> <B> <CA B C>    (treat it like "$@$*")
>     <A B CA> <B> <C>    (treat it like "$*$@")

well. "$@" "$@", $@$* and $*$@ are clear syntaxes that proves an intentio=
n
so "$@$@" should be another one related to the fact that something is
joined at the boundary. and to me "something" means "anything left betwee=
n"
(possibly empty).

so: set A B
        "$@ x $@"       =3D>   "A" "B x A" "B"
        "$@$@"          =3D>   "A" "BA"    "B"

> I'd still love to know what the script's intent is.

I my guess would be based on "nothing but what the other syntaxes
provides more expicitly".

regards

--=20
Marc Chantreux
P=F4le CESAR (Calcul et services avanc=E9s =E0 la recherche)
Universit=E9 de Strasbourg
14 rue Ren=E9 Descartes,
BP 80010, 67084 STRASBOURG CEDEX
03.68.85.60.79

