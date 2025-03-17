Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E813219A67
	for <dash@vger.kernel.org>; Mon, 17 Mar 2025 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202586; cv=none; b=GiEb96/w9PGMB0tllQQNCRPnZh9syUacX3al7aGUZUAYZ3e3qcbo+QT0isPdES36aGJOtaFQgVzzGZKMQPWTIsomMfrZf31o2diWGe73BQy+SL5ZLVh+2dcm8W6ZNMkBv/RT7AViZexv37hJQ0/Np/8aCvjNKCvK89K1FNuGSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202586; c=relaxed/simple;
	bh=Br2SnzZHtz6/fxP8pLfbf60Dg+KUIY9K1M1LjkU4C+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJy99mo1SafQvlIztBdxjlkgG3D6eeWRmr7fLhq4TMMCg+ChnrHL8uCRscV1RQQFq9f4ckDnJBome40g+AHYrtCMI6Afb1r6PuIzDVPU1Nc6OJzZdCdiSw5An+kj62MjhrQJ5iMY2T1h1qkurNis09+9jvDV7/ndgQF9JjMmKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1++AXuB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1++AXuB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so644663966b.0
        for <dash@vger.kernel.org>; Mon, 17 Mar 2025 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742202583; x=1742807383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3x+7k3ReiZKNiIKPJzpCNCdmuQCgPrzOpI4eDaNZ9Y=;
        b=e1++AXuB6d0R2NaJo1s8IdPsvJy73U+Uaa1VcGtEhcAyTn5K1xQBHHZNul/O3yZIs9
         OK+DC5eCubGknCl0JqRGJzB09fmdm5HTCGXb1u25PE+SeTif/e2+8CG0g6QRKZbSDMUC
         6VdCdQ/12l53FfTwYXqKyxjwg7tX2LsSgxPXFbmxezobZq6ZNtN2n+I7O//BqkXmwmLB
         2iq5RTGGAwaP5OMB9KXqtlLPDa4VFkbtoBfx1l1kKxkjpS8O2fcuEnoWGn8vt4N9WAqj
         AEkMDHZ6k1hbkRp8iTUvWCQSceisXzomtZVNQZZO/ZBrlC7ujvh990oy6E2z/SX5e66K
         ljZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202583; x=1742807383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3x+7k3ReiZKNiIKPJzpCNCdmuQCgPrzOpI4eDaNZ9Y=;
        b=AfDrYy9OirjaV7tTphx5KAHYvzV8xR9ZNttklxaxj0m0320d2vRlUiSdPfiemmygGO
         1OuovAnVkrKw3oClc0zZ+dQq4a4fMfbOK7U6B3B23d4z44GkqyPokI9jwmmSSjax+R2f
         LpHUAs7u57Y6Ee/dlrvF+e+A7syq7d5GDHUbBQE7zaLis+nrwB6rQD3YC98t/MXguxa9
         RWwV9F3F7YPX/iffTiVffw8tyU47bYddXhWtxSDXanJlAEpxQ9g46h7bv4LuC7zvUiF4
         RtGYKLR3W+O01VTKITwFdPNXX1qNg710L8DxeZCgzzEeIZE85LLqCgwuAAWrBRViM+p+
         mWvw==
X-Gm-Message-State: AOJu0Yw3jbI1G471e6QQRz+ieb/EPhJyO1lxsVXpq3PH5FjGRkcuJ1NQ
	29xJ2MB2TdV6A8/sO4DI8LQgYFTI9wdzc3zRjYuOpEqEnXqQOPvmrAWrUg==
X-Gm-Gg: ASbGnctR2m/JkfGZC8csyimuSp4nxeTlYmGliItDe/TZX4p2sbUz7AnrdsGqkW5RNt5
	e2l5mzefaPnEoIkWuHW4h2h0v0zfebLuTzTXzQlfgPcGwtND6PfDt/oZIqdeuo7EehbGgjM5PdQ
	0sNclx2CAvv2VsBDQ8qTb7V5azQKZbdMbhKOFl6RvIaorFxHKkcrW4SoByFd+Ee+VSvictKkK2y
	iM7tBio0Z9ZpgEUmEQynNYikO1DXSUrZhuPPwGvf45voJ5arCUDgPNu4joCQVpmn37W4nijgj6i
	W1/tOLdjxjV8/1woNXugnCs=
X-Google-Smtp-Source: AGHT+IHNoKHmaQipn/rZ1bFrgz2DokhUiET6FD7DTwJkoHxCCGcY9dDlL1QiTL4D3pNmrYamKu1vzw==
X-Received: by 2002:a17:907:2d0f:b0:ac2:a089:f47c with SMTP id a640c23a62f3a-ac33052f006mr1115428566b.55.1742202583229;
        Mon, 17 Mar 2025 02:09:43 -0700 (PDT)
Received: from gmail.com ([2001:4bc9:1fb7:92c4::5b4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a40f61sm628366766b.134.2025.03.17.02.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:09:42 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:09:39 +0100
From: Johannes Altmanninger <aclopte@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: expand: Fix scanright zero handling when fnmatch is disabled
Message-ID: <Z9fm07IjSZ3Ym3NB@gmail.com>
References: <Z7mDhYBNOMKSJtEJ@gmail.com>
 <Z81WqTBtj9TRqQzy@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z81WqTBtj9TRqQzy@gondor.apana.org.au>

On Sun, Mar 09, 2025 at 04:51:53PM +0800, Herbert Xu wrote:
> Johannes Altmanninger <aclopte@gmail.com> wrote:
> > I noticed another regression in c5bf970 (expand: Add multi-byte
> > support to pmatch, 2024-06-02).
> > 
> > This command now prints "abc-def" but used to print "ef".
> > 
> >        x=abc-def
> >        y="${x##*d}"
> >        echo "$y"
> 
> Fix this by setting s to the correct value in scanright based
> on FNMATCH_IS_ENABLED.
> 
> Fixes: c5bf9702ea11 ("expand: Add multi-byte support to pmatch")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index 7a30648..0066e1a 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -650,7 +650,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
>  
>  		if (zero) {
>  			*s = '\0';
> -			s = rmesc;
> +			s = FNMATCH_IS_ENABLED ? rmesc : startp;

Seems to work, thanks. I can go back to running master now (with
https://lore.kernel.org/dash/ZzlT_1CY5AjxtqAs@gondor.apana.org.au/
applied too)
