Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A0244660
	for <dash@vger.kernel.org>; Mon, 16 Mar 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625272; cv=none; b=ieyflsoDHYocXT8IVVvsjQS5dHl0YoFVQnfc9vToR7B/tpvpvEm+W7e5dB4OqrL1MgArdMyiP8H6QI1HG7Jr72UUj71yF5Ywp1kkJCfCedJwZqxOgJiRf5l3ssOvJkZUb6aY1pw4z37I7EbQ9h0pYmWquIEJtha0pK+VC5rCBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625272; c=relaxed/simple;
	bh=YWsex4qtWe4pf0tMqyNO1W/2KBoKThyh6Ihxtl8kyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M1PasmVP4fygTRH6T5J0hSm+kuy/W2CaGyh1Wvo6KK2xoPpowYabQuJNni8riSVcvWVA5Cc9CycELDtX+Le1i5Kxxxwoq1Fj49s/GLNPhMl5m/keXukSMXEIXiU7R/C+HXxNpEB3RXS7I9C6p7nOacCqXDOIKiALFPNnkI09xEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Vbxawm21; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Vbxawm21"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=ujWsvrKHEpJS0CaLj0QSdE1MdmHC6Grw5G9Ue5A6/lo=; b=Vbxawm21deVa/OUzEoXqsHJJKy
	FcL/2RF/TBvwO+Z8mbaiDxLXXr2xvtbUVm7xNDbKUPCcRkb3W+j33tt3/NJq/mdcxaOgfK50W0dSQ
	f6VxcMC8Wt8DwWqGY7nbIa3Bv/l0G2wzqJzf2pehwA0Pay+MTvfj/uLQRypVhDLRyszSBh+EIOnH0
	LeP1wlXf/3MVlme7KRYZJ6oksqclMAsazj+RaiiZMWV1WlSngxdv0uy5YcuNcSjxtQUQ1WoFfpIJe
	d4UWTurxUONfagFbGQsUGXT1eywfd6wsiNHfWd7lB75RaNuGo9YQXQPFaY841mSgUcXUKFIXKjqN+
	QZb5Luqg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1wx7-00Ehj8-28;
	Mon, 16 Mar 2026 09:41:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 16 Mar 2026 10:41:05 +0900
Date: Mon, 16 Mar 2026 10:41:05 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: dash@vger.kernel.org
Subject: Re: Extraneous test in setsignal()?
Message-ID: <abdfsQgaqAXQlwdj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcN3qdr0ee_Ny0syn_eS6dh6yK59AYX8PgamV20P-MXFaQ@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Denys Vlasenko <vda.linux@googlemail.com> wrote:
> void setsignal(int signo)
> {
> ...
>        if ((t = trap[signo]) == NULL)
>                action = S_DFL;
>        else if (*t != '\0')
>                action = S_CATCH;
>        else
>                action = S_IGN;
>        if (rootshell && action == S_DFL && !lvforked) {
> ...
> 
> If you read the above carefully, you see that action == S_DFL check
> can be eliminated if we rewrite the above like this:
> 
>        new_act = S_DFL;
>        if ((t = trap[signo]) != NULL)
>                new_act = S_CATCH;
>                if (t[0] == '\0')
>                        new_act = S_IGN;
>        } else if (rootshell && !lvforked) {
> ...
> 
> 

Thanks.  But that's exactly what gcc 14 generates anyway:

  b2:   44 8b 35 00 00 00 00    mov    0x0(%rip),%r14d        # b9 <setsignal+0x29>
                        b5: R_X86_64_PC32       vforked-0x4
        if ((t = trap[signo]) == NULL)
  b9:   48 85 c0                test   %rax,%rax
  bc:   0f 84 ee 00 00 00       je     1b0 <setsignal+0x120>

...

        if (rootshell && action == S_DFL && !lvforked) {
 1b0:   44 89 f0                mov    %r14d,%eax
 1b3:   0b 05 00 00 00 00       or     0x0(%rip),%eax        # 1b9 <setsignal+0x129>
                        1b5: R_X86_64_PC32      shlvl-0x4
 1b9:   75 1d                   jne    1d8 <setsignal+0x148>
                switch (signo) {
 1bb:   83 fa 16                cmp    $0x16,%edx
 1be:   77 18                   ja     1d8 <setsignal+0x148>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
