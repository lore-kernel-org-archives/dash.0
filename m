From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 3 Dec 2015 23:17:58 +0000
Message-ID: <20151203231758.GB10853@chaz.gmail.com>
References: <n3nrqu$mj2$1@ger.gmane.org>
 <5660ADD6.4020308@gigawatt.nl>
 <20151203211748.GC9581@chaz.gmail.com>
 <5660B78B.5000302@inlv.org>
 <20151203230431.GD9581@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56503 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbbLCXU0 (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 Dec 2015 18:20:26 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsd-dash@m.gmane.org>)
	id 1a4dAh-0004Mx-PM
	for dash@vger.kernel.org; Fri, 04 Dec 2015 00:20:19 +0100
Received: from 90.200.237.28 ([90.200.237.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 04 Dec 2015 00:20:19 +0100
Received: from stephane.chazelas by 90.200.237.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <dash@vger.kernel.org>; Fri, 04 Dec 2015 00:20:19 +0100
Content-Disposition: inline
In-Reply-To: <20151203230431.GD9581@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2015-12-03 23:04:31 +0000, Stephane Chazelas:
[...]
> > Summarising: POSIX states that "each occurrence in the input of an IFS
> > character that is not IFS white space, along with any adjacent IFS white
> > space, shall delimit a field". This *may* be interpreted to read that a
> > final non-whitespace IFS character denotes an empty final field, because
> > otherwise that final character wouldn't be delimiting any field, but
> > only terminating one. It's pretty ambiguous, though.
> [...]
> 
> I agree the spec is not very clear
> http://thread.gmane.org/gmane.comp.shells.bash.bugs/4825
> http://thread.gmane.org/gmane.comp.shells.bash.bugs/15768
> 
> But see this interpretation:
> https://standards.ieee.org/findstds/interps/1003.1-2001/1003.1-2001-98.html
> 
> I can't find the austin-group discussions, but I'm pretty sure
> I've seen several and Chet is refering to one from 2005 over
> there.
[...]

See also:
https://groups.google.com/forum/#!topic/comp.unix.shell/krZy2rvnv2g
(Geoff is from the OpenGroup).

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=512438
I actually was the one raising it for posh. I (and the posh
maintainer apparently) failed to notice that it was applying to
"read" there as well.

-- 
Stephane

