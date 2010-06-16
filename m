From: Brian Koropoff <bkoropoff@gmail.com>
Subject: DASH regression
Date: Tue, 15 Jun 2010 19:14:14 -0700
Message-ID: <1276654454.16819.24.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33133 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213Ab0FPCQG (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 15 Jun 2010 22:16:06 -0400
Received: by pva4 with SMTP id 4so437317pva.19
        for <dash@vger.kernel.org>; Tue, 15 Jun 2010 19:16:06 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,
    I encountered a regression in DASH from git while attempting to get
it working on Solaris.  I got it to build and run, but my scripts were
mysteriously failing.  I tracked it down to a logic bug in setvareq()
that caused it to assign through the wrong pointer when attempting to
remove a variable from its hash bucket.  The following test case
reproduces the bug for me:

--

#!/bin/dash
GDM_LANG="bar"
OPTION="foo"
unset GDM_LANG
# OPTION has mysteriously become unset
echo "$OPTION"

--

I'll follow up with a patch.

Regards,
Brian Koropoff

