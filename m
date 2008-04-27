From: Bill Maas <bill@stsx.org>
Subject: Re: Shell source with relative pathname does not work
Date: Sun, 27 Apr 2008 21:57:49 +0200
Message-ID: <1209326269.14798.4.camel@aurora.internal>
References: <1209282837.21826.6.camel@aurora.internal>
	 <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:3817 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbYD0T56 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 15:57:58 -0400
Received: from [192.168.1.6] (stsx.xs4all.nl [213.84.238.115])
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m3RJvo2a036131
	for <dash@vger.kernel.org>; Sun, 27 Apr 2008 21:57:55 +0200 (CEST)
	(envelope-from bill@stsx.org)
In-Reply-To: <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

Hi Oleg,

I'm very sorry, but I obviously missed a crucial point here: the shell
_searches_ the PATH for an executable file to be sourced. I'm still not
convinced about the need for (and security of) such a feature, however..

But it's a design choice, and I'll respect it. Just have to take care to
prepend relative pathnames from the commandline/config with a "./" in my
scripts.

I don't expect to be bothering you again with this one;)

Bill



