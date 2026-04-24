Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757131A7E2
	for <dash@vger.kernel.org>; Fri, 24 Apr 2026 03:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001147; cv=none; b=OQ1Z8UfAuCi3oUY+VQ3ZWtsCD6JQiY6r7RIFsfcvlcqhjGsr0rI2yAmv7ZHw05r1rF0rUB0HaTD1+86y1MITy078uG7AfWSeFg1MIj1dlKiW9Erb2vOM7Yx9jH1QzJxiylRVoFF0Mt+naCVGbdSxAprapmPILiWU2vskOu7ZINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001147; c=relaxed/simple;
	bh=9sVhRZM9nfK2hcwBslz8vooA5FrpximgOFoufcUk81s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCiMhRl3Lxuoq7MdxT9COW8LFpXMPRIp/XbVOVQrvVda/QPULAuWZYd5BZWtiS3JAYP21gM/fr97J0ry99IV+4xvuvXwx9C2fzvegow9tl2dvQ7AjR4F/dG9+gDluT1JOj+3PuXCT0qc7LLLKGQHQotSK9SrObwiLV7ShwRRyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFuvVtuK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFuvVtuK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8dbbc6c16b2so916964285a.0
        for <dash@vger.kernel.org>; Thu, 23 Apr 2026 20:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777001145; x=1777605945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNuLQ5MsRPhEqXaAa4nvOXC426VC54w2+EUERDGu78o=;
        b=bFuvVtuKEFlzwgT6d4zgfDvrOK35ghFrpDkh10a7S7E0rIT133Sz5DZvIrntd3KGHw
         OVWkEpiXA96F7GYkt7IHq8ceb6yIidgPHR6hxxqM7yP+6ci1hLCs9zIPsDra71Zi0my/
         ENmFMJfQrbdhkGGzkRjR1EPDyJAeKM/7WM9oUQdxgZKct2tkaqjmvWH6cymgDQPXApd6
         j6E/D4ecBDloJKtQXnmaqkxZtuGE03kGw2wcAXIAwXku1MaF8pL8/m4AjtGFPHW2pV5y
         Y3wEuVflPw9d3ox4U4vZ2URsZ185pvelKqROGdQAHs2edcJHNtiogO04MgdTVqCGarn4
         9jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777001145; x=1777605945;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNuLQ5MsRPhEqXaAa4nvOXC426VC54w2+EUERDGu78o=;
        b=Po8MV4uTamgV2fWiGG5pq5ceNX5HUqdmVZaFW8Jolx1rMATlmQpCiNd/vv2tPrDsrX
         iveEOQXTW4MM/vWNjN5q8amiUTJIeUU2veb2y6cFCjSduzxHnvg1jW9DfUgam3SmSUq+
         6MbyhC7FFEf0/+Xv8Bqb7yMu/zHAeRV+1NI0ZIO0QrK7HqBZ+p+mVHM2oCYHeBrO6P1O
         sCh0vTYrDQci3dUHquYTocUW/RuXhoDpN2+KOx+RdynBF1oG25siMnetrO7h6bxZXGo/
         8Dpxf24QPI9s9O63Vc0xtJ9IKh+eK7uhSAiex96Bm275+3JYHBXlS3boIDvdNgG672vx
         E2yQ==
X-Gm-Message-State: AOJu0YwQK4hPRvcbJR3D6RS3hCrMyg+dkMKcHTKBpPcxnoRRbqmjjSaI
	rgJYYmjl606wzZm0ht0ISKUMzM2X8MPLaWCiOFHOBtUlwATU/ScOLF6d4Znzmg==
