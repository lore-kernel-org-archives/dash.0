From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: static vs. dynamic scoping
Date: Wed, 10 Nov 2010 22:01:30 +0100
Message-ID: <20101110210130.GA17871@stack.nl>
References: <AANLkTi=CURDu8AVnAsT4esOBi5-xw8th5ix501jX0fRJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:61803 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756349Ab0KJVBc (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 10 Nov 2010 16:01:32 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=CURDu8AVnAsT4esOBi5-xw8th5ix501jX0fRJ@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: =?utf-8?B?0L7Qu9GM0LPQsCDQutGA0YvQttCw0L3QvtCy0YHQutCw0Y8=?= <olga.kryzhanovska@gmail.com>
Cc: dash@vger.kernel.org

On Wed, Nov 10, 2010 at 03:15:59PM +0100, =D0=BE=D0=BB=D1=8C=D0=B3=D0=B0=
 =D0=BA=D1=80=D1=8B=D0=B6=D0=B0=D0=BD=D0=BE=D0=B2=D1=81=D0=BA=D0=B0=D1=8F=
 wrote:
> Eric Blake wrote:
> > Or should dash switch entirely to static scoping (my gut feel is th=
at
> > static scoping may be more efficient to implement, which fits in li=
ne
> > with dash's desire to be as lean as possible)?

> static scoping is much more efficient. Think about accessing a global
> variable in a deep function call stack, e.g. 20 functions deep. With
> dynamic scoping you have to look up the list of local variables for
> each function *first* before looking at the global variables. In my
> example this means 20 look ups. Each further function adds another
> look up.
> For static scoping you just look at the local variables of the
> *current* function and then look up the global ones. This is faster
> and much more efficient.

That's not how dash implements it, though. The local builtin saves the
value and attributes of the variable and they are restored upon return.
There is just one table of variables to search (two in older versions
and other ash versions, the additional one storing variable assignments
for regular builtins like IFS=3D read x; these were converted to the lo=
cal
mechanism recently).

The real efficiency benefit of static scoping comes when disallowing
access to locals when the name is not known at compile time: at run
time, the names of the locals are not necessary.

--=20
Jilles Tjoelker
