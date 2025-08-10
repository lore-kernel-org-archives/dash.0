Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F942629D
	for <dash@vger.kernel.org>; Sun, 10 Aug 2025 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754863475; cv=none; b=l+xoVpWexvK3+u4OkVi2yU7iqtqbFZv8VW27l7l1ol3QLp/xva81lcIiM4aFktmNRNSMeBoPQymSuKue4GG+5fRXe+aBHAm42Cmd5R7RwuTqNdzFrTcLS1bzYhHQ8+57I5xr9gbOAyfgLUf5v+NDImEz1A6QtiWQL5NXCZErL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754863475; c=relaxed/simple;
	bh=xOgWCYDgfD7XME/JfxdThmkPrWOJ0KhYHBNMMI2X05Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ck/D+ynNTRNSdwZCZB5Qz+9uKTi9JMaHGvcfB0MphMjHjrJmhf5vod41CtVC+JvIAUybUlKam1YC59GP0g7zrPHffV+nc0At8WxGatT/TK0eTsTaiXobriniHSg5+24BfZpzmsAD3cJNM4dLT0ENVz/lAy+2o1/RU/9tarSqW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jqt7cxrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jqt7cxrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754863472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHQOSXcANn8gtr0toKYzwRDnfz3bUf/sLReoJ3LoOcY=;
	b=Jqt7cxrUu7WrcFamofiFDYDPd7XVjBfTDAGt2ATIa1vbOBfyNGoNoHpzRX8tTQgSQ/jRkL
	V0IkpCUvmf8pzNF/3u9FOrQEzon+zu8gqLb5vzGF8sTdI7AXnVmfMM08FWkv+XQWIl44h2
	J7bGun3lxRt/I113Smb4Hov14VIQCDQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-g2E80p5mNteoXha8tTJqiA-1; Sun, 10 Aug 2025 18:04:30 -0400
X-MC-Unique: g2E80p5mNteoXha8tTJqiA-1
X-Mimecast-MFC-AGG-ID: g2E80p5mNteoXha8tTJqiA_1754863470
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-af93e838f92so272418066b.0
        for <dash@vger.kernel.org>; Sun, 10 Aug 2025 15:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754863469; x=1755468269;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHQOSXcANn8gtr0toKYzwRDnfz3bUf/sLReoJ3LoOcY=;
        b=XqCdOcm/tz2Ws6Rc2qDg8sV3YmcUKqtIpKbByWfOwvzO6zUrsP2WoMedStEa0XjqYY
         sTwfmXWIFv2wvMxf8anJl1Nmn924dpz7gfUKQDNRO2ZubXki5Rzru0ZsB+B/ns9R6Kop
         BxpluwcSHeNEBf1jmf0MQ/OpKG+msSpviVeDTaTxvuCq/ev+yYn5TUK8Ww8LLkUg/ylN
         IeaGl4iewMsDwHOpxSBHp5QPuex1RZHBkIsBC2GIxer1CiHOA04f+fQSkfc6BF7sPAGU
         j/pcSyQ6J+2qGCHZMHuHX7gTuR7JeNtBLdArdbe1eMswjLHkSuuXKQjLJBrN7t6wxuXQ
         ZU0w==
X-Gm-Message-State: AOJu0YzkGFBlOSbL5b5eq+XYKhyVgx+ajCk2xemDEipjHwUveW7BWAoo
	itqgxhKjHk9DXCp1Vwnte/8Xu9X9X2K5rPc9onsaAqPagenZ+/qK5HeHEmJihO9t6hXVznZ4I8T
	xSeXKZXQ/29tV61z6rKmu+L0k2bOqymUjqijsBET4Tv+7DFIvEhQwsV9H3OFufiIHnwEauVKvCP
	fEDDluYr9Jo0RkqRskc5aCiVPrp4PNCQevyCWTJAI=
