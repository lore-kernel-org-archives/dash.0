From: Oleg Verych <olecom@gmail.com>
Subject: Re: Parameter expansion fails when assigning a local variable
Date: Wed, 1 Jul 2009 10:42:01 +0300
Message-ID: <8499950a0907010042l6a9bb4das1c32f4e5c97e5dc@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC73AEC8A9FE8@xmail3.se.axis.com>
	 <20090622085729.GA22431@gondor.apana.org.au>
	 <0906282220250.1491@somehost>
	 <20090629004750.GA2019@gondor.apana.org.au>
	 <0906291823520.16266@somehost>
	 <20090630013807.GA13339@gondor.apana.org.au>
	 <0906301817190.14361@somehost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:63655 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZGAHl7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 1 Jul 2009 03:41:59 -0400
Received: by fxm18 with SMTP id 18so609587fxm.37
        for <dash@vger.kernel.org>; Wed, 01 Jul 2009 00:42:01 -0700 (PDT)
In-Reply-To: <0906301817190.14361@somehost>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>, Jesper Bengtsson <jesper.bengtsson@axis.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

Hallo.

2009/6/30, Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>:
[...]
> Sure I will.  But that won't make the misfeature go away :(
>
> And, by the way, I think the bug should probably be classified as a design
> flaw and a security bug.  Reason is it has undesired side effects which
> may lead to overwriting unrelated local variables and may have other
> serious implications.

Before you, guys, write such things, you'd better read something heavy
about /bin/shELL.

Please:

UNIX SHELL Quote Tutorial
Written by Bruce Barnett
http://www.grymoire.com/Unix/Quote.html

Sh - the Bourne Shell
http://www.grymoire.com/Unix/Sh.html

Thanks.
-- 
sed 'sed && sh + olecom = love'  <<  ''
-o--=O`C
 #oo'L O
<___=E M
