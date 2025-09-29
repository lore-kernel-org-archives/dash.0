Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76B23C4F3
	for <dash@vger.kernel.org>; Mon, 29 Sep 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759171232; cv=none; b=LIC7j8vlwItEP9oQcvunXY+yVEsvUe1qJiG1lynJjp56Vzuo7Vv3H+tPvUi4BE6OOfARdcyFhQsmCRU8P8VZaXUXR51S1r4vLEWEvu6FsHR6pg7SknfzvOR944MmyhKCa+i98ptkxwjOxvM+mRRs+S7sIMfo5kv6fJJjo+LrYwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759171232; c=relaxed/simple;
	bh=fB3qTx3YWWwdrJ/+YhuPcgKE9RZ8mM0Lgm8afr3RJuc=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:References:
	 In-Reply-To:Content-Type; b=beVCeUJTkaY8af7nFeEo89jOWk32piQgnVtD/Kfgd/iEEvFiWCpfOvE8Va/cuXlHcTRsmmD7/CJ/NbBTT2ZTt8hVErIWJef4dG7mGtLAEkuxdhvQ5HH3YqXdSY0ZIHPCZbUPEgjuJJkq1yhaApQA0ab0oVx/Q5XWekNpIinvwfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com; spf=pass smtp.mailfrom=reillybrogan.com; dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b=Cmr5mkhY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reillybrogan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=reillybrogan.com header.i=@reillybrogan.com header.b="Cmr5mkhY"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-86278558d6fso244674485a.1
        for <dash@vger.kernel.org>; Mon, 29 Sep 2025 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reillybrogan.com; s=google; t=1759171229; x=1759776029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9lIrjQKvMfa6YfdqcDxZIBZGYfZm18V4fsqhNHnBFE=;
        b=Cmr5mkhYw1ia7Dp38aU8ivDdkW3laiG+L2DFu7c+/GfKx97CN4OgDKf7smuXCMZ3S7
         7Wsa0Cyfor0ndBw8z/UnDnzpPdUU4oGq4KYs1b4XTZLVVeIdaG1NZJKv2GNAxV/gPCRL
         OcVoZRbtJOH2vyObJ755rkwxy2xiDIh7UCVA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759171229; x=1759776029;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9lIrjQKvMfa6YfdqcDxZIBZGYfZm18V4fsqhNHnBFE=;
        b=QEksrgJFHLjnS78sWvrp+oXnVK0dQHt5Umv4A67wu8xEqtCgGXCRMm46GmzRw9eIlh
         kEEVKMLExkfSbvzd63ahndY8Ppy5FPt6pO22f/fu0cM+204d5Mn3FnTGPt4PstMb7ZAu
         UIDxv6QXtoTgmkmJs+yhHgeoC07URjqfOg0UwkYcSlfDcNTAbTmDV6nKxdyTkiiU6CAz
         9BVmHWVNE4op3F58EIrykBHjvc9HybAFTouGQYD44iH3C7mzoRXaRkDzW5M1flMp+oNQ
         9SI1ckKg4JhsTGN9x9BmtkOuBLtpZcRgGAGfJMIjAGBDXVkwDzc94e35RIX3rEma7m6e
         M8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp99HX+ESkg5h+fQrjYSC+zB07A+FJ36Gj3Wd3igorLOJplATx2aD+jgq1m5ZobxsYYcDo@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJauEQFGGppB15BpTSYUhVIiQ/R+Nh+IioNW0Ht4hi5eEoY6C
	rbBxgIefIYKuxxMBEuTYKJy5iEhtnUn8T9scTo8hJwHGR+bs1v1I9q818LBHcEBAqB4=
X-Gm-Gg: ASbGncszf8wbyCPsw6+KYN+itCd4b7FZAurn+sUjDut6MxjcUFjBzA/wIJjmsKS8AWR
	V0khBU64XNlBOY/AmcuDsedZjXl9qr2JXO7lRJQJirdDNB71+tCGvhEKYpRGe9qwuf8j4UftJw/
	lVc0Dg0zTWKBBRnde/I8EpXrOL/E6Vln+QMAT9zaNFrg9/QOQr4cPuTcyxPj0Q8DGhnAcAOSvAC
	0Zy6Kv/Evb9DC7TZehm76W/1WRqly/iCfzRn19/pYOhHXesyz8LJSCAoP//zLyoJrrbna8conXo
	MPRwAEYIzeN+Z2BMwwlFsH5wrayGSbOTCq2EaEDNfepR6oCklG0wUU4W2UdJDQwG/HzSxZs08ny
	MWOsUwec4e91JM2DJIaagbawxKjq+y86Q3Ra2ruabfJt9GFN9VsQojLv/NZhf+0NkBP11o32f8Q
	xsFrk=
X-Google-Smtp-Source: AGHT+IEHyLOhhb5XyIXfntM9tv36iuU4dpprklanheDxc6gX000NnzeZCKBT/DIdizn0p3xxW2Szmw==
X-Received: by 2002:a05:620a:4722:b0:812:c6e3:665e with SMTP id af79cd13be357-85ae95bb3demr2473402585a.72.1759171229068;
        Mon, 29 Sep 2025 11:40:29 -0700 (PDT)
Received: from [192.168.1.241] (24-152-154-74.fttp.usinternet.com. [24.152.154.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c27564344sm869612585a.10.2025.09.29.11.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 11:40:28 -0700 (PDT)
Message-ID: <9c262960-4097-4a13-af04-f8c7049f30ff@reillybrogan.com>
Date: Mon, 29 Sep 2025 13:40:27 -0500
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: reilly@reillybrogan.com
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Subject: Re: [PATCH] expand: Fix off-by-one bug in expmeta
References: <d3a79537-be6a-4e5d-afe6-8b8d9dd57955@reillybrogan.com>
 <aNivTiVPAJAgHDDH@gondor.apana.org.au>
In-Reply-To: <aNivTiVPAJAgHDDH@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I can confirm that that patch works for me. Thanks!

On 9/27/25 10:45 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Sep 26, 2025 at 04:15:15PM +0000, Reilly Brogan wrote:
> >
> > ../configure: 9961: .: cannot open ../gcc/cp/config-lang.in���M�U: No such
> > file
> > ```
> 
> This was caused by the failure to include the terminating NUL
> character when expanding path names.
> 
> ---8<---
> Ensure the terminating NUL character is included when expanding
> path names.
> 
> Reported-by: Reilly Brogan <reilly@reillybrogan.com>
> Fixes: a9012f4078be ("expand: Process multi-byte characters in expmeta")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/src/expand.c b/src/expand.c
> index 1fab394..912384d 100644
> --- a/src/expand.c
> +++ b/src/expand.c
> @@ -1686,7 +1686,7 @@ static char *expmeta(char *name, unsigned name_len, size_t expdir_len)
>   			goto out_opendir;
>   		enddir = expmeta_rmescapes(enddir, name);
>   		if (lstat64(cp, &statb) >= 0)
> -			cp = addfnamealt(enddir, expdir_len);
> +			cp = addfnamealt(enddir + 1, expdir_len);
>   		goto out_opendir;
>   	}
>   	start = memrchr(name, '/', p - name);
> 
