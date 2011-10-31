From: Stephane CHAZELAS <stephane_chazelas@yahoo.fr>
Subject: Re: [PATCH] echo: fix octal escaping with \1...\7
Date: Mon, 31 Oct 2011 14:56:33 +0000 (UTC)
Message-ID: <slrnjatdp1.p2m.stephane.chazelas@spam.is.invalid>
References: <20111031034146.GA19477@gondor.apana.org.au>
 <201110310023.45138.vapier@gentoo.org> <4EAE9ECB.4040607@redhat.com>
 <ACAAFE20-00AB-46BC-BEE4-3BFAA1F0141A@aim.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:44515 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932712Ab1JaO4v (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 31 Oct 2011 10:56:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1RKtI8-0002D0-I5
	for dash@vger.kernel.org; Mon, 31 Oct 2011 15:56:48 +0100
Received: from 188-223-3-27.zone14.bethere.co.uk ([188.223.3.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 31 Oct 2011 15:56:48 +0100
Received: from stephane_chazelas by 188-223-3-27.zone14.bethere.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Mon, 31 Oct 2011 15:56:48 +0100
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2011-10-31, 07:35(-06), Paul Gilmartin:
> On Oct 31, 2011, at 07:12, Eric Blake wrote:
>
>> [adding bug-libtool]
>>  
> [removing, because I'm not registered.]
>
>> On 10/30/2011 10:23 PM, Mike Frysinger wrote:
>>> On Sunday 30 October 2011 23:41:58 Herbert Xu wrote:
>>>> Mike Frysinger wrote:
>>>>> POSIX states that octal escape sequences should take the form \0num
>>>>> when using echo.  dash however additionally treats \num as an octal
>>>>> sequence.  This breaks some packages (like libtool) who attempt to
>>>>> use strings with these escape sequences via variables to execute sed
>>>>> (since sed ends up getting passed a byte instead of a literal \1).
>>  
>> That's a bug in libtool for using "echo '\1'" and expecting sane behavior.  Can you provide more details on this libtool bug, so we can get it fixed in libtool?  Or perhaps it has already been fixed in modern libtool, and you are just encountering it in an older version?
>>  
> Yes, there's value in coding defensively.  However:
>
> I used to know a statement in POSIX that builtins should behave
> identically to the executables in /bin (or perhaps /usr/bin)
> except for performance.  So, testing with dash on Ubuntu:
[...]

This can only reasonably be done on systems where the shell and
utilities are maintained by the same persons. On my system,
/bin/echo '\FS' starts a flight simulator. Should I ask dash to
implement that same flight simulator?

See also GNU test that doesn't behave the same as GNU bash's
"test" (test a \< b for instance).

-- 
Stephane

