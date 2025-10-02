Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47279C148
	for <dash@vger.kernel.org>; Thu,  2 Oct 2025 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442219; cv=none; b=q9vd0ozO49uZQdxvITFKN8TsJtk/fVQgPELgA5dCiOkbK+082P3vj/w90JsLHnD++M91qI3K+g8iyzU3Cn1Ry4UNcR3PIAf2uGMuEREigaxF00Goykqa2ps8r8nq4q5CwcpRKQT3hnW2pdTnvI13uYn2wsuzdVjoB4B3L2+mKCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442219; c=relaxed/simple;
	bh=KbcMq+IzBBZtOG15mX4PqGOGZINxMesocMXNCsUyt7E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hqUjUNE+UWHA3kpt0uYFdtzcoq2S9BJRcg5k56yls6MFko0pS82kojDT/DPQbx1n5tUqKthgQwOA/ZiirW0nsxnQdmo+q7iggdp1+VRHySf9akfiV9o05iysGn0p+yCL38DBNeUffSNhcbhURAbYgErOqATQQEURPBM6PSTnvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca; spf=pass smtp.mailfrom=systematicsw.ab.ca; dkim=pass (2048-bit key) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.b=CM82s0W7; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.b="CM82s0W7"
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 69F521A05C6;
	Thu,  2 Oct 2025 21:56:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf10.hostedemail.com (Postfix) with ESMTPA id D0A042F;
	Thu,  2 Oct 2025 21:56:48 +0000 (UTC)
Message-ID: <2b8b60af-82f0-437c-a99e-260aafe37b82@systematicsw.ab.ca>
Date: Thu, 2 Oct 2025 15:56:47 -0600
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Reply-To: Brian.Inglis@SystematicSW.ab.ca
Subject: Re: dash 0.5.13 configure config.status truncated running under dash
 0.5.13
Content-Language: en-CA
To: Dash <dash@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
References: <ba3014e6-b1f6-4b6b-99ac-524dafd22f33@SystematicSW.ab.ca>
 <aNvMWqEu-uIiCbGk@gondor.apana.org.au>
 <81470aa2-3689-46a7-84bc-a7781cacf048@systematicsw.ab.ca>
 <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
Organization: Systematic Software
In-Reply-To: <aNx4g4eZSsdvXlRH@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D0A042F
X-Stat-Signature: c8wukshiqepmewdzaxnoi5ne41685kix
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+5GMvwO9Xd0pjBa26UJ8XfEiwpWzmKr38=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:cc:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=THjaOq2V459P2iI8yuGvn8WPjQWIDjSXVDaUiAKZzXU=; b=CM82s0W7cdO+1aEJ2CRlS5DlB1t9qQSE6ZPouUEkAdgnv7D7Y2u8gSDq3dA55cpiiOVZrBTp4Ylhpf50B2XvRlw4Dh1Ad6ULs7dV1IBoHiXmsSo0zNCoOdMl0KSjY9ylPXCfkUif3US+W/qz8i1cu5+ZaSFx5+DUwaxe4Y1TYiaD6tZZnrYI2/dB2hmbbnqZ/uSOD9JNA37kA5Y5+4HkFBCsoTs4CGiK02NBBbOzHtk2GFQ69u8N+LPFGh44kw17jgt59nsNDtN9e85NZ1GcR9INjW5aDqbw6ihqRalpMlzGj48mJsSAGSfgvOnI1G4N/gQTDoEaXdDtRlMONYvG0A==
X-HE-Tag: 1759442208-900985
X-HE-Meta: U2FsdGVkX1/WtbzbhTuREPv5pKwOxYXqSJD0dN58r4jMXrLxMlBFs66TF65zAEg3iQ+ppKcz5ofUb5dwlQH31PRjLU1QIOyMsC9jpaHhQC/MO9Ax3tooYt4NGjFpzeXJfQbZ9bIm5SRtLclFBrnLI8MUsAozIWDxiN0sKUFjs3/N7+iBz5jaG83AZbD/FKFGHlYxlaogskD+uBA8FR0i64UC4gHR9vEqsw6Oqx5xyjt3cv/JGnfQtj6nTOgduKgtRTOwQ7Z+pGtLGfgvHHDfti2S2Mqm+JqFm/8YkI34C8OtIqsXC456s2rn/XhtKPrJBvzD5AH1RBURfIPZbuEia0LiZ+EO6Q8UYWAoZ42HXW1gMC8yEZPCxz1ACcEnLt/GfwrBrFPwB4MB7NbHaOnmTw==

On 2025-09-30 18:40, Herbert Xu wrote:
> On Tue, Sep 30, 2025 at 11:11:49AM -0600, Brian Inglis wrote:
>>
>> Attached outputs from last instance of failing build just to be sure:
>> zstd compressed bigger files this time to keep sizes decent.
> 
> Thanks.  I tried it and it makes no difference.
> 
> So I guess you will have to bisect this one.  Here is my suspicion
> and it would be a good place to start your bisection:
> 
> commit 509f5b0dcd710804fb6c66750c7c7fd2d30a3ec9
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Sun Apr 21 08:33:53 2024 +0800
>      redir: Use memfd_create instead of pipe

As config files are not distributed in the repo, it appears to be caused by 
autoreconfig 2.72 as I cannot even build 0.5.12 without your packaged config 
scripts, so I have already raised an autoconf issue!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
