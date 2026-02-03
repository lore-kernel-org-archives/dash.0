Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39194392C2D
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109277; cv=pass; b=vAnLPv9hV1jvFmppkt03vtXLVXcJbyzsEhYA3UuQ2i+5kmg2vYpnYVoYsLn6GRgUYK6aQZCEh371NNq1WXtmtx7oDp8jFposDKQhKW5Fi2GPxI9FpbQz2ROoT8Oe+KNXGbXu2kVvMQC6Tr9Enpv7wLF+Ed/f+x257Awj1mhKC78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109277; c=relaxed/simple;
	bh=qOPD4s0Je9JFyyeGg6Gc342Po8y6oqgeonQhSlCtFmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjbrHBWZ/px/AWBLE0+FydATkC3GgqKK3Z28upm6xXGu45EmN63esPOizxM7nw4pEc4UARKeBpNz5/Vq4oH3Jxt9oGMWv4fy0+HZdHMrnW7nAZS4THq0TUEZMpGm8tkbJhn591GrSa+mtCER7tl2YsK600gu9dx3geQspw8wiag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGXuMScx; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGXuMScx"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-794f701a3e6so1257937b3.2
        for <dash@vger.kernel.org>; Tue, 03 Feb 2026 01:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770109272; cv=none;
        d=google.com; s=arc-20240605;
        b=OeVxyXN569X5YwJQPr4qyLSZIrsaxoowayZpICcC0Y/xoxYUFSfoRMQiSFteVi2H6r
         jFy/UrIkPB1daU8JzLWyeYi5Dpv9/5GucgEV/nn+9nQpxjbPgq5Bkek6d6clWdtENQmA
         xZmePe+NjbDrb4L/bspxFzGcUMUGyo8MAu5mqgx0cFn/1eC2SquDWx4n43q3td/xQ2w2
         5OmTenaJ1ZUCv/gj6Jqxlb2CerbIl/49iaqMsC/WtKquPi/oVLUIPXUtm9IZrZRCzkNI
         HqWTbsyNY6b+LUWWp/3FsxExtfIirngH99QQr4+K6qDzlPrciNu9LjgmXksHpz3Dhxdz
         0NqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qOPD4s0Je9JFyyeGg6Gc342Po8y6oqgeonQhSlCtFmw=;
        fh=sGqz0TFHxm3bL68YbZMXWFx6aYdLh17paNNTf2lv0DQ=;
        b=UQdo1HMaHhVcSsf2Mdjvntx4RXWlbMHf8KJAeCK8RYI+/WyEjVsHwhWEd6kgnwIy7i
         m0js/4MM+5D7KCxwbjFs+1jJ7TurlH1dxdouTqsSUay7Ph4zgwtGVgg99Qe644ZSrIwf
         RzMufjAGtNN+JAN3EDS161zCgc6k7tI0gGU5BhUAFfmhTGmfIBS3k5xOTis/h8sTRMhI
         wBC0z/YY3bhDj0pA8W5ind6wPDM6hGMwsnF2IetzgjtK+4PyQeIYOWsIN/QFzamvREog
         T69D0TlcedGbYvlU4AEoqQeEktRZXlXA3YDL9o6l1WmBO7YW2j13P2Z7Y5diWWAregIX
         Qp7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770109272; x=1770714072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOPD4s0Je9JFyyeGg6Gc342Po8y6oqgeonQhSlCtFmw=;
        b=RGXuMScxtA3c2Y2Fu1+jM6rLIL5PrDVVQ8xdSe1XHg8mkOPmMmlIZ/u9zWZNqJT6BB
         2tFWWct8O77XkSc85YynTOejN/mMlTuBqWFBI7/Cp/aOac3kRCHIviOIuxg4BG5mo6v/
         7fFEKizQARhvxrqI1zBvZi6uJ6BCnzoQce7UtFSQ0iHa0C500nuWdI6jjjodtyehOdKk
         96nJZAAwU/IWr+kellaAULHTFaQmarVWK/yQMCUkDdO6/U7DnGD5UJ29DhfX5PPei462
         928FyocwD1i5PExhgxPghSHBgLWsPd+TOkKQk117WT/dBIqF4zhQplCyVn9MdyUxcE5j
         xesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109272; x=1770714072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qOPD4s0Je9JFyyeGg6Gc342Po8y6oqgeonQhSlCtFmw=;
        b=l3k5zRO0mgdtZ/i12um5l3iM1EbLsfxOZXyXU6J3CJTiYVLn354JEfefmz7htYRR7W
         A06JG4xALYGlDCNk52PDtYdHqCCg395ER5Ynp7Q0lQ6SKrx+z0S0Yc1en607V+KMK3XV
         wG9ppdeSv/4Y8MwY20MSx5gpD+zW3N3ZJ9sD/z59BPc7LAEXT/TWPUHIUlnOpMneY+DF
         eIW3Noo16sGCtxtndfIJ2LQ465s7XncqqAZ3tSAHlWp89x36CL8ZqV2RlWBSsar2V0Vx
         XUuEgc1J2F3wfl0cN3opj5EKBwHKMNapWx/qeeWglzkeMexxHUQJAoC+f5BTYqvhpj9D
         pUlw==
