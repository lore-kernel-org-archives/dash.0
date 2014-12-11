From: saulery@free.fr
Subject: [MAN] Clarify two redirection mechanisms
Date: Thu, 11 Dec 2014 10:03:06 +0100
Message-ID: <1418288586-1587-1-git-send-email-saulery@free.fr>
References: <20141209165431.GB5708@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:28724 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531AbaLKJGR (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 11 Dec 2014 04:06:17 -0500
In-Reply-To: <20141209165431.GB5708@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: dash@vger.kernel.org, =?UTF-8?q?St=C3=A9phane=20Aulery?= <saulery@free.fr>

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
+Copy file descriptor n2 as stdout (or fd n1).
+fd n2.
 .It [n] Ns \*[Lt]&-
 Close standard input (or n).
 .It [n1] Ns \*[Gt]& Ns n2
-Duplicate standard output (or n1) to n2.
+Copy file descriptor n2 as stdin (or fd n1).
+fd n2.
 .It [n] Ns \*[Gt]&-
 Close standard output (or n).
 .It [n] Ns \*[Lt]\*[Gt] file
--=20
2.1.3

