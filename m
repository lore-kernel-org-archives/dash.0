Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020731E850
	for <dash@vger.kernel.org>; Wed, 15 Apr 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241118; cv=pass; b=lqqIUB8CWrA8RtJAmaalfmWCKkzQU4rvfSeIA5B5AgJrzmP/Vrw6rUQ87Bdq5pzkTtYaAtPZqUT1zNLQ7d9ZEPzJmaFiQBJ5bCEUMv4yYW4loLLy2pRlcvq11rF3Tppq7TyEUlbeQqwmVPEi1F3byvSRtbm814fHwqnvN2xvitU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241118; c=relaxed/simple;
	bh=yR+yx+GtLKh3RoaC2tYTqPNcgXVoml8DfkVJOuJpJkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhtoqLO7dHeKL7CSZkSKZjJgjjJIwk+OezrUdRy2uHEng/duRp29DLGXpKDaAOnsS2Y/jLwQEvJKXZD9MQ9dowNBjJX1IztrUaK+EyNCFf1wWj2C87xdNPKV3gGbT2QTH4UV04sI8FMQNJDz596XI08QeqtRw2wtu8Qr2LtHffM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oah15yeP; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oah15yeP"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-386c441ba1dso3025511fa.2
        for <dash@vger.kernel.org>; Wed, 15 Apr 2026 01:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776241115; cv=none;
        d=google.com; s=arc-20240605;
        b=jkfOw8v7/TuzGVOC0BQxqDsOclWmCMNzyQATD6maIyk1UFKM9BBLdbEbVebLpveLdf
         JaNFplCsKx+n7l0DkwRmCTr5SEDdJ+vgTw5n1a97qk1KuQqlywZGZJADqEwORrHvI16Q
         DQuiej5QMDHId02KhVT7o8SFTCplg4wNILg9TAK6SCVkcLYE/NuG70U3KdGIUPMiIysj
         D0H1kWUHI09eTTN6tb+0VMl5ZpAeUEYxis2dKmumOFv++0A7c4JdpbQm9bBeNR/Mu+wo
         yqa8TqzhiZYmiqV69faq9aWp1Sa9E9eXKN1zNyI9vkXt7F4bFMp7aHoQYEVztvnWm+8B
         6iMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T4PmrK1W3V4dawSdpOb1tKE+pZRssdIduFFyQHEG4p8=;
        fh=sZxCTSZ2cOfjEu+VVRhtHcYA7EYpYlk/Tl6KLIOn7f0=;
        b=bu+ACVR/ASoXOBUWLIYiyy57DjWZ7OuyOoirbDZXHiJ0wvEy8tcf07HT7H26pCv96e
         Z5XPDo39fZU39wtIV+5e4nvwcs7wwD3DbMGeGrfXGdB4w37IRaWYQJCBPfuKj+7tVJ7X
         tVLoUP4lojrSjuAus15G/HLEJ6IS0qxPBMrTrVQ6PLrjq4l5ocOvZ35GR6JqGogEO+Qe
         Hzyr/MTSze+AsdCx0S+BL5f41CwpQcCr7H4wUu4BOUAWYDsIICLCjswtzigAnTevroGZ
         EXhI3GAxchDOdaNtfspBi9mOaKBFFDpoEIu4WHL/NyadXr1Es4qy3FD/geXTQLfLvwY9
         RKUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241115; x=1776845915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4PmrK1W3V4dawSdpOb1tKE+pZRssdIduFFyQHEG4p8=;
        b=oah15yePj44UP710+Mpn4bANswWaqZthqIzFoV+bvRSAuBlQqwDAW860OFLKVrXNVp
         aiSGkEBhBpfgtSE6NwBXTVrvSJiP6K6IoYnyn1TbLtkccBGydvSIA5xo+5tirAuNcFGa
         oeCjM3P21tdSTkhbsZj1DInq+V5nyYrbnXYVnF51NePwKlEWmxXky9f8KdnoLICiM0jc
         XAU4DzB0ECzqOhtlSfq0bW1IYJJQnwiVKfLWvCOFJRBUb57+C/9d1bZzAew68yndYO64
         /tqXM0jzKgcqzg8OQDf5CzLTqHVCIx2CTTgCzHH1K/msiH9Vjj+DF69YCeGkpxqjL0pZ
         XxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241115; x=1776845915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T4PmrK1W3V4dawSdpOb1tKE+pZRssdIduFFyQHEG4p8=;
        b=GwFrJeKxxiDUUhUdUPOXEllNNkhdR5lJ8hPDO1q3LWRLY4mJwvIF4s3YtQclH7ZhIH
         Zgcv6X0UNa8SW1gJhkny3OScddoazDrz7vqp6puvM6BnGdxne5pCRzyxygCCSvbphcQx
         yd1FemAvXmGeJqs6s/0i8CNIJUCocaL2U1SjSTyZijcivjsXQkbxVYPVUVSfEAW/ieo/
         9Gwsza+XKYRcNsyoMObZ3CXU3l+ybDrGZiaNBTji4+Bp4b2VQCgMIfiDAaiiPG0ozTXq
         c+g2RKjZ3QJUtEf1kT6+6iivBiIFPoDfACsjjH+7m48p4yR5+TMO7QuW7ELJEgLZBG3P
         d22Q==
