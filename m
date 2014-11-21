From: saulery@free.fr
Subject: [MAN] Clarify two redirection mechanisms
Date: Fri, 21 Nov 2014 12:52:34 +0100
Message-ID: <1416570754-9998-1-git-send-email-saulery@free.fr>
References: <20141112021204.GA23275@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:29539 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbaKULym (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 21 Nov 2014 06:54:42 -0500
In-Reply-To: <20141112021204.GA23275@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: saulery@free.fr

=46rom: St=C3=A9phane Aulery <saulery@free.fr>

Close Debian Bug #501566
---
 src/dash.1 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/dash.1 b/src/dash.1
index d782882..429657a 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -402,11 +402,13 @@ Append standard output (or n) to file.
 .It [n] Ns \*[Lt] file
 Redirect standard input (or n) from file.
 .It [n1] Ns \*[Lt]& Ns n2
-Duplicate standard input (or n1) from file descriptor n2.
+Redirect standard input (or fd n1) from the same resource as currently=
 open on
+fd n2.
 .It [n] Ns \*[Lt]&-
 Close standard input (or n).
 .It [n1] Ns \*[Gt]& Ns n2
-Duplicate standard output (or n1) to n2.
+Redirect standard output (or fd n1) to the same resource as currently =
open on
+fd n2.
 .It [n] Ns \*[Gt]&-
 Close standard output (or n).
 .It [n] Ns \*[Lt]\*[Gt] file
--=20
2.1.3

