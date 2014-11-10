From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: Redirection: interval file descriptor (0-9)
Date: Mon, 10 Nov 2014 14:33:19 +0100
Message-ID: <20141110133319.GA5382@free.fr>
References: <20141110121200.GA4725@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:7131 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbaKJNe4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 08:34:56 -0500
Content-Disposition: inline
In-Reply-To: <20141110121200.GA4725@free.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: control@bugs.debian.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Here is a small patch reported by a user of Debian [1]. Could you please
integrate? Thank you for your help.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=646847

Regards,

-- 
Stéphane Aulery

--EeQfGwPcQSOJBaQU
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="dash.1.fix-redirection-file-descriptor.diff"

--- dash.1.old	2014-11-10 12:30:45.305874210 +0100
+++ dash.1.new	2014-11-10 13:08:26.996931055 +0100
@@ -385,7 +385,7 @@
 Following is a list of the possible redirections.
 The
 .Bq n
-is an optional number, as in
+is an optional number between 0 and 9, as in
 .Sq 3
 (not
 .Sq Bq 3 ) ,

--EeQfGwPcQSOJBaQU--
