From: Alkis Georgopoulos <alkisg@gmail.com>
Subject: No wildcard expansion with redirected filenames
Date: Sat, 07 Aug 2010 22:34:21 +0300
Message-ID: <1281209661.6631.33.camel@alkis>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51580 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0HGTe1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 7 Aug 2010 15:34:27 -0400
Received: by fxm14 with SMTP id 14so4415985fxm.19
        for <dash@vger.kernel.org>; Sat, 07 Aug 2010 12:34:26 -0700 (PDT)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Isn't this supposed to work?

$ touch file1
$ echo 1 > file?
$ ls file? 
file?  file1

I.e. dash actually created a file named 'file?' instead of globbing.

Please CC me if possible, I'm not on the list.

Kind regards,
Alkis Georgopoulos

