From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH 2/2] [INPUT] exit 127 if command_file is given but is a directory
Date: Tue, 29 Sep 2009 11:16:26 +0000
Message-ID: <20090929111626.19483.qmail@623e55deb600c6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from a.ns.smarden.org ([212.42.242.37]:1141 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbZI2LXo (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 29 Sep 2009 07:23:44 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This commit makes dash exit with return code 127 instead of 0 if
started as non-interactive shell with a command_file specified as
argument that is actually a directory.

The wrong exit code was reported by Jari Aalto
 http://bugs.debian.org/548687
---
 src/input.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/input.c b/src/input.c
index c1e3e54..7ab1de6 100644
--- a/src/input.c
+++ b/src/input.c
@@ -206,6 +206,10 @@ retry:
 				}
 			}
 		}
+		if (errno == EISDIR) {
+			exitstatus = 127;
+			exraise(EXEXIT);
+		}
 	}
 	return nr;
 }
-- 
1.6.0.3

