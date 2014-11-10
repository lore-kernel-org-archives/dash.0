From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: dash: details of redirection/duplication in manpage are reversed
Date: Mon, 10 Nov 2014 12:19:51 +0100
Message-ID: <20141110111951.GA4185@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:51612 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaKJLVY (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 06:21:24 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: control@bugs.debian.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

forwarded 501566 dash@vger.kernel.org
stop
-------------------------------------------------------

Hello,

Here is a small patch reported by a user of Debian [1]. Could you please
integrate? Thank you for your help.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=501566

Regards,

-- 
Stéphane Aulery

--IS0zKkzwUGydFO0o
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="dash.1.fix-redirection-docs.diff"

--- dash.1.old	2014-11-10 12:15:29.809398575 +0100
+++ dash.1.new	2014-11-10 12:17:03.401856125 +0100
@@ -402,11 +402,11 @@
 .It [n] Ns \*[Lt] file
 Redirect standard input (or n) from file.
 .It [n1] Ns \*[Lt]& Ns n2
-Duplicate standard input (or n1) from file descriptor n2.
+Duplicate standard input (or n1) to file descriptor n2.
 .It [n] Ns \*[Lt]&-
 Close standard input (or n).
 .It [n1] Ns \*[Gt]& Ns n2
-Duplicate standard output (or n1) to n2.
+Duplicate standard output (or n1) from n2.
 .It [n] Ns \*[Gt]&-
 Close standard output (or n).
 .It [n] Ns \*[Lt]\*[Gt] file

--IS0zKkzwUGydFO0o--
