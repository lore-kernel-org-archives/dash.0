Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D231B81C
	for <dash@vger.kernel.org>; Tue, 20 Jan 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935009; cv=pass; b=XuDw8J4wDGRvkNefu2gbl8C06z/YgbtBuUpI/1Uuq8v5lQVFhBF3B1RBhIMhezYbfkdd+TTiUEMfoj9P6u4OYwkfo7YN7i/Khqdh0fxVdantIIHAwaqD36qkrSpBZhnkAOQ6qcCrC/eF3EN8Dcxe+1w0ZpVAe8fA9dHAHC4fzeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935009; c=relaxed/simple;
	bh=AZEz2EP7fX5sPKlfx0Tf4KS8f0mkpTn4hRdOsXQmNVo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gI0nxvM/IIAlcRx99gGxV2mtZk3DBlHWvc5SvXI4r1mH26qEZOJXCVTLyIvJds/531Ifx4X1vOdpF6oSuDxvziXypT6K5tJKdOyjyoRHQHOeRVb0JYhWqvj6w0QWb06UQGnkV+pETRuBUQhXzBudjmPf7K2ehcjuit/9Ibirwsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGX8WaBm; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGX8WaBm"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-793ae293fadso49306057b3.0
        for <dash@vger.kernel.org>; Tue, 20 Jan 2026 10:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768935004; cv=none;
        d=google.com; s=arc-20240605;
        b=l0AT3Fj/N6iQAV39sk4GT2lqJccIRdhRxWo3qpDSfqHVnk4ZpYSTzjEkMIuqoDttDS
         zp9BI6HaSW7R7ZqNuTwswXlk+kCa328k2h8h6x0Bi0JDiGR+bkT+krdoy9VKd809hBnP
         7/xJXHNCwXwM3Y4gMKDwbEa9L3DR0m3ypRKCpfrRBkVXr+2b3iO5MHRGRUdrFZCh9A0+
         UzJtpC33fD4MT+chatmQCksDLYkxZeUmaK3mxqgmbp8jQP9kOZeX4+uL6iHoeC/KbE7D
         1MbQq3+In3znLAssCMgu7Okaz8+JriItuderjrFGCB4AyXi42TcV49ghU+f3xB46bw/F
         73Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=16n+twY5pX3e+ZjsHQlAaGj8SZgUgYEHXQpsPT19oUk=;
        fh=Q7kkUHvUpV7GF22BcVPTe0jHcVVjWF0IspJwmqq6Oh4=;
        b=Cll6gkKHUn54SALUUb40ZPTsL35E4O9RoQ84bDtoj6oHJme1z+/GsqF78qgS5zeBDP
         FleLvH0NmhYRS70xjXkGHn4uLgLotZUR0OfSNbSUwz6jLUMM4mtx2ZV9CziyKk1yjOg3
         hbsxygvUDLcsPREtb48gHw3ckxQgcAC5FlUWaK+3vb+DLGXZLvsoMvB3CUqgUblzzUD+
         inqAqeMpTrRnIXMI3P3NMFhqK0cFjk6tuJiKngRAzOJjb4eOrar99SfBCtRkWUGb8HnF
         wkyP+tCokXvq5w0ZgRCcmXnuKSVjij7/0SW40Qfl4gN2xKJCiCUINciRgcqM35Rv5PhX
         vuPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768935004; x=1769539804; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=16n+twY5pX3e+ZjsHQlAaGj8SZgUgYEHXQpsPT19oUk=;
        b=cGX8WaBmGjDrArgK8NL7DC+QXSTd/f7lxYkI7nRVeHH8rfwN4z/+p9LBP2TH4YLkl5
         IIzvKxJe9SiKQcr2AyLr86SrZY9Dyy2eCBRq8lFcDPmlqSzoud2IYFY8boL4cQ8gnCc3
         C/0aTp9FQKxlEbOdZD9a8VDejSavXpubiikofe+pwztGqQ0IoZ0YMHH7p7GptMjKu8pa
         pJ7t7pTH+fxlcCUxPZl82WnFmpxycsCfm/zf/HuMGMcaIfElEBl1BzG0S6/KE+eYFUiK
         EfJkhmsv4Jj3kbBek+YwMG8KH8lFg34rlEPMGxm2oaN//NHT3OdbquhfZVIvQS1XEREA
         lGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768935004; x=1769539804;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16n+twY5pX3e+ZjsHQlAaGj8SZgUgYEHXQpsPT19oUk=;
        b=eqyaxiCTFLe3C+pGni/6zsAXHdPz2ArsSQAsWsmWc/ADnec8lRO0WmTNymv5R80S3k
         bBWa0AxNpvz5Rr2TlozLojdRw6DnbJ5e6Ys6FxS61gZnceceGxDRbd5v3cV620s0nEeR
         8vJVdpSo8nmPLYMVHgsFIoyxuOyktzmqJqbj8xHU22IkxyJMoTEqmlwirUwCAoXT66Ay
         93y9nFQCTKO2CmBEFQPcbjKUMZfbPQgfx1Gj1y16QI54kHw4hDr886984cne48KGR9FY
         gvM8IYlkHW1P3jv9UE0LB4G1vqSt20IUXWsw7qXhPRC9Nr1w8C5HV2Pypp/1/+pc0Sji
         mJMg==
