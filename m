From: Brian Koropoff <bkoropoff@gmail.com>
Subject: Portability patches
Date: Tue, 18 Jan 2011 21:07:16 -0800
Message-ID: <1295413636.4278.28.camel@gemini>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53777 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab1ASFHT (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 19 Jan 2011 00:07:19 -0500
Received: by iyj18 with SMTP id 18so403168iyj.19
        for <dash@vger.kernel.org>; Tue, 18 Jan 2011 21:07:18 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

I've been working on a new build system (yeah, I know, *another* one)
that aims to be highly portable to various POSIX systems and light on
dependencies (in the spirit of autotools, though substantially less
insane).  Pure POSIX sh turned out to be robust enough for my project,
but the various UNIX systems I've ported it to lack anything with dash's
raw speed.  Naturally, I just ported dash to them as well.

Patch stack incoming.  I expect some of these might need further
explanation or revision before being accepted.

Regards,
Brian Koropoff

