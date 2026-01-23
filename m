Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A72296BC5
	for <dash@vger.kernel.org>; Fri, 23 Jan 2026 12:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769172249; cv=pass; b=TxxThzYTxaiWxt/2RJCxzrwunsGwuHGrtU6+P6v3alNRyzFuGojQDt3qRmqPXq70HD4We+lbhOtVRovEyNtKiSYWjO4+7U4BAmL5nzpMY3CKte9SsOfwDYBmoNLcvxbpuJgtfGGmAW//mGHTF2LqUcSHbeSISYNxqmRu0PgqHH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769172249; c=relaxed/simple;
	bh=I/+bhIV9JxlE/XXC/7O9uEAjXkIc7EMTh3Q7RghpsmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=KYdblzwAwJEQ4zh/598gOZryMshazlu49gprkL9nOhJCCAtNEapTzNN9e+K1BFforFJJb/eO8RapvxW8Ccu++CG/rI4DmRx4vznqSDHbv73QmjXwJJtOqpsD0Hr0G3HbR2an7EJUHAgdMVrv8tVUy1APgnkcxIw02A4Fhmgw/cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGBACAi+; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGBACAi+"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64960418d46so405994d50.1
        for <dash@vger.kernel.org>; Fri, 23 Jan 2026 04:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769172246; cv=none;
        d=google.com; s=arc-20240605;
        b=KYMcQwVVAMGLBAYj8IIiXfVVTDDKWhCaKpFdX+zE6sEKA9fJA+OuSZ+FoTOgSyOT2l
         pri+gnuakwtccsKRK9VKjWj+JnuaFqAvj7dNbIu1mNwiBkJrHGo5PxJ+wSaj3U2tbJ/X
         ouiDasOcSkVPQ2j5T3aIcP4MwM6nvFzmA6t0yayFhj6tOre0amnpg6UPPWarM+CJB9Db
         GKyW5TUK6wyJ5G7CAdw5+Thxt9X9aSo2fSs8x30gbO8Ra05ZU9IKePkgVibffmJAcjtZ
         RsVpq3lyUNS+NaI5kWjhd+WRLJpZHRfBAeX6sssL3Ee1p/g+sd+VxEd5zdEzNx7njMUQ
         XRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=toi1cc5q5DXnKU4K33UTlSXTVfAlNw5EI6/6FehdPAY=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=LbGTlFZexPih/rzUnMuF0R0oHESi4a5dR5ImCV675iSIpwUy+CINWmyAq7cCxQC250
         1P1kGgiJfp4gbsik/YffRCVhNM6vjPqgcZJ4fm0hGBk9DKZ41Bzyu+EZM33nFvZML3uG
         Lz4zA4fr7CEcaj2Va5lBWUXNa7SvNw8v5u2pqWsWMFGsPJxK2G8nDMs5s/LIbzYyyMeu
         iHiL66J8/wHA8Y+6kc9uiIfqZYfaAOm5ApBXSqwA8bMog2u85fD64mXQ0LVj8wtzWoVl
         9/Iyj4J7id7tgII6sDPUPQd9WgovE0tB/3upDbF9T/z3UUdoSJHlCt66EjRA9EFc9w6q
         /5ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769172246; x=1769777046; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=toi1cc5q5DXnKU4K33UTlSXTVfAlNw5EI6/6FehdPAY=;
        b=FGBACAi+DbXD0lgSOLD5W6C3G4vqcLJvT/XDgqQufs6oLymGEf2opB8TVkt0/5M/D8
         HrqDD65keVtogvZC+rx/SCK6Cd1HZbdG98qoAl/bJb5PTk/PDf8kI2Piqb43cy/R77Ln
         bROvBuftcRyoP0syjyc/o4G+WBSHsSV8mWpO1cty2smagaXsPyz93mrp2Vz2QH+RT+jl
         77TFy1BborWUVxdt+548KDPgJD8Vvc+gSUNCwzDVtyVdRElvKrTsAvsS0J/LiXJSglYb
         gBqEJMtG9mcEEcO3+Mmusx+7qCDdqIpGEnj6Ijz3zVuoP4ATo6oq+cmmE1v/mNZ+hEaL
         Nvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769172246; x=1769777046;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toi1cc5q5DXnKU4K33UTlSXTVfAlNw5EI6/6FehdPAY=;
        b=BzJS9ttBAWdYvzBXobWWg/rFl3gIi6OPIbvPNJ/dVsmjfJVgr1XerYU36yVlXry8hc
         mgnMTZdgravcBJ3e/rFhGEKZbQKH8yPMjo7JFhtNtSbxFpN6kNKJ9qgG8bTL7ifPE5ip
         dshuxrCpwjf+xPV7eiSbLM3Z3C7Sg/KzKQ42YCqnEE3VOtkFSlAIk7t4vLIc7TgJohp0
         I4MHZUUcziRNWLcQbad6WyoyqIGAUGJOhKpcqirEoh5nLyO39Q+9AAVxj6eyH8/wLi6z
         hTsmFvWpFev6nII2f+ZVxU9CxTArBI9+P2hJInkEbXAjg9ifOnbK+wwYJSIibW31CEyV
         Limw==
