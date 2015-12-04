From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: dash: read does not ignore trailing spaces
Date: Fri, 4 Dec 2015 00:00:35 +0000
Message-ID: <20151204000035.GC10853@chaz.gmail.com>
References: <n3nrqu$mj2$1@ger.gmane.org>
 <5660ADD6.4020308@gigawatt.nl>
 <20151203211748.GC9581@chaz.gmail.com>
 <5660B78B.5000302@inlv.org>
 <20151203230431.GD9581@chaz.gmail.com>
 <20151203231758.GB10853@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34564 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbLDAAi (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 Dec 2015 19:00:38 -0500
Received: by wmvv187 with SMTP id v187so51543561wmv.1
        for <dash@vger.kernel.org>; Thu, 03 Dec 2015 16:00:37 -0800 (PST)
Received: from chaz.gmail.com ([90.200.237.28])
        by smtp.gmail.com with ESMTPSA id 200sm1108696wmn.11.2015.12.03.16.00.36
        for <dash@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Dec 2015 16:00:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151203231758.GB10853@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2015-12-03 23:17:58 +0000, Stephane Chazelas:
> 2015-12-03 23:04:31 +0000, Stephane Chazelas:
> [...]
> > > Summarising: POSIX states that "each occurrence in the input of an IFS
> > > character that is not IFS white space, along with any adjacent IFS white
> > > space, shall delimit a field". This *may* be interpreted to read that a
> > > final non-whitespace IFS character denotes an empty final field, because
> > > otherwise that final character wouldn't be delimiting any field, but
> > > only terminating one. It's pretty ambiguous, though.
> > [...]
> > 
> > I agree the spec is not very clear
> > http://thread.gmane.org/gmane.comp.shells.bash.bugs/4825
> > http://thread.gmane.org/gmane.comp.shells.bash.bugs/15768
> > 
> > But see this interpretation:
> > https://standards.ieee.org/findstds/interps/1003.1-2001/1003.1-2001-98.html
> > 
> > I can't find the austin-group discussions, but I'm pretty sure
> > I've seen several and Chet is refering to one from 2005 over
> > there.
> [...]
> 
> See also:
> https://groups.google.com/forum/#!topic/comp.unix.shell/krZy2rvnv2g
> (Geoff is from the OpenGroup).
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=512438
> I actually was the one raising it for posh. I (and the posh
> maintainer apparently) failed to notice that it was applying to
> "read" there as well.
[...]

More:

http://thread.gmane.org/gmane.comp.shells.bash.bugs/9661/focus=9662

Where Chet (I think) refers to:
https://standards.ieee.org/findstds/interps/1003-2-92_int/pasc-1003.2-98.html

The 2005 Austin group discussion can be seen on the web archive:
http://web.archive.org/web/20050301075813/http://www.opengroup.org/austin/mailarchives/

One article there was forwarded to the zsh mailing list:
http://www.zsh.org/mla/workers/2005/msg00306.html
(but not acted upon)

Which leads to https://www.opengroup.org/austin/aardvark/latest/xcubug2.txt
confirming that
https://standards.ieee.org/findstds/interps/1003.1-2001/1003.1-2001-98.html
is contemporary and a follow-up of that 2005 discussion.

-- 
Stephane
