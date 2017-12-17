From: "G.raud" <graud@gmx.com>
Subject: Please document the peculiar $ENV processing
Date: Sun, 17 Dec 2017 19:00:34 +0100
Message-ID: <20171217175910.42kia52d2pfbklyi@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:49482 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752393AbdLQSBI (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 17 Dec 2017 13:01:08 -0500
Received: from gmx.com ([164.132.51.91]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lt2BW-1fABam3vbe-012ayC for
 <dash@vger.kernel.org>; Sun, 17 Dec 2017 19:01:06 +0100
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The processing of the $ENV variable is not at all mentioned in the
manpage.  POSIX only requires that parameter substitution is applied to
it.

In fact in dash the value of $ENV is subject to parameter and command
substitutions and to arithmetic expansion.  This should be documented,
as this behaviour is more complex that what POSIX requires and is
different from other shells: ksh93 and pdksh/mksh additionally subject
it to tilde expansion.

Here is a proposed text change of one sentence:

 If the environment variable ENV is set on entry to an interactive shell,
 or is set in the .profile of a login shell, the shell next reads
-commands from the file named in ENV.
+commands from the file named by ENV after subjecting its value to
+parameter expansion, command substitution and arithmetic expansion.

Regards,

--
G.raud Meyer
graud@gmx.com
