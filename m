Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7A1C0DD2
	for <dash@vger.kernel.org>; Fri, 29 Mar 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724511; cv=none; b=YYK/oQRALg3iHAHaiVsw7/Y6PqYL50r7XVbtooN4FzQsA3URAJj8LigJ0fuAye3myuKraj+7k8PG4DR/p8SsKgXACmI1K0ZJtLA+ZI0L3FO119vFDe5lMG27vpfteSa6Gk2fokCR8OxAI334vYycZjkNK/mMxLJN9bp/SQZvp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724511; c=relaxed/simple;
	bh=R1+yWziHaf44ZBtSfpYTRf4IeZ5QjA35rdHv6FZMx1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/r/Z1kVrJ7QJJsaCLqt4ED1K8uQfob3Ji+L7/1ZDb/NHh1+9spUZV9yEPIpi2phSV+CBm1yOkTYLV8iljjQD7+GAMaqXeaXG9gv+ByeAfpicBAHcOt0Dr1fCWJP6E9O5077d23dmcqr/5ucXZDYT8D/sQ+BzQ06MX1dYn1A3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcvvNCxC; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcvvNCxC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso2622686a12.1
        for <dash@vger.kernel.org>; Fri, 29 Mar 2024 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724506; x=1712329306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2s5tOLVKPkXlwrA/EgZHuM0Fbi+4tW7rVTv5JBu8KsM=;
        b=NcvvNCxCvKwT9Dki6qyklH36T+CtTsvmPGX2+4Z+2Y/n4LLgB4LFtiugORXHNP/Ghc
         ULjDSNWV2WF+0Da64vYjk2PiKPcDdL7d9Zk9xFEYUCkUUED4NuO6TlsBuW7AlyQtMuqo
         MayfKr6WQy2MU06Y3fQyMhIOBNh+VOmaOoNRRuV5t6LuPAQDxT3R4End+RXhWMOCy/V1
         IRTaDcoo57f646T2u7z9j7tenOyMxYH47kQ2967MicctZGR4RPnHtfjI/rki+1lAtwgU
         Wz6qrDZE4Po/bmD48cjVUmTtzYy79sXFveX5/9UdADUY9/qfv2R/aWxPo3qCcN4e1G3z
         rmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724506; x=1712329306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s5tOLVKPkXlwrA/EgZHuM0Fbi+4tW7rVTv5JBu8KsM=;
        b=AlXHQXuJz4S78UgXbkxyBU2Dj6RAzvG0YLS2t1oDs+8R0KioE77aRKmtmwlLH/Zv9w
         vP3ZO92Q2YLd+vqToc1SDHqI8RkGNmmxyDIXXZ7FkE3T5qOPQufzuFkLN/Sktd0VDh1p
         1F5foImCBh7akEesqPxIGbzCSbRlEYPE6joBjOWveSDU5h52OCeqUU5qjPREtptr/2PL
         h1zuzz8Zk8rsjr19md61A90WEFI+Ncx3IMTiMejd3F3lf7yuJPq3wEq4TAVH9aj59K5K
         XcGSQFsGDZusw/+tDTSp4WIRvFrtf1nwm8ygmNHPDmCVsi3W1eZV7+m1fUDSTAGiG/xj
         qxmg==
X-Forwarded-Encrypted: i=1; AJvYcCXTMrQ/NZ+NsImxh1yuFnPD20jvGRoe2jVJlr2bTVE2TKrOCfIz9mrBm0hP0b71sMWyuCFIB0klvr7fvIBKC71h04Ew1A==
X-Gm-Message-State: AOJu0Yz/f6ylAr6UTT1uo/ocBUaEUTtqbMmkJprflP/U7HoJSbUwN0co
	z+x9GGdfjgIzfZNI3jyN3WFmDG0IMxUtLh4QYuRWNIHKOOzcC+h3
X-Google-Smtp-Source: AGHT+IEdidMVZJ7A+lI0JEfowhu3I9RYnPuDTk0b6V2PYLfsOqUbh94VFiBr+fd/NghPTE+QwvducA==
X-Received: by 2002:a50:d4cb:0:b0:56b:d158:c5de with SMTP id e11-20020a50d4cb000000b0056bd158c5demr1440226edj.16.1711724506313;
        Fri, 29 Mar 2024 08:01:46 -0700 (PDT)
Received: from gmail.com (193-81-214-13.adsl.highway.telekom.at. [193.81.214.13])
        by smtp.gmail.com with ESMTPSA id g5-20020a056402428500b0056c3013485csm2088549edc.69.2024.03.29.08.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:01:45 -0700 (PDT)
Date: Fri, 29 Mar 2024 16:02:26 +0100
From: Johannes Altmanninger <aclopte@gmail.com>
To: Jilles Tjoelker <jilles@stack.nl>
Cc: harald@gigawatt.nl, dash@vger.kernel.org
Subject: Re: [PATCH v2] Allow trap to un-ignore SIGINT in asynchronous
 subshells
Message-ID: <ZgbYAvgixaQEsF4K@gmail.com>
References: <b42dbf13-989d-4609-bbcb-8b9eababbe65@gigawatt.nl>
 <20240329112419.1571653-1-aclopte@gmail.com>
 <20240329135039.GA20398@stack.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329135039.GA20398@stack.nl>

On Fri, Mar 29, 2024 at 02:50:39PM +0100, Jilles Tjoelker wrote:
> On Fri, Mar 29, 2024 at 12:24:00PM +0100, Johannes Altmanninger wrote:
> > [*]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
> > [**]: https://lists.gnu.org/archive/html/bug-bash/2023-01/msg00050.html
> 
> There is definitely a good reason for S_HARD_IGN: it implements the
> following requirement of the trap builtin (XCU 2.14 Special Built-In
> Utilities -> trap):
> 
> ] Signals that were ignored on entry to a non-interactive shell cannot
> ] be trapped or reset, although no error need be reported when
> ] attempting to do so.

The wording in [*] is extremely confusing.  To me, "If job control
is disabled (see the description of set -m) when the shell executes
an asynchronous list, the commands in the list shall inherit from
the shell a signal action of ignored (SIG_IGN) for the SIGINT and
SIGQUIT signals." sounds like those signals are ignored on entry,
so it sounds like "cannot be trapped or reset" applies.

I guess we are dealing with two different sets of inherited signal
handlers, the specific SIGINT/SIGQUIT for asynchronous subshells,
and the others that were inherited normally.

> ] An interactive shell may reset or catch signals ] ignored on entry.
> 
> The change that should be made is that the automatic ignore of SIGINT
> and SIGQUIT in background subshells should not use hard ignore.
> Hard ignore still applies if the shell inherits ignored signals
> from its parent.

Oh, I had thought, ignoresig(SIGINT) and ignoresig(SIGQUIT) on
background subshell entry were our only uses of S_HARD_IGN.
So this means that this logic from setsignal()

	if (act.sa_handler == SIG_IGN) {
		if (mflag && (signo == SIGTSTP ||
		     signo == SIGTTIN || signo == SIGTTOU)) {
			tsig = S_IGN;	/* don't hard ignore these */
		} else
			tsig = S_HARD_IGN;
	}

interprets all inherited-as-ignored signals as being hard-ignored,
but that doesn't include SIGINT/SIGQUIT because they were inherited
in a different way, via ignoresig()

Will fix.
