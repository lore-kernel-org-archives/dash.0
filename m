From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH] parser: Catch errors in expandstr
Date: Tue, 28 Apr 2020 16:17:58 +1000
Message-ID: <20200428061758.GA1771@gondor.apana.org.au>
References: <SJhI_AW9YJmphaap5RzzVqYTGsA529iV7GOEBafT9ilDPGFpMRRJlNt3TrMBwh0uqKQltSvsH2P8x_2in6enHT5DzygjAtrRSvWl5xHofeY=@emersion.fr>
 <20200121063959.tel7ty76fkz33xpn@gondor.apana.org.au>
 <5e56df24.H24u7mxAPbLPL6fI%rmy@frippery.org>
 <20200228004023.GA9163@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:45346 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1GSV (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 28 Apr 2020 02:18:21 -0400
Content-Disposition: inline
In-Reply-To: <20200228004023.GA9163@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Ron Yorston <rmy@frippery.org>
Cc: contact@emersion.fr, dash@vger.kernel.org

On Fri, Feb 28, 2020 at 11:40:23AM +1100, Herbert Xu wrote:
> On Wed, Feb 26, 2020 at 09:12:04PM +0000, Ron Yorston wrote:
> > Herbert Xu wrote:
> > >This patch fixes it by using the literal value of PS1 should an
> > >error occur during expansion.
> > 
> > There's another case that should be handled.  PS1='`xxx(`' causes the
> > shell to exit because the old-style backquote leaves an additional file
> > on the stack.
> > 
> > Signed-off-by: Ron Yorston <rmy@pobox.com>
> > ---
> >  src/parser.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> When you send a patch to an existing thread could you please change
> the Subject line? Otherwise your patch will be silently dropped by
> patchwork.

As I haven't received another patch, I'm going to fold yours into
my original patch.

---8<---
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

On Wed, Feb 26, 2020 at 09:12:04PM +0000, Ron Yorston wrote:
> 
> There's another case that should be handled.  PS1='`xxx(`' causes the
> shell to exit because the old-style backquote leaves an additional file
> on the stack.

Ron's change has been folded into this patch.

Reported-by: Simon Ser <contact@emersion.fr>
Reported-by: Ron Yorston <rmy@pobox.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index b318b08..5e36929 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1571,28 +1571,46 @@ setprompt(int which)
 const char *
 expandstr(const char *ps)
 {
+	struct parsefile *volatile file_stop;
+	struct jmploc *volatile savehandler;
+	const char *volatile result;
+	volatile int saveprompt;
+	struct jmploc jmploc;
 	union node n;
-	int saveprompt;
+	int err;
+
+	file_stop = parsefile;
 
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
+	unwindfiles(file_stop);
+
+	return result;
 }
 
 /*
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
