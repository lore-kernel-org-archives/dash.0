From: "G.raud" <graud@gmx.com>
Subject: [BUG] quoted substring parameter expansion ignores single-quotes in
 the arg
Date: Tue, 26 Sep 2017 05:41:48 +0200
Message-ID: <20170926034148.ohemy3jubd2nskyj@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:50681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966548AbdIZDl6 (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 25 Sep 2017 23:41:58 -0400
Received: from gmx.com ([171.25.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LaG7C-1dVcsc39Ze-00m5WO for
 <dash@vger.kernel.org>; Tue, 26 Sep 2017 05:41:56 +0200
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

To test that the single quotes are considered ordinary chars when
double-quoting the parameter expansion:

$ dash -c "a=\\'a\\'; echo \"\${a%'}\""

The result is surprising and non consistent with a non double-quoted
expansion where the single-quotes act as quotes:

$ dash -c "a=a%; echo \${a%'%'}"

Additionally the manual states that the arg to substring processing is
processed as an ordinary word (as probably POSIX too).

Regards

-- 
G.raud Meyer
graud@gmx.com
