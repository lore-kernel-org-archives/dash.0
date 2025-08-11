Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919851A9FB6
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929819; cv=none; b=KR3zd0I17pr6CnoZ+by2Xc2wnZigyMz8v7gpu8c57vv9qeyp1GfyFfWLrcdQAOQJ0IRtf13HRoJOcAVwDyzVICjjoLNZDed/lSTn32s+dk37cDeqMLeEkcCPqKd5Pu1jzXunMtfSAdDib35Cs0oV7/Ai3wrsZ0C7jV8FipSJ5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929819; c=relaxed/simple;
	bh=vNdkL+AY4uL0HyBVT1F2mL1G6BguIonetuwXUR5fPM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tr+veaLay0QjQZrWtQx6WpWqS93Ul6BAyTsTpEiNJskGAJRE/ZbbpO0PoJs9BQS5V4A1vWiwgLxsKPN3WZm7vag9Tsxg5sn89FPgIolyHQy9A3SjXZ9hJ7KX6omCM7SNdF+9kgQb9VIQtw9FLd8E7lDS+El/bN5n7TMDWkYU6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKP6OGj2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKP6OGj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754929815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHTXCA1pf4EBwNaZR/IZCw3wcKRg0dVvTYIbYULXbB8=;
	b=SKP6OGj2c8KW8qi8AsLqWQ/lxuVuXIlUpHKoY6zg/GnyXDm34fMkv70ZR8R4TYrw+4WYBP
	5f20nkRsdthUzgBGxDo2uF8mW4/c8vWkv8eKw7xu6DieiXeQC2OFs9yv80RBbp1PrA3DE8
	H2TjJLRZqevMSB/smUk6xlsdhj8j+b0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-RbRR11yDOoyjuk-5mjBTxA-1; Mon, 11 Aug 2025 12:30:14 -0400
X-MC-Unique: RbRR11yDOoyjuk-5mjBTxA-1
X-Mimecast-MFC-AGG-ID: RbRR11yDOoyjuk-5mjBTxA_1754929813
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af911fc1751so317185566b.0
        for <dash@vger.kernel.org>; Mon, 11 Aug 2025 09:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929813; x=1755534613;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHTXCA1pf4EBwNaZR/IZCw3wcKRg0dVvTYIbYULXbB8=;
        b=R6azbo5fmWkDqdWL5kQcMeSBJXRSXNiwOGv+CkS0Fo+B46n42+x8BRG3gDDL+cw1Iy
         zsiArEMGSeYslY+PL/ENgCxAsZ4DbLbbAIONmJE/Dlnte0dpqy6/9qfl5rk4nBfC4EvY
         nDQROVIw+bOp0GPDcFUPTcdkAD+hIxVKTSn73WlcBoFvKP6IAW9NHTR0fzljUq8nhs+5
         VZkQqs9PxBr1w8ynj3qGTGYwLIT69MJGUPSBUFfZf5El8fM468DHd1qyqNpDqBKhPfBT
         XdLuhvhP+txFEiB8ulpBDIMF3M8mBPi0tKeCnIAlg8LbqL3RF/chBxIgw86wZZNwQpSD
         Rb2g==
X-Forwarded-Encrypted: i=1; AJvYcCWHKSNhXDig3AzCDd1Z8VT/gl2yppT/C07UKHenywNUhIbGM0Slsnk3/KJlQfi+pHbV6Lpm@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFoE7ernXZCyBumOuLffQ7wZRoz4syMZnDo26VLJkeI/txmmo
	79bBFy3iTHUTes7oYFqTIOKzsyo7qHX2zH1OA89umG5J3VYtuKmyToiaXyy0ONa1PUNhH0hQqTQ
	qYzynbVQ/jV3ow/648qWjafSPuTlc59LIsS1n2AEGHHTVk3aD2BChYvyZvu5bqhE=
X-Gm-Gg: ASbGncv8PKFoFn6ouTUDLNL2eioDlPg0RejpuFc13wTHHIcsiNDdpR1Gc8bY1EHrfZz
	53fgip6bLedKb0dLo5TwiWNCL7o0EPwaKYnCj252EnxfqcNJnCrHxFZkk3NUbOJ32KDSIaz/8sf
	ICMl6hmHXnLKBLi7meIXHcsgKGSVQNOnflBU2cq1NDAggeZ3NYd6oR4BzgvM9G3uPmUAgA1Ew7p
	QbrLNSEkyGlq2C4H/2j+EH6WxgFDO8nUpujkZZLCguSJDDmpvLfeh9QYbSkb+Iii5KiYtncAlGq
	AKB1Eupf/N6uOuJDxhjyaL0kyZHLD5GLzPKBF/0TGth9
X-Received: by 2002:a17:907:9621:b0:af9:3eea:353a with SMTP id a640c23a62f3a-af9c6545a6cmr1196416366b.61.1754929812529;
        Mon, 11 Aug 2025 09:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsVZLBq8UqHE2niTn1S/T8U8+XHf+bUSGo3tm8/ukhwTorSCDhUQkdoOKk98wFi+RllYAChQ==
