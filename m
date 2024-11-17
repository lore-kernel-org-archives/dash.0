Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691C26289
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731826464; cv=none; b=PrQUfvvU1iu9RDy+G1EqI+7paBrLxY13E0lZ3hLgs8WwVnI3jQ7JzxLaU3GwVkkvQ3/7omO5/UCp8feuX6Of2fT5TgxrNAGbsFDFRxly+JFABoXxQ1roP+2TLYzY70JgEeKrBfJFMZGCrLA40XE8zrTDZD/fh6f0HDDnhfug/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731826464; c=relaxed/simple;
	bh=DgG+iMZTHISZLFYxeQhVtHniaO7eTU1ny8yJ6UBUBuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1zfC1wM84GakRBtWM0VAqqIF1u3UWRiUBF3BtAC/IjKSEl2ce3+bwH/WASn+CslwXkiaDzEurdhfmrArAGtDbH/NKEf8ZcTvPpkgMeyeIGllpe8IEQKK+7sUAfaittbKf5B9ukYL2WPiJ4YFQAE9qJLhQ4vO17XDCiF2TBBFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKdU9efJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKdU9efJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382433611d0so217519f8f.3
        for <dash@vger.kernel.org>; Sat, 16 Nov 2024 22:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731826461; x=1732431261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GeGZMn/c67YSbJ+ytjU2Rz43VUsp3LrMWK1RjNPeFw=;
        b=eKdU9efJ6Adbcqe4TEKi138tqYMHNwpVssqMNb+YvFy1j9CjoDaGZyVbuWe/Ma7IkY
         YR8wtAVUaXguATR/+W4lqYPGDWYjI3/zMu2KOQIjBvaE5G7AnsyUTJQXCdEx9XzInH/s
         VR/coNvM4y98l84vPsIcAKn8ytNhGB+qvSv3Hfx1SJgRjLkPTpMMKvLKvQBPhbjZVZ9f
         y81Lf8yxrbB5H+aTYH0lf+8mRo6Btd4D4o+qqx7nBSgRjos+TS92SxbpwP7gzOl+ZbcU
         HOErXNVrD7rOJZJEp72XMhUdmI1zqoIe36HyT4CZMZMhvUv1Cbqvdi6K5PQeYR2WdFBz
         0VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731826461; x=1732431261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GeGZMn/c67YSbJ+ytjU2Rz43VUsp3LrMWK1RjNPeFw=;
        b=myfzOASEOQlWiUdke5ZiNbqH6dkx1iq5UvghEkYm57vG1J8L1wt6Pe1X/DRpIDgsdT
         Ras93AMPI4CKZhK5Y0vStlnW01e3Thf1V+XOVA0W23TdLVGAgmM6L0WDqRsCYLyD21UR
         kMnDO1xe4JpiozWpfDOcwfIog4kpGRvTfBYmEt4ZNr9TjCeydi3LSm8d1uxh9OmNDbwr
         Wgk7DzxFUVhqUEnoFUY76VYc2GPz1M2mePoiHo50J46SK16x01Mlu4N9L11cd+XudDnZ
         pdj8iJmNlKYcY8m/kneNGSGlOo4Uem1HmrFgf5puqe+OCaZwXWYpDFgJr9M2dWDIq5Vf
         zOOw==
X-Gm-Message-State: AOJu0YzL/jan+8JAcuRyTP84pm/zMePnvZ1lPdSs41BTfy8L5sM2iHDe
	tkiRKTAKsJNHjO43J75nFztTDmG09dTtDsEtHk1C5U/M+Nuf705w4d5IgA==
X-Google-Smtp-Source: AGHT+IFpq10nDxkkFYs9R9b9dcPOFOSbhCy0emXCfxuwdIHoDsAJhn4FoER5Z5++166duQJnESXnWw==
X-Received: by 2002:a5d:6486:0:b0:382:3959:f429 with SMTP id ffacd0b85a97d-3823959f5d8mr3325897f8f.5.1731826460668;
        Sat, 16 Nov 2024 22:54:20 -0800 (PST)
Received: from gmail.com ([2001:871:22f:1e7:3203:c8ff:fecb:a3c3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df7e177sm387836466b.84.2024.11.16.22.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 22:54:19 -0800 (PST)
Date: Sun, 17 Nov 2024 07:55:22 +0100
From: Johannes Altmanninger <aclopte@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] expand: Fix scanleft/right for !FNMATCH_IS_ENABLED &&
 quotes
Message-ID: <ZzmTWsAPq7G_PCeA@gmail.com>
References: <ZuS3PI7He-T7pugf@gmail.com>
 <ZzlT_1CY5AjxtqAs@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzlT_1CY5AjxtqAs@gondor.apana.org.au>

On Sun, Nov 17, 2024 at 10:25:03AM +0800, Herbert Xu wrote:
> Johannes Altmanninger <aclopte@gmail.com> wrote:
> > I'm hitting an easily reproducible crash.
> > It bisects to c5bf970 (expand: Add multi-byte support to pmatch, 2024-06-02).
> > 
> > After bisecting I reduced it to this example (probably not minimal)
> > 
> >        echo \\ | dash -c 'foo=$(cat; printf .); foo=${foo%.}'
> 
> Thanks for the report.  This patch should fix the problem:

thanks this works for me. I've been using master for the trap fix.
