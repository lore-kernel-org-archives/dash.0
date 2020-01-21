From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] parser: Catch errors in expandstr
Date: Tue, 21 Jan 2020 14:39:59 +0800
Message-ID: <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:59778 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUGkD (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 21 Jan 2020 01:40:03 -0500
Content-Disposition: inline
In-Reply-To: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Simon Ser <contact@emersion.fr>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Fri, Dec 13, 2019 at 02:51:34PM +0000, Simon Ser wrote:
> Just noticed another dash bug: when setting invalid PS1 values dash
> enters an infinite loop.
> 
> For instance, setting PS1='$(' makes dash print many of these:
> 
>    dash: 1: Syntax error: end of file unexpected (expecting ")")
> 
> It would be nice to fallback to the default PS1 value on error.

This patch fixes it by using the literal value of PS1 should an
error occur during expansion.

Reported-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index b318b08..201d5bd 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1571,28 +1571,43 @@ setprompt(int which)
 const char *
 expandstr(const char *ps)
 {
+	struct jmploc *volatile savehandler;
+	const char *volatile result;
+	volatile int saveprompt;
+	struct jmploc jmploc;
 	union node n;
-	int saveprompt;
+	int err;
 
 	/* XXX Fix (char *) cast. */
 	setinputstring((char *)ps);
 
 	saveprompt = doprompt;
 	doprompt = 0;
+	result = ps;
+	savehandler = handler;
+	if (unlikely(err = setjmp(jmploc.loc)))
+		goto out;
+	handler = &jmploc;
 
 	readtoken1(pgetc_eatbnl(), DQSYNTAX, FAKEEOFMARK, 0);
 
-	doprompt = saveprompt;
-
-	popfile();
-
 	n.narg.type = NARG;
 	n.narg.next = NULL;
 	n.narg.text = wordtext;
 	n.narg.backquote = backquotelist;
 
 	expandarg(&n, NULL, EXP_QUOTED);
-	return stackblock();
+	result = stackblock();
+
+out:
+	handler = savehandler;
+	if (err && exception != EXERROR)
+		longjmp(handler->loc, 1);
+
+	doprompt = saveprompt;
+	popfile();
+
+	return result;
 }
 
 /*
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
