From: Dan Muresan <danmbox@gmail.com>
Subject: Re: shift "fatal error"
Date: Sat, 26 Mar 2011 09:11:30 +0200
Message-ID: <AANLkTinQyNdnbuE9Ytw43bnwVvFqXy4kxbsuiFReidDT@mail.gmail.com>
References: <AANLkTik1TC3jv-imnbChRGqtHzRCvKCcB5_LnqEnDc9u@mail.gmail.com>
	<20110310192333.GE3948@wopr.local.invalid>
	<20110315213116.GA53303@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57433 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1CZHLb convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Sat, 26 Mar 2011 03:11:31 -0400
Received: by bwz15 with SMTP id 15so1370441bwz.19
        for <dash@vger.kernel.org>; Sat, 26 Mar 2011 00:11:30 -0700 (PDT)
In-Reply-To: <20110315213116.GA53303@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

> That may have been the intention (considering that it matches the rea=
l
> Bourne shell in addition to various flavours of Korn shell), but that=
 is
> not how I would interpret it. A too high shift count still seems
> syntactically valid to me.

After reading the other part of the spec (about syntax errors in
utilities), I reached the conclusion that dash has just enough excuses
in the spec and in history to behave as it currently does -- so
presumably nothing will change (especially since the current behavior
*reduces* usability).

> A statement about the exit status in a particular error situation als=
o
> usually indicates that the shell shall not abort.

Yes, that was the main point, but it's true that specs can be
self-contradictory.

> Examples of shift commands that I think shall cause the shell to abor=
t:
> shift -S =A0# unless a -S option is supported as an extension
> shift x =A0 # unless arithmetic expressions are accepted as an extens=
ion
> shift @ =A0 # unless there is some strange extension

That's how I would have thought any reasonable person would interpret
the blurb about syntax errors in special built-ins, but apparently
there are other ways to see it, rooted in historical precedent even.

-- Dan
