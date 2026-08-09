Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648A4B0493
	for <dash@vger.kernel.org>; Sun,  9 Aug 2026 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786304980; cv=pass; b=inJvswlRaDgwHV8dsMnI0tgHLMXB1V6Xz5pO/jk9EpKR+/F04O8RFD1f/P2Jvr3ntN7IFInZk9zI/QU6SWUiSIl8SD9hxp8npG67x5RJ3XkRsUfn0JNOPSRD9wxA0kcAilkdupF8Z2tYFe/Rb2+5kCvnXWTYKHSZUZhiUR98W6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786304980; c=relaxed/simple;
	bh=MzOKuiNb+Iqw3iniYHB31LSJ4qVlnTYICZ9dAjlkQDk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BS4dDgcEvo5pU8+rikaoKbr+AG4xAPaRv2/gp4b5hv4/eHr8VKCxsib2JxLTqGS6EVevQK+H6dnhgxTOPdRSHZ5mjsEhVY6kxUi+w7LbcWpOrZ18dYZyzQ+pqAa1Y5w69nH/KaAl+/WPYC+m2ctwzILn5Y3z6CjNCFJzOQJWoHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIU9SXhd; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIU9SXhd"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso801229a12.0
        for <dash@vger.kernel.org>; Sun, 09 Aug 2026 12:49:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786304979; cv=none;
        d=google.com; s=arc-20260327;
        b=gtGzntC3Ys8ct3bNt3Dx13pAWOJCLRQeZe2yNXIGHyutO1IcSt2wLO8xqzJL1SIsna
         etMaTDpV5qejL2N5dpowh6Ri8gyKjgHL3FcDSpa27E0A5MNOJ2OLTVTSsoL3FU6ey8VL
         rbNronIm2A3vWGoT2SMrft9QnUn7YpiLGRuQXO6bU1WJiQ75PRlFDJcw5x7GxofwZ+1s
         vbFHz3J+dXtbQMpshlae5ydy3JDrbIQZZ2azdiZAhd7XdyjpyMGshki5zXEuHwRJ7W98
         N95ItwqfethQFF1RIbLGDOrsKveGkxcQAMLOwBHplqApSB70QwvauMMdC5BAMk6fu2by
         dPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MzOKuiNb+Iqw3iniYHB31LSJ4qVlnTYICZ9dAjlkQDk=;
        fh=IQlwNzxyN571D6yOtzBJlpdgqqQzXYli08Mb2hM/RcM=;
        b=jhWZVuqtZ+oaVl0zagy4ooa2oxlxP60mxu6iGeBHYcGww8dt60UBA7vdiXjJVjabqq
         1boAII9EGmH75KepPrjxqo6QipLQkAx7WlCuR+RKh3cwXcvDU9NM3ohe1PZDClmQ9ETw
         lc2QxZUMpNlRHV1O4KZV9PRwED6AYu2ICZqQHwab1f5QKm43RA9fvKaNJuFFBlvIGClq
         4lZ2OxV8tZkX9iXdz0/Hl9srqftWyN61SHCAMVdFTb2YMJDgLzsSO/HxvBhWktnworOK
         LP3428+do2uV/gGL2kXn8BPYxFryiu0MTZtS8kNCW8wySiREwVj8rBPaMsCOiSMDZDdU
         e8vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786304979; x=1786909779; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MzOKuiNb+Iqw3iniYHB31LSJ4qVlnTYICZ9dAjlkQDk=;
        b=kIU9SXhdSGUuoP1vUPSDnq/7a+clGLiAn7QQYWukub4JbpZ9jrleAgaMqPlKiNX/Ej
         qdfbG///REzrCNZ2uWMIm9nbXrcAsnKFe7b1ArU01s2P361Skmvm3ghuhlqnIXsjOH3P
         +d+A3vWIxcEqXa4VzPwhqaYtItAe7tKXCNLaz8boStK08wjTPO9q0GxPa4oXNBrGYATk
         KdSd7YcZVWec5E4RQfqbTk3+WvT4skZuquBcyVg6rUlGUOkNNabC9I4ec+4EsWTVDqnz
         0auJH2SiPl9kAQeVy6Sb6psNrd0Mn426CdI6XHFoHt7qFzhQz/BnOMRLvp92c+kQD4OT
         8aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786304979; x=1786909779;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MzOKuiNb+Iqw3iniYHB31LSJ4qVlnTYICZ9dAjlkQDk=;
        b=OmkJK76nHL5dYcro8L6f/IzieZtKEfAL3SgF2X6r4RcsvjEghIZgFZOZZJtq6DNCmd
         169GMVBH1itTpfxPJnqlbuneQ+xgC9qwm5ap3tPyhsoPtO/l0nLrTrAWxJCPL3rBJAzZ
         vlEdqh+DDCSNaJ4/E+VslXeL2r24YQ86vlrcdlDyxbzCizgKAR01cMiKhaePg2qANDBe
         YYapJ/yLARzoGKmNE/+BXiea8WvScHW8LNHGvEQsqma+74qqP4fHlGnCAbG1hx1JJGPO
         gVNeOOixL6s4tSbD6i+BLDjJIukmUlEejZrv/Csd67iDQECQzyJUxqMVTtJbkMUeEIYT
         oPjQ==
