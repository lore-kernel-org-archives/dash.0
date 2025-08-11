Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D31EE019
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898741; cv=none; b=GUlU+Syw6nZpMae8vyGZ5aBnDFSAwgDBrDpXiFXrIwcGWDRo4iFH2I6RvkWO2VtC8OxmWwVuXTh5jj5JJP//7A4IHLnN/jQ9bw06fLmlyIsc3IERtorQOmhPzZ/knGcoOx+pcaQWoacsbvY2yAfLavvCJlW8HOnjY11DRsbC79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898741; c=relaxed/simple;
	bh=kw0RcZVKBTdDpNUrbS3wWnCL1141Ma4QW4DGl/lb5BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNINhiK6NvI+M1enFR5nd2KwqxKnUxgcnONDeq9zHTn+PlnPMEP3VSgM81CzkljGLDZjUeEUA2fONsmR8TnUc5KgrkW7qA1iU8F71+jOw2VB+sa3JDhCv0e7sP1qgF98Y4mbWlmkj664uagRPBi2cw0EDPxTqWuQhHB7flCHHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NS/Emg5z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NS/Emg5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754898737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oqk8aD58HuwrzJUEAjVsGZ0LRXOsdI/Gs2xmlxgQttA=;
	b=NS/Emg5zQt62DiSHCVikJ8NQ97DE800er9sNNgENomw/xn3YJQB9hALptuZf2KlYs4HyYo
	JXir50e4Gllo2Iokjm6FBWFUgECIEpwwDIDJEGziSPHJG04Tl4AC6QLoDRHA6RiRUrqX70
	epeytQ5kYc4/qsTDoffjC+6VHOLdn3g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-NfUgpYG1Mqm527Xw-MW0yA-1; Mon, 11 Aug 2025 03:52:14 -0400
X-MC-Unique: NfUgpYG1Mqm527Xw-MW0yA-1
X-Mimecast-MFC-AGG-ID: NfUgpYG1Mqm527Xw-MW0yA_1754898733
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6181858bed8so950422a12.0
        for <dash@vger.kernel.org>; Mon, 11 Aug 2025 00:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898733; x=1755503533;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqk8aD58HuwrzJUEAjVsGZ0LRXOsdI/Gs2xmlxgQttA=;
        b=ckraBKcOiLDuxi9YAW3sxVhoD8tUFKNe/0XqGjgdwA28AMFVPAYwgcvwXJFGpaEgXY
         moxMa1+P3geS0orfiGLEtWeEXdp/APXZTgF3wYmBZqtcwsdlodsAsWVQp+2rmLgKcOs0
         ZymqbwTdBKoDa+NR1JMMj5TcseAv9m6bvLUC2Z1S9vZz+Zx5vs/uM/ZmJu3t90MmJkv2
         Go6aL81IbwexLC7FyisS3qtbxk4frDJwUXBOpM7K14A2HaIS8WCCXairGyqZEh/Vh+Kq
         WzWRpZakwBUloYbq5em2b0XF0OnsJdyOeG53EPVrqMZ1tm6kQdNR6kQiKVyiUDt7kQCN
         W0VA==
X-Forwarded-Encrypted: i=1; AJvYcCVUp4O3HJvc57nRLqZLhb3cZkx6NNbWceJPlig7It3UjI07dVOJILa4aN2hfIsEXn14CgTT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rXr1OeHiyFXs/KHohNRNyfx1sO1p8HotfQfii6VuR0wEg9Qf
	eo5YoGwGOSMJtxW6nOP548lQx7UI8pthBPX8vUwvrnSW6jqK/NfEMvHvUXguqj5TNgCXe73vyKr
	ssgRtPQBDeHBZxysxjUy5Cc0Ax/yySAC3wPDKoMUze6/l4AlsmwpNeRNqfzPaSP4=
X-Gm-Gg: ASbGncvw7g2d0HgIlhvZ+PkYjXiLRI+SMLmfMXvkL4pZShErC9e9VUCJ8h/dd75N7T/
	S9eLCJ871m78/v9YWR3/tqDfI1v7Hss/v1HLFIR2lWZOx0o4pjAkcO+cXH/FQVUREMQ/2FvUoYo
	IcC+04pv4yhj1X9Y0XD7AE7Es4ln4rZB6l2NjZokX2LOMcC4ZV3n5ElpzhU7/Lx1JM/quL6MxvC
	JIupfiD9AuTezHFDLhkQ4dJtfe66oTp6gUtz1FW+v7/DUwXjekiOLKU5G6SSjjseNXQZmNfpf2d
	6BTmd76gxVHlyfQjNZWN9x4muy+MX3+d3Oy58iPhQlPI
X-Received: by 2002:a05:6402:254e:b0:613:5257:6cad with SMTP id 4fb4d7f45d1cf-617e302b838mr9866711a12.11.1754898732622;
        Mon, 11 Aug 2025 00:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1Bj00gvm05w6OrRMGdFKxX0ZAPEYyfX/wSPL4xGXAThyKaBH0rOUbFiUYe5PZz8J7Pp5ig==
X-Received: by 2002:a05:6402:254e:b0:613:5257:6cad with SMTP id 4fb4d7f45d1cf-617e302b838mr9866705a12.11.1754898732253;
        Mon, 11 Aug 2025 00:52:12 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7a32sm18042829a12.37.2025.08.11.00.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 00:52:11 -0700 (PDT)
Message-ID: <5d9124b5-d687-d864-b73d-79d9bbcf160a@redhat.com>
Date: Mon, 11 Aug 2025 09:52:10 +0200
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
From: Denys Vlasenko <dvlasenk@redhat.com>
In-Reply-To: <a708d788-e496-4478-b1b2-48ccfae092fd@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 03:21, Harald van Dijk wrote:
> On 10/08/2025 22:30, Denys Vlasenko wrote:
>> The reason for "pid == 0" retrying NONBLOCK wait for more processes
>> is unclear: if we got here, we already did wait for processes
>> just now, got none, waited for signals and got a not-SIGCHLD one,
>> so there should not be more processes to wait for.
>> A comment explaining it would be nice?
> 
> A signal that gets sent to a process group can simultaneously be> a nonfatal signal to the shell, and a fatal signal to the child,> where the nonfatal signal to the shell may get processed by
> the shell before the SIGCHLD resulting from the fatal signal> to the child. I do think it's possible for that extra> loop iteration to find more processes that have terminated.
>
> Whether this is an important case to handle, I do not know.

Of course any additional iteration of wait3(WNOHANG) has a chance
of finding more processes exited or stopped.

But by this logic, we may as well decide to do seventeen
iterations of it, not two.

It makes more sense to do the minimum number of iterations
required for correct behavior.

Consider that the addition of DOWAIT_WAITCMD_ALL flag
(the "jobs: Only block in waitcmd on first run" commit)
was needed exactly because in waitcmd() -> dowait() case,
dowait() is doing an unnecessary second wait3()
instead of letting waitcmd to check whether it is necessary
to wait more.

Now, with the DOWAIT_WAITCMD_ALL, it still does
the unnecessary second wait3(), it's just not causing
a potential buggy behavior (hang) because it's now doing
wait3(WNOHANG).

