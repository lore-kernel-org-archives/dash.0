From: maximilian attems <max@stro.at>
Subject: [PATCH 2/2] [EVAL] clean up myhistedit.h
Date: Thu,  8 Jul 2010 10:36:20 +0200
Message-ID: <1278578180-6969-2-git-send-email-max@stro.at>
References: <1278578180-6969-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:40777 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157Ab0GHImB (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 8 Jul 2010 04:42:01 -0400
In-Reply-To: <1278578180-6969-1-git-send-email-max@stro.at>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org, klibc@zytor.com, maximilian attems <max@stro.at>

fixes debug compilation of klibc:
In file included from usr/dash/eval.c:64:
usr/dash/myhistedit.h:34:22: error: histedit.h: No such file or directo=
ry
In file included from usr/dash/eval.c:64:
usr/dash/myhistedit.h:36: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98_=
_attribute__=E2=80=99 before =E2=80=98*=E2=80=99 token
usr/dash/myhistedit.h:37: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98_=
_attribute__

as none of the History or EditLine seem to have an usage, removed them.

Signed-off-by: maximilian attems <max@stro.at>
---
 src/myhistedit.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/myhistedit.h b/src/myhistedit.h
index 22e5c43..4699b34 100644
--- a/src/myhistedit.h
+++ b/src/myhistedit.h
@@ -31,10 +31,6 @@
  *	@(#)myhistedit.h	8.2 (Berkeley) 5/4/95
  */
=20
-#include <histedit.h>