X-Gm-Message-State: AOJu0Yy8CCkI8gNi2uxXNOkM6baXjSh7HDy+fHelSd30vEMZPVI3dz5C
	kBMNQ4JM6DwQqwKqpfMODMpU/tuuZbastxt1ObsxdvScHc5oTy/gGxB9bZbNzz28NqCVzChRGyc
	JzRI8iJhxfPOO56VlO+kr/95Yo1NmHwREKh6N
X-Gm-Gg: AR+sD13yTrp1o1kfzjAn8TvUY66qg/YbTgI4Rz/zviDE6JJi1U/LcGKEY0OfZnusNyk
	3c0RhA56fB2uN+lZOHN5cYrKFpW9aTCtKwq9uYG6Bz8LWTBDMdhCrYiRlHkiDNme7Q0lfZHjOBa
	TRJVEtdMR9gybBCjI/1oUUZspqAc1Ou34ie8nzPO1opA1gFQSUGlVcO3mVSDKHuQUPO1G8j3LSD
	sLpyuqrRnlNyjkaCdBeXGN5B09Z0SFFxZIsQpQUZeVSqs2PFjI/D6lyZ1UbnVDBBJ7siByVhJFo
	fdP2oWbWKl1WcTdjVQAEHgjXkAt8i9JD+Y6R1kbriRuc
X-Received: by 2002:a05:6a21:3392:b0:3c3:9595:57ef with SMTP id
 adf61e73a8af0-3cb85ffd1cemr42870002637.31.1786304978883; Sun, 09 Aug 2026
 12:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Sun, 9 Aug 2026 14:49:01 -0500
X-Gm-Features: AUfX_mwevTLZL_EgtrL7P-PUOnZ4q5wgPaJhWiaoEmim84N5wn9uql3WIe8IXpg
Message-ID: <CALaQ_hrYRcp1_+1KPx9UXMtMb8UgRRJCRj9Y6JBCc73ogO7jmw@mail.gmail.com>
Subject: `command -p` Not Searching Path
To: mail@anselmschueler.com
Cc: DASH Mailing List <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

This might relate to, or be in a similar vain as "Why does the command
builtin not circumvent invocation of builtins?"
(https://lore.kernel.org/dash/9098f57c-66f1-40fc-a714-b73d208c81d6@anselmschueler.com/)

I had thoughts about how aliases, functions, built-ins, executables
behave in a shell, and came across
https://stackoverflow.com/a/64028240 which I thought was great.

I tested the concept in dash, and did not get the expected results
(specifically relating to `command -p`)...
Setup:
1) $ echo () { printf "%s\n" "hey function"; } //first, otherwise 1)
and 2) swapped will fail at 2)
2) $ alias echo='printf "%s\n" "hey alias"'
3) $ mv /usr/bin/echo /usr/bin/echo.bak
4) $ cp /usr/bin/ls /usr/bin/echo

Tests:
1) $ echo //from alias
2) $ \echo //from function
3) $ "echo" //from function. Just thought to test that just now
4) $ command echo //Presumably from built-in
***5) $ command -p echo //SHOULD have been from PATH, which we made to
be a copy of `ls`
6) $ which echo ///usr/bin/echo
7) $ ls -l /usr/bin/echo /usr/bin/ls //both size 166640

I don't know why 5) behaves that way for echo.
I already have `ls` as a function (for coloring), and went ahead and
added it as an alias as "echo alias", and `command -p ls` properly
used the executable in PATH (non-colored output). That was done in a
clean environment ($ exec dash) after the prior tests.
