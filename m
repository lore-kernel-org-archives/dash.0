Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF90347C7
	for <dash@vger.kernel.org>; Sun, 10 Aug 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854436; cv=none; b=OJ8VJ1QmUeAJLgB3Lk3QIKJTdWofQmQ47y4G90KpBLUTdtHZdQhBZsS1DChNnEzJkinjxrzyJ/fmhr3HA4gILj1pfQw6FPNbkV0HdbVO7MvO+Tbjt1/cQhImqQ6ZdBxGwYSwtmQHvxNQa0Sf2au4u9dcKiMjXCb3uFaUDbQvsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854436; c=relaxed/simple;
	bh=oWnO3tpb1t1GpzZ9pRx3R6T1QqUbMcdhyaR4Np/8gWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jd9h0+/ull++pD9so4qSOMlv4JgLndgnpPwc1laWrDCPQNeeF1US+PbF1Gv7Hhbjl8QZPawnGF9CXzXSENjTmTmTvros6ROeFqeG0Xrq1wxqb/rS/9l4GvCrZtMA+noiVDENv7kCV+IrprF4DTfKC0MaLiI+LuJhMDWq8I46BEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfAhOI5D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfAhOI5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754854432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeqJ4j3jqG2QQoUbtrNlr33H5z0wUqUeZWI36EcnuYA=;
	b=LfAhOI5DTxGfCzcbfx6yUpYTXag/gBoUbJHblPnVf0iIkLPyPiAAhaucqjCZwb1fZrDQYT
	oIneyEHuplomsIKWbjsWrlER2PDEEvdEy7W53nH4YmSdJxKeU9YM9xVM04uIRZmx5m8CTQ
	+6bVIBCYM3187xmOEOdYkfGNRvrp0IA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-aEiwgiwmPpW358RIGwbCzQ-1; Sun, 10 Aug 2025 15:33:50 -0400
X-MC-Unique: aEiwgiwmPpW358RIGwbCzQ-1
X-Mimecast-MFC-AGG-ID: aEiwgiwmPpW358RIGwbCzQ_1754854429
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af9423cfdb9so320126266b.1
        for <dash@vger.kernel.org>; Sun, 10 Aug 2025 12:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754854429; x=1755459229;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeqJ4j3jqG2QQoUbtrNlr33H5z0wUqUeZWI36EcnuYA=;
        b=qCsZ/l55K0laHnEf07TkX+bxJvw96EM+wPS9SPCgjLEoDl2EZV1lYGIq5TGWP+QDKO
         LFaupF2H0lX0x04kxanFUDhFTUWr6HBPLLw2SRBSdrioWgplYeWkP6g24gnapPqTfjvA
         Av2xbderSA1akI77JsRJI7XqfuMmbQjjjhUqSIDcOt76LIbWVCPUZZc8l4obHKrwEHUR
         MzaM0Ii/7sYCbkLq9SiMVw4Hsfd9N353QIGrKE5dj6kIHk4jSF1ERWgzDRYxNF8a8ds0
         P9Q9nlBgRP5R4IC/a9UlJ0A2A7LKaxA72Q5kMsopSUiXusNNg3PW3t+WGWd+Xv3kwTw0
         OVag==
X-Forwarded-Encrypted: i=1; AJvYcCWvpHuIIj5mIc/ewfq3AbBCIsqgPwVAgxjOqHOkZiiy7ZLvSn77moDOoQAoDXPHdIvDc9Jq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyua2r0DmlSFtyx6AP0OuYGBzNqyIrawjULjnXQrLJ7suHRvJ1+
	ptGc48yFG+Lk1szokugtT4LxjgMV39ZSf4P1m7HvvdNVQ3E0t4iP7X+9v0EycAxH8JRrZQyK1En
	DVZaIt0GYSi9xtFP7rpT9Ri77LhW10ZT/o/xSzgOFSNrcFAdN6931lbp+wImzyHg=
X-Gm-Gg: ASbGnctmrz7KfBoQRUTxjHDRkepIKR8M9reRoow3QyGanigbwdsQyeT9I/iU8Z5Itwz
	1RLdjpa0NEZw+5ZgMUTl0ztF2+q+ZCRdLCC56wNvVAXs/nu0j3FbVI0/JrVGqnoe8ny1NN5R73S
	EIdhF6j3vfM69jJ5cpUB9sDimqVm9hZwzB8qq6vbMsy34xeHLRyLTotwAVhyMfMUzYMcjYn1POP
	oUxfO1LTODMCW06x8L9ag5GqVnSUdy14dsX/iv87aQDf2h+/N2QVfMNKDioWGD3/SzA5Bte+eGe
	0ZSHa5tFPksrU2lexIOnYzJIQiolVUG8p5s/qYu0Gv1o
X-Received: by 2002:a17:906:ee89:b0:ae3:7058:7b48 with SMTP id a640c23a62f3a-af9c648c961mr951863866b.25.1754854428590;
        Sun, 10 Aug 2025 12:33:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIMr/W66oKYXQbtxVE8efGnl9boh+rnNp4Q0ODZSc148dJdtrllh21N56bIj2EjJQZ+7gq2g==
X-Received: by 2002:a17:906:ee89:b0:ae3:7058:7b48 with SMTP id a640c23a62f3a-af9c648c961mr951862866b.25.1754854428206;
        Sun, 10 Aug 2025 12:33:48 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a07670bsm1912082266b.8.2025.08.10.12.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 12:33:47 -0700 (PDT)
Message-ID: <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
Date: Sun, 10 Aug 2025 21:33:46 +0200
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
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
 <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
From: Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/9/25 15:52, Harald van Dijk wrote:
> Hi,
> 
> On 09/08/2025 14:29, Denys Vlasenko wrote:
>> struct job *vforkexec(union node *n, char **argv, const char *path, int idx)
>> {
>>          struct job *jp;
>>          int pid;
>>
>>          jp = makejob(1);
>>
>>          sigblockall(NULL);
>>          vforked++;
>>
>> <<<< Parent can get a signal here.
> The sigblockall(NULL) is meant to prevent that from happening.

Yep, missed that. Should be ok. I'm mistaken.

However, this method requires three syscalls:
one to mask all signals before vfork,
then two syscalls (one in the parent and one in the child)
to unmask them back.

Whereas the method of recording PID usually needs
just one getpid() syscall.
Should we consider switching to that method?

