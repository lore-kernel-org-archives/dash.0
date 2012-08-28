From: Todor Vlaev <t.vlaev@gmail.com>
Subject: [EXPAND] Nested parameter expansion results in an empty string when quoted
Date: Tue, 28 Aug 2012 16:27:24 +0300
Message-ID: <CAAv6kGS+Cgg2JmRqCeWNZtxpoUuJ0wBSLac0BJJGW8kuiqUgwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54233 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab2H1N1q (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Aug 2012 09:27:46 -0400
Received: by qcro28 with SMTP id o28so3344937qcr.19
        for <dash@vger.kernel.org>; Tue, 28 Aug 2012 06:27:44 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

While playing around with parameter expansion I noticed that the
following didn't work in dash  (dash 0.5.5.1-7.4ubuntu1) as compared
to bash even though I believe it should be POSIX-compliant:

my_str=swan; last_char="${my_str#${my_str%?}}"; echo ${last_char}

If the double quotes are removed, the last character is printed correctly.

At a quick glance through the commits after the 0.5.5.1 release I saw
the following bug fix. Could it be related?

0d7d66039b614b642c775432fd64aa8c11f9a64d
[EXPAND] Fix quoted pattern patch breakage

Thanks,
Todor
