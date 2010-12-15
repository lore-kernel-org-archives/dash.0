From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: read() builtin doesnt read integer value /proc files (but bashs
 does)
Date: Wed, 15 Dec 2010 12:55:51 -0600
Message-ID: <20101215185551.GA22905@burratino>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
 <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com>
 <20100903212504.GA86276@stack.nl>
 <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com>
 <20100904193504.GA3357@stack.nl>
 <20101128084219.GC8818@gondor.apana.org.au>
 <1012151034250.15865@somehost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55630 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab0LOS4I (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 15 Dec 2010 13:56:08 -0500
Received: by wyb28 with SMTP id 28so1765571wyb.19
        for <dash@vger.kernel.org>; Wed, 15 Dec 2010 10:56:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1012151034250.15865@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, 595063@bugs.debian.org

Hi Cristian,

Cristian Ionescu-Idbohrn wrote:
> On Sun, 28 Nov 2010, Herbert Xu wrote:
> > On Sat, Sep 04, 2010 at 07:35:04PM +0000, Jilles Tjoelker wrote:

>>> This discarding is still bad as it throws away valid data if the open
>>> file description is shared. This happens if stdin is redirected inside a
>>
>> I'm with Jilles on this.  I also don't particularly feel like
>> bloating dash just because of the borked /proc interface when
>> there is a perfectly adequate work-around in "cat".
>>
>> 	value=$(cat /proc/file)
>
> I wouldn't call that "a perfectly adequate work-around", but a painful and
> unadequate work-around.

For what it's worth, here's what bash does (based on strace):

1. Determine whether the file is seekable.  That is, seek using
SEEK_CUR with offset 0.

2. If seekable, read a nice big chunk and then seek back to put the
file offset back in the right place.  If not seekable, read one byte
at a time.

This works in /proc because files in /proc are seekable.

That said, I don't think borked /proc is a great reason to do this
(it's a better reason to fix /proc).  Speeding up the read builtin
might be a good reason.

Regards,
Jonathan
