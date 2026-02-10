Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198B35A93E
	for <dash@vger.kernel.org>; Tue, 10 Feb 2026 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719051; cv=none; b=TKnfOH1+EGRphB0GZxmvUZT5NVpCb2PaZvSudrNVZdarFGJHt/XW0q2gS091He2ahoxVO4ADZb72t3ywhLl0Pv1ZuXEF2PoNLfs91lUxEFFJ6+FmOkIobljSaYSEhGgTVwwyf49HR+/XcxYHt6J4Kv4F4USI0U67L/hqzkqu/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719051; c=relaxed/simple;
	bh=9cEEZPGR9Cxc5LOFcFV1I2+i2Ug0nifjDEsgrXyyU8E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr3Zs0cXCbhW9V611uRbN+lRWdniMH7DCDg5XyVJhKNsI8Z9h29sgWTWub08M4dPxR/+jSrK6+hef5RAFfMtQJ80a4eSdHH+MHE3iWjK4TV+bneGVGI9xwddSFsNslpOWXpNsBK1ZUTILgZw0JUZGX/ugCT88fI5YgA8EZkPbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy0XVINR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy0XVINR"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso41931575e9.1
        for <dash@vger.kernel.org>; Tue, 10 Feb 2026 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770719045; x=1771323845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2qJuffcXPkCH1zhJoHmpMfo5vJmsSqo1Cy0gn7oaGVQ=;
        b=hy0XVINRk124kAYHDvaWb18I0d/qmaY9LjofzuQwm5+2hX22pFwD24h4cOyoQH4fz5
         UsQwKzbEgZaJkDyvmL0n977chkSjJTK6svYA314YAyAHcbTeS2pWJo7rsQIwiQ1i9i9T
         +CuiN2rafJr0bzTy/FTr/DQ0ZWzS4IOwnPOn/AC9vk3clVQ4a3q71xEIliMG9W61LDVW
         DbogEny8eg1oGQYSXerpfji6RvXTJ1uwB0NMcJJiia9kftOzl5JAvFtSdXLrOuvR2hfY
         H1wfhX4SnEj2cdo0opgYlQtPaScHAfaNs2acWMDXVowmbDinGasL1qlKPVXUdJji9uO4
         hIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770719045; x=1771323845;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qJuffcXPkCH1zhJoHmpMfo5vJmsSqo1Cy0gn7oaGVQ=;
        b=fT3JgbiA2EMYrzn0NM3zLrDIUgN3Bfi4JzZFDjmrEi9viNpa83PrE0d1gmVEYRWGn5
         PkxHRndwblh4cz1U816vwy9xMaQ3AUOmnGVocFRi7xr7GkubEqH7O4d9Dp47/LoaUH+L
         Svz6nkNPfzpW9AyxOuQ7g2W7HQJCuhk7KHRMdKdjoVfeM4gSn3Po3mtH9cvnqqkr1U8X
         rwELYkqe0zbQDlNYjb8VcwUmcYt2dJMVVsOT4Om8oUzXusLQ4s3kiZ8jJ57wI40bHOiX
         J9PMzBcbsNAEVy2JJb6ngnNJn1BDeUi3bO1C5e6119jwc8UO8OwZsoivgebDeN6xY4S9
         Q4zw==
X-Gm-Message-State: AOJu0YwVUJ/3DaGFL+qZitnn4w6nXEsiCgwkuldjF5PSjlCtIP0xq7tp
	T5WwGbvgtAg2eSOKCkpUIAyR4zfb+yHR+s+cC4deU6heqsdPKFtbe+uQHBUkKUyUjw==
X-Gm-Gg: AZuq6aL6IZ1/RYvOcJIw+hZVCzFnxjCY+RHUEqkE/WVobHjee9pz815pZqPpRRCe695
	SUrf5o3l3587J2YVD4xK8lB+6QkbzGi3vCnLdsCAu6uS6X2AJTuKliZJvAQ4Rfzdhlml6xhyo3l
	Rd/WomKJZYfhALCNNf50NaIeDShlgmzvAXJlb9uyswEjQgTXTtST4us7yoBm3nmQO8C6MS8ox9H
	QkzzohVzzjlrIGWF5VkKfjKLdBIdoAMZwN4xfhbvOt3A3/PFT4qOB/sR2h+4Fu9HJUfZfx5Z8xI
	nR4z+H0cFiuk/pROHP2obmMsgDWSB3lh7ZBJPPKEDMzaCzjVUgTB1aOT2GGfOntBuclpgxm3ZL8
	HzfsuZedZ+6VKJ19fauuxN3fopEntv3bzqS4eFGGX9rvU4sLpV1t0wZ+8VkgjDhITGcJh+a+By/
	hMkVu5SRx+dCVwP6XpFEQ9
X-Received: by 2002:a05:600c:a416:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-483255d164emr177320035e9.5.1770719044952;
        Tue, 10 Feb 2026 02:24:04 -0800 (PST)
Received: from teapot ([78.143.211.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d8f2csm74969075e9.1.2026.02.10.02.24.04
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 02:24:04 -0800 (PST)
Date: Tue, 10 Feb 2026 10:24:04 +0000
From: Earnestly <zibeon@gmail.com>
To: dash@vger.kernel.org
Subject: Re: Surprising behaviour when reading from a named pipe and standard
 input
Message-ID: <aYsHRFz5kAWkcLSb@teapot>
Mail-Followup-To: Earnestly <zibeon@gmail.com>, dash@vger.kernel.org
References: <aYqFr-Twb-njdsDh@teapot>
 <f13da815-0438-44be-b224-a6f5c5ee4454@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f13da815-0438-44be-b224-a6f5c5ee4454@gigawatt.nl>

On Tue, Feb 10, 2026 at 02:00:18AM +0000, Harald van Dijk wrote:
> In bash, <&0 suppresses the implicit </dev/null, meaning the outer
> environment's stdin gets used.

I hoped that dash would do the same, when faced with an explicit use
of <&0, which I try to base on my reading of the standard:

> If, and only if, job control is disabled, the standard input for the
> subshell in which an asynchronous AND-OR list is executed shall
> initially be assigned to an open file description that behaves as if
> /dev/null had been opened for reading only. This initial assignment
> shall be overridden by any explicit redirection of standard input
> within the AND-OR list.

    With emphasis on the last sentence.

You write that dash does ultimately interpret this correctly but applies
it too late, after fd 0 is already /dev/null.

Perhaps because this is not merely a no-op (as 0<&0 is) and that dash does
attempt to do the right thing (too late), it suggests maybe dash should
change behaviour.

However you're right about portable shell scripts. I have to accept the
minimal interpretation and your solution is very reasonable, perhaps even
more explicit as well.

Many thanks for your explanation.
