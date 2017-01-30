From: Martijn Dekker <martijn@inlv.org>
Subject: Re: [PATCH] unset/null variables should expand to 0 during arithmetic
 expansion
Date: Mon, 30 Jan 2017 00:13:42 +0000
Message-ID: <cc2914b7-c2f3-82a0-3b2a-6e4885c5f34f@inlv.org>
References: <A7A04C3C-65D2-404B-B65F-0053A4D2E78C@pomona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from kahlil.inlv.org ([37.59.109.123]:50384 "EHLO kahlil.inlv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbdA3Aeg (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 29 Jan 2017 19:34:36 -0500
In-Reply-To: <A7A04C3C-65D2-404B-B65F-0053A4D2E78C@pomona.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Michael Greenberg <Michael.Greenberg@pomona.edu>, "dash@vger.kernel.org" <dash@vger.kernel.org>
Cc: Austin John Blatt <ajb22014@MyMail.pomona.edu>

Op 19-01-17 om 21:06 schreef Michael Greenberg:
> unset x ; echo $((x+=2))
> 
> Running bash on this program echoes the number 2 to standard out and sets x to 2. Running dash (git HEAD/release 0.5.9.1) yields an error:
> 
> src/dash: 1: Illegal number: 

Yes, looks like a dash-specific bug. The related shells Busybox ash and
FreeBSD /bin/sh act like POSIX says they should.

> The standard is a little bit unclear about what to do for variables that are set to null (or non-numeric values). I’d interpret the standard as defaulting for unset variables, having null and other non-numeric strings cause some kind of error. bash, as usual, goes well beyond what the standard indicates: any non-numerical value is defaulted to 0. So:
> 
> x="" ; echo $((x+=2))
> 
> x=“yo” ; echo $((x+=2))
> 
> both yield 2! If you ask me, that’s a bridge too far—and asking for bugs.

That's recursive arithmetic expression parsing in bash, ksh and zsh; if
the value of a variable is an arithmetic expression (including simply
another variable name, such as "yo") this is evaluated, which in this
case means the value of "x" is taken as the value of "yo" which is taken
as zero. That behaviour is not specified by POSIX, of course.

- M.

