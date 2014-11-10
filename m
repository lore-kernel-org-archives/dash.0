From: =?utf-8?B?U3TDqXBoYW5l?= Aulery <saulery@free.fr>
Subject: 'man dash' typo: "the shell .... proceed onto"
Date: Mon, 10 Nov 2014 12:20:45 +0100
Message-ID: <20141110112045.GB4185@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:53887 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaKJLWR (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 06:22:17 -0500
Received: from hubert (unknown [88.183.246.121])
	(Authenticated sender: saulery)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5357EA6347
	for <dash@vger.kernel.org>; Mon, 10 Nov 2014 12:20:00 +0100 (CET)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

Here is a small patch reported by a user of Debian [1]. Could you please
integrate? Thank you for your help.

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=576503

Regards,
 
-- 
Stéphane Aulery

--dTy3Mrz/UPE2dbVg
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="dash.1.typo.diff"

--- dash.1.old	2014-11-10 12:01:55.869419425 +0100
+++ dash.1.new	2014-11-10 12:06:24.458732491 +0100
@@ -596,7 +596,7 @@
 characters.
 The commands in a list are executed in the order they are written.
 If command is followed by an ampersand, the shell starts the
-command and immediately proceed onto the next command; otherwise it waits
+command and immediately proceeds onto the next command; otherwise it waits
 for the command to terminate before proceeding to the next one.
 .Ss Short-Circuit List Operators
 .Dq &&

--dTy3Mrz/UPE2dbVg--
