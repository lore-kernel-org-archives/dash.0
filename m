Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C9221DB1
	for <dash@vger.kernel.org>; Sun, 21 Dec 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766337768; cv=none; b=sZI23xG51eZJ2RcpgMZiThh1UEm4frjdZAc+pz8/rSRo/vTW54cLhpBiIbmDlMqPmKAI0wtrY8c6OqNdJmQU6Azh6tp3RViFf1KzU1tFoA3wsosOF/TvupxJB3MdZoWNg8iN1G6wDGcr1+ZtvHNxG/mbvZDWtVKp46fEibdjvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766337768; c=relaxed/simple;
	bh=v5L/s7WgnNBotSdvTI19wyyR4+oBLsLfByUeyrGereE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wyvwut135qybLERDKVL5Bo7ojfo7VT17zMcRzQNnyiRMOgYzXwpfqATv4uj0BWFLMS9FIoY99XHYDW6rLfYvrmgzInVUMfEummNCP4KrCTVY7H1RuCW1qv3lR7or3NPjrMBnvfTZkmtw24fibScou9iNBGO7cjT1W4DlfKTcExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lahteenmaki.net; spf=pass smtp.mailfrom=lahteenmaki.net; dkim=pass (1024-bit key) header.d=lahteenmaki.net header.i=@lahteenmaki.net header.b=BOFTFVih; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lahteenmaki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lahteenmaki.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lahteenmaki.net header.i=@lahteenmaki.net header.b="BOFTFVih"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edb6e678ddso47815361cf.2
        for <dash@vger.kernel.org>; Sun, 21 Dec 2025 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lahteenmaki.net; s=google; t=1766337765; x=1766942565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5L/s7WgnNBotSdvTI19wyyR4+oBLsLfByUeyrGereE=;
        b=BOFTFVihgovePtpUW+eXbes11djcXZMso83F6E+ZieiKPFNEJbsx75Rc+uzgUhXpp8
         Xf71nqwglExQCEcx1qjwffFbKAX0QPZW39N7tCMvfCI1CczKFJFAXy4bJ03YhyCQ9jiN
         V4NafJhUOctTmplyd/ssnhwMpHdK39l81xdiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766337765; x=1766942565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5L/s7WgnNBotSdvTI19wyyR4+oBLsLfByUeyrGereE=;
        b=RQc61atYVyTJjM+AuttZTHK1KBMXypyoNRM6pfy4Af6uCr7DzFGE60SwQK7eRe/Qcf
         BYTgJZ1Xxf2iigSDK+kOIUO8ItzZJzZGRyWBoC5HJNJVA7oq0JzRfd7s15mAtSadxmrW
         EFJKSm8/XZkWlwEs3kBhS7iftBTK/1Vy4MLis+IspySmj452/je0urPirpKmwBhNXcMl
         SLxXHZO+KrvpaDMy27X6fknlnXqM+088jd8vE+Xq+2SIEAfpKucJIdtqwlJOU+UpXswk
         S2Csw0PRtdkS+/zQkSMpf2wckGcnKeaib9n7d1OeglvfvBAk2EEY/jGRIWNOJbDAexHj
         esuA==
X-Gm-Message-State: AOJu0YyIeN8J89jloJJMSXeW9LPSY//NfHWqNB63O93XwFGkJSBSKgj9
	oa2wFedAHCOTf3jdUhlUTnSa4kYSDhgnT92bf7r4SFWVQsIU4v9cXovt9qZej5LMRjoZxRbTe/l
	Ex2b99hHDBH1INueqDXpOtuqp6td7vCCHuQLt3K9aWpMidilKHbjWc7FBwQ==
