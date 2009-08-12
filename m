From: Eric Blake <ebb9@byu.net>
Subject: Re: avoid compiler warning
Date: Tue, 11 Aug 2009 21:30:08 -0600
Message-ID: <4A823740.1010604@byu.net>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta13.emeryville.ca.mail.comcast.net ([76.96.27.243]:60469
	"EHLO QMTA13.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755436AbZHLDgG (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 11 Aug 2009 23:36:06 -0400
In-Reply-To: <20090811040330.GE10700@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

According to Herbert Xu on 8/10/2009 10:03 PM:
> On Thu, Jul 09, 2009 at 12:55:25PM +0000, Eric Blake wrote:
>> ccache gcc -DHAVE_CONFIG_H -I. -I..  -include ../config.h -DBSD=1 -DSHELL
>> -DIFS_BROKEN  -Wall -gdwarf-2 -Wall -Werror -MT mystring.o -MD -MP -MF
>> .deps/mystring.Tpo -c -o mystring.o mystring.c
>> miscbltin.c: In function `umaskcmd':
>> miscbltin.c:201: warning: subscript has type `char'
>>
>> isdigit is only defined over EOF and unsigned char values, so without this
>> patch, you can trigger undefined behavior.
> 
> What compiler and what libc was this? isdigit is supposed to
> be a function that takes an int argument according to POSIX.
> If libc implements it as a macro then it's up to it to cast
> the parameter to (int).

This is with recent newlib (the warning was intentionally added exactly to
catch the sort of bugs that my patch fixes), coupled with any version of
gcc 3.4 or newer.  Additionally, there is a pending bug report against
glibc requesting that glibc add the same QoI warning to flag potentially
buggy code, since it is quite easy to flag the use of raw char as a bug:
http://sources.redhat.com/bugzilla/show_bug.cgi?id=10296

In a particular demonstration of the bug, there are some locales where
isspace('\xff') is false but isspace((unsigned char)'\xff') [aka
isspace(0xff)] is true, when char is a signed type.  And although both
glibc and newlib cater to most instances of this bug (as a QoI
enhancement, these libraries guarantee that isspace('\xfe') [aka
isspace(-2)] returns the same result as isspace(0xfe)), not all platforms
have this QoI support, and can actually end up dereferencing outside of
array bounds.

Note that isdigit is a bit unique among the ctype macros: C89 and C99
state that it is locale dependent (with a range still limited to EOF or
[0-UCHAR_MAX]), but POSIX adds the additional restriction that it only
return true for the ten contiguous characters '0' through '9', meaning
that any POSIX-compliant version of isdigit(x) can be as simple as
((unsigned)(x)-'0'<=9) for all x, without regards to locale or
out-of-range arguments.  But not all locales comply with POSIX, so it is
not generally portable to rely on isdigit being this simple or fast.  On
the other hand, there are a number of packages that #define ISDIGIT,
rather than use ctype's isdigit, exactly to get the speedup guaranteed by
POSIX; this may be something you want to do in dash.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
