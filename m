From: Szabolcs Nagy <nsz@port70.net>
Subject: build issues when using pcc
Date: Sun, 22 May 2011 14:34:14 +0200
Message-ID: <20110522123414.GD6142@port70.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from morecp.net ([79.172.201.187]:46128 "EHLO port70.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab1EVMnr (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 22 May 2011 08:43:47 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

hello i compiled dash with pcc and found two issues:

src/output.h the outc macro is not standard c:
#define outc(c, file)<->((file)->nextc == (file)->end ? outcslow((c), (file)) : (*(file)->nextc = (c), (file)->nextc++))

type signature of the operands are int ? void : char*
but the two sides of : should be compatible
either use
    ... ? outcslow(), 0 : ...
or
    ... ? outcslow() : ..., (void)0
otherwise a standard compliant compiler won't compile it


the other issue is in the mkbuiltins:
it assumes that the cpp does not produce empty lines with
whitespace only
the following line
< $builtins sed '/^#/d; /^$/d' > $temp
should be
< $builtins sed '/^#/d; /^ *$/d' > $temp

so empty lines with spaces are dropped as well
(allowed by the standard after the preprocessing pass)


(also it would be nice to include a configure script in
the git repo, or don't use autoconf in the first place)
