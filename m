Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4193C2D5408
	for <dash@vger.kernel.org>; Mon,  6 Oct 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763537; cv=none; b=O7774nBBjb4wYS32JLnukfp151aIzcRWYoWWTv0ccXq+0DH56SBoxi5Ue91LQj+ESIKjl4rXCoQktRRCvZ0OvwRZ/CMBQ6Q1f8O6Yo7ysa6X9ZC//EZbkhHO63iZRUWeCQjiWTFuZI9DTTiPXnJaKolNYxHw6mC7Xj7TXkeiGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763537; c=relaxed/simple;
	bh=UvUQGUQ5JBYWsPF3dXQX6iAwy8oILLzV2IJ6nbkFtUQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DNctXYSpuQoaXGyqkFWVySkbkOgUzICD0cr1TowvD3qnRHSiM4FSmkJDw1BMu/ja0wQ1IaU4u9WmsbjDB+rsBCH5jg1oR/Udif173ytJx9qWzj8lJSk2+RcrTOrX8R060wlRfEyVH6rVpv6PAjF+hblZhuJfkWvr8OwUdymsI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=W6doUbCM; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="W6doUbCM"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1FA3E240101
	for <dash@vger.kernel.org>; Mon,  6 Oct 2025 17:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1759763531; bh=FZSdmjPAXFVwLHEvuacW3y96mjV/fbwZWZm1+M2MGx0=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=W6doUbCMK2YMlYUFVLXTXDxaTqP0sOnHVl6m2iN+06v5iUn09Z9ZNG0vScQOOpri/
	 RcqodxEYjdb0AXQgwNDwVQ2zv1+raaFFOwBh9i7sobtMEnJMiwxcgR1+YJoXeEzTOh
	 J1wGPuqhCCQvBgOAq8OdzuZMisHwuTBniBxOyufsD3MUOeOt3BxPLV3ocGG1aF/Jup
	 6FHVsDPWHRktCT1U3GIWHsfx6ccGaGnXvhn84KEeyD7XFZEV7AfWTH87rSbuTFVxXz
	 z4q7hv/QPEnkTpfGhwSVr6U0+33dMK8/OCgR5nUdC1FSvR2s9LxVNpixgP6rLdEOtx
	 0VCbAJQUZ3aYw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cgN6L3n8zz6tvh;
	Mon,  6 Oct 2025 17:12:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Oct 2025 15:12:10 +0000
From: j.daubert@posteo.de
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] builtin: Keep backslash on quotes outside of dollarsq
In-Reply-To: <aOM2ykncn3sL2LsJ@gondor.apana.org.au>
References: <aOM2ykncn3sL2LsJ@gondor.apana.org.au>
Message-ID: <c0a8a284b7b64cfd6ed1062a50a8be08@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Thanks, the patch fixes the build problem of inetutils for me.

Am 06.10.2025 05:26 schrieb Herbert Xu:
> Juergen Daubert <j.daubert@posteo.de> wrote:
>> I'm using dash 0.5.13 with the two patches
>> 
>>  [PATCH] expand: Fix off-by-one bug in expmeta
>>  [PATCH] expand: Fix typo in pmatch for wildcard search
>> 
>> as /bin/sh and get the folling breaking while building
>> GNU inetutils:
>> 
>> ...
>> make[2]: Entering directory '/tmp/inetutils/src/inetutils-2.6/src'
>>  CC       hostname.o
>>  CC       traceroute.o
>>  CC       inetd.o
>> <command-line>: error: expected expression before '/' token
>> inetd.c:166:31: note: in expansion of macro 'PATH_INETDPID'
>>  166 | static const char *pid_file = PATH_INETDPID;
>>      |                               ^~~~~~~~~~~~~
> 
> Thanks for the report! This is due to an unintended change in behaviour
> of echo '\"'.  Thie patch should fix the problem.
> 
> ---8<---
> Only dollar single quote should eat the backslash character before
> a quote.  Make the skipping of the backslash conditional on mbchar
> in conv_escape.
> 
> Reported-by: Juergen Daubert <j.daubert@posteo.de>
> Fixes: 776424a8f915 ("parser: Add dollar single quote")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/bltin/printf.c b/src/bltin/printf.c
> index ff576ff..106aecd 100644
> --- a/src/bltin/printf.c
> +++ b/src/bltin/printf.c
> @@ -339,7 +339,7 @@ unsigned conv_escape(char *str0, char *out0, bool 
> mbchar)
> 
>  	switch (ch) {
>  	default:
> -		if (ch == '"' || ch == '\'')
> +		if (mbchar && (ch == '"' || ch == '\''))
>  			break;
> 
>  		if (ch == 'U') {
