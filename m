From: Rink Springer <rink@rink.nu>
Subject: [PATCH] Remove dependency on fmatch.h if it does not exit
Date: Fri, 2 Feb 2018 08:43:15 +0100
Message-ID: <20180202074315.GC1669@rink.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.zhmu.nl ([37.247.37.64]:33440 "EHLO mail.zhmu.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750871AbeBBHt2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 2 Feb 2018 02:49:28 -0500
Received: from mail.zhmu.nl (mail.zhmu.nl [37.247.37.64])
        by mail.zhmu.nl (Postfix) with ESMTP id D7919640C
        for <dash@vger.kernel.org>; Fri,  2 Feb 2018 08:43:17 +0100 (CET)
Received: from mail.zhmu.nl ([37.247.37.64])
        by mail.zhmu.nl (anathema.codehulu.net [37.247.37.64]) (amavisd-new, port 10024)
        with ESMTP id 75yJPNAa3qeS for <dash@vger.kernel.org>;
        Fri,  2 Feb 2018 08:43:15 +0100 (CET)
Received: from gloom.zhmu.nl (mail.zhmu.nl [37.247.37.64])
        by mail.zhmu.nl (Postfix) with ESMTP id A7BF36405
        for <dash@vger.kernel.org>; Fri,  2 Feb 2018 08:43:15 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Dear all,

Attached is a trivial patch that removes the assumption that fnmatch.h
is available - the configure script already checks for fnmatch(3) and
supplies its own implementation if necessary, but fnmatch.h is always
included.

Let me know what you think.

Regards,
Rink

