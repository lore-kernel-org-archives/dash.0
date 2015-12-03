From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 3 Dec 2015 23:04:31 +0000
Message-ID: <20151203230431.GD9581@chaz.gmail.com>
References: <n3nrqu$mj2$1@ger.gmane.org>
 <5660ADD6.4020308@gigawatt.nl>
 <20151203211748.GC9581@chaz.gmail.com>
 <5660B78B.5000302@inlv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35474 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbLCXEe (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 3 Dec 2015 18:04:34 -0500
Received: by wmuu63 with SMTP id u63so41111877wmu.0
        for <dash@vger.kernel.org>; Thu, 03 Dec 2015 15:04:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5660B78B.5000302@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org

2015-12-03 22:43:39 +0100, Martijn Dekker:
> Stephane Chazelas schreef op 03-12-15 om 22:17:
> > It's meant to split into "a" and "b", not "a", "b" and "". As
> > ":" is meant to be treated as a *delimiter* or *terminator*.
> 
> That was my interpretation of the standard, too. So I reported this as a
> bug to author of yash, but he reads the standard differently and came up
> with a good argument for that. See:
> 
> https://osdn.jp/ticket/browse.php?group_id=3863&tid=35283#comment:3863:35283:1435293070
> 
> Summarising: POSIX states that "each occurrence in the input of an IFS
> character that is not IFS white space, along with any adjacent IFS white
> space, shall delimit a field". This *may* be interpreted to read that a
> final non-whitespace IFS character denotes an empty final field, because
> otherwise that final character wouldn't be delimiting any field, but
> only terminating one. It's pretty ambiguous, though.
[...]

I agree the spec is not very clear
http://thread.gmane.org/gmane.comp.shells.bash.bugs/4825
http://thread.gmane.org/gmane.comp.shells.bash.bugs/15768

But see this interpretation:
https://standards.ieee.org/findstds/interps/1003.1-2001/1003.1-2001-98.html

I can't find the austin-group discussions, but I'm pretty sure
I've seen several and Chet is refering to one from 2005 over
there.

-- 
Stephane
