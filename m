Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB78A35
	for <dash@vger.kernel.org>; Sun, 28 Jul 2024 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722134194; cv=none; b=CuP0BPbUXYN626JP0NtGh9+ffoYmlLbky3IAoxXQvq8EpLF0GStqLsgsr1AVWzugsK0csqmaNWOA5L0yM1Ix02G9XZKWCiy41O5/9qkmNIV7ddvMGMfL7K7D6ao5Nqd2fZZ8CNRrwDvOQvXdtswzIeRFDuBWEf6YhFxLF9MkOjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722134194; c=relaxed/simple;
	bh=8HM/x1C7mvgN9hzIppYLyMSYs74n0+tGG8IAAmnpqYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RGcmy02YjCw379Nlz5KtbVqRbTE8IkpkHO0v6kTe1hCt3k+wAfDJ0ZVgETOwwNGdAL3C0gzB124mbPQbwQrQBSqYIeSqWI9zlM0XKyges5hfXZvF/gLzAKjbQ1XR8VxtJBiEA7Vp3y7AeYODTFph4nRJ71bm3hqvyra+4nXINVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sXtdM-000dqN-1g;
	Sun, 28 Jul 2024 10:36:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 28 Jul 2024 10:36:25 +0800
Date: Sun, 28 Jul 2024 10:36:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] bltin/test: align -nt and -ot with POSIX.1-2024
Message-ID: <ZqWuqe25h-VkDqnj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qup6njf3q6f5nharnzzvq55dggdollemf6hifsudqn5sx7spwb@tarta.nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> diff --git a/src/bltin/test.c b/src/bltin/test.c
> index 2db4d0f..06f6818 100644
> --- a/src/bltin/test.c
> +++ b/src/bltin/test.c
> @@ -17,6 +17,7 @@
> #include <string.h>
> #include <unistd.h>
> #include <stdarg.h>
> +#include <stdbool.h>
> #include "bltin.h"
> #include "../exec.h"
> 
> @@ -471,16 +472,17 @@ newerf (const char *f1, const char *f2)
> {
>        struct stat64 b1, b2;
> 
> +       if(stat64(f1, &b1) != 0)

Please add a space between if and '('.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
