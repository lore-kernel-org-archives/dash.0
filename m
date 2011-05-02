From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] [MAN] Remove spurious space in descriptions of PS1, PS2, PS4
Date: Mon, 2 May 2011 03:07:01 -0500
Message-ID: <20110502080648.GA16077@elie>
References: <87fwozqy21.fsf@Pulska.kon.iki.fi>
 <20110430220553.GB20433@elie>
 <87liyqpudv.fsf@Pulska.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39797 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1EBIHK (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 2 May 2011 04:07:10 -0400
Received: by iyb14 with SMTP id 14so4465150iyb.19
        for <dash@vger.kernel.org>; Mon, 02 May 2011 01:07:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87liyqpudv.fsf@Pulska.kon.iki.fi>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Kalle Olavi Niemitalo <kon@iki.fi>

From: Kalle Olavi Niemitalo <kon@iki.fi>

LANG=C man dash shows:

     PS1        The primary prompt string, which defaults to ``$  '', unless
                you are the superuser, in which case it defaults to ``#  ''.

     PS2        The secondary prompt string, which defaults to ``>  ''.

     PS4        Output before each line when execution trace (set -x) is
                enabled, defaults to ``+  ''.

Each of the documented default values has a graphic character and
two spaces between the quotation marks.  However, the actual
default values have only one space, rather than two.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Kalle Olavi Niemitalo wrote[1]:

> Here's the diff against 0.5.5.1-7.4.

Thanks.  Looking at the formatted output, I see some other extra
spaces (mostly around punctuation), but fixing these confusing ones
first doesn't sound like a bad idea.

[1] http://bugs.debian.org/624715

 src/dash.1 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index ddeb52b..3847d98 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2276,16 +2276,16 @@ setting.
 There is a maximum of 10 mailboxes that can be monitored at once.
 .It Ev PS1
 The primary prompt string, which defaults to
-.Dq $ \  ,
+.Dq $\  ,
 unless you are the superuser, in which case it defaults to
-.Dq # \  .
+.Dq #\  .
 .It Ev PS2
 The secondary prompt string, which defaults to
-.Dq \*[Gt] \  .
+.Dq \*[Gt]\  .
 .It Ev PS4
 Output before each line when execution trace (set -x) is enabled,
 defaults to
-.Dq + \  .
+.Dq +\  .
 .It Ev IFS
 Input Field Separators.
 This is normally set to
-- 
1.7.5