X-Received: by 2002:a17:907:9621:b0:af9:3eea:353a with SMTP id a640c23a62f3a-af9c6545a6cmr1196412766b.61.1754929812053;
        Mon, 11 Aug 2025 09:30:12 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8359sm2037608166b.89.2025.08.11.09.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 09:30:11 -0700 (PDT)
Message-ID: <24b4a38f-5c88-729f-9b04-71a295f4efd8@redhat.com>
Date: Mon, 11 Aug 2025 18:30:10 +0200
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
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
 <a708d788-e496-4478-b1b2-48ccfae092fd@gigawatt.nl>
 <5d9124b5-d687-d864-b73d-79d9bbcf160a@redhat.com>
 <c9366587-0723-4380-b50a-a43035678523@gigawatt.nl>
From: Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <c9366587-0723-4380-b50a-a43035678523@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/25 14:57, Harald van Dijk wrote:
> On 11/08/2025 08:52, Denys Vlasenko wrote:
>> On 8/11/25 03:21, Harald van Dijk wrote:
>>> On 10/08/2025 22:30, Denys Vlasenko wrote:
>>>> The reason for "pid == 0" retrying NONBLOCK wait for more processes
>>>> is unclear: if we got here, we already did wait for processes
>>>> just now, got none, waited for signals and got a not-SIGCHLD one,
>>>> so there should not be more processes to wait for.
>>>> A comment explaining it would be nice?
>>>
>>> A signal that gets sent to a process group can simultaneously be> a nonfatal signal to the shell, and a fatal signal to the child,> where the nonfatal signal to the shell may get processed by
>>> the shell before the SIGCHLD resulting from the fatal signal> to the child. I do think it's possible for that extra> loop iteration to find more processes that have terminated.
>>>
>>> Whether this is an important case to handle, I do not know.
>>
>> Of course any additional iteration of wait3(WNOHANG) has a chance
>> of finding more processes exited or stopped.
>>
>> But by this logic, we may as well decide to do seventeen
>> iterations of it, not two.
> 
> I think this is misrepresenting what I was saying, and what the code is doing.
> 
> Currently, the code loops until it gets a result telling it there are no more processes that finished. You're suggesting looping as long as it gets a result telling it there *are* processes that finished. The difference is in the case where the shell got no information at all on whether a process finished, because the shell received a signal.

         rpid = 1;
         do {
                 pid = waitone(block, jp);
                 rpid &= !!pid;    <<<<<<<<<<<<<<<<<<<<<<<<< HERE
                 block &= ~DOWAIT_WAITCMD_ALL;
                 if (!pid || (jp && jp->state != JOBRUNNING))
                         block = DOWAIT_NONBLOCK;
         } while (pid >= 0);
         return rpid;


If we got pid == 0, it happens in exactly one case:
we did waitpid(WNOHANG), got 0 ("children exist but none yet
changed its state"), then waited for a signal and got one,
which wasn't SIGCHLD.

The above behavior is requested by only one caller: waitcmd()
- the "wait" builtin.

"wait" builtin is required to be interruptible by signals and
to set exitcode to (128 + sig).

Therefore, if we got pid == 0, we don't need to wait
for any more processes. We need to return to waitcmd()
and let it set $? accordingly.

Instead, we do yet another loop.


> You're suggesting (please correct me if I am misrepresenting
> what you meant) that because the shell received a signal,
> we already know that there are no more processes that finished,

The last part is incorrect. I'm not saying that we know
that there are no more processes that finished.
I'm saying we don't care at this point: we know that we are "wait"
builtin and we got interrupted by a signal.

> For processes that finish before the signal, and processes that> finish after the signal, I agree.
> But those aren't the only situations: I'm pointing out that
> it's not only possible, but reasonable and common, that
> a process finished and the shell received a signal at exactly
> the same time. That is the situation that the code currently
> handles, that your proposed change would not handle.

Yes, current code, after getting a signal, will try and see
whether there are processes with changed state. I understand that.

I'm saying that it is not necessary. We already got the signal.

But actually, my bigger point is that the code is awfully convoluted.

It's ok to leave the logic unchanged, but perhaps it should be
tweaked to be more understandable. Unreadable code snippet example:

                 if (err || (err = -!block))
                         break;

Assignment in the conditional, just what we need to be confused.

Or look at this:

/* mode flags for dowait */
#define DOWAIT_NONBLOCK 0
#define DOWAIT_BLOCK 1
#define DOWAIT_WAITCMD 2
#define DOWAIT_WAITCMD_ALL 4

First two modes tell dowait() what to do:
do a nonblocking, or blocking wait3().

But DOWAIT_WAITCMD name uses a different convention.
Instead of telling dowait() what to do, it tells dowait()
*where the call came from*! So, what would dowait() do?
Code reader has no idea...
Why not name it, for example, DOWAIT_CHILD_OR_SIGNAL instead,
so that it describes what dowait() will wait for?

Currently these three small functions are in such shape that one needs
at least ~30 minutes to grasp what's going on.
I, in fact, needed several test runs with instrumentation to understand.

