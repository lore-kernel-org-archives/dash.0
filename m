Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33F8BF8
	for <dash@vger.kernel.org>; Sat,  6 Apr 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712393740; cv=none; b=jaG8vg9yUjClPBnyrud6VtuzZm6kjs3k+eYVoimxvyL5iBGdig9wJZ7m7XRT938FTZmEbGwIQVSb9ZU5zBHfrXRfZAWVogKENbyi+xGE3LychW7nhvWelHdzztMW087Z9mUXb+tRjEJyd/aO7srufT454QWe8jnR85mfd1Zj6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712393740; c=relaxed/simple;
	bh=usCS0mnKo90Ruhe8cjuoDkPoutcyIaLTFrwqdQgpIcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWPKZSe9DuYlHqnuLzBJ1kjNipl0/41UDSXHJKBsQKwINmtkEq/tuGXCUAXYVpuC12osrCpqhpiIcrgKwZZuNrPQ0jaPPa7sIR8taF+mitDXP6u+UCFCAs531gksFKQohLicUuhueiGkFHsTUO5HFxRlupQLR7LCoVQITCdTLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rt1pc-00FtR6-VF; Sat, 06 Apr 2024 16:55:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Apr 2024 16:55:42 +0800
Date: Sat, 6 Apr 2024 16:55:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: [PATCH 1/6] fc -s: refuse multiple events instead of ignoring
Message-ID: <ZhEODiKLhiGh1dPl@gondor.apana.org.au>
References: <ab3fbcc2-1a9a-136b-0b02-a5ea31fe02c5@gigawatt.nl>
 <96c003b30fc95cdf5aed3162901abaa9b89430e2.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c003b30fc95cdf5aed3162901abaa9b89430e2.1675798292.git.nabijaczleweli@nabijaczleweli.xyz>

On Tue, Feb 07, 2023 at 08:33:25PM +0100, наб wrote:
> The POSIX SYNOPSIS (and our manual which steals it verbatim) says:
>   fc -s [old=new] [first]
> and, indeed, we only use the first non-= argument
> instead of enforcing the usage, which is confusing.
> 
> bash:
> 	2025     ls
> 	2026     id
> 	$ fc -s ls=who 2025 2026
> 	who
> 	nabijaczleweli pts/2 2023-02-07 17:36 (192.168.1.109)
> 	nabijaczleweli pts/3 2023-02-07 17:38 (192.168.1.109)
> 	nabijaczleweli pts/4 2023-02-07 16:58 (192.168.1.109)
> 	nabijaczleweli pts/5 2023-02-07 17:45 (192.168.1.109)
> ksh93:
> 	240     id
> 	241     ls
> 	$ fc -s ls=who 241 240
> 	ksh: hist: -e - requires single argument
> yash:
> 	2       ls
> 	3       id
> 	$ fc -s ls=who 2 3
> 	fc: too many operands are specified
> zsh:
> 	    2  id
> 	    3  ls
> 	tarta% fc -s ls=who 3 2
> 	fc: bad option: -s
> dash (before):
> 	    1 ls
> 	    2 id
> 	$ fc -s ls=who 1 2
> 	who
> 	nabijaczleweli pts/2 2023-02-07 17:36 (192.168.1.109)
> 	nabijaczleweli pts/3 2023-02-07 17:38 (192.168.1.109)
> 	nabijaczleweli pts/4 2023-02-07 16:58 (192.168.1.109)
> 	nabijaczleweli pts/5 2023-02-07 17:45 (192.168.1.109)
> dash (after):
> 	    1 ls
> 	    2 id
> 	$ fc -s ls=who 1 2
> 	src/dash: 3: fc: -s takes one history argument
> 
> Adapted-from: NetBSD src bin/sh/histedit.c rev 1.38 by aymeric@
> ---
> Here's a quick few that fix my report and a couple of the ones you list
> at the end of that thread.
> 
>  src/histedit.c | 7 +++++++
>  1 file changed, 7 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
