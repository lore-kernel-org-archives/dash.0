Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBF243956
	for <dash@vger.kernel.org>; Wed, 27 Aug 2025 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272009; cv=none; b=h4Npul6eeANPOq8StTNO3Imn1wM6XY1+y0YSvh8JJbGhgWcLO0q90UJaJBaotSBzJ/YBSfkfewhzj34PMEg9OL474/Za3J+eawg9El6zF57z2q/Ox/8UTAUSm7J32uGkhohIumHSl1xpQBbkEvMMyoAEAvVaAC7ypydVofCeEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272009; c=relaxed/simple;
	bh=jHlkj0v2IG4x2+rS2mMFBSj5DUhgM1KCvWFD8LCZiz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tmldMxoVBtO2srY+qvHTKkNVLvA+k2gdcw8z0FIY83cFyZ01cs/y3hjP/OxKe6HCgBLur6cIcqeIISqvKb9RrlpGkzlJoRI74Gqck5pwfekJJA4AgE3eWXf4Q7URey1Jx1q755J7XFpibtMxSfxh6P/zGK5SYqaSzIyAbf4VoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=FnhnAqeX; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="FnhnAqeX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZSiWdlNPV9tw7fVv7b3yOzEtBugDK3b78fEDcoTdots=; b=FnhnAqeX4Nb4Vagk+qkUXygy1r
	1Y0KZiUD09J7QwNnQdq/FJEN9Plaj1MPwWxfEfLCya4wKL0t5tt8HVlWSKFWyvx90NON9Nx+woYIU
	rzhkaLmQBpN/nhSOuTWTiwz92n30MaR2NNPl7iH7VO8RxkC88EsAq4Y8Fhy0TyEUTLyyxxTv60R+8
	xCgr/BYq24cWPU9hikKfmtCp1zBH+2R7tUmVJttP8ZskfYZE9L1JhUylGVFq2eRE5wOUw43sBSQ6j
	8ls5cLzmI6ZOtn19UHdlFEgEYbrhuHIGrlyCfGyag5/53LjDagFy76abOQklg2L52ho+abbB7zPnE
	ElIH8qPQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ur8KI-0007cS-0J;
	Wed, 27 Aug 2025 13:19:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 27 Aug 2025 13:19:58 +0800
Date: Wed, 27 Aug 2025 13:19:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
Subject: Re: [BUG] heap-use-after-free(read) pstrcmp() src/mystring.c
Message-ID: <aK6VfoGws2WeSj9d@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe0fea8-24c5-4dbb-a2c9-3c0e01af7c18@astralinux.ru>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <aushakov@astralinux.ru> wrote:
> 
> I encountered a bug in Dash in commit fd725b7a75 and would like to 
> report it. The details are provided below.
> The target crashed when reading from memory after it has been freed.
> ==119==ERROR: AddressSanitizer: heap-use-after-free on address 
> 0x515000008f08 at pc 0x62b3e92a9f96 bp 0x7ffe2076bc00 sp 0x7ffe2076b3b0
> READ of size 1 at 0x515000008f08 thread T0
>     #0 0x62b3e92a9f95 in __interceptor_strcmp 
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:466
>     #1 0x62b3e9353a34 in bsearch 
> /usr/include/x86_64-linux-gnu/bits/stdlib-bsearch.h:33
>     #2 0x62b3e9353a34 in findstring /upstream/dash/src/mystring.c:260
>     #3 0x62b3e935c140 in readtoken /upstream/dash/src/parser.c:737
>     #4 0x62b3e935ce76 in list /upstream/dash/src/parser.c:181
>     #5 0x62b3e936072e in readtoken1 /upstream/dash/src/parser.c:1587
>     #6 0x62b3e93693ff in parseheredoc /upstream/dash/src/parser.c:690
>     #7 0x62b3e93601d6 in readtoken1 /upstream/dash/src/parser.c:1597
>     #8 0x62b3e9369bc3 in xxreadtoken /upstream/dash/src/parser.c:843
>     #9 0x62b3e935bfb6 in readtoken /upstream/dash/src/parser.c:711
>     #10 0x62b3e935ce76 in list /upstream/dash/src/parser.c:181
>     #11 0x62b3e934a242 in cmdloop /upstream/dash/src/main.c:223
>     #12 0x62b3e922543c in main /upstream/dash/src/main.c:180
>     #13 0x7ab34e084249 in __libc_start_call_main 
> ../sysdeps/nptl/libc_start_call_main.h:58
>     #14 0x7ab34e084304 in __libc_start_main_impl ../csu/libc-start.c:360
>     #15 0x62b3e9226520 in _start (/upstream/dash/src/dash+0x1a520)
> 
> 0x515000008f08 is located 8 bytes inside of 512-byte region 
> [0x515000008f00,0x515000009100)
> freed by thread T0 here:
>     #0 0x62b3e92b9068 in __interceptor_free 
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
>     #1 0x62b3e934c8cd in popstackmark /upstream/dash/src/memalloc.c:187

Thanks for the report.  This is a manifestation of the fact that
the dash parser is not re-entrant.  Despite that, it gets called
recursively when a prompt needs to be generated during parsing.

Hence the crash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
