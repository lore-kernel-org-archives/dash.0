From: Olof Johansson <olof@ethup.se>
Subject: Parameter expansion, patterns and fnmatch
Date: Tue, 9 Aug 2016 11:28:32 +0200
Message-ID: <20160809092832.GB23983@brutus.ethup.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from brutus.ethup.se ([85.17.45.102]:55667 "EHLO brutus.ethup.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbcHIJe7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 9 Aug 2016 05:34:59 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I'm seeing some discrepancies between dash built with --enable-fnmatch
and dash built without that got me curious. Maybe you could help shed
some light?

 foo='[abc]'
 echo ${foo#[}
 echo ${foo#\[}

With dash built with --enable-fnmatch:

 abc]
 abc]

With dash built without --enable-fnmatch:

 [abc]
 abc]

I was able to reproduce this behavior on latest git master
(17a5f24e0). The dash manual states:

> The end of the character class is indicated by a ]; if the ] is
> missing then the [ matches a [ rather than introducing a character
> class.

Which to me suggests that the non-fnmatch case is not the expected
behavior. Is this interpretation correct?

Thanks,
-- 
Olof Johansson                            https://github.com/olof
