From: Eric Blake <ebb9@byu.net>
Subject: Re: bugs in cd
Date: Mon, 31 Aug 2009 06:23:27 -0600
Message-ID: <4A9BC0BF.30608@byu.net>
References: <loom.20090714T212706-910@post.gmane.org> <20090831121822.GC7311@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:52305 "EHLO
	QMTA06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752401AbZHaMXM (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 31 Aug 2009 08:23:12 -0400
In-Reply-To: <20090831121822.GC7311@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

According to Herbert Xu on 8/31/2009 6:18 AM:
> On Tue, Jul 14, 2009 at 09:39:03PM +0000, Eric Blake wrote:
>> Furthermore, POSIX requires that if the element in CDPATH ends in slash, that 
>> no additional slashes are added while forming the candidate curpath.  In light 
>> of the fact that //home need not be the same directory as /home (and indeed, on 
>> cygwin, they are distinct entities), this is also a bug:
> 
> Can you quote where POSIX says this?

Which version of POSIX are you looking at?  POSIX 2008 added quite a few
clarifications about the handling of // that were not listed in POSIX 2001.

http://www.opengroup.org/onlinepubs/9699919799/utilities/cd.html

"5. Starting with the first pathname in the <colon>-separated pathnames of
CDPATH (see the ENVIRONMENT VARIABLES section) if the pathname is
non-null, test if the concatenation of that pathname, a <slash> character
if that pathname did not end with a <slash> character, and the directory
operand names a directory."...

In other words, if CDPATH is "/", then you should not append any
additional <slash> characters, such that you end up checking for the
existence of "/foo", not "//foo".

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
