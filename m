From: "Taylan Ulrich B." <taylanbayirli@gmail.com>
Subject: Password prompts
Date: Sun, 29 Aug 2010 15:51:54 +0200
Message-ID: <AANLkTikjqe9hmQD5YVRGXbnb+yLg0C77ZdocLa=C2UyD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45879 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0H2Nv4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 29 Aug 2010 09:51:56 -0400
Received: by wyb35 with SMTP id 35so5741074wyb.19
        for <dash@vger.kernel.org>; Sun, 29 Aug 2010 06:51:54 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash <dash@vger.kernel.org>

When a program disables the printing of entered characters (e.g. at a
password prompt), and the user hits ^C without submitting, printing
stays disabled permanently, even when you switch the shell.

For example enter "su someuser -s /bin/dash -c su" from bash, and hit
^C at the password prompt; bash will be affected.
