From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] [BUILTIN] Require leading '0' on octal escapes in echo
Date: Sat,  1 Nov 2014 17:14:06 +0000
Message-ID: <53785239c041de620223d4a7beba523e1627b65a.1414861984.git.john@keeping.me.uk>
Return-path: <dash-owner@vger.kernel.org>
Received: from jackal.aluminati.org ([72.9.247.210]:33235 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbaKARWi (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 1 Nov 2014 13:22:38 -0400
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: John Keeping <john@keeping.me.uk>

printf(1) supports octal escape sequences in its format argument which
are specified as (from POSIX):

	"\ddd", where ddd is a one, two, or three-digit octal number

But the argument to the "%b" format specifier allows:

	"\0ddd", where ddd is a zero, one, two, or three-digit octal
	number

which is similar to the wording for echo(1) (for XSI-conformant
systems):

	\0num	Write an 8-bit value that is the zero, one, two, or
		three-digit octal number num.

Because conv_escape() handles the first case, applying the second
behaviour in conv_escape_str() must also catch the characters '1'-'7' so
that they are not converted as octal numbers.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
This was reported several years ago [1] but the patch proposed in that
case seems to have been a bit aggressive and breaks the handling of
"%b".

[1] http://thread.gmane.org/gmane.comp.shells.dash/664

 ChangeLog          | 4 ++++
 src/bltin/printf.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/ChangeLog b/ChangeLog
index 2155764..3212995 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2014-11-01  John Keeping <john@keeping.me.uk>
+
+	* Require leading '0' on octal escapes in echo.
+
 2014-10-13  Eric Blake <eblake@redhat.com>
 
 	* cd: support drive letters on Cygwin.
diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 5f9e81c..b17e6dc 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -260,6 +260,11 @@ conv_escape_str(char *str)
 				ch += k;
 			} while (--i);
 			continue;
+		} else if ('1' <= ch && ch < '8') {
+			/* Stop conv_escape handling these as octal. */
+			ch = '\\';
+			str--;
+			continue;
 		}
 
 		/* Finally test for sequences valid in the format string */
-- 
2.1.0.374.g390713e

