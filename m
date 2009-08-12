From: Eric Blake <ebb9@byu.net>
Subject: Re: avoid compiler warning
Date: Tue, 11 Aug 2009 21:19:40 -0600
Message-ID: <4A8234CC.8020007@byu.net>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au> <4A819D67.7060301@zytor.com> <20090811215615.GA31592@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:49874
	"EHLO QMTA12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755612AbZHLDTj (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 11 Aug 2009 23:19:39 -0400
In-Reply-To: <20090811215615.GA31592@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, dash@vger.kernel.org

According to Herbert Xu on 8/11/2009 3:56 PM:
> On Tue, Aug 11, 2009 at 09:33:43AM -0700, H. Peter Anvin wrote:
>> Herbert... the *type* is int, but the *value* has to be in the range
>> [-1,UCHAR_MAX] or the behavior is undefined in both the C and POSIX
>> standards.
> 
> Good point.  I'll apply the patch.  I'd be very surprised though
> if this was the only instance in which we pass a char along.

I would be surprised, too, but this was the only instance that triggered a
-Wall warning from gcc for my libc (more details in another mail, as
requested), so all other use of ctype is either through unsigned char or
int, rather than straight char.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