X-Gm-Message-State: AOJu0YybtaRHha5cLKg1cFpPlKXDA3dZh2WBY9MuZZJzaR8rLf1ZgEKq
	ftEyxHtNJsdWC7JCPtYIwYjycoDIDiTRtyE5tw48jIALxBnkgxWKAX1tiKy07CrSiaCN5unHXTR
	uKLUSF4xJWOXqL1Jd897gTCiDSCDXO36XhOKwqTI=
X-Gm-Gg: AZuq6aKtYEgsf7brvoR4QF2SU+vTfywW3EVSKuNzkGU3Gl39/5IVLv99MqS3nUIN77F
	pkIVOPFJh650QX+hqDzHI+MIY2+MtujuWTlay5YsDbUGpO57oMM7v5PRDGNp1aRx9qjegZb2p+O
	s2YziKrndmOt3Iso6vYIPdkEvQulo4cobe++Za5izAU1kIugC2HajdoOrvn63sEB3NdSdGtI7hM
	JK7ARzYekHCUhiXtnqpqKP6JI4L3o7buSzPvoPfRB7CXN9ZOmwQuYldhoW9Ae9/6EeHmkUHZ4kn
	nrAsWiMUTVToxkw/ns8ZcCsXbg==
X-Received: by 2002:a05:690e:b46:b0:644:7d7f:ed41 with SMTP id
 956f58d0204a3-6495be6b4cemr2148834d50.3.1769172246074; Fri, 23 Jan 2026
 04:44:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADdNFavnk7LogUfLQrKkAuRryUuTrkx6OpeKVJpUr4ahXcD=6w@mail.gmail.com>
In-Reply-To: <CADdNFavnk7LogUfLQrKkAuRryUuTrkx6OpeKVJpUr4ahXcD=6w@mail.gmail.com>
From: Aleksander Ushakov <retes672@gmail.com>
Date: Fri, 23 Jan 2026 15:43:54 +0300
X-Gm-Features: AZwV_QhLgJg_5IZz_l_TizwYl-TYHG8U5clYgZ7Bl3IRaO5u7oYyka8fDf7IdyY
Message-ID: <CADdNFatsHjyyxSVE4Zj+CumzCpY_5+bRKN1weTiedjRPd63-fg@mail.gmail.com>
Subject: Re: [BUG] nullptr-with-offset growjobtab() src/jobs.c:818:34
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I checked it on the latest clang 21.1.8. The problem has disappeared.
But the problem keeps on older versions of clang.
If we open C17 standard, then we can see
"""
If both the pointer operand and the result point to elements of the
same array object, or one past the last element of the array object,
the evaluation shall not produce an overflow; otherwise, the behavior
is undefined.
"""
The problem place of code:
jq = (struct job *)((char *)jq + l);

A condition of C standard is 'pointer operand' and 'result' should
point to elements of the same array.  But jq is nullptr. So jq and jq
+ l point to elements of not same array, then the condition isn't
complete.

