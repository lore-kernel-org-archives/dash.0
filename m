From: Brian Koropoff <bkoropoff@gmail.com>
Subject: Fix for Solaris patch and new HP-UX patch
Date: Fri, 15 Apr 2011 19:30:10 -0700
Message-ID: <1302921010.2620.3.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:35389 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab1DPCaN (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 15 Apr 2011 22:30:13 -0400
Received: by pxi2 with SMTP id 2so1976362pxi.10
        for <dash@vger.kernel.org>; Fri, 15 Apr 2011 19:30:12 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I found an oversight with the patch that switches to PRIdMAX for
printing intmax_t.  The printf shell builtin actually programmatically
constructs format strings by inserting the 'j' length modifier.  I have
create a quick patch that makes it extract the length modifier from
PRIdMAX instead.  I'll also send a new version of the HP-UX port patch
rebased against this and the latest dash master.

Regards,
Brian Koropoff