X-Gm-Gg: AY/fxX5gwrASj+E7JB+XQR7gkwE4RBo7MDpBenQP6xbB0kM/uJQuYZ/t/+gVf6Up1OY
	yAO0vj5oJjwr5d40ZkKCZrHiIcw4qEDUbaFH6UtREoAOiz1piMnQm56KpcLRgSLIpdWnoVsluFp
	1GWnH9/EdALoyAQ+AzbjGsIaIDlWRAd1VSEZANv4GFM0Qg6ftv3R+ZTi9A4kGp3Sy5WcKMW1rkC
	F7+sUzkc6FaG13htRGup6G/oO22dFmFpFFKFyYk47oubYTtJ6nwWfrIoW8KqN5EMDrI+ZSg1yZ9
	vJ1TZrA=
X-Google-Smtp-Source: AGHT+IGFjIc9MULBZp8LgDw7NElA2vLjqtrbDAP6UwcEjFAFjLOwk1uEnKGv1KkqNxG+lVgVlHY6J5n8ipBPUZsPXhk=
X-Received: by 2002:a05:622a:5a07:b0:4f1:bd73:ac6f with SMTP id
 d75a77b69052e-4f4abdb8cc8mr144138541cf.74.1766337765553; Sun, 21 Dec 2025
 09:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANhYXO9FwbqvSJba8B6p+dzL4AoeA5O85kRxXdzWRe19hMwVtQ@mail.gmail.com>
 <a5a6026d689dbb91b5ede440416ee5f0@posteo.de>
In-Reply-To: <a5a6026d689dbb91b5ede440416ee5f0@posteo.de>
From: =?UTF-8?B?SnlyaS1NYXR0aSBMw6RodGVlbm3DpGtp?= <jyri-matti@lahteenmaki.net>
Date: Sun, 21 Dec 2025 19:22:09 +0200
X-Gm-Features: AQt7F2qk3FBWuOtsIIm7SlG-CZuo3zuX8PM_QNXzW4UmyzoTk4zUWwcj91W4HNQ
Message-ID: <CANhYXO-cYjVynP8TZ6rGJRb375TQASpdQ-Ev1271xOA3T2o4EA@mail.gmail.com>
Subject: Re: Behavior change in Dash pipes/read?
To: j.daubert@posteo.de
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for a quick answer!
Unfortunately those patches don't seem to make a difference, although
I may have failed to apply them correctly since I don't really have
any experience in patching or building C-things.

It seems that my test case still works in commit
6574d63a1163d8f97e2e9588bee80e0067080924 (hello is printed) but fails
in 1713d1d6592f09f23b5abfb4562cbe5a7615fb1a (hello disappears).
Does this ring any bells?

The test-case is just an unrealistic test-case, of course, but it does
seem to mimic my actual script failure.
I'm not able to test commit 657... for my scripts, since it just segfaults.

-- Jyri-Matti L=C3=A4hteenm=C3=A4ki

la 20.12.2025 klo 19.35 j.daubert@posteo.de kirjoitti:
>
> Hello,
>
> use these additional patches, published after the 0.5.13.1 release:
>
> https://marc.info/?l=3Ddash&m=3D175976339511457
> https://marc.info/?l=3Ddash&m=3D176121885702468
> https://marc.info/?l=3Ddash&m=3D176188900609643
>
> Greetings
> Juergen
>
> Am 20.12.2025 17:41 schrieb Jyri-Matti L=C3=A4hteenm=C3=A4ki:
> > Hi,
> >
> > after upgrading from Dash 0.5.12 to 0.5.13.1 some of my scripts
> > stopped working. Here's a test case:
> >
> > $ /nix/store/wy9ass74g4yc1x354ydbdlxkfkxxjv2x-dash-0.5.13.1/bin/dash
> > -c 'echo hello | { read -r x; echo "$x"; }'
> > $ /nix/store/4kjsgkcxqfadycyspzfrf9gg5n5bpc27-dash-0.5.12/bin/dash -c
> > 'echo hello | { read -r x; echo "$x"; }' hello
> >
> > (with 0.5.12 "hello" is printed, but with 0.5.13.1 it's not)
> >
> > Can someone confirm?
> > Thank you!
