From: Sylvain Bertrand <sylvain.bertrand@gmail.com>
Subject: POSIX compliant trap signal names
Date: Thu, 30 Oct 2014 16:23:50 +0100
Message-ID: <CAN5MFOrmT4U+A+4jS_NGybFjH1uw1HGoRbpa2megL_LshsTuGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34184 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365AbaJ3PXv (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 30 Oct 2014 11:23:51 -0400
Received: by mail-yk0-f182.google.com with SMTP id q200so2413296ykb.13
        for <dash@vger.kernel.org>; Thu, 30 Oct 2014 08:23:51 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hit the issue while compiling linux 3.16.3 with dash,
${linux-src}/scripts/link-vmlinux.sh line 114 .
The signal names for trap built-in must be prefixed with SIG to be
POSIX compliant. dash expect trap signal names without a SIG prefix.

regards,

-- 
Sylvain BERTRAND
