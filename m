Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9FF224AF9
	for <dash@vger.kernel.org>; Sat,  9 Aug 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754746942; cv=none; b=bji1xn1WyU16cIDMHCbIA94SPSMYEwDyqPpX/9drosvvtrt/U5/3kw0u4UKt69+2V41jiDVcp+igZ/BtCv8Td+OtNdy7X/TfefEz3RNN15P0zPNSPhJMB8Dgde4YN91yuWooQtY9/PqfcK1H5Nta+j4zcdec5/Vwv4mELZxx0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754746942; c=relaxed/simple;
	bh=xltiAy3WYy1U4cFRR4HBxe3HV2GHqFR/brr2Frrs9LQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Z+5ZXUzofYu6Ls88C4nJftYItppV5JELXvXkVljBeLVLkxXIOLmBlm+K//yqu2BxlGHyuAs9jrUTIeMkJ1sHEbdfATRnykc/odBBhD9pv25aP+23iX7dcrrOv5jCxOmMM3x1H1QtEBTYeLVT5dRXBJbvlrRhYol1LkindUpANK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YymxMxAb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YymxMxAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754746939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAlIc4A5a+G1XlCeS/Ch+92vJsT1uRAa7ag25pfAcHI=;
	b=YymxMxAb6IQdGM9ffL2NY16QgC2UHs8ufF0/d39RyyzkPkZiwM2l4Kq19/ZEF03L6hsbVs
	IQeHUvQIGOKebsxX2fdMmSEn2CJy9ZkrrdIc6Pct2DRtgy2RBt2kNDV4p5IGuxfu4yW3z0
	5EbojFZBbmVfaEp41KRAh7nEQIEhXpQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-wLqSdvyXM3-aaQ5Vo8x5nQ-1; Sat, 09 Aug 2025 09:42:18 -0400
X-MC-Unique: wLqSdvyXM3-aaQ5Vo8x5nQ-1
X-Mimecast-MFC-AGG-ID: wLqSdvyXM3-aaQ5Vo8x5nQ_1754746937
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-af4f3e4514dso254877566b.2
        for <dash@vger.kernel.org>; Sat, 09 Aug 2025 06:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754746936; x=1755351736;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAlIc4A5a+G1XlCeS/Ch+92vJsT1uRAa7ag25pfAcHI=;
        b=YKQXZ3RB1Mub7KpKoLxJaWldYXWV6euirL653b4zNzAvwu3LfcVuFX9y2+ufX8PMML
         HrPuOCz1NOasY8LwEfXiEO9fZmbVqcjIkgRT98xf5TS7+jdh7psDRxxqnMyXpX2ttJ3/
         n5Ay5LX2IBzVawIjn/UX+W1yjG3OL56tYQL0DX9gHJz8JLFws/Gk2GzTghqO5VVUrS5s
         7gd+eyvED/E7RpDQwmCq+J2Lx77SkQoe/qe7PSVhD0trKLqoeb0Q2K/x9oAplEJzwKvx
         6TBnfFgIeMwD6EfosqQHeq0IJeRw3c5vwBAcJeBj//haP5X0EzlxYppe/KSjkvx8s3Cg
         eYLQ==
X-Gm-Message-State: AOJu0YwkiVcnVwMtIJSWFXqR48vUqHMyHwTvVNL2uGQou9D/rD6XU5KN
	xaE7347GBbwEOOFen6jHpQBXkjw2UEHAADFySEStIJylSL+pCrdMETlB05srJ/nJ4UTA0YjCPa5
	SF7SsMy2W5Fz/4VqCf/7rsk4GutfB7MmK2S1m2aTP24Fad7wtRmNy3Cqb37vmM6UWWRpIigphHq
	DTtdmriyT4BL0keY7cPQX662CJVkbc1VhZIVF218w=
X-Gm-Gg: ASbGncv4OtxyXKmACu1taHl3ONMOEPD2LA2kYBFnlGftrx2mGqpM38T4J3+yUBm6Cp8
	xfAqZscbrflPE38Ke46cxEE0OsyenPjwsLHU4o0hCEah+d6KdgIjsxOGZBZL37dDZ+wJIBDkalx
	3zCdXVR0/Gt3NyI9yiUwj/eVh29gOYwogulev+kH7FPBQXsuUVZ1nCQ8E1Rq27TUDHhp8fhKwz7
	cTt9mP7wdck/V3M8SyUSCsvmVCaDoBg+K2NBNF4sdw/ZVAoiu3xsram+KPtZj/jBuzI2e34280v
	soo6pOsZRncbELuqbACKGw+agD6KzzCVX/NRhCsdMK6/
X-Received: by 2002:a17:907:3d94:b0:af9:7823:61ad with SMTP id a640c23a62f3a-af9c6516da2mr638996066b.29.1754746936546;
        Sat, 09 Aug 2025 06:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtai+3v5+d3edaSEaLiZdnU9nPwQn5IWF9R8vB/qPsnuLHdzV3U49JIFiKtWD2osRxHOUqiw==
X-Received: by 2002:a17:907:3d94:b0:af9:7823:61ad with SMTP id a640c23a62f3a-af9c6516da2mr638993466b.29.1754746936074;
        Sat, 09 Aug 2025 06:42:16 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763c8sm1654113166b.22.2025.08.09.06.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 06:42:14 -0700 (PDT)
Message-ID: <38e17655-0aee-6bc2-bad9-7a209fa6d51e@redhat.com>
Date: Sat, 9 Aug 2025 15:42:13 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Looking at "int vforked" in signal handler is racy
Content-Language: en-US
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
In-Reply-To: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> I see this solution:
> 
> vfork_parent_pid = getpid();
> have_vfork_sibling = 1;
> pid = vfork();
> if (!pid) { child ops; NORETURN; }
> have_vfork_sibling = 0;
> 
> void
> onsig(int signo)
> {
>          if (after_vfork && getpid() != vfork_parent_pid)
                ^^^^^^^^^^^s/after_vfork/have_vfork_sibling/

>                  /* We are vfork child, DO NOT MODIFY ANY VARIABLES! */
>                  return;

