From: Alexey Zinovyev <alzinovyev@gmail.com>
Subject: [PATCH] fix UTF-8 issues in read() builtin
Date: Wed, 8 Sep 2010 01:26:15 +0400
Message-ID: <20100907212615.GA28796@3arch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57735 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478Ab0IGVZZ (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 7 Sep 2010 17:25:25 -0400
Received: by ewy23 with SMTP id 23so2645430ewy.19
        for <dash@vger.kernel.org>; Tue, 07 Sep 2010 14:25:24 -0700 (PDT)
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, I think there is a bug in read() builtin.

$ cat test
echo 'ρ'|while read i; do echo $i; done
$ dash test

$ bash test
ρ

Same with some japanese symbols.
Looks like dash strips 0x81 byte. 

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dash-read-fix.patch"

diff --git a/src/miscbltin.c b/src/miscbltin.c
index 5ab1648..f8c5655 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -101,7 +101,6 @@ readcmd_handle_line(char *line, char **ap, size_t len)
 			 * will not modify the length of the string */
 			offset = sl->text - s;
 			remainder = backup + offset;
-			rmescapes(remainder);
 			setvar(*ap, remainder, 0);
 
 			return;

--bg08WKrSYDhXBjb5--
