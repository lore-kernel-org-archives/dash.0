From: Eric Blake <ebb9@byu.net>
Subject: Re: avoid compiler warning
Date: Tue, 11 Aug 2009 21:32:10 -0600
Message-ID: <4A8237BA.20701@byu.net>
References: <4A55E8BD.1090809@byu.net> <20090811040330.GE10700@gondor.apana.org.au> <4A819D67.7060301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:38100 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755452AbZHLDcI (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 11 Aug 2009 23:32:08 -0400
In-Reply-To: <4A819D67.7060301@zytor.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org

According to H. Peter Anvin on 8/11/2009 10:33 AM:
> Herbert... the *type* is int, but the *value* has to be in the range
> [-1,UCHAR_MAX] or the behavior is undefined in both the C and POSIX
> standards.

Actually, the *value* has to be either EOF (which is negative, but not
necessarily required to be -1) or [0,UCHAR_MAX].  But you are correct that
for most (all?) platforms, EOF is -1 even though it is not mandated as such.

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
