From: Bill Maas <bill@stsx.org>
Subject: Re: Shell source with relative pathname does not work
Date: Sun, 27 Apr 2008 21:41:34 +0200
Message-ID: <1209325294.14630.15.camel@aurora.internal>
References: <1209282837.21826.6.camel@aurora.internal>
	 <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:2211 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbYD0Tlh (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 27 Apr 2008 15:41:37 -0400
Received: from [192.168.1.6] (stsx.xs4all.nl [213.84.238.115])
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m3RJfYkO037510
	for <dash@vger.kernel.org>; Sun, 27 Apr 2008 21:41:35 +0200 (CEST)
	(envelope-from bill@stsx.org)
In-Reply-To: <slrng18mf9.pr0.!gmane?olecom.ENOMSG@flower.upol.cz>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

Hello Oleg,

thanks for your reply.

On Sun, 2008-04-27 at 13:54 +0200, Oleg Verych wrote:

> http://www.opengroup.org/onlinepubs/009695399/utilities/dot.html
> 
> So, behavior must be as for ordinary binaries -- searching PATH and
> not current dir. by default. IMHO quite good decision -- care where
> you are, and what you are executing.

. file           fails
. path/to/file   succeeds (note the missing leading /)

> `bash` seem to do searching in `.', but this must be its feature.

So in the second case, dash must be doing the same as bash. I think that
from the point of security, failing in the first case and not in the
second is a bit odd. The safe criterium should be "starts with a slash
or a dot" (not: contains a slash).

But since the sourcing program has either already been checked for exec
bit and leading [./] or presence in PATH or has been started as "sh
file", any limitation is probably overdone. And whether performed from a
script or from the commandline, it's just another case of "[builtin]
command arg".

The PATH thing applies to executables which are to be run with no
executing command (such as "sh"), hence the search path is limited.
Sourced files do not run on their own (so to speak), so PATH does not
apply here. Sourcing scripts should be trusted to know what they want,
no need to think for them.

IMHO;) Hope I'm being a bit clear.

Thanks,

Bill

