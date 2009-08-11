From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: avoid compiler warning
Date: Tue, 11 Aug 2009 09:33:43 -0700
Message-ID: <4A819D67.7060301@zytor.com>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38962 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbZHKRgv (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 11 Aug 2009 13:36:51 -0400
In-Reply-To: <20090811040330.GE10700@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Blake <ebb9@byu.net>, dash@vger.kernel.org

On 08/10/2009 09:03 PM, Herbert Xu wrote:
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
> 
> So I think you should fix this in your libc instead.
> 

Herbert... the *type* is int, but the *value* has to be in the range
[-1,UCHAR_MAX] or the behavior is undefined in both the C and POSIX
standards.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

