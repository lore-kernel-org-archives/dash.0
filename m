From: Isaac Jurado <diptongo@gmail.com>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Thu, 5 Jul 2012 23:01:16 +0200
Message-ID: <CALqPu37DGb7XjZvvAawRA9cYLN0Mex4nWzZQJ6Obs0fgY6aVNQ@mail.gmail.com>
References: <20120703201334.GA66099@stack.nl>
	<20120705074355.GA969@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55233 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab2GEVBR (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 5 Jul 2012 17:01:17 -0400
Received: by vcbf11 with SMTP id f11so5706778vcb.19
        for <dash@vger.kernel.org>; Thu, 05 Jul 2012 14:01:16 -0700 (PDT)
In-Reply-To: <20120705074355.GA969@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jilles Tjoelker <jilles@stack.nl>, eblake@redhat.com, PaulGBoulder@aim.com, dash@vger.kernel.org

On Thu, Jul 5, 2012 at 9:43 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>>
>>> That argues that we should drop our strcasecmp() for the much simpler
>>> strcmp(), in order to remove the bloat we already have.
>>
>> Such a change would be at odds with the goal of dash to be a usable
>> shell. It is not good to break existing scripts, even if those
>> scripts are not strictly POSIX-compliant, and particularly so if the
>> scripts relied on designed behaviour. Such changes can waste a lot of
>> time.
>
> I agree with Jilles.  I don't think any change is required here.

That answers directly to the case sensitivity of signal names.  Is it
also the same answer about supporting the SIG* prefix?

Cheers.

-- 
Isaac Jurado

"The noblest pleasure is the joy of understanding"
Leonardo da Vinci
