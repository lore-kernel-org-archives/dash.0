From: =?UTF-8?B?UGV0ciBTa2/EjcOtaw==?= <pskocik@gmail.com>
Subject: Greater resolution in test -nt / test -ot
Date: Thu, 22 Jun 2017 10:30:02 +0200
Message-ID: <9903b02c-041f-38b6-e510-06b9f8744fbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33885 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFVIaD (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 22 Jun 2017 04:30:03 -0400
Received: by mail-lf0-f68.google.com with SMTP id l200so1190372lfg.1
        for <dash@vger.kernel.org>; Thu, 22 Jun 2017 01:30:02 -0700 (PDT)
Received: from [10.10.0.2] (147.213.broadband18.iol.cz. [109.81.213.147])
        by smtp.googlemail.com with ESMTPSA id r28sm558845edd.33.2017.06.22.01.30.00
        for <dash@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 01:30:00 -0700 (PDT)
Content-Language: en-US
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi,

would you be willing to pull something like this?

diff --git a/src/bltin/test.c b/src/bltin/test.c
index 58c05fe..7ea02f2 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -478,7 +478,9 @@ newerf (const char *f1, const char *f2)

 	return (stat (f1, &b1) == 0 &&
 		stat (f2, &b2) == 0 &&
-		b1.st_mtime > b2.st_mtime);
+		( b1.st_mtim.tv_sec > b2.st_mtim.tv_sec ||
+		 (b1.st_mtim.tv_sec == b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec >
b2.st_mtim.tv_nsec )))
+	);
 }

 static int
@@ -488,7 +490,9 @@ olderf (const char *f1, const char *f2)

 	return (stat (f1, &b1) == 0 &&
 		stat (f2, &b2) == 0 &&
-		b1.st_mtime < b2.st_mtime);
+		(b1.st_mtim.tv_sec < b2.st_mtim.tv_sec ||
+		 (b1.st_mtim.tv_sec == b2.st_mtim.tv_sec && (b1.st_mtim.tv_nsec <
b2.st_mtim.tv_nsec )))
+	);
 }

 static int

I could use greater resolution in `test -nt` / `test -ot`, and st_mtim
field is standardized under POSIX.1-2008 (or so stat(2) says).

Best Regards,
Petr Skocik
