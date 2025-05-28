Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECB20E6E4
	for <dash@vger.kernel.org>; Wed, 28 May 2025 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461708; cv=none; b=A3J+SM8BNtuBMUIptOcbHtqwI06wiXefUlVtr2iEjxkGPQmdAG4UfylqQOpJuBriefywxGxo7NqosXkBzASztR8fZEyat5ba/nswfM7ZMrCxraudkyIbXTHLmhudiuHaL9f0tnV3KTX4LZUbjsFjqqIjniF8NDgmpHGXGrdD8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461708; c=relaxed/simple;
	bh=d1ZKyPN3C72BC1KYHD04tD8VIFvU7HoxPLa+f8JeaoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS7LQTvt2qusuzhtVYFaCU6D7P02R31UogzzFusfp08ffxYmbvirF4MElQTOhyjWnPaTWa0Ig2ox3kdqglSAiFAs1JfkDL63BbYelPZWIclVi7xdRFXAoqiBqY7pqxbCArTXirhrHrJyk1K9YI2n2yvNpIe3zpKDUPmqlfYaZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHeA826t; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHeA826t"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3121aed2435so36162a91.2
        for <dash@vger.kernel.org>; Wed, 28 May 2025 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748461706; x=1749066506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rN78b8BScqPVyBskK7hwnJHRPgql+kEGzwMnEcrxMgE=;
        b=kHeA826thfJFmkwwN90PGvnsbv3EV4YcE+uriaqvCBbRXocXsdhewSehUtgZc6k9+W
         9RNLuXVwWT0dXePm8vyCDYDYN33tt9y7Ka7bAEFnqZSe+BhVwLfVxPXVRNic+InOfyXk
         cY4DWC3KTelo82uyQdrUxMOH2tEVTsL+go3bVw7h8BbyctUidfmVPx87BNAWArZ5G6qz
         ZUgfRpC/PYzktRprlvbTFsRP4m+3+BSDmKXD5WGWq1usBAkiSniDzdWmuZYXxkp9knI3
         yZiPMxCx+9gEo6mXlix9G4cZtHG336pvBKTson50jqXrFyJcjv8BbyDI7kwxAioB4CgE
         L10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461706; x=1749066506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN78b8BScqPVyBskK7hwnJHRPgql+kEGzwMnEcrxMgE=;
        b=wgTnLqMiurUNoUhFx+zEvfvpOoZsR4rO/0AnB+mlV5991MdOxrwwllqJohtc1TD4Wt
         BXZoDZX5ScSa+wopubTYNfQ4T4eHEH6adXIc2QbHWZhi+dWN6AWrWny1ZRd/RSllC166
         dg2bLgCfN/4Si0LvM05ReNIq8YKbPe7s6qMCCApi7zLisG6RDaNTla1ZIWekDrLQSJnM
         mPPUpj6PAy6pF47zzVd7pW6eGR+oWT/hnITuJVEq+TXds7Xe2aR0YgLlTqAQLtJ2DYdj
         9ThAPpKh4UlhBx7txp56+EHsEpCBJF86CTl8fDXeRaYyQPL2PKfjNgbQ1mV6tk40Zc41
         DVvQ==
X-Gm-Message-State: AOJu0YxSlSY/m8mH3Gro9GbCTZ1Gl2J2HD50gEHmuz5bZHsvj+VeVI4D
	GFVya9WKEmSsEKc0WDgEKuzq4299WC4sZ880yrIFf5iEXeGiQcW5RfjTe7JxLA63UfyjMyhUtet
	XiqSqTgMNC/QKTEpxmAGqoEVwwVhlFitFPSMm
X-Gm-Gg: ASbGncuL6QdVqfRVbU/u30CJg3RIkoCmEMJDWmJLHHDYNGiDpI3C/U91M6Y49/Y86wn
	2oZehI/wPuKLvDg9O3UcFkh8X03dJLCuvxdWvJo3RPOyOL0RSSjMsuE9rm1XcF3pam9pLIWXxMq
	O5hX1YGAOaGOl/yQecyvP8NzmCKMvxdkjL6w==
X-Google-Smtp-Source: AGHT+IE6e4jbcsawmHZRwy9o4lh2JJDRwBV9I73L+WF9ePRRC499+gfuTawny1AHrhosudc0jmpBAgRSlC0sgPRYHvY=
X-Received: by 2002:a17:90b:3852:b0:30e:8c5d:8ed with SMTP id
 98e67ed59e1d1-3110f31a4fbmr26837943a91.19.1748461706149; Wed, 28 May 2025
 12:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaQ_hok_beXdXUkjCBVuatgPzua94kv3dfvZjpp=7aFoqNMMA@mail.gmail.com>
 <aDZ8Y00WXGmi5ZFA@gondor.apana.org.au>
In-Reply-To: <aDZ8Y00WXGmi5ZFA@gondor.apana.org.au>
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Wed, 28 May 2025 14:47:49 -0500
X-Gm-Features: AX0GCFtfdkqoKyDm6GMhii3_Pd0OJkp3wwNKfDAiI0LRrO-7UXnkQl998xx0WAs
Message-ID: <CALaQ_hq1d7=ySGSHeczuGC=SUD=o6P9CkZTeHC0wFdZF9gb=Nw@mail.gmail.com>
Subject: Re: [PATCH] input: Reset eof in reset_input
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH Mailing List <dash@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:33=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Tue, May 27, 2025 at 07:09:17PM -0500, Nathan Royce wrote:
> > I hope I'm doing this correctly by contacting you, as I saw no process
> > to go by (eg. via README)...
>
> Thanks for the report.  This should go to the mailing list which
> I have now cc'ed.
>
> > Using the script sample below, the "read" for the "After" prompt which
> > happens after the "loopRead" function which reads from a redirected
> > "heredoc", ends up being skipped over (or rather, not waiting for user
> > tty stdin, as if it was somehow still being read by the loop, even
> > though it's out of scope?).
> >
> > Success: 0.5.12
> > Fail: b3e38adf6718801e7f06267b438c45caec9523bb
> > Success: Bash - 5.2.037
>
> It's the new EOF handling patch, which was not reset correctly
> when stdin is redirected, causing the EOF to persist after redirection.
>
> Here is a reproducer:
>
> echo ok | {
>         read x < /dev/null
>         read x
>         echo $x
> }
>
> ---8<---
> Ensure that the EOF state is reset in reset_input as otherwise
> the new stdin may be treated as empty.
>
> Reported-by: Nathan Royce <nroycea+kernel@gmail.com>
> Fixes: 69786bc79f9b ("input: Fix pungetc on PEOF")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/src/input.c b/src/input.c
> index 6388b83..1aff3d4 100644
> --- a/src/input.c
> +++ b/src/input.c
> @@ -684,6 +684,7 @@ void __attribute__((noinline)) flush_input(void)
>
>  void reset_input(void)
>  {
> -       flush_input();
>         stdin_istty =3D -1;
> +       basepf.eof =3D 0;
> +       flush_input();
>  }
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Confirmed patch success.
Might I suggest adding a README to at least contain information on
reporting procedure? Maybe I was missing something and it's just
assumed everyone would know that everything under the kernel umbrella
would have a ML as "<project>@vger.kernel.org"?