X-Gm-Message-State: AOJu0YyqBDLPsqXwLwhotb4+J4MX+G+ZbU++hEwORPceSq/7yniFz3bE
	SgtfL1sGL2HqI7mAAX0l0wsUnBftRNorvAOwh09GQZMJrzclty00RuoCf1tN5PEytDUtMly4Cr+
	bBJZio91vKUmx3F4o4vxAXkEp+8l2ro8TSOoUm2ZTAg==
X-Gm-Gg: AeBDietE8q9YNKr0hdcDCNFYq8qXFQOPufLWSGYPSm8qrjpEDA+So6tIwHCm+EsSa+H
	fegZdcw/w+ZnlydGHHnMA0qLo8mmHfrD7OCQK4//AkX8vJG1RZwE8zkB4k/29LyEt3SeQgqxazZ
	bguRJJBzxUeAbWvKO3ixTGJsOhpGhEFLkFxKwg46uugStLIhrSETHCzXujHCHW6PARTf0FSkZap
	gW46R75/Wlkps+m6+8noM42AvCr3YURMdaqzpGlokFQFcnsyd0j+Rdn+1yZJQycJJ+Fn7uBDl/P
	o6KP08TxuFhGWcHExxL7yXrHQfl3o0BU2Oyi0w5bFqiTv67ItcnKnnF9yza1KvbGVy/TJvBC62p
	PSBBJTfQK8hIVF2hniCZ3ytP7EBKqqMJPnODM
X-Received: by 2002:a05:651c:1509:b0:38a:365c:8416 with SMTP id
 38308e7fff4ca-38e9d9502bfmr2228241fa.3.1776241115183; Wed, 15 Apr 2026
 01:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMfPbcbH6C6vd8Cp-sWfpZL5ih_q=2pTMcDbZ9PidQFjzc+3hg@mail.gmail.com>
 <a7604baa-02b5-4b26-8569-a27a806b50be@gigawatt.nl>
In-Reply-To: <a7604baa-02b5-4b26-8569-a27a806b50be@gigawatt.nl>
From: Samuel Marks <samuelmarks@gmail.com>
Date: Wed, 15 Apr 2026 20:18:23 +1200
X-Gm-Features: AQROBzBTgSqzXMG5aWJr7ZrU-WkZb4FPfXy7AHKEmk1sM49Sqa9_X9ExBB-_f1Y
Message-ID: <CAMfPbcapQ8ixUG2P9At+2YJp2xd6AZia4Qw8rKfahw-wXKA6-g@mail.gmail.com>
Subject: Re: WASM + dash (again!)
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the support and the feature suggestions

Now have >50 tools [curl, jq, head, less, more, top, nano, =E2=80=A6],
clipboard integration, localStorage CRUD, piping, custom functions,
and more.

Please keep the suggestions coming!

PS: Oh and I did similar for toybox
http://samuelmarks.github.io/toybox/
https://github.com/SamuelMarks/toybox/tree/wasm

Samuel Marks
https://github.com/SamuelMarks
https://linkedin.com/in/samuelmarks

On Mon, Apr 13, 2026 at 1:26=E2=80=AFPM Harald van Dijk <harald@gigawatt.nl=
> wrote:
>
> Hi,
>
> I don't know enough about WASM to comment beyond just loading it up and
> seeing that it seems to work for basic things (which is always a good
> sign) but:
>
> On 13/04/2026 00:44, Samuel Marks wrote:
> > The port successfully passes a headless Node.js adaptation of the
> > `dash` test suite.
> What test suite did you use? dash does not have one. As some basic shell
> constructs require forking, they do not work (as I think you expect),
> and I would have expected these to be covered by any test suite.
>
>    # echo 1 &
>    ./this.program: 0: Cannot fork
>    # echo hello | cat
>    ./this.program: 0: Cannot fork
>
> It is totally fine to say you are not looking to fix this, I'm just
> wondering if your test suite gave you some indication of what other
> constructs may not work either.
>
> Cheers,
> Harald van Dijk
