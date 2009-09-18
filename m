From: Eric Blake <ebb9@byu.net>
Subject: Re: bugs in cd
Date: Thu, 17 Sep 2009 18:03:23 -0600
Message-ID: <4AB2CE4B.5070104@byu.net>
References: <loom.20090714T212706-910@post.gmane.org> <20090831121822.GC7311@gondor.apana.org.au> <4A9BC0BF.30608@byu.net> <20090831125653.GA8262@gondor.apana.org.au> <loom.20090831T160451-196@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:58172
	"EHLO QMTA12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbZIRADM (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 17 Sep 2009 20:03:12 -0400
In-Reply-To: <loom.20090831T160451-196@post.gmane.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

According to Eric Blake on 8/31/2009 8:08 AM:
> Herbert Xu <herbert <at> gondor.apana.org.au> writes:
> 
>>> In other words, if CDPATH is "/", then you should not append any
>>> additional <slash> characters, such that you end up checking for the
>>> existence of "/foo", not "//foo".
>> Fair enough.  However, I noticed that they haven't fixed up PATH
>> to do the same thing.

>> Since we use the same function for PATH and CDPATH, I'm not going
>> to make any changes until POSIX becomes consistent in this respect.

> Fair enough; I'll keep you posted when the Austin group rules on my report.
> http://austingroupbugs.net/view.php?id=139

The Austin Group has now made their ruling; there is a 30 day clock before
the interpretation becomes official, but consensus will probably be
granted to the proposed wording:

> Interpretation response
> ------------------------
> The standard states the requirements for PATH
> and conforming implementations must conform to this. However, concerns
> have been raised about this which are being referred to the sponsor."
> 
> Rationale:
> -------------
> This is for consistency with the previous change to CDPATH made in interpretation 1003.1-2001 #199
> https://www.opengroup.org/austin/interps/uploads/40/15188/AI-199.txt [^]
> 
> 
> Notes to the Editor (not part of this interpretation):
> -------------------------------------------------------

> At line 5674, replace the sentence:
> 
> When a nonzero-length prefix is applied to this filename, a <slash> shall be inserted between the prefix and the filename.
> 
> with:
> 
> When a nonzero-length prefix is applied to this filename, a <slash> shall be inserted between the prefix and the filename if the prefix did not end in <slash>.


-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
