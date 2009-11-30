From: William Immendorf <will.immendorf@gmail.com>
Subject: Dash fails to compile on UTF-8 with the Coreutils i18n patch
Date: Sun, 29 Nov 2009 18:54:44 -0600
Message-ID: <62234dc60911291654k6a4fc375o131af7460db907e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dash-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:21265 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbZK3Ayi (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 29 Nov 2009 19:54:38 -0500
Received: by ey-out-2122.google.com with SMTP id 4so816781eyf.19
        for <dash@vger.kernel.org>; Sun, 29 Nov 2009 16:54:44 -0800 (PST)
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hello,

I think you might rember this madness if you were around the LFS/BLFS
lists and this list:

http://linuxfromscratch.org/pipermail/blfs-support/2009-August/065714.html
http://linuxfromscratch.org/pipermail/lfs-dev/2009-August/063125.html
http://www.mail-archive.com/dash@vger.kernel.org/msg00151.html

As of now, HEAD still fails with the exact same error!!!!!! The
solution: Change all LC_COLLATES to LC_CTYPES in mkbuiltins, and it
should work on the affected (Both LFS and Fedora), and on ones that
aren't affected. Please, can you dash that fix out for me?

-- 
William Immendorf
The ultimate in free computing.
Messages in plain text, please, no HTML.

--------------

"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman
