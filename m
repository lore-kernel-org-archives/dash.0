Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48F25601
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712388908; cv=none; b=HLtXenagn/DF12wCR+tKR+Hd4iSX0b3fFiqynBM2sbL/lwfdIW5MUL124JPY3qCsvG+8m+WS1MPdICeR5O0Jf8jDRz8zBbXdJyyTHA+lixLBYc4YO43Sb19NgzA9maEV9KgMJe/X1VYX2RsUlYqZLszjoQzCCQZfv2jniM4E1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712388908; c=relaxed/simple;
	bh=6otcNKWzoRr7TcuMh7XJ5URrE90YPNKt9suL+l3sr9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7PixyZLf8ZBM7OyY4OReVDw+IR2Qy8Os3K1KJH09EB9uLaFMTJ9qO0Ggu4DMDv7XOk7QHYxct58jiTrftAF/7ILMTLOeKymOd8CrQQjzEqDKIVz61m74V/fB1TnBFL98gsAtkKQ9jdXB4MSacxnZbeUjpeS3pU6nKAA37Yb4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt0Zo-00FqM9-Tm; Sat, 06 Apr 2024 15:35:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 15:35:18 +0800
Date: Sat, 6 Apr 2024 15:35:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Subhaditya Nath <sn03.general@gmail.com>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] options: Fix getopts handling of colon in optstr
Message-ID: <ZhD7NqlaAlwineJF@gondor.apana.org.au>
References: <CAPHxB8twYdk0v_m-kwQw3crRdNTditd5U10mk7SR8WTdt2vhcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPHxB8twYdk0v_m-kwQw3crRdNTditd5U10mk7SR8WTdt2vhcw@mail.gmail.com>

On Mon, Feb 06, 2023 at 08:38:47PM +0530, Subhaditya Nath wrote:
> Putting a colon at the beginning of optstring to silence errors doesn't
> mean that the colon is a valid option. Before this patch, dash treated
> -: as a valid option if the optstring started with a colon. This patch
> fixes that problem.
> 
> Test:
> 
>     getopts :a opt -:
>     echo $opt$OPTARG
> 
> Correct output - ?:
> Invalid output - :
> ---
>  src/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