X-Gm-Gg: AeBDies3ePzKmDp8/VEMb5X2Yv849nT9JOXFgRUyskIoeZMcWrTU78+nIwuIqCctEC+
	EZDfsHr9LNw0sRCd1qd8bNZlCq1FW8fZtD7E2i+yTIS2St/gcsfZfCgMaSMkGO2MOofBP9bLmxX
	Szcetq4qgGEmkq7sYZj8cOd8Q/sYYtnXFdMUPS9vnXPTRvpAL0wjkJ9cNgK5W7DKa/+4sl05kfp
	KkR1b7GJaXy/0eMtiBbLfAQpKjkcbsuuWFajArDxNSssyO78o6yEupOz21kxYXo8B5rsd0Zefxg
	aI5CnTRDxMgmeWm3bgKrs9jJkzKagrD+18C3NoZbkoE5BM85TLkJZA8mE7cJ8Z9UYm73GEmGA3Y
	UtsvwPmrcBJPdfJm7wC86YqFOkQfGI+l8fyWfyEz6SmMoaG4mTaNo878nT7pgJZTUEHEpBX7VP7
	MuD7KU0caesOVFTHWXyhPd7/23aY/utbIyVCRQexIqNIb8JaOyucqG0sDiEKv8ifhy9QcDWTccp
	yfpJIOyW138SOvYNVMWnPLUWuVVizr0kQ==
X-Received: by 2002:a05:620a:470f:b0:8d8:ed00:5a91 with SMTP id af79cd13be357-8e78c7b5bb2mr3485558485a.22.1777001145002;
        Thu, 23 Apr 2026 20:25:45 -0700 (PDT)
Received: from HQ ([2607:fea8:ea1f:9fea::4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d8edb77esm1796877985a.22.2026.04.23.20.25.44
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:25:44 -0700 (PDT)
Date: Fri, 24 Apr 2026 00:25:42 -0300
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
To: "dash@vger.kernel.org" <dash@vger.kernel.org>
Subject: Re: stty -echo doesn't work?
Message-ID: <aeritsy5VkLSE6H_@HQ>
Mail-Followup-To: "dash@vger.kernel.org" <dash@vger.kernel.org>
References: <aemGV--9_pn_ABU2@HQ>
 <b7d62511-4a17-427e-ab7b-468f9896e6de@gigawatt.nl>
 <aeqQ-ExEzduLIW3W@HQ>
 <aa17c927-f25e-4556-88df-df9cb0aba199@case.edu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa17c927-f25e-4556-88df-df9cb0aba199@case.edu>

> The `cat' behavior is consistent with how POSIX describes `stty echo':
> 
> echo (-echo)
>     Echo back (do not echo back) every character typed. This shall have the
> effect of setting (not setting) ECHO in the termios c_lflag field, as
> defined in XBD 11. General Terminal Interface.
> 
> So the `echo' suboption only controls echoing of input. If dash, when
> using libedit and with editing enabled (e.g., `set -o emacs'), restores
> echo when reading the command line, it would appear that libedit is
> forcing a known set of tty flags.

Thank you; this is the sort of stuff I meant when I said I felt like I
needed to do more research, but you've done it for me.

> > now that is what I _expected_ to happen, but that is based on bash's
> > behaviour, which is based on readline (what bash uses (I think?)).
> 
> It does.
> 

Thank you for confirming :)

> Do you think that the editing library should honor the user's tty settings
> modified using `stty', use its own internal `sane' settings to provide
> consistent behavior, or use internal settings separate from the ones set
> using `stty' but provide a shell builtin that allows users to modify those
> internal settings (e.g., tcsh's `setty')?
> 
> All of these are reasonable choices that different shells have made.
> Readline, obviously, uses the first option.
> 
The only one of these that I really object to is the second (which is
what libedit does), because it is the one (in my opinion) that is most
suprising for the user. The first is maybe the simplest/cleanest (least
suprise), again, in my opinion.

As you said, though, these are all reasonable choices, so this is
decidedly not a bug in dash (or, rather, libedit), but just behaviour I
was not expecting.

> > Well now I feel like I might need to do
> > some more research. Maybe this is a situation where bash does something
> > weird but we're all used to it.
> 
> I would argue otherwise, of course.

I really should have emphasized the _maybe_ in that comment. I really
just didn't want to seem completely ignorant for expecting dash to
behave the same as bash in the case that it (bash) was actually doing
the wrong (but maybe more appealing) thing.
-- 
S.
