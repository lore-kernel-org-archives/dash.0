Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345091EB48
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712406269; cv=none; b=db7j/ax0GrXEB1ynmnXTyw9iARSWztF8158kUjs/BhECQyzhYgHYB/pUr8Soc30K7f0pRKsff1DzvW/waEgQm3zc80ppg1ZJbkD+7JA79XcQbd/4ap1Q+ZItWgeDNqwcbb3naJa/9tD2tVLqE/mbgqmFIBFTmDb9HQ6OsFjB5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712406269; c=relaxed/simple;
	bh=LeuBeEHjluR95IzyI4w5+ZHuGgIeUrTyM+TeZFo/S6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYbHopguT61+miSFCofDJXbNVLH3766W/oCdqE/U4KVYCR8qqEoz+hSGUCxn1qrJ/0c0StndgfQdJh0aA26fXvIFAJLlAw1hZgt5qvtDyk2QzjIooCb28/yPSMjjp6HKnVF0xjZG9dEAfuEWbZ5J7fCR5+lvThijBN6Sd/3XK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7oKo4mL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7oKo4mL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F64AC433C7;
	Sat,  6 Apr 2024 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712406268;
	bh=LeuBeEHjluR95IzyI4w5+ZHuGgIeUrTyM+TeZFo/S6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7oKo4mLzfsbXvAmWRZ6UfHvuntQkwudYOYXJhloj42BVb2TfQkx1rUxPqA6TBS3V
	 B+MdecLJqV3bhj8ceevvJ5rKTiVat0dYnWM9yTsgc8pxa1xvUT597mzHvTozaN5sSb
	 nl92wuLFcjWKUq5ss/YE3qTe3im0ITJOlqkJ9lOO/BPYKriG9lqCgBnjysL992XEbQ
	 B9O6cjnmjU3nV4xzKHgzuhqmBAkCMyb5CiC44zGc7p81i/87nHhQ2ulA09MAh1jy2d
	 jRapnWTkQp+i1cGKy8PCkGa7/zaG3gYrFJE0ModIycAwDQSmc0nfhaPBvp/iTxEveE
	 bwnxTFO1C4okA==
Date: Sat, 6 Apr 2024 14:24:23 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Harald van Dijk <harald@gigawatt.nl>,
	Fabrice Fontaine <fontaine.fabrice@gmail.com>, dash@vger.kernel.org
Subject: Re: [PATCH] configure.ac: drop -Wl,--fatal-warnings
Message-ID: <ZhE-96_CBVZTbIn9@example.org>
References: <20240216163319.860768-1-fontaine.fabrice@gmail.com>
 <8fc1a12d-bbb2-48cd-8172-cc99f1db15fd@gigawatt.nl>
 <ZhEY10QCIPwQOjBv@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhEY10QCIPwQOjBv@gondor.apana.org.au>

On Sat, Apr 06, 2024 at 05:41:43PM +0800, Herbert Xu wrote:
> On Fri, Feb 16, 2024 at 05:55:46PM +0000, Harald van Dijk wrote:
> > 
> > On 16/02/2024 16:33, Fabrice Fontaine wrote:
> > > Drop -Wl,--fatal-warnings with --enable-static to avoid the following
> > > static build failure:
> > > 
> > > configure:4778: checking for strtod
> > > configure:4778: /home/autobuild/autobuild/instance-8/output-1/host/bin/powerpc-buildroot-linux-uclibcspe-gcc -o conftest -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -mabi=spe -mfloat-gprs=single -Wa,-me500 -Os -g0  -static -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -static -Wl,--fatal-warnings conftest.c  >&5
> > > /home/autobuild/autobuild/instance-8/output-1/host/lib/gcc/powerpc-buildroot-linux-uclibcspe/8.4.0/../../../../powerpc-buildroot-linux-uclibcspe/bin/ld: warning: conftest has a LOAD segment with RWX permissions
> > > collect2: error: ld returned 1 exit status
> > 
> > Where is this warning coming from? Does it show a real problem that needs to
> > be addressed?
> > 
> > As for the actual patch, you're right that configure should not be using
> > -Wl,--fatal-warnings, it should be avoided there for the same reason -Werror
> > should be, the warnings that get promoted to errors differ between toolchain
> > versions and in general, it is not possible to ensure that all valid
> > toolchains, all valid warning flags, result in no warnings.
> > 
> > I suspect though that it was added for a reason, that there were things that
> > *should* cause configure checks to fail, that did not fail except with
> > -Wl,--fatal-warnings. Whatever that reason may have been, it will need to be
> > handled differently if -Wl,--fatal-warnings is dropped. Unfortunately, it
> > was added to dash back in 2007 before the current mailing list existed, so I
> > am having trouble finding any explanation for what those errors may have
> > been.
> > 
> > Dropping it sounds good to me if no one can tell why it is there, but I
> > would suggest some experimentation may be in order to try and figure that
> > out first.
> 
> The patch was sent by Alexey Gladkov back in 2006.  Let's ask him
> to see if he remembers what the -Wl,--fatal-warnings was for?

Oh. It was so long ago. If I'm not mistaken, -Wl,--fatal-warnings was
added to --enable-static because of --with-libedit. But this may be a
false memory. Sorry.

[Thu Oct 4 14:21:44 2007 +0800] 12dc496 "[BUILD] Add --enable-static option to configure."
[Tue May 23 20:52:23 2006 +1000] 13537aa "[BUILD] Added --with-libedit option to configure"

> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

-- 
Rgrds, legion

