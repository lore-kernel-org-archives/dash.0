From: Larry Hynes <larry@larryhynes.com>
Subject: Small cleanup to src/dash.1 - Command Line Editing
Date: Sat, 17 Jun 2017 15:53:26 +0100
Message-ID: <6csf1e-9n5.ln1@sabon.larryhynes.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:53966 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdFQOzP (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 17 Jun 2017 10:55:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcsd-dash@m.gmane.org>)
        id 1dMF7y-0004w6-GH
        for dash@vger.kernel.org; Sat, 17 Jun 2017 16:55:06 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi

src/dash.1, under Command Line Editing, states:

	It's similar to vi: typing <ESC> will throw you into command
	VI command mode.

- There appears to be no need for both occurrences of 'command'
- I can't see a reason for VI to be capitalised
- 'will throw you into' seems a little... enthusiastic

Following diff changes it to

	It's similar to vi: typing <ESC> enters vi command mode.

diff --git a/src/dash.1 b/src/dash.1
index 8b8026d..f35d89d 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2232,7 +2232,7 @@ enabled, sh can be switched between insert mode and command mode.
 The editor is not described in full here, but will be in a later document.
 It's similar to vi: typing
 .Aq ESC
-will throw you into command VI command mode.
+enters vi command mode.
 Hitting
 .Aq return
 while in command mode will pass the line to the shell.

