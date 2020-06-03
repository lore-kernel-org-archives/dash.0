From: Matt Whitlock <dash@mattwhitlock.name>
Subject: Bug when parsing redirection syntax error
Date: Wed, 03 Jun 2020 14:55:29 -0400
Message-ID: <1851e5f2-80f5-4bd6-9993-e23a0980bd1e@mattwhitlock.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCSz6 (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 3 Jun 2020 14:55:58 -0400
Received: from resqmta-ch2-08v.sys.comcast.net (resqmta-ch2-08v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1CEC08C5C0
        for <dash@vger.kernel.org>; Wed,  3 Jun 2020 11:55:58 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

$ cat <<<EOF
dash: 4: Syntax error: redirection unexpected
$ true
dash: 4: Etrue: not found

This is with Dash 0.5.11.

It looks like the first character after the unexpected redirection operator=20=

mistakenly gets retained in a buffer somewhere and interferes with the next=20=

command to be read.
