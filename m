From: Bosco <jbosco.gg@gmail.com>
Subject: echo "\\1"?
Date: Thu, 27 Jul 2017 12:23:09 +0000
Message-ID: <CAC4gepeczuKhmanuBqYybUTjvo6eNeZk6FyqHjOhx8n-qDfCSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:34767 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0MXa (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 27 Jul 2017 08:23:30 -0400
Received: by mail-qt0-f179.google.com with SMTP id s6so71516680qtc.1
        for <dash@vger.kernel.org>; Thu, 27 Jul 2017 05:23:30 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

According the man pages, for echo command, "\\" should print '\'
character, and \0digits should print the byte in octal base.
But the command

echo "\\1"

outputs the byte 0x01 in hexadecimal (or 001 in octal).
Is this a bad behavior or is intentional?

Bosco.
