From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: dash.1 - Confusion between two pages c[h]sh
Date: Mon, 10 Nov 2014 12:35:00 +0100
Message-ID: <20141110113500.GA4401@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:27382 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837AbaKJLgg (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 06:36:36 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: control@bugs.debian.org


--M9NhX3UHpAaciwkO
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

--M9NhX3UHpAaciwkO
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="dash.1.fix-chsh.diff"

--- dash.1.old	2014-11-10 12:30:45.305874210 +0100
+++ dash.1.new	2014-11-10 12:31:10.873999206 +0100
@@ -2322,7 +2322,7 @@
 .Pa /etc/profile
 .El
 .Sh SEE ALSO
-.Xr csh 1 ,
+.Xr chsh 1 ,
 .Xr echo 1 ,
 .Xr getopt 1 ,
 .Xr ksh 1 ,

--M9NhX3UHpAaciwkO--
