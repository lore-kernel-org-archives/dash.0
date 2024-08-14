Received: from smtpout01-ext2.partage.renater.fr (smtpout01-ext2.partage.renater.fr [194.254.240.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104D143879
	for <dash@vger.kernel.org>; Wed, 14 Aug 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.240.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626827; cv=none; b=KRP8Y3a81Op37YjbTL9DJXe+BMNJbYZqpDhnCAjZQCFXbz2YKcRSF5Qkv+L+j6D+sUht9GzudcwLykGppALe7L/dmO1eUZIffC4aTFWD36QUTiEnpEdNKE0xatLphFwGcZLuXamZWHK8mwyOiFZIwLQlkMHMyFBtGWsQneMTth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626827; c=relaxed/simple;
	bh=+whugo8SilOt+yWhJc+AQGpqF7m19c+oYsqL3r10sOc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elnrIU6XQd/Y4egKgS85jSNCImXfSYx61jmUPlCv4JM2Qz0R5oA6h5XPWzvhtb1WRsKwrqJh95K9PkXRP2TyctvNlhhKcHJTQr/y16FfOn5Fjusr04p0rW3Us35gf0cORvfzipERYeFT53tkC0eFaBvXX5rpydmzPwgFmBjU/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr; spf=pass smtp.mailfrom=unistra.fr; dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b=f+1iO4+Y; arc=none smtp.client-ip=194.254.240.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unistra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unistra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unistra.fr header.i=@unistra.fr header.b="f+1iO4+Y"
Received: from zmtaauth03.partage.renater.fr (zmtaauth03.partage.renater.fr [194.254.240.26])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id 224A763D6B;
	Wed, 14 Aug 2024 11:04:10 +0200 (CEST)
Received: from zmtaauth03.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPS id 173F88000B;
	Wed, 14 Aug 2024 11:04:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTP id 0652D800C4;
	Wed, 14 Aug 2024 11:04:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth03.partage.renater.fr 0652D800C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unistra.fr;
	s=CF279DD4-6F58-4C59-BB33-73FDC6DFC1E3; t=1723626250;
	bh=VGlTQhLaBBg0yg6SJAN1PWS7QeHjHSkcJuMyBC8kBC8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=f+1iO4+YVE670Cah/ccXB/uFr3u9KgeuZq42OTExY+sSeq3whTBZc3MnrcDL3It47
	 LpSVZaXlvKKiMzg2TPsgJalh7Wq5g1gTOkh8KHklJig1IX/MDOXS3xtKcprGKpwnTJ
	 5nbn7Z2/zCCyJqnOPLOPe6q6lRbt5qulSTiO40t27leFE17mmQg67/735UEp3N+8ry
	 fgXsKQtStCYeRFBVkz1SLSmIUfk6bqk+oSwMIprGnB41Bzte8bfZiJ9Z73yRikKU7Y
	 3U5N8sNeAptYlHQ+6n1O7QNV8R8e6zE2DCy0QJpSBPkEQ9wQ82Yyg3LwoE9YYePZyo
	 RngfpKNzCjuPg==
Received: from zmtaauth03.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth03.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id syxI04OxmyQL; Wed, 14 Aug 2024 11:04:09 +0200 (CEST)
Received: from 82.67.52.52 (unknown [194.254.241.251])
	by zmtaauth03.partage.renater.fr (Postfix) with ESMTPA id CDF548000B;
	Wed, 14 Aug 2024 11:04:09 +0200 (CEST)
Date: Wed, 14 Aug 2024 11:04:08 +0200
From: Marc Chantreux <mc@unistra.fr>
To: dash@vger.kernel.org, busybox@busybox.net, bug-bash@gnu.org,
	Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Question on $@ vs $@$@
Message-ID: <ZrxzCOnZv-HffFuB@prometheus>
References: <20240814004525.A7mNIdWf@steffen%sdaoden.eu>
 <ZrwTnBvk8_2mdQUS@wooledge.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZrwTnBvk8_2mdQUS@wooledge.org>
X-Virus-Scanned: clamav-milter 0.103.8 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepofgrrhgtucevhhgrnhhtrhgvuhiguceomhgtsehunhhishhtrhgrrdhfrheqnecuggftrfgrthhtvghrnhepuedviedvvefflefhudeggfeuleegledtueeklefhfeejuddtvedvfeelffffuddunecukfhppeduleegrddvheegrddvgedurddvhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdehuddphhgvlhhopeekvddrieejrdehvddrhedvpdhmrghilhhfrhhomhepmhgtsehunhhishhtrhgrrdhfrhdpnhgspghrtghpthhtohepgedprhgtphhtthhopegurghshhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsuhhshigsohigsegsuhhshigsohigrdhnvghtpdhrtghpthhtohepsghughdqsggrshhhsehgnhhurdhorhhgpdhrtghpthhtohepshhtvghffhgvnhesshgurghouggvnhdrvghu
Content-Transfer-Encoding: quoted-printable

> We know what "$@" is supposed to do.  And something like "x${@}y" is
> well-defined also -- you simply prefix "x" to the first word, and appen=
d
> "y" to the final word.

> But I don't know how "$@$@" is supposed to be interpreted.  I do not se=
e
> anything in the official wording that explains how it should work.

As the doc you just mention said: let's set A B C

     "x$@y"    yA" "B" "Cy"

So the only consistent behavior I see is

     "$@$@"    A" "B" "CA" "B" "C"
                        ^-("$3$1")

     "$@ $@"    A" "B" "C A" "B" "C"
                        ^-("$3 $1")

I'm really currious: do you see another one ?

regards

--=20
Marc Chantreux
P=F4le CESAR (Calcul et services avanc=E9s =E0 la recherche)
Universit=E9 de Strasbourg
14 rue Ren=E9 Descartes,
BP 80010, 67084 STRASBOURG CEDEX
03.68.85.60.79

