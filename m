From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] [MAN] rename sh to dash, update DESCRIPTION and HISTORY
Date: Wed, 11 Feb 2009 14:53:03 +0000
Message-ID: <20090211145303.20815.qmail@24af49ab6270b0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([212.42.242.37]:3274 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751340AbZBKOxI (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 11 Feb 2009 09:53:08 -0500
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Rename sh to dash in the header and synopsis; remove reference to the
4.4 BSD release in the description, and replace the history information
with a reference to NetBSD's ash.

Suggested by jaalto through
 http://bugs.debian.org/499838

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 src/dash.1 |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index 5a8e2fe..c7771d0 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -34,9 +34,9 @@
 .\"
 .Dd January 19, 2003
 .Os
-.Dt SH 1
+.Dt DASH 1
 .Sh NAME
-.Nm sh
+.Nm dash
 .Nd command interpreter (shell)
 .Sh SYNOPSIS
 .Nm
@@ -93,9 +93,6 @@ but it is not a Korn shell clone (see
 Only features designated by
 .Tn POSIX ,
 plus a few Berkeley extensions, are being incorporated into this shell.
-We expect
-.Tn POSIX
-conformance by the time 4.4 BSD is released.
 This man page is not intended
 to be a tutorial or a complete specification of the shell.
 .Ss Overview
@@ -2333,11 +2330,15 @@ The process ID of the parent process of the shell.
 .Xr environ 7 ,
 .Xr sysctl 8
 .Sh HISTORY
-A
 .Nm
-command appeared in
-.At v1 .
-It was, however, unmaintainable so we wrote this one.
+is a POSIX-compliant implementation of /bin/sh that aims to be as small as
+possible.
+.Nm
+is a direct descendant of the NetBSD version of ash (the Almquist SHell),
+ported to Linux in early 1997.
+It was renamed to
+.Nm
+in 2002.
 .Sh BUGS
 Setuid shell scripts should be avoided at all costs, as they are a
 significant security risk.
-- 
1.6.1.2.346.g8600b3.dirty

