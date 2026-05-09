Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A68003D
	for <dash@vger.kernel.org>; Sat,  9 May 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350840; cv=none; b=uX61MAzU4LYWXaqOn+WelXVZ5T1NTf0RfOqyZYnnqsDtEY7f4Jqh7TPkkrUZERFCFM6vLZ1YUptC4Y0ba+R22CurW0toxWgaqLWWxJziXQwffNXcxI7zF0QbsqUyVJpkxXohqGZV+3ipJKpv+ly4eJWYUzutu+MflRYqRxTnISw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350840; c=relaxed/simple;
	bh=wPuACwiqVEkMBx9EDMcpKvnAZPhOhLXKkVYRWdAyWFE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLtnh42tfYhs90BL079XdM9KdLBU+6zVUYD0xdvx18z+Zxb6yNsQFOMXKwM576kNmM9b3YyKSMGJTTonOSw8Sn0uQI6scLkNsZpmcUMB7pS934SLyFlz9WFpJ1ZNNugdHEQF2jPFXp+8HfSh46i8XC134onG9v0fleUksYWr84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqZc2b6J; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqZc2b6J"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b4000e51fdso31444156d6.1
        for <dash@vger.kernel.org>; Sat, 09 May 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778350838; x=1778955638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsrdNwgZXYAEpbGRYjnPk6H/FcWsN6SZN5LuJol7trU=;
        b=QqZc2b6JLBpAptyflfjd3YJGGeFKH8SU9S2ZBfJ9/hUhlARn+y2jVfm8DWmUY8xHa/
         WASiMOjuIEvi7OB3GqSiVn/TV4jXWIsjQ8oyq+vPJKgDC1Lid56AgY/EJ8JJn6RBvdfD
         Q7fY4seLi82298lzRJ7S68+9DAYpdgsHj+ByKydjen0Tuu1KBEpZo4dUgcGhKYXiUUOn
         HGI/djb6kx1cWPxWPjWikmq80K80qWJ6/91rbmgqshAPij9jiLIZIqVJm4nBjVKW3LJR
         OVnNj6cpVA0sbvyY/YMl6as+fr6/4YEv4x1YtBjI3qC2HLmpp/6iNbFbGb7oRw+ttZKz
         l3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778350838; x=1778955638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsrdNwgZXYAEpbGRYjnPk6H/FcWsN6SZN5LuJol7trU=;
        b=gMDG1sGemJlgszDK6f+2e3Wq2uxqhFBc0DlNlRkTa0CNLcyGHKIZU7GV4o7Lhbt0ao
         ilbmXPt8xS3/8E8OZVqxlLEKskv/1EeYUmaBlgxo4hGyLHwM6vrwx5vRVxNgG7KvC4yV
         prUWb7204tB/ekVmT92ffypnir2nZCfDmFe80Q+N47XOM9Cq2kEckIPlPV+vgkw/L7d8
         7foVGPDLuqL1lmjFbZli3e1DhGBx1zqzVtjvz1W+4EVhGOm+Ky0iWnQUCYpPJGETw1/R
         reGDWle+3dVrfiuvWV8vvfe+hL8lFefq5ScdtstfraSkt8M3LKLbN/Bzk2d21WUhBQbo
         SAqw==
X-Gm-Message-State: AOJu0YyJv4kegpoVUBwQPj8/sgUMDF5TGO2lnZQDdylhOqxenntkUM9R
	WSBYNfFKl9qJIlMsJjF22UdTqAQiKk9+TMt4WD3XuquTOABQ2QyURECVRsHtGg==
X-Gm-Gg: Acq92OEeSD+WC4iAIvsR6g+wr7KdB53B9btRKZ4cZXDrGlznTWvgM5X7HNznKISsvMZ
	gBV+Wpgt4GDvOH3srCD5XeAbAgGQpeO4OsQzR841anCJ69utY+HlzQ+oB5oNhwSUKjH8Dzka3oZ
	jUqtv31UyBgFL3n66ilZGI7mOy0yZKuYVaFjS9K0cErhZw+S7gMk8HOh8Y/3qRbBzhROaOovMvf
	ywHWM3hZciP1ujGumyUE34yTHovpAXVQinHWbyG8it9XaS22V/+zGtyMOpMfFsuavptxWrVS1Cq
	M8+0ILuCtG+2efm9Igx4rNYsvar783bhtgB/hFce5avwNJIReSFZMzLv6cRfD0Bq4R1b+HP11vx
	9P7sXafnWf2onTNCUJiouItNoOv7pq85yW78SZXur5r25Tdk6yu4pawUaTH47UonC4maeWLG8jM
	DTclJknt9IgpZSp73IoJJ029lgpQz9D0AIT8njfyhaTUkng5DNQSb3cjl5UY72q26hHEccO1Kzm
	PWOnuQBzek6FtLzdJPG/mcgVZJDNNBRXuR6dVpn/TegFA==
X-Received: by 2002:a05:6214:1c09:b0:8ac:b4d5:50db with SMTP id 6a1803df08f44-8c1af2f057fmr51399846d6.28.1778350837989;
        Sat, 09 May 2026 11:20:37 -0700 (PDT)
Received: from HQ ([2607:fea8:ea1f:9fea:8a14:df76:3915:ffe1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3aed2920sm50064406d6.7.2026.05.09.11.20.37
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:20:37 -0700 (PDT)
Date: Sat, 9 May 2026 15:20:35 -0300
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Subject: Re: [PATCH] Use proper grave accent character
Message-ID: <af9681mqftmoCPdK@HQ>
Mail-Followup-To: dash@vger.kernel.org
References: <20260418185528.29367-1-sebastien.peterson.boudreau@gmail.com>
 <af6hpLV8IFrTd3G6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af6hpLV8IFrTd3G6@gondor.apana.org.au>

> Sorry could you please explain why this makes any difference because
> they look identical to my untrained eye.

No worries! In the troff(7)* language, the character ` becomes a left
quotation on typesetters supporting it, and ' becomes a right quotation.

IOW, if your terminal supports unicode (along with a few other variables),

	`command`

in the input code can end up being displayed as

	‘command‘

which is not the input the shell expects!
The way to typeset the ` character is with either the \` escape sequence
or the \(ga character -- both should be portable across different
*roff's according to groff_char(7), so I opted for the latter.

Hope this clarifies :)
---
* manual page might be groff(7) on your system.
-- 
S.
