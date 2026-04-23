Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432617555
	for <dash@vger.kernel.org>; Thu, 23 Apr 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980221; cv=none; b=oJabYtBvI0cYI7Eez1vgVETxPcyndaNQV9DNcJ3d5wMb/Z9naOwCrs7jHnO6h6EgJbsQz/iov9N/Ac27fJsjMZEHypc6QhjIGsYg4PpRai2Oxff5GgY/+kEDXxvjCi3cWkrjC5U8LAY9tXM6vApbxf995iT7Tf80Ce0j/WGHXfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980221; c=relaxed/simple;
	bh=oLxhUOWarYOiO8w+W4A5f8qewQq1j3DLKnuX1CHUouE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVW1ataipfC03gElC6y5Tya8cQy7/F3porqgBaEdB5HTTWdyCmGkf9MOYbdiBn1Mt/s7iHiVvhssZ0s066o26gQBZM5Mf+V/kr6Mo+cB/jd6vpC2WKmUv5oWqMLmjfuuWO6MVLR3Q6rYbL9gN5dD5vUu7nECPzg2K9AkpGkwlfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfqYDL0S; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfqYDL0S"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89f1e767f92so64702166d6.2
        for <dash@vger.kernel.org>; Thu, 23 Apr 2026 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776980219; x=1777585019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HyHrw6U8XUAxWOJfJ8h4na8Hgv6VV5dWgwbBAAvZd1U=;
        b=qfqYDL0SBAdFhOwFxueiVXF691Ph0Edwj224NIJCfUO+TBNFQHOszalIiARqZ/c4U1
         7GpHg3K8KtcXNL+tK+fOiJSxQBXBQyyBu1QpxBWLQsoJzemhUtnZkDr6BMb0cWhAKR57
         3XDzfKUUeNRClyW7NdUjrxq6fW/VvEc8P4JaJ9Ga8MLKa6epRo/tCKvAJEH8rQiIZfRZ
         4/LlIpeLWnUUTXwOvUVmiiI27UbSMWi4PoirhztbUw9rt+SmbAXTvXkk5QauGmY5qkpP
         a6MtHw+M5+zamfJ2UioFJ6gyR/w2XlJn2eGw1R/Yhyu6wmCu38NWi6ryBvHymu0kXM4u
         bGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980219; x=1777585019;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyHrw6U8XUAxWOJfJ8h4na8Hgv6VV5dWgwbBAAvZd1U=;
        b=RmYBL8/rELTYtbhmM3ZvQmzOEnCUK3edy88wIFB8M/BmZW8yk3ZtcX1GgoQ/BnQRqD
         UcJ+ZE8GVQlPELwsu/KaoecscEcYMWddiJS/xwKYgiUZk3RET0fC3B+7MP/x4hFWb5Kx
         gvAd2OkgNB+W4Z+x+wUHrJOQfG8XDBvFJMLSZqRmlV2mAOKcJwdAwzSIFeMDpqGsKLxT
         QdgKzWlaR6HSbuY+3OlioMMbL18pk5G6STCkZB7mws1dna4PdQeaCZSu4ttEln/iiis4
         OgKHXCDoo5STcT5vCZWv9ZH/O5wnrjfdy/UjjBM5K5H/nso5yJxHxK/Rw4U6pvyLT6nb
         t5CA==
X-Gm-Message-State: AOJu0Ywu9Bsvi/1zwfuRswjOTb9dh0grTOEfFtPOk8WL3rk30NRIh0xE
	93DHw/EO1wos5WCDkvSByGi6bGabf6q8a5YjSMLCGO1NNAkeqD7JilS640q4cg==
X-Gm-Gg: AeBDiesTTymyfrcNMJtvoz7YwPc+ZaqojMYDKwq1EV8jIHvXQVx6tllIrhBxCUwj8DJ
	uiLFxdJ4Q49OrxaBC9XWFpE0RaTdH6O/8LGjgdcobhc/Lvr1typ8oxVnTSdD8J8ZaVdqPfNEn2x
	F+m3qYLOnqIBwytx7pLAz1L6YEaQpaNeSBD/Ifw2k0d6frtLdhhqV+7wMkKWCEYjNt24JwGQfPj
	ELZgbs+KCOpXC9ghhAYrdhV1s5OCVREy+UOtYUxjcUzfi++1kuNCJqbhL8oLSlo3wk+jHudw68U
	WMlLCbsvsXMbQojI0qij8gO+VeVKJQVVN9w7bQ0yIbWl8gUFRRzeOsnwdzcT8egoZOu0uGiyc/r
	VSBDtpvmS5InybgEUySK35XCgQk9SY4snPayNuEC/OwtmWBbwrtRBrLoG1tGkK0yrkzAZn9+11A
	s1XlVSiQma1hQ0Odc19rlQl5GrXYTpJQMYCVnPxbYsSlGacKgtznAtk4aYaT9vJUeNpRzzaZ3sn
	nlFaeCXBeJxQofSaXzS2qEGdP+M0387Ug==
X-Received: by 2002:a05:6214:5d8d:b0:8ac:bb62:fe4e with SMTP id 6a1803df08f44-8b028023d7bmr475273666d6.6.1776980219295;
        Thu, 23 Apr 2026 14:36:59 -0700 (PDT)
Received: from HQ ([2607:fea8:ea1f:9fea::4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm170355816d6.13.2026.04.23.14.36.57
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 14:36:58 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:36:56 -0300
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Subject: Re: stty -echo doesn't work?
Message-ID: <aeqQ-ExEzduLIW3W@HQ>
Mail-Followup-To: dash@vger.kernel.org
References: <aemGV--9_pn_ABU2@HQ>
 <b7d62511-4a17-427e-ab7b-468f9896e6de@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d62511-4a17-427e-ab7b-468f9896e6de@gigawatt.nl>

> stty is not a shell built-in command and dash has no control over what it
> does.

I knew that, but this was still a behaviour I was only seeing in dash
and not other shells.

> Running this locally, what seems to be happening is that the command
> did work, but when dash is using libedit for command editing, it immediately
> gets reset when prompting for the next command.

I really should have done more thorough testing... You're right; I see
that echo is disabled when I try

	$ stty -echo; cat > foo

For the duration of cat(1) (IOW, until I hit ^D), the terminal does not
echo, but upon returning to the shell echo is restored.

> What behaviour are you expecting here? Are you expecting echo to still be
> turned off when entering the next command, or to be turned off again after
> the next command has been entered successfully? Both options, as well as
> dash/libedit's current behaviour, seem reasonable at first glance to me.

Assuming I am understanding the two options you list, I think what I
expected was the second? For bash, the user input is not echoed until
echo is restored with `stty echo', but the prompt is still printed
after each command is entered. To make myself extremely clear (not
because I don't think you're capable of understanding, but because I
don't think I'm capable of explaining...), I will do a lil diagram thing

	$ echo hi
	hi
	$ stty -echo
	$            # user types `echo not echoed', but it is not shown
	not echoed
	$            # user types `stty echo', but it is not shown
	$ echo hi again
	hi again

now that is what I _expected_ to happen, but that is based on bash's
behaviour, which is based on readline (what bash uses (I think?)). What
do I think _should_ happen? Well now I feel like I might need to do
some more research. Maybe this is a situation where bash does something
weird but we're all used to it.

Thanks for your detailed reply!
-- 
S.
