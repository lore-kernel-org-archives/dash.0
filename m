From: "G.raud" <graud@gmx.com>
Subject: [BUG] ignored substring parameter expansion after $@ ("$@""${v%/*}")
 command line)
Date: Tue, 26 Sep 2017 05:39:59 +0200
Message-ID: <20170926033942.z4m5jglztiqjxzda@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56689 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933685AbdIZDkP (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 25 Sep 2017 23:40:15 -0400
Received: from gmx.com ([171.25.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MLunc-1dzzZh2HKG-007maH for
 <dash@vger.kernel.org>; Tue, 26 Sep 2017 05:40:13 +0200
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

To test that the param susbtitution in "$@""${v%*/}" is ignored (on a
command line or in an assignment):

$ dash -c 'v=1/2; w="$@""${v#*/}"; echo "$@""${v#*/}" "$w"'

Note that the quoting has to be around each variable, that the first has
to be $@ and that the bug occurs with %, %%, #, or ## substring
processing.

Adding a string in between the 2 required vars does not change the
behaviour:

$ dash -c 'v=1/2; echo "$@"s$u"s${v#*/}"'

except by adding a string, even empty, inside the quoting of $@:

$ dash -c 'v=1/2; echo "$a$@""${v#*/}"'

Regards

-- 
G.raud Meyer
graud@gmx.com
