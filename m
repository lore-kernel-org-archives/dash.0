From: Ron Yorston <rmy@frippery.org>
Subject: Re: [PATCH] parser: Catch errors in expandstr
Date: Wed, 26 Feb 2020 21:12:04 +0000
Message-ID: <5e56df24.H24u7mxAPbLPL6fI%rmy@frippery.org>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
 <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from sov.nat64.mythic-beasts.com ([93.93.129.128]:35700 "EHLO
        frippery.frippery.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727446AbgBZVMG (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 26 Feb 2020 16:12:06 -0500
In-Reply-To: <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: herbert@gondor.apana.org.au, contact@emersion.fr
Cc: dash@vger.kernel.org

Herbert Xu wrote:
>This patch fixes it by using the literal value of PS1 should an
>error occur during expansion.

There's another case that should be handled.  PS1='`xxx(`' causes the
shell to exit because the old-style backquote leaves an additional file
on the stack.

Signed-off-by: Ron Yorston <rmy@pobox.com>
---
 src/parser.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/parser.c b/src/parser.c
index 201d5bd..d7e717a 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1572,12 +1572,14 @@ const char *
 expandstr(const char *ps)
 {
 	struct jmploc *volatile savehandler;
+	struct parsefile *file_stop;
 	const char *volatile result;
 	volatile int saveprompt;
 	struct jmploc jmploc;
 	union node n;
 	int err;
 
+	file_stop = parsefile;
 	/* XXX Fix (char *) cast. */
 	setinputstring((char *)ps);
 
@@ -1605,7 +1607,7 @@ out:
 		longjmp(handler->loc, 1);
 
 	doprompt = saveprompt;
-	popfile();
+	unwindfiles(file_stop);
 
 	return result;
 }
-- 
2.24.1
