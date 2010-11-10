From: =?KOI8-R?B?z8zYx8Egy9LZ1sHOz9fTy8HR?= <olga.kryzhanovska@gmail.com>
Subject: Re: static vs. dynamic scoping
Date: Wed, 10 Nov 2010 15:15:59 +0100
Message-ID: <AANLkTi=CURDu8AVnAsT4esOBi5-xw8th5ix501jX0fRJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34134 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab0KJOQB (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Nov 2010 09:16:01 -0500
Received: by yxt3 with SMTP id 3so359974yxt.19
        for <dash@vger.kernel.org>; Wed, 10 Nov 2010 06:16:00 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Eric Blake wrote:
> Or should dash switch entirely to static scoping (my gut feel is that
> static scoping may be more efficient to implement, which fits in line
> with dash's desire to be as lean as possible)?

static scoping is much more efficient. Think about accessing a global
variable in a deep function call stack, e.g. 20 functions deep. With
dynamic scoping you have to look up the list of local variables for
each function *first* before looking at the global variables. In my
example this means 20 look ups. Each further function adds another
look up.
For static scoping you just look at the local variables of the
*current* function and then look up the global ones. This is faster
and much more efficient.

Olga
-- 
      ,   _                                    _   ,
     { \/`o;====-    Olga Kryzhanovska   -====;o`\/ }
.----'-/`-/     olga.kryzhanovska@gmail.com   \-`\-'----.
 `'-..-| /       http://twitter.com/fleyta     \ |-..-'`
      /\/\     Solaris/BSD//C/C++ programmer   /\/\
      `--`                                      `--`