X-Gm-Gg: ASbGncvKuRFy9Tm/97I5/Cpn/PNIQ48Tz7QXmlnOC6beqwrI6Wqgbfs5nz0esRGfvve
	LXjTTBPcQX6yKgk4tzxvu0ILtEmS/kkM5yliDl9NQxL/CGwVvM8SV6ofnqOrSeTY8M2TGG/lhjO
	JpeGYZ0F2gAe5T9qECkQuloBUNGimYKTBsTW20I4qRhuitdNHAC3QueNL/hK+ziOZoDZZY3dsKK
	f9zDMFikNakd+UniRBnc6rDaIxbN0hbq5jcA+Mxs7DoAO7GonaNYGalKN1ukacB6iKTEDprcngW
	P4q3rvA4f0YMq4VPR7eEducoiODjWGpFY2vTqwzP53YP
X-Received: by 2002:a17:907:9720:b0:ae0:b3be:f214 with SMTP id a640c23a62f3a-af9c63308a0mr789481766b.9.1754863469156;
        Sun, 10 Aug 2025 15:04:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4wrfFlgQ0jxIKitv6iHsvMjEY6/cE9L7iD1rUornOkdP67zKwbIftmSk+HOgDHvNhB2aV2Q==
X-Received: by 2002:a17:907:9720:b0:ae0:b3be:f214 with SMTP id a640c23a62f3a-af9c63308a0mr789480366b.9.1754863468629;
        Sun, 10 Aug 2025 15:04:28 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0def2esm1881302266b.61.2025.08.10.15.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 15:04:28 -0700 (PDT)
Message-ID: <d7c1fb12-6e2d-49f4-0934-fc7134557d5f@redhat.com>
Date: Mon, 11 Aug 2025 00:04:27 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: wait code is fishy
Content-Language: en-US
From: Denys Vlasenko <dvlasenk@redhat.com>
To: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
References: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
In-Reply-To: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/10/25 23:30, Denys Vlasenko wrote:

>         rpid = 1;
>         do {
>                  pid = waitone(block, jp);
>                  rpid &= !!pid;
>                  block &= ~DOWAIT_WAITCMD_ALL;
>                  if (!pid || (jp && jp->state != JOBRUNNING))
>                          block = DOWAIT_NONBLOCK;
>          } while (pid >= 0);
>          return rpid;
> }
> 
> So the dowait() return value is 0/1 "got signal" indicator:
> 0 is "we got a !SIGCHLD signal", 1 is "we didn't".
> 
> Not clear why we bother. We already have that indicator,
> it's "pending_sig" global variable.
> 
> So the calculation of "rpid" is redundant.
> The only caller which checks dowait()'s return value is waitcmd()
> and it can just look at pending_sig.
> 
> The reason for "pid == 0" retrying NONBLOCK wait for more processes
> is unclear: if we got here, we already did wait for processes
> just now, got none, waited for signals and got a not-SIGCHLD one,
> so there should not be more processes to wait for.
> A comment explaining it would be nice?
> 
> -                if (!pid || (jp && jp->state != JOBRUNNING))
> -                        block = DOWAIT_NONBLOCK;
> +                /* If got signal, do one more nonblocking wait (why?) */
> +                if (pid == 0)
> +                        block = DOWAIT_NONBLOCK;
> +                /* if waiting for a specific job, continue blocking wait unless it stopped running: */
> +                if (jp && jp->state != JOBRUNNING)
> +                        block = DOWAIT_NONBLOCK;

I thought about it a bit more. The entire loop in dowait()
is for these purposes:

- if we waited for a process in blocking mode and got one (got pid > 0),
but the job we were waiting for is still running
(jp->state == JOBRUNNING), we have to wait in blocking mode again,
until it's not JOBRUNNING.
The user is waitforjob(jp) -> dowait(DOWAIT_BLOCK, jp)

- if we waited for a process in non-blocking mode and got one (got pid > 0),
we should see whether more processes have terminated,
we have to wait in non-blocking mode again.
The users are
  showjobs() -> dowait(DOWAIT_NONBLOCK)
  waitforjob(NULL) -> dowait(DOWAIT_NONBLOCK)

Notice that in both cases, pid > 0. If it is not,
the loop does not seem to make sense: we did not see any processes
changing state, why would we want to check again immediately?

waitcmd() does its own looping while it sees at least one JOBRUNNING
job, so it does not need dowait() to loop - only to do
one nonblocking waiting, and if there are still processes running,
then sleep waiting for signals.

Should we change?

-	} while (pid >= 0)
+	} while (pid > 0); /* one process seen changing state, look for more */

