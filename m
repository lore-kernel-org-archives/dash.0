From: "Rocky Bernstein" <rocky.bernstein@gmail.com>
Subject: LINENO and PS{1,2,4} ?
Date: Mon, 23 Jun 2008 15:29:36 -0400
Message-ID: <6cd6de210806231229x1b30d3f6yb65e989b11c6a95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:37331 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760652AbYFWT3i (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Jun 2008 15:29:38 -0400
Received: by yx-out-2324.google.com with SMTP id 31so433900yxl.1
        for <dash@vger.kernel.org>; Mon, 23 Jun 2008 12:29:37 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

I have been looking at dash recently and notice in the manual page:

BUGS: PS1, PS2, and PS4 should be subject to parameter expansion
before being displayed.

Also I notice that there isn't a builtin LINENO which POSIX suggests
(e.g. http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html)

I've been considering rectifying this. What's the protocol for
submitting a patch, and/or the likelihood this would get into a
release assuming the patch is reasonable.

Is there currently a schedule for the next release?

Thanks.
