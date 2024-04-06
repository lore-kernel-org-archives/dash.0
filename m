Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4767EAD5
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712396498; cv=none; b=MdoexJFVunt/a3UUU6S1z2d+46MwbU06FrtGD048r5OIB4S91AfmFvLEzNUBqfC74z6ZP9p+WMJK14KUs9S+hdxyk/IysJuiiRBPGTKPfzdrJnW4flipv3ZVpjA+PwfQrI98DT8b7cPJCyXnKaTl39POxhQmJf1XPj1BFghQHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712396498; c=relaxed/simple;
	bh=t/kiI25bewsPLfV7BaJw9ATvouDueFXBHtkmDWyspQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le9/QTwU9RphnsHjCk7NJ6rf5tH8z2yFNFrFedZiTICMvjPvsAT1uUEdFumb8dF9T+b3aW7S22loKxSMy+WOc7b03yx00Lm6DSUarnYa93/zeJs7zVpTu17qkxKj1vn7ZHu33Tv+V1afcSHFLiV5QnLoELZnEMA770SDiS7EtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt2YA-00Fu4y-EI; Sat, 06 Apr 2024 17:41:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 17:41:43 +0800
Date: Sat, 6 Apr 2024 17:41:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>,
	Alexey Gladkov <legion@kernel.org>
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, dash@vger.kernel.org
Subject: Re: [PATCH] configure.ac: drop -Wl,--fatal-warnings
Message-ID: <ZhEY10QCIPwQOjBv@gondor.apana.org.au>
References: <20240216163319.860768-1-fontaine.fabrice@gmail.com>
 <8fc1a12d-bbb2-48cd-8172-cc99f1db15fd@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc1a12d-bbb2-48cd-8172-cc99f1db15fd@gigawatt.nl>

On Fri, Feb 16, 2024 at 05:55:46PM +0000, Harald van Dijk wrote:
> 
> On 16/02/2024 16:33, Fabrice Fontaine wrote:
> > Drop -Wl,--fatal-warnings with --enable-static to avoid the following
> > static build failure:
> > 
> > configure:4778: checking for strtod
> > configure:4778: /home/autobuild/autobuild/instance-8/output-1/host/bin/powerpc-buildroot-linux-uclibcspe-gcc -o conftest -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -mabi=spe -mfloat-gprs=single -Wa,-me500 -Os -g0  -static -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -static -Wl,--fatal-warnings conftest.c  >&5
> > /home/autobuild/autobuild/instance-8/output-1/host/lib/gcc/powerpc-buildroot-linux-uclibcspe/8.4.0/../../../../powerpc-buildroot-linux-uclibcspe/bin/ld: warning: conftest has a LOAD segment with RWX permissions
> > collect2: error: ld returned 1 exit status
> 
> Where is this warning coming from? Does it show a real problem that needs to
> be addressed?
> 
> As for the actual patch, you're right that configure should not be using
> -Wl,--fatal-warnings, it should be avoided there for the same reason -Werror
> should be, the warnings that get promoted to errors differ between toolchain
> versions and in general, it is not possible to ensure that all valid
> toolchains, all valid warning flags, result in no warnings.
> 
> I suspect though that it was added for a reason, that there were things that
> *should* cause configure checks to fail, that did not fail except with
> -Wl,--fatal-warnings. Whatever that reason may have been, it will need to be
> handled differently if -Wl,--fatal-warnings is dropped. Unfortunately, it
> was added to dash back in 2007 before the current mailing list existed, so I
> am having trouble finding any explanation for what those errors may have
> been.
> 
> Dropping it sounds good to me if no one can tell why it is there, but I
> would suggest some experimentation may be in order to try and figure that
> out first.

The patch was sent by Alexey Gladkov back in 2006.  Let's ask him
to see if he remembers what the -Wl,--fatal-warnings was for?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