May be just apply the simple patch?

diff --git a/src/jobs.c b/src/jobs.c
index 6622bdd..89417c3 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -812,7 +812,7 @@ growjobtab(void)
        jp = ckrealloc(jq, len + 4 * sizeof(*jp));

        offset = (char *)jp - (char *)jq;
-       if (offset) {
+       if (offset && jq) {
                /* Relocate pointers */
                size_t l = len;

So the behaviour is same with
https://www.spinics.net/lists/dash/msg02872.html. And the input data
can be taken from there (first bug report). When I tested it on my
system, sudo wasn't installed
.
>
> I encountered a bug in Dash 0.5.13 (on commit
> 5139d6a27763fc0be386e15634db21e45598b299) and would like to report it.
> The details are  provided below.
>
> jobs.c:818:34: runtime error: applying zero offset to null pointer
>     #0 0x586492cd930b in growjobtab /upstream/ub/src/jobs.c:818:34
>     #1 0x586492cd8e45 in makejob /upstream/ub/src/jobs.c:773:9
>     #2 0x586492cdacc8 in vforkexec /upstream/ub/src/jobs.c:985:7
>     #3 0x586492cbacb7 in evalcommand /upstream/ub/src/eval.c:901:9
>     #4 0x586492cb7f9c in evaltree /upstream/ub/src/eval.c:299:12
>     #5 0x586492cdf69c in cmdloop /upstream/ub/src/main.c:242:8
>     #6 0x586492cdf35a in main /upstream/ub/src/main.c:176:3
>     #7 0x7fe9eb831249 in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
>     #8 0x7fe9eb831304 in __libc_start_main csu/../csu/libc-start.c:360:3
>     #9 0x586492c86850 in _start (/upstream/ub/src/dash+0x3e850)
> (BuildId: e68b2d28b6287f88e673d7eb3b1d49090e50fd76)
>
> SUMMARY: UndefinedBehaviorSanitizer: nullptr-with-offset jobs.c:818:34
> Aborted (core dumped)
>
> ////////////////
> Place in the code:
> ////////////////
>
>         if (offset) {
>                 /* Relocate pointers */
>                 size_t l = len;
>
>   ------------>jq = (struct job *)((char *)jq + l);
>                 while (l) {
>                         l -= sizeof(*jp);
>                         jq--;
> #define
>
> ////////////////
> My environment:
> ////////////////
>
> Debian-12, x86-64, clang-19 compiler
>
> /////////////////
> Steps to reproduce:
> /////////////////
>
> $ aclocal && autoheader && automake --add-missing && autoconf
> $ CC=clang CFLAGS=" -Wno-everything -fsanitize=undefined -g -O0"
> ./configure --disable-fnmatch --disable-lineno --disable-glob
> $ make
> $ cd src
> $ export UBSAN_OPTIONS=print_stacktrace=true,symbolize=true,print_stacktrace=1,report_error_type=1,symbolize=1
> $ ./dash < myfile.txt
>
> //////////////////
> Steps to get myfile.txt:
> //////////////////
>
> copy the text into file bs64.txt (between ==== and ======):
>
> =====================================================================================
> JFxf/6QAgCAwCmNkIC0KY2QgLS0tCgplY2hvIBB8fCAuAGZ3d3d3d3d3d3d3d3d3d3d3d3d3d3d3
> d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3
> d3d3d3d3d3d3d3d3d3d3d3d3d3d3dwoyPiYxCgoKCgoKaWxlCiQqKgoyPiYxCgoKCgoKaWxlCgoK
> Dw9/Dw8CCiQkJCQ4WwpjZApjZApjZCAtAAIgMIAgMGRisbFjZCAtAAB//wpjZCAtCmNkIAABYyAw
> CmNkIC0KY2QgAgICAKckMUUkMSQlJCQuJDpbpyQxRSQxJCQkJCQCJCQkJBgkJCQkJCQkJCQkJCTb
> JP8AZfAkJCQkJGMg/y+SkpKSkpKSaGUD6HAWbyDkPiYxJEAgAEQg4eHh4eHh4W8gfiRAYGBgYIMA
> H5KSkpKSkiQkQCQkAIAkAgIvCm5kCmhl//99Y2NjY2NjY2NjY2NjY2Njd2NjY4NjY2NjY2NjY2Nj
> Y2NjY2NBY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjYyRmCmMoKS8KY2gAAAAgLwpjKCkgCmM9fiB2
> aWw9fiBlY2ggKip7UGg5NGP/f3syWDRjICR7MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIx
> MjIyMjIlOjIyMjIyJToqfYM9ezJYNGMgJHsyMjIyMjIyMjIyJTJEM00kKCghHP9/QEIpKWVjaDIy
> NzoqfXiDQGo5ADfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+7n
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 52Nhc2Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fm5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fnIyQk
> JCQkbyBobyBlBXZmPiYtIH5pbOfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fnIC8KYyAAIApEZCAvCmNkCh16Cgo/ASAtACAgCgo/ASAtACAOMApjYyAtCmNkIC8K
> Y2QKHaX/pACAIDAKY2MELQpjIz8BIC0AICAKCj8BIC0AICAKCj8BIC0A5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn59Hn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fnfOfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fnAH//CmNkIC0KY2QgLWQgIApuZApjZCAuCmMtCmNkIC0KYyAwCmNkCmNkIC0KY2QgLQpjIDAA
> AUQgLQpjZCAvCmNkIC1jIDAKaAH65+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5y1S5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn58fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5Ofn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fnIufn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fnL2Rldi9udWxs5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
> 5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5xTo5+fn5+fn5/7n5+c8PAAkUwokUwpcW1dP
> Tq85XFwkJFxkfVxcW1dPTq85XFwkJFxkW1dPTmxlNSBpbGUKZiR7UEE9SCUlOiR7UEE9SCUlOip9
> ZXVobyBmaSp9WWNobyBmaSBm6AMAACBmbGUkMWM9fiB2aWw9fiBmaWw9fiBmbGVlCmUKYyD/L5KS
> kpKSkpJoZQPocBZvIOQ+JjEkY2QgLQAAf/8KY2QgLQpjZCUtCmMgMApjZCAtCmNkIC8KbmQKY2Qg
> LQpjIApjZCAtCmMgeIAgOWRisbFjZAAgLQAAf/8KY2QgLQpjZCAtZCAgCm5kCmNkIC7zYgAAAP8g
> LQpjIDAKY2QKY2QgLQpjZCAtCmMgMAABRCAtCmNkIC8KY2QgLWMgMApoAfoAsbGxsbEAgCAwClBk
> IC0ZY2QgLQpjILGyo7FmX/+kAIAgMGNjY2NjY2NjY2NjY2NjY7GxsbGxsbEkHyQAABAXAQBvb29v
> b29vb28KCmNkIC0KYyAwCmOxY2QgLQAAf/8KY2QgLQVjZCAtCmMgMApjZCAtCmNkIC8tCmMgMApj
> ZC4tCmMgMApjAEAt+2JkXG8teWzHCiD/pACAIDAKj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+P
> j4+Pj4+Pj4+PgACPj4+Pj4+nJDFFJDEkJSQkJCQ6UP//MUUkMUUkECQ6kpKSkpKSkpKSkpKSJCQk
> JDpbpyQxRSQxJCUkJCQkOmNobyBmUVxc2VyCbhAdhiBmaWxcbD1+IGZpbApjZCAtCmNkJS0KYyAw
> CmNkIC0KY2QgLwpuZApjZCAtCmMgABBkIC09fiBmbGVlCmUKYyD/L5KSkpKSkpJoZQPocBZvIOQ+
> JjEkY2QgLQpjZCAtCmNkJS0KYyAwCmNkIC0KY2QgLwpuZApjZCAtCmMgCmNkIC0KYyB4gCA5ZGKx
> sWNbpyQxRSQxRSQQJDqSkpKSkpKSkpKSkpKSko6SkpKSCmMKYw==
> =====================================================================================
