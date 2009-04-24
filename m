From: "Larson, Timothy E." <TELarson@west.com>
Subject: RE: Solaris
Date: Fri, 24 Apr 2009 09:03:11 -0500
Message-ID: <226316B3E1F749498E28ACA66321D5BA14CBE7BC@oma00cexmbx03.corp.westworlds.com>
References: <CB5348B152BEC84F9FE88EA7DBB2CD6505AA429E@OMAEXMB02.corp.westworlds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from mail144.messagelabs.com ([216.82.254.51]:34877 "EHLO
	mail144.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757024AbZDXODO convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 24 Apr 2009 10:03:14 -0400
Received: from oma100exbh01.corp.westworlds.com (oma-inet-pub2 [216.57.102.249])
	by linux512.wic.west.com (8.13.1/8.13.1) with ESMTP id n3OE3Cni006783
	for <dash@vger.kernel.org>; Fri, 24 Apr 2009 10:03:13 -0400
In-Reply-To: <CB5348B152BEC84F9FE88EA7DBB2CD6505AA429E@OMAEXMB02.corp.westworlds.com>
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: "dash@vger.kernel.org" <dash@vger.kernel.org>

(My apologies if you receive this as a duplicate.  I got a strange error when sending.)

> I cannot get dash 0.5.4 to build on Solaris.  I've made a couple small
> patches that may be a step in the right direction.

These patches were not committed, so I am now working on 0.5.5.1 and
carrying them forward.  In addition to the two mentioned, there are an
additional 10 (or so) patches needed.  Mostly issues that seemed to be
related to C99 compliance: Solaris 9 doesn't have stdint.h, isblank()
function, etc.

If someone would care to review them, I'll drop them on my server.

Thanks,
Tim

--
      Tim Larson        AMT2 Unix Systems Administrator
          InterCall, a division of West Corporation

Be always sure you are right, then go ahead. - David Crockett