X-Forwarded-Encrypted: i=1; AJvYcCV7CyUHeAIxHqc1RIBX+H+Gdg9f3LWO2GoyUJ924WyWPGfav07Ql3OSXGRBJO5hP6CH4OHH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VxDUiRewt937QgWihi/LNryqsG3Ba7pKGjtewsDMy6MQX37C
	h934nJsOmNELCIXu8N2dCAH8/7jydTTafpfeFxbl7uHtON9FoR3F/0D9xhkxjl76wrcvMj1HM8m
	tH6fpyYimZ7aIMJsJy1BUIedmTZcB6qluOyhK
X-Gm-Gg: AZuq6aKsPWCCAiaH8u2msiYEkOUNA4WejTdqyTyINnZXxXbDO/E4gM5Z3EJVxIY6pgj
	pqWDcfRZrF0iGCx1gepwRNRE7ayxZjfdmbhMfakfjYVB5voYgtexv+5HxAyFy46meY5bJ5lsAMK
	L33X4PPcjTpX9a3Wroop2VVOh379g/op9JYs1UnAV7bdpEJ/bFmK6JeV+/ERM6WOqO262PMHvhJ
	S91MuS1ECUhXM+cDEMqnZkII6EuxG/1I6BKxlmAt+MXkJeAqaFSP7cGQ3LFDEUnboJDRUcI
X-Received: by 2002:a05:690c:e3cd:b0:786:68da:26d6 with SMTP id
 00721157ae682-7949de653c0mr121992297b3.2.1770109272123; Tue, 03 Feb 2026
 01:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Pine.BSM.4.64L.2601262052451.32136@herc.mirbsd.org>
In-Reply-To: <Pine.BSM.4.64L.2601262052451.32136@herc.mirbsd.org>
From: Jari Aalto <jari.aalto.fi@gmail.com>
Date: Tue, 3 Feb 2026 11:00:59 +0200
X-Gm-Features: AZwV_Qh4tpgcFEvQtiHCATQyBHju8tnK_WAP-KTYZBBbBT2FSMUz06iJkz_8Q7c
Message-ID: <CAOU7HicmTfdNgsJEZM8xE51KNg+-kkGBtf_Lh6V7XY-pM804bg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IHlvdXIgJCgj4oCmKSBidWdyZXBvcnQ=?=
To: mirabilos <mirabilos@mag-kekse.de>
Cc: Martijn Dekker <martijn@inlv.org>, Chet Ramey <chet.ramey@case.edu>, dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jan 2026 at 23:06, mirabilos <mirabilos@mag-kekse.de> wrote:
> Hi Jari,
> https://pastebin.com/4LD95GJS
> Please do not capitalise any letter in =E2=80=9Cmksh=E2=80=9D

Cc: Chet, (thanks for the similar reply)

I'll remember, thanks for pointing it out..

> The thing is: the pr=C3=A6-POSIX accent-gravis-style command substitution
> is not identical to the POSIX $(=E2=80=A6) comsub. For example, the user =
may
> not use double quotes both outside and inside, as the results differ
> between shells there (and yes, POSIX allows that, and it is good to
> do so).
>
> [...]
> So, writing =E2=80=9C`#comment`=E2=80=9D, even if it works, is actually u=
ndefined, too.

Ouch, too bad POSIX didn't define them to be exact equivalents.
From user's perspective, I wou=C3=B6d have expected the statements to
exhibit the same behavior.

pasterbin deleted

Thanks for the explanation,
Jari
