Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C0637
	for <dash@vger.kernel.org>; Sat, 18 May 2024 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992804; cv=none; b=KW8hxwHs4twxYRjaflORXlCmCeQDjB7e9btCPZPwOcee+9sEqZ/Hd9bdBuqc8T2aLHexrvysBSdFlnDiWWcmBhkgqINPmRhactLrGeoLvqxIipPc7pcZV8s4hnVL4Dy41lVMeqhSTwo04qldhgxibWycxXUDWhyEUYjfoTKdig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992804; c=relaxed/simple;
	bh=HIiZ8qH074FmxgcN9FbKlpp5FjbeBxNsBDamrSax+wI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mqy26GclFcN8uerEpWNt61QBP8cy9t2mL6QVB1/XPWJ1nopGNTEeOQVH5j/IW4Asj1UuqQ6NnUou0HcVmJbL/C6LIhJ550EryQ2HTOlaeCz9tKwAcBIB7RiAt8J1Seg7d/wbHR/VfoJuje8LIWcrE6/FsB7i5OGGnAG0YrAojd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8878-00GyqC-0l;
	Sat, 18 May 2024 08:39:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 May 2024 08:39:55 +0800
Date: Sat, 18 May 2024 08:39:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Fix non-Linux build
Message-ID: <Zkf428Yvs_JMPmF2@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a635d8-c129-4bcf-a274-af36d928263b@inlv.org>
X-Newsgroups: apana.lists.os.linux.dash

Martijn Dekker <martijn@inlv.org> wrote:
> As of 509f5b0d, the build fails on Darwin/macOS, which does not have 
> memfd_create(2). The build fails on redir.c because the fallback for 
> memfd_create, which is defined in system.h, is not included. Presumably it is 
> the same on other systems without memfd_create.
> 
> diff --git a/src/redir.c b/src/redir.c
> index 2505d49..8a77a92 100644
> --- a/src/redir.c
> +++ b/src/redir.c
> @@ -57,6 +57,7 @@
>  #include "memalloc.h"
>  #include "error.h"
>  #include "trap.h"
> +#include "system.h"

The patch was white-space damaged but I applied it by hand.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
