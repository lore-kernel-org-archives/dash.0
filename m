Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A29321425
	for <dash@vger.kernel.org>; Tue, 23 Sep 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625405; cv=none; b=WEYcWUhv5IPksHQ69csLJnC01RT+dE0lo30rEY6crhLkaVUHNVWfFokeJscfKbKtjd6sX5YQAtWf4ylfQhA6I1c+MbEv8DfwY/a/tD4L9WuehSa2DqtYYkSYjnCuo9q98c4Zbix8hbMs1o67v6q3+14yo2qFm6D7JqETVlLvLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625405; c=relaxed/simple;
	bh=MkT/wLkt7SBoi7F4oVlLbmpPCB9IICYu1dBeoCD74gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbkUKKpsxHuNwxP2YoUoP4ZFsSlTuNYFHRoXx6IrvfxJ0KXDqM8U6xnHt1UH2k4lHsY7uTnDs4qHc+bMfIEKAh5fMOxPykLKvu4O5Pj28TYZ723q8Xc6FjmD0nc1oUCFopGV1lw976yMu2RcuGTjbqjtMyXSNoN22Gz1qxGMBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=Ui0Rbpvm; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="Ui0Rbpvm"
Received: from [192.168.178.24] (unknown [31.94.68.2])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id CEA2091;
	Tue, 23 Sep 2025 12:03:20 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl CEA2091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1758625401;
	bh=H0gYIJGliG6Won/J/lhHpi8i3zxf9MAD9P6kSwx3kXk=; l=803;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ui0RbpvmMdOpu/dGKjd0bZq24VXEviJewst1S2Ks1HkgarnGaWb8/U+26D1SW/quG
	 QA/a362tBfvpZInxfxMqfynd4EygH4w8uJSSUlyKm7L0lBA8RgFNLVTZ0BEWJb/sbp
	 tm1IDAi/BzcHMc/fJ0Yuz3/2xL5TWwUEkYOsYOT0=
Message-ID: <6f017266-fc35-4864-9f10-3ead8af4e9f4@gigawatt.nl>
Date: Tue, 23 Sep 2025 12:03:20 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug: 0.5.13 regression in parsing
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Reilly Brogan <reilly@reillybrogan.com>, dash@vger.kernel.org
References: <aNI-RCggOzN-tyHy@gondor.apana.org.au>
 <77d15ae4-e9e9-44f5-9eda-f287a4815411@gigawatt.nl>
 <aNJ3dYOcNX_lrTbr@gondor.apana.org.au> <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aNJ4Nd-lE1rIjhH3@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 11:36, Herbert Xu wrote:
> On Tue, Sep 23, 2025 at 06:33:25PM +0800, Herbert Xu wrote:
>>
>> Thanks for the hint.  I can reproduce now by attempting to build
>> xcb-util.  I'm looking into it.
> 
> OK it's the same old problem: whenever we add a new feature that
> makes us closer to bash, libtool gets confused and mistakes dash
> for bash.  Normally it would explicitly invoke /bin/bash if it
> detects that /bin/sh is dash.

configure did/does prefer bash but can run with dash, either on systems 
where bash is not available or when CONFIG_SHELL is set to bypass the 
automatic switch to bash. This has been working for years, and I very 
much suspect that if you run with a slightly older version of dash, you 
will see that it also works for you.

Cheers,
Harald van Dijk
