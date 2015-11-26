From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: [BUG] dash uses $* instead of $@ in variable assignments
Date: Thu, 26 Nov 2015 21:37:53 +0000
Message-ID: <20151126213753.GA8662@chaz.gmail.com>
References: <n37neq$eem$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34836 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbbKZVkO (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 26 Nov 2015 16:40:14 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1a24Gt-0002r0-CV
	for dash@vger.kernel.org; Thu, 26 Nov 2015 22:40:07 +0100
Received: from 2.121.21.200 ([2.121.21.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 26 Nov 2015 22:40:07 +0100
Received: from stephane.chazelas by 2.121.21.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Thu, 26 Nov 2015 22:40:07 +0100
Content-Disposition: inline
In-Reply-To: <n37neq$eem$1@ger.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2015-11-26 20:44:26 +0100, Gioele Barabucci:
> Hello,
> 
> I am forwarding a bug [1] reported by a Debian user: dash incorrectly
> uses `$*` instead of the requested `$@` inside variable assignments.
> The current version of dash is affected by this bug.
> 
> A simple test from the original reporter:
> 
>     $ dash -c 'IFS=:$IFS ; set -- a b c ; echo "$@" ; x="$@" ; echo "$x"'
>     a b c
>     a:b:c
[...]

This behaviour is what I expect and is common to other shells as
well.

$* and $@ are the concatenation of the positional parameters
with the first character of $IFS, but "$@" in list contexts
expands to all the position parameters as separate words. That's
a logical continuation to the Bourne behaviour (which
concatenated on space instead of the first character of $IFS).

POSIX used to be unclear about it. I had raised the issue some
time ago and I beleive there's a new wording. See the longish
discussion at
http://thread.gmane.org/gmane.comp.standards.posix.austin.general/9972

In any case, you should only use $@ quoted and in list contexts.
$* may be used quoted in non-list contexts.

IIRC the proposed new wording for the POSIX spec would make this
behaviour of dash non-conformant:

$ dash -c 'set a b c; IFS=; echo $*'
abc

(even though I'd argue it's a logical design choice).

-- 
Stephane

