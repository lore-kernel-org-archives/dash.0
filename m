From: Ron Yorston <rmy@frippery.org>
Subject: Re: Bug in Dash's unquoting of backslashes within backquoted strings
Date: Thu, 21 May 2020 22:57:32 +0100
Message-ID: <5ec6f94c.cf6OsC6v8fwGBIKX%rmy@frippery.org>
References: <b2fe3536-23b8-4d04-8197-701ab50da86f@mattwhitlock.name>
 <5ec6f4d5.8pMzL3JNioCKa/Fi%rmy@frippery.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgEUV5c (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 21 May 2020 17:57:32 -0400
Received: from frippery.frippery.org (unknown [IPv6:2a00:1098:0:86:1000:33:7648:f18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B543BC061A0E
        for <dash@vger.kernel.org>; Thu, 21 May 2020 14:57:32 -0700 (PDT)
In-Reply-To: <5ec6f4d5.8pMzL3JNioCKa/Fi%rmy@frippery.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, dash@mattwhitlock.name

Ron Yorston wrote:
>This seems to have been introduced by commit 6bbc71d (parser: use
>pgetc_eatbnl() in more places).  Reverting the following part of the
>commit makes the problem go away:
>
>            case '\\':
>-                                if ((pc = pgetc()) == '\n') {
>-                   nlprompt();
>-                   /*
>-                    * If eating a newline, avoid putting
>-                    * the newline into the new character
>-                    * stream (via the STPUTC after the
>-                    * switch).
>-                    */
>-                   continue;
>-               }
>+                                pc = pgetc_eatbnl();

Alternatively I see that BusyBox ash did this:

            case '\\':
-               pc = pgetc();
-               if (pc == '\n') {
-                   nlprompt();
-                   /*
-                    * If eating a newline, avoid putting
-                    * the newline into the new character
-                    * stream (via the STPUTC after the
-                    * switch).
-                    */
-                   continue;
-               }
+               pc = pgetc(); /* or pgetc_eatbnl()? why (example)? */

Ron