X-Gm-Message-State: AOJu0YxMOQToXnD5wen1odAwleQnM1czqdl/vq+n14jpWapumM0pBulv
	1Sc6qWvJsQ/mDK9QBV2CW6CwZB51OWg1PtQs+MYlSQsSIJyZJl+GQsE/d3UcbrUBm/T1yksNqYz
	qzvU8N5FSjzBQmwpD+7lKjLMTKyFZ+Eqz/+EFMYE=
X-Gm-Gg: AZuq6aIbevFZmxAHvGmY3AyAPSQxYDl3vReOwnUGUCaaFMmsmshz4TNcrfaPqDtV3WD
	PBF4kHknIF8ehJSIjE0M/s9lXFp2LfHwwqTSUmxLt2XGwroZ5lnQos6dc9+tfuTcEfzaNnI+m+Z
	WiGmMMrhTm4fKHKam51XaoRp+IX7xhJjQxhlze31armkvbIsFV8yd7pSa6Kqjev2MVntTNqJE8n
	tf6+axXAPp1nEN3tuKnptpzbE20iG8kf9gr7Lf8aM15XHn18xfVa4p/qmPAonz9Wtr1f63MAi/f
	o1DrzaoVrDd8L5OBuktO8nfmCw==
X-Received: by 2002:a05:690e:4101:b0:648:f591:fd70 with SMTP id
 956f58d0204a3-64917736b6dmr10582642d50.73.1768935004052; Tue, 20 Jan 2026
 10:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aleksander Ushakov <retes672@gmail.com>
Date: Tue, 20 Jan 2026 21:49:53 +0300
X-Gm-Features: AZwV_Qh0_7MY4-l9iZV-I8rKPRYAIIzjI8TB0ePTLTt2WqC3EZ_KtjY_Jc3VA7Y
Message-ID: <CADdNFavnk7LogUfLQrKkAuRryUuTrkx6OpeKVJpUr4ahXcD=6w@mail.gmail.com>
Subject: [BUG] nullptr-with-offset growjobtab() src/jobs.c:818:34
To: dash@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I encountered a bug in Dash 0.5.13 (on commit
5139d6a27763fc0be386e15634db21e45598b299) and would like to report it.
The details are  provided below.

jobs.c:818:34: runtime error: applying zero offset to null pointer
    #0 0x586492cd930b in growjobtab /upstream/ub/src/jobs.c:818:34
    #1 0x586492cd8e45 in makejob /upstream/ub/src/jobs.c:773:9
    #2 0x586492cdacc8 in vforkexec /upstream/ub/src/jobs.c:985:7
    #3 0x586492cbacb7 in evalcommand /upstream/ub/src/eval.c:901:9
    #4 0x586492cb7f9c in evaltree /upstream/ub/src/eval.c:299:12
    #5 0x586492cdf69c in cmdloop /upstream/ub/src/main.c:242:8
    #6 0x586492cdf35a in main /upstream/ub/src/main.c:176:3
    #7 0x7fe9eb831249 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #8 0x7fe9eb831304 in __libc_start_main csu/../csu/libc-start.c:360:3
    #9 0x586492c86850 in _start (/upstream/ub/src/dash+0x3e850)
(BuildId: e68b2d28b6287f88e673d7eb3b1d49090e50fd76)

SUMMARY: UndefinedBehaviorSanitizer: nullptr-with-offset jobs.c:818:34
Aborted (core dumped)

////////////////
Place in the code:
////////////////

        if (offset) {
                /* Relocate pointers */
                size_t l = len;

  ------------>jq = (struct job *)((char *)jq + l);
                while (l) {
                        l -= sizeof(*jp);
                        jq--;
#define

////////////////
My environment:
////////////////

Debian-12, x86-64, clang-19 compiler

/////////////////
Steps to reproduce:
/////////////////

$ aclocal && autoheader && automake --add-missing && autoconf
$ CC=clang CFLAGS=" -Wno-everything -fsanitize=undefined -g -O0"
./configure --disable-fnmatch --disable-lineno --disable-glob
$ make
$ cd src
$ export UBSAN_OPTIONS=print_stacktrace=true,symbolize=true,print_stacktrace=1,report_error_type=1,symbolize=1
$ ./dash < myfile.txt

//////////////////
Steps to get myfile.txt:
//////////////////

copy the text into file bs64.txt (between ==== and ======):

=====================================================================================
JFxf/6QAgCAwCmNkIC0KY2QgLS0tCgplY2hvIBB8fCAuAGZ3d3d3d3d3d3d3d3d3d3d3d3d3d3d3
d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3d3
d3d3d3d3d3d3d3d3d3d3d3d3d3d3dwoyPiYxCgoKCgoKaWxlCiQqKgoyPiYxCgoKCgoKaWxlCgoK
Dw9/Dw8CCiQkJCQ4WwpjZApjZApjZCAtAAIgMIAgMGRisbFjZCAtAAB//wpjZCAtCmNkIAABYyAw
CmNkIC0KY2QgAgICAKckMUUkMSQlJCQuJDpbpyQxRSQxJCQkJCQCJCQkJBgkJCQkJCQkJCQkJCTb
JP8AZfAkJCQkJGMg/y+SkpKSkpKSaGUD6HAWbyDkPiYxJEAgAEQg4eHh4eHh4W8gfiRAYGBgYIMA
H5KSkpKSkiQkQCQkAIAkAgIvCm5kCmhl//99Y2NjY2NjY2NjY2NjY2Njd2NjY4NjY2NjY2NjY2Nj
Y2NjY2NBY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjYyRmCmMoKS8KY2gAAAAgLwpjKCkgCmM9fiB2
aWw9fiBlY2ggKip7UGg5NGP/f3syWDRjICR7MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIx
MjIyMjIlOjIyMjIyJToqfYM9ezJYNGMgJHsyMjIyMjIyMjIyJTJEM00kKCghHP9/QEIpKWVjaDIy
NzoqfXiDQGo5ADfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+7n
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
52Nhc2Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fm5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fnIyQk
JCQkbyBobyBlBXZmPiYtIH5pbOfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fnIC8KYyAAIApEZCAvCmNkCh16Cgo/ASAtACAgCgo/ASAtACAOMApjYyAtCmNkIC8K
Y2QKHaX/pACAIDAKY2MELQpjIz8BIC0AICAKCj8BIC0AICAKCj8BIC0A5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn59Hn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fnfOfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fnAH//CmNkIC0KY2QgLWQgIApuZApjZCAuCmMtCmNkIC0KYyAwCmNkCmNkIC0KY2QgLQpjIDAA
AUQgLQpjZCAvCmNkIC1jIDAKaAH65+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5y1S5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn58fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5Ofn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fnIufn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fnL2Rldi9udWxs5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn
5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5xTo5+fn5+fn5/7n5+c8PAAkUwokUwpcW1dP
Tq85XFwkJFxkfVxcW1dPTq85XFwkJFxkW1dPTmxlNSBpbGUKZiR7UEE9SCUlOiR7UEE9SCUlOip9
ZXVobyBmaSp9WWNobyBmaSBm6AMAACBmbGUkMWM9fiB2aWw9fiBmaWw9fiBmbGVlCmUKYyD/L5KS
kpKSkpJoZQPocBZvIOQ+JjEkY2QgLQAAf/8KY2QgLQpjZCUtCmMgMApjZCAtCmNkIC8KbmQKY2Qg
LQpjIApjZCAtCmMgeIAgOWRisbFjZAAgLQAAf/8KY2QgLQpjZCAtZCAgCm5kCmNkIC7zYgAAAP8g
LQpjIDAKY2QKY2QgLQpjZCAtCmMgMAABRCAtCmNkIC8KY2QgLWMgMApoAfoAsbGxsbEAgCAwClBk
IC0ZY2QgLQpjILGyo7FmX/+kAIAgMGNjY2NjY2NjY2NjY2NjY7GxsbGxsbEkHyQAABAXAQBvb29v
b29vb28KCmNkIC0KYyAwCmOxY2QgLQAAf/8KY2QgLQVjZCAtCmMgMApjZCAtCmNkIC8tCmMgMApj
ZC4tCmMgMApjAEAt+2JkXG8teWzHCiD/pACAIDAKj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+P
j4+Pj4+Pj4+PgACPj4+Pj4+nJDFFJDEkJSQkJCQ6UP//MUUkMUUkECQ6kpKSkpKSkpKSkpKSJCQk
JDpbpyQxRSQxJCUkJCQkOmNobyBmUVxc2VyCbhAdhiBmaWxcbD1+IGZpbApjZCAtCmNkJS0KYyAw
CmNkIC0KY2QgLwpuZApjZCAtCmMgABBkIC09fiBmbGVlCmUKYyD/L5KSkpKSkpJoZQPocBZvIOQ+
JjEkY2QgLQpjZCAtCmNkJS0KYyAwCmNkIC0KY2QgLwpuZApjZCAtCmMgCmNkIC0KYyB4gCA5ZGKx
sWNbpyQxRSQxRSQQJDqSkpKSkpKSkpKSkpKSko6SkpKSCmMKYw==
=====================================================================================
