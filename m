Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A328688A
	for <dash@vger.kernel.org>; Sat,  9 Aug 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754746154; cv=none; b=JmmhFYf4+L0aaTMP6GlsS5AC/m0C0D4gMNo26ZT6jBnGCTbbXRCT3uBftW/VoP9iM6Sgp6Rvm7Qm+Bgw2NqzZPdAhOhZexuVa8p1IFCUnAv3DqAhsGpro9R6gHF/f6CHD5RQwdpr/beq4JkOJ7gU4sfRl8Dyzhz/1i02df1nN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754746154; c=relaxed/simple;
	bh=lQG5kw3OWouWpWNXA2DxdjHNgEeul9OR5B7ZvMWwhac=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OqG/XDHoh57p07BdMvP3XjWUjJQsuWcREU7bg/JevRByPSWxqpvevSv6Hz+6s3zQ8STbSEvyGBTRhKr/56hM7gERNY3boUs3MePzvoffKwFUhfOFEu/ZJudzEErx0n/SmL2VlCMZoWOvHHEBpJ9j4kyMlhuQF+FgCPiaErWNM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJUZxJZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJUZxJZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754746151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z9nUhnj9rz/Sg6sspdkOxkoReCYNi7qiCZbZOXLSQtc=;
	b=hJUZxJZKXqkM72z5a3ZUAg+pz7uiRgRgzIX5IUIIz6m3b5kzWn8Bg0D9vBQboO9jK0AGYQ
	J7Q34VbWHEl38EMsRmslHSiPA5alpw2IzKp/2EygkHjcRZMxRvyTGTlg3LNqOz4kBWlS4G
	z9FQJMujbRWNiEHAdB8fenaW3n91UAg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-P_R6WzRxPtC5qypllrRIvQ-1; Sat, 09 Aug 2025 09:29:09 -0400
X-MC-Unique: P_R6WzRxPtC5qypllrRIvQ-1
X-Mimecast-MFC-AGG-ID: P_R6WzRxPtC5qypllrRIvQ_1754746148
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-615cef7d015so2433339a12.2
        for <dash@vger.kernel.org>; Sat, 09 Aug 2025 06:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754746148; x=1755350948;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z9nUhnj9rz/Sg6sspdkOxkoReCYNi7qiCZbZOXLSQtc=;
        b=Sn/i+zj9dADlCw43o2r2X52A0iiQzNthzGvnqH7irTDvq+bE1VhpdoPlN8+FQ936Jz
         NzTbBNnUczP11P0HdwewqqXdUAgxdI9Ojm/ky7bY5QjX7FGp0nJKGIizW6dq5HHJQxAY
         rLU0r3x+mzAjGNYmu4nQpxWsUpphT5Ttfzx1JvfWfwqyh++Aa8eUp5cxCmecoC5FQtBM
         xyTN0pZH4mkG9hcEZLDJZZJqyGotITmfxlOzBWk0SJo7/fE/qHdkKoq4igom1leP+e+b
         OhREbiUJHNz2SSOjuOJkvhYfoIXsw8qgoDTuJuzFvGbwsZbcqjUKWMz+p33UmKGAjWeo
         gMXA==
X-Gm-Message-State: AOJu0Yx4tSNY7kGytYDSaIO+PfRha5fCgU4Y1oS7UNK6OAysAVpfb5pR
	4Azy6g9G4zyAJmicZd2KqxyXCWNoOnNhDFtvNfZyiqZuiu8nFn7IiunZcJPtPJ3GgMWRLTCYDro
	bKfaeZFneJj7Qe9IRQ0+2tG1OGBL54a4ris1F3tfqYZ8ECsn5Y/kuOqdJDAFYxnmvTKU5JBB87o
	sJW8163A8RIUQqcDq2PBgmh2PTMMqQZVr5scGM9aE=
X-Gm-Gg: ASbGnct4xf2UXAOUy/CKD/ao+nyry0m/yMna9PiwsuJIsevVAs80/i+V1DXdL37SrNh
	H2PxWpf9zEfl6FABgHyHSdk1m0x4ONb8W6FeOWltN0titeQqH9GYSYh2xlX8iHKfRhRUv9olAm0
	SHgc9l4wE7IMaWWHpxdsjeLbNdRymmMBf5nO0nc7b6NpPb6tAEHW/DCMuYloQ68EbGdmnNVVsPC
	dWXWkHwzLOeGOE0B/aRBSQd1jECWlL5kIgxHoIdlp4EBsr6JvixppPcpIxA82RrSiJf3LowhBSs
	Z4JevHVwY8XmSHxLUZxQuTtl3Y+C5hHTqmzt6xtkTbB+
X-Received: by 2002:a05:6402:268d:b0:617:4a59:c5da with SMTP id 4fb4d7f45d1cf-617e2e53bbamr4784141a12.23.1754746147863;
        Sat, 09 Aug 2025 06:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBCGGuPwVb+CUJiRsuFE0oXefVyvS3cc8JGkWModHJGnxz1+/krlDBNZoX7m3S79xLqFEwYA==
X-Received: by 2002:a05:6402:268d:b0:617:4a59:c5da with SMTP id 4fb4d7f45d1cf-617e2e53bbamr4784124a12.23.1754746147399;
        Sat, 09 Aug 2025 06:29:07 -0700 (PDT)
Received: from [192.168.1.181] ([193.165.40.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm14998109a12.0.2025.08.09.06.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Aug 2025 06:29:06 -0700 (PDT)
Message-ID: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
Date: Sat, 9 Aug 2025 15:29:06 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: dash@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: Looking at "int vforked" in signal handler is racy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

struct job *vforkexec(union node *n, char **argv, const char *path, int idx)
{
         struct job *jp;
         int pid;

         jp = makejob(1);

         sigblockall(NULL);
         vforked++;

<<<< Parent can get a signal here.

         pid = vfork();

         if (!pid) {
                 forkchild(jp, n, FORK_FG);
                 sigclearmask();
                 shellexec(argv, path, idx);
                 /* NOTREACHED */
         }
<<<< Parent can get a signal here. The window is in fact not that small:
<<<< in the child, execve() syscall is rather complex (needs to tear down memory
<<<< mappings, which causes TLB invalidation) and takes time.
<<<< all this time parent is blocked and does not execute,
<<<< so it don't yet reach the next line:

         vforked = 0;
	sigclearmask();


Signal handler:

void
onsig(int signo)
{
         if (vforked)
                 return;
^^^^^^^^^^ this assumes we dot signal in the vforked child,
but it may be false! We may be in the parent!


How to solve this.... at any given time,
there are only two processes which share address space via vfork,
all other possibly existing copies of shell processes (such as
the grandparent shell if the parent is a subshell) have a
separate address space.

So, in signal handler, we are in three possible situations:

* we don't have a "vfork sibling" at all (we aren't after vfork)
* we are after vfork and we are parent: need to handle the signal
* we are after vfork and we are child: must not mess up the parent's
   address space, thus do NOT handle the signal
   (or else it can e.g. set intpending = 1 *in the parent too*!)

I see this solution:

vfork_parent_pid = getpid();
have_vfork_sibling = 1;
pid = vfork();
if (!pid) { child ops; NORETURN; }
have_vfork_sibling = 0;

void
onsig(int signo)
{
         if (after_vfork && getpid() != vfork_parent_pid)
                 /* We are vfork child, DO NOT MODIFY ANY VARIABLES! */
                 return;

