Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E373C3DA7D
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 06:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjACGQD (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 01:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjACGQD (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 01:16:03 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD0C42
        for <dash@vger.kernel.org>; Mon,  2 Jan 2023 22:16:01 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pCaac-00DMOt-CY; Tue, 03 Jan 2023 14:15:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 03 Jan 2023 14:15:58 +0800
Date:   Tue, 3 Jan 2023 14:15:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org, harald@gigawatt.nl
Subject: [v3 PATCH] input: Read standard input byte-wise
Message-ID: <Y7PIHqN4ic4UBOBb@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42d2b629549d8be07d14acb6cdd7d0f853ed1a6e.1670979949.git.nabijaczleweli@nabijaczleweli.xyz>
X-Newsgroups: apana.lists.os.linux.dash
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> 
> POSIX Issue 7, XCU, sh, STDIN says:

Your patch breaks history support since that relies on there
being a whole line in the input buffer.

This works for me:

---8<---
POSIX Issue 7, XCU, sh, STDIN says:
 When the shell is using standard input and it invokes a command that
 also uses standard input, the shell shall ensure that the standard
 input file pointer points directly after the command it has read when
 the command begins execution. It shall not read ahead in such a manner
 that any characters intended to be read by the invoked command are
 consumed by the shell (whether interpreted by the shell or not) or
 that characters that are not read by the invoked command are not seen
 by the shell.

I.e.
 sh <<EOF
 id
 cat
 good!
 EOF
must execute id, then execute cat, then the cat must copy "good!"
to the standard output stream, and similarly
 sh <<"EOF"
 id
 read Q
 good!
 echo Q$Q
 EOF
must execute id, then read "good!" into Q, then echo "Qgood!".

Heretofor the output was as such:
 uid=1000(nabijaczleweli) gid=100(users) groups=100(users)
 ./dash: 3: good!: not found
and as such (with -x):
 + id
 uid=1000(nabijaczleweli) gid=100(users) groups=100(users)
 + read Q
 + good!
 sh: 3: good!: not found
 + echo Q
 Q
and a strace confirms:
 read(0, "id\ncat\ngood!\n", 8192)       = 13
 read(0, "id\nread Q\ngood!\necho Q$Q\n", 8192) = 25

Reading the standard input byte-by-byte is the obvious solution to this
issue, Just Works, and is how all of shells do it on non-seekable input
(we could, theoretically, read regular files block-wise,
then seek within them after parsing, but the complexity out-weighs
the rarity of running sh < program; we could also do whole-line reads
on teletypes in icanon mode, but, again, the gain here is miniscule
for an interactive session, and the mode can change at any time, so...).
Naturally, we keep reading block-wise from not-standard-input.

With this patch, we observe the correct
 uid=1000(nabijaczleweli) gid=100(users) groups=100(users)
 good!
and
 + id
 uid=1000(nabijaczleweli) gid=100(users) groups=100(users)
 + read Q
 + echo Qgood!
 Qgood!

Link: https://bugs.debian.org/862907
Reported-by: наб <nabijaczleweli@nabijaczleweli.xyz>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index ec075f5..43c9161 100644
--- a/src/input.c
+++ b/src/input.c
@@ -159,6 +159,17 @@ int pgetc(void)
 	return __pgetc();
 }
 
+static int stdin_clear_nonblock(void)
+{
+	int flags = fcntl(0, F_GETFL, 0);
+
+	if (flags >= 0) {
+		flags &=~ O_NONBLOCK;
+		flags = fcntl(0, F_SETFL, flags);
+	}
+
+	return flags;
+}
 
 static int
 preadfd(void)
@@ -195,22 +206,38 @@ retry:
 
 	} else
 #endif
+	if (parsefile->fd)
 		nr = read(parsefile->fd, buf, IBUFSIZ - 1);
+	else {
+		unsigned len = IBUFSIZ - 1;
+
+		nr = 0;
+
+		do {
+			int err;
 
+			err = read(0, buf, 1);
+			if (err <= 0) {
+				if (nr)
+					break;
+
+				nr = err;
+				if (errno != EWOULDBLOCK)
+					break;
+				if (stdin_clear_nonblock() < 0)
+					break;
+
+				out2str("sh: turning off NDELAY mode\n");
+				goto retry;
+			}
+
+			nr++;
+		} while (!IS_DEFINED_SMALL && *buf++ != '\n' && --len);
+	}
 
 	if (nr < 0) {
 		if (errno == EINTR)
 			goto retry;
-		if (parsefile->fd == 0 && errno == EWOULDBLOCK) {
-			int flags = fcntl(0, F_GETFL, 0);
-			if (flags >= 0 && flags & O_NONBLOCK) {
-				flags &=~ O_NONBLOCK;
-				if (fcntl(0, F_SETFL, flags) >= 0) {
-					out2str("sh: turning off NDELAY mode\n");
-					goto retry;
-				}
-			}
-		}
 	}
 	return nr;
 }
diff --git a/src/input.h b/src/input.h
index 8c39f33..8830b66 100644
--- a/src/input.h
+++ b/src/input.h
@@ -34,6 +34,12 @@
  *	@(#)input.h	8.2 (Berkeley) 5/4/95
  */
 
+#ifdef SMALL
+#define IS_DEFINED_SMALL 1
+#else
+#define IS_DEFINED_SMALL 0
+#endif
+
 /* PEOF (the end of file marker) is defined in syntax.h */
 
 enum {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
