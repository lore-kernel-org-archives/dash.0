Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E123F9D4
	for <dash@vger.kernel.org>; Mon, 15 Apr 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170860; cv=none; b=tl3VhwqOP1O3QOWj3lNt0Qv6rMDE10LnQbPXS4nlIvNi+77AryRaoLOKViMnpHhAvuwjA1sVlZQF9Pd9+awkrFuxhuXmOdnE3uvpOZ1itucBSHj8+dnKQ4NH3QjtWW1Jmor4L/obHSZ9eohI9/fFENTCtJwmawf1mJWt0MpLPX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170860; c=relaxed/simple;
	bh=GsMGOP+H8LGzNPWeTgqjEJpjuM8hegEcjmAKV86+USo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwgngh+ivfgEFOzXkUYcdGvn7K1zWoM/IPSbAZrhITRlYiPk1RPdqwy6OSqqTlvx0ax/w9gZOiJt/Svrt7Kp6Mb3VWCHUeIxapu1fliywvDJvIPFgCd+uMg8JYGQd9QLbQYwugkYPGKm7euZQY2pQCCpjFpdNPIryP49qt4CZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rwHzg-001l16-7X; Mon, 15 Apr 2024 16:47:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 15 Apr 2024 16:47:33 +0800
Date: Mon, 15 Apr 2024 16:47:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Michael Greenberg <michael@greenberg.science>,
	DASH shell mailing list <dash@vger.kernel.org>
Subject: [PATCH] parser: Extend coverage of CHKEOFMARK
Message-ID: <ZhzppSDU1dgMOaNi@gondor.apana.org.au>
References: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>
 <m2zganhhlt.fsf@greenberg.science>
 <24a86069-8589-4bba-f90a-105ec3619da1@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24a86069-8589-4bba-f90a-105ec3619da1@gigawatt.nl>

On Fri, Jan 13, 2023 at 01:41:44PM +0000, Harald van Dijk wrote:
>
> Although this representation is not without its problems, it would handle
> this transparently, and has the arguable benefit of automatically handling
> things like
> 
>   $ cat <<`this is problematic`
>   hello world
>   `this is problematic`
> 
> as well. This has come up on the list before; this works in bash, ksh, yash,
> and zsh, and POSIX places no restrictions on what words can be used as
> heredoc delimiters, so I think shells are required to accept this and it is
> technically a bug that dash doesn't (as well as several other shells), even
> if no one would ever make use of it.

Alright.  I've bitten the bullet and extended the existing CHKEOFMARK
to cover all the cases.

---8<---
Extend the coverage of CHKEOFMARK to cover parameter expansion,
arithmetic expansion, and command substitution.

For command substitution, use the reconstruction from commandtext
as the here-document marker.

Reported-by: Harald van Dijk <harald@gigawatt.nl>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 2a2fe22..ac22ae5 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1242,13 +1242,19 @@ commandtext(union node *n)
 {
 	char *name;
 
-	STARTSTACKSTR(cmdnextc);
-	cmdtxt(n);
+	STARTSTACKSTR(name);
+	commandtextcont(n, name);
 	name = stackblock();
 	TRACE(("commandtext: name %p, end %p\n", name, cmdnextc));
 	return savestr(name);
 }
 
+char *commandtextcont(union node *n, char *next)
+{
+	cmdnextc = next;
+	cmdtxt(n);
+	return cmdnextc;
+}
 
 STATIC void
 cmdtxt(union node *n)
diff --git a/src/jobs.h b/src/jobs.h
index 2832d64..a58d2a2 100644
--- a/src/jobs.h
+++ b/src/jobs.h
@@ -107,6 +107,7 @@ int forkshell(struct job *, union node *, int);
 struct job *vforkexec(union node *n, char **argv, const char *path, int idx);
 int waitforjob(struct job *);
 int stoppedjobs(void);
+char *commandtextcont(union node *n, char *next);
 
 #if ! JOBS
 #define setjobctl(on) ((void)(on))	/* do nothing */
diff --git a/src/parser.c b/src/parser.c
index 299c260..e3168de 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -46,6 +46,7 @@
 #include "syntax.h"
 #include "options.h"
 #include "input.h"
+#include "jobs.h"
 #include "output.h"
 #include "var.h"
 #include "error.h"
@@ -628,9 +629,10 @@ parsefname(void)
 	union node *n = redirnode;
 
 	if (n->type == NHERE)
-		checkkwd = CHKEOFMARK;
+		checkkwd |= CHKEOFMARK;
 	if (readtoken() != TWORD)
 		synexpect(-1);
+	checkkwd &= ~CHKEOFMARK;
 	if (n->type == NHERE) {
 		struct heredoc *here = heredoc;
 		struct heredoc *p;
@@ -901,6 +903,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	/* syntax stack */
 	struct synstack synbase = { .syntax = syntax };
 	struct synstack *synstack = &synbase;
+	int chkeofmark = checkkwd & CHKEOFMARK;
 
 	if (syntax == DQSYNTAX)
 		synstack->dblquote = 1;
@@ -1010,39 +1013,35 @@ toggledq:
 						synstack_pop(&synstack);
 					else if (synstack->dqvarnest > 0)
 						synstack->dqvarnest--;
-					USTPUTC(CTLENDVAR, out);
-				} else {
-					USTPUTC(c, out);
+					if (!chkeofmark)
+						c = CTLENDVAR;
 				}
+				USTPUTC(c, out);
 				break;
 			case CLP:	/* '(' in arithmetic */
 				synstack->parenlevel++;
 				USTPUTC(c, out);
 				break;
 			case CRP:	/* ')' in arithmetic */
-				if (synstack->parenlevel > 0) {
-					USTPUTC(c, out);
+				if (synstack->parenlevel > 0)
 					--synstack->parenlevel;
+				else if (pgetc_eatbnl() == ')') {
+					synstack_pop(&synstack);
+					if (chkeofmark)
+						USTPUTC(c, out);
+					else
+						c = CTLENDARI;
 				} else {
-					if (pgetc_eatbnl() == ')') {
-						USTPUTC(CTLENDARI, out);
-						synstack_pop(&synstack);
-					} else {
-						/*
-						 * unbalanced parens
-						 *  (don't 2nd guess - no error)
-						 */
-						pungetc();
-						USTPUTC(')', out);
-					}
+					/*
+					 * unbalanced parens
+					 *  (don't 2nd guess - no error)
+					 */
+					pungetc();
 				}
+				USTPUTC(c, out);
 				break;
 			case CBQUOTE:	/* '`' */
-				if (checkkwd & CHKEOFMARK) {
-					USTPUTC('`', out);
-					break;
-				}
-
+				USTPUTC('`', out);
 				PARSEBACKQOLD();
 				break;
 			case CEOF:
@@ -1218,13 +1217,16 @@ parsesub: {
 	static const char types[] = "}-+?=";
 
 	c = pgetc_eatbnl();
-	if (
-		(checkkwd & CHKEOFMARK) ||
-		(c != '(' && c != '{' && !is_name(c) && !is_special(c))
-	) {
+	if (c != '(' && c != '{' && !is_name(c) && !is_special(c)) {
 		USTPUTC('$', out);
 		pungetc();
-	} else if (c == '(') {	/* $(command) or $((arith)) */
+		goto parsesub_return;
+	}
+
+	USTPUTC('$', out);
+
+	if (c == '(') {		/* $(command) or $((arith)) */
+		USTPUTC(c, out);
 		if (pgetc_eatbnl() == '(') {
 			PARSEARITH();
 		} else {
@@ -1234,11 +1236,15 @@ parsesub: {
 	} else {
 		const char *newsyn = synstack->syntax;
 
-		USTPUTC(CTLVAR, out);
 		typeloc = out - (char *)stackblock();
-		STADJUST(1, out);
+		if (!chkeofmark) {
+			out[-1] = CTLVAR;
+			STADJUST(1, out);
+		}
 		subtype = VSNORMAL;
 		if (likely(c == '{')) {
+			if (chkeofmark)
+				USTPUTC('{', out);
 			c = pgetc_eatbnl();
 			subtype = 0;
 		}
@@ -1262,8 +1268,11 @@ varname:
 			if (!subtype && cc == '#') {
 				subtype = VSLENGTH;
 
-				if (c == '_' || isalnum(c))
+				if (c == '_' || isalnum(c)) {
+					if (chkeofmark)
+						USTPUTC('#', out);
 					goto varname;
+				}
 
 				cc = c;
 				c = pgetc_eatbnl();
@@ -1272,7 +1281,8 @@ varname:
 					subtype = 0;
 					c = cc;
 					cc = '#';
-				}
+				} else if (chkeofmark)
+					USTPUTC('#', out);
 			}
 
 			if (!is_special(cc)) {
@@ -1288,10 +1298,15 @@ varname:
 		if (subtype == 0) {
 			int cc = c;
 
+			if (chkeofmark)
+				STPUTC(c, out);
+
 			switch (c) {
 			case ':':
 				subtype = VSNUL;
 				c = pgetc_eatbnl();
+				if (chkeofmark)
+					STPUTC(c, out);
 				/*FALLTHROUGH*/
 			default:
 				p = strchr(types, c);
@@ -1304,9 +1319,11 @@ varname:
 				subtype = c == '#' ? VSTRIMLEFT :
 						     VSTRIMRIGHT;
 				c = pgetc_eatbnl();
-				if (c == cc)
+				if (c == cc) {
+					if (chkeofmark)
+						STPUTC(c, out);
 					subtype++;
-				else
+				} else
 					pungetc();
 
 				newsyn = BASESYNTAX;
@@ -1333,13 +1350,15 @@ badsub:
 			synstack->dblquote = newsyn != BASESYNTAX;
 		}
 
-		*((char *)stackblock() + typeloc) = subtype | VSBIT;
 		if (subtype != VSNORMAL) {
 			synstack->varnest++;
 			if (synstack->dblquote)
 				synstack->dqvarnest++;
 		}
-		STPUTC('=', out);
+		if (!chkeofmark) {
+			*((char *)stackblock() + typeloc) = subtype | VSBIT;
+			STPUTC('=', out);
+		}
 	}
 	goto parsesub_return;
 }
@@ -1353,14 +1372,19 @@ badsub:
  */
 
 parsebackq: {
-	struct nodelist **nlpp;
-	union node *n;
-	char *str;
-	size_t savelen;
-	struct heredoc *saveheredoclist;
 	int uninitialized_var(saveprompt);
+	struct heredoc *saveheredoclist;
+	struct nodelist **nlpp;
+	size_t psavelen;
+	size_t savelen;
+	union node *n;
+	char *pstr;
+	char *str;
 
-	USTPUTC(CTLBACKQ, out);
+	if (!chkeofmark) {
+		STADJUST(oldstyle - 1, out);
+		out[-1] = CTLBACKQ;
+	}
 	str = stackblock();
 	savelen = out - (char *)stackblock();
 	grabstackblock(savelen);
@@ -1370,9 +1394,6 @@ parsebackq: {
                    reread it as input, interpreting it normally.  */
                 char *pout;
                 int pc;
-                size_t psavelen;
-                char *pstr;
-
 
                 STARTSTACKSTR(pout);
 		for (;;) {
@@ -1405,10 +1426,8 @@ parsebackq: {
 done:
                 STPUTC('\0', pout);
                 psavelen = pout - (char *)stackblock();
-                if (psavelen > 0) {
-			pstr = grabstackstr(pout);
-			setinputstring(pstr);
-                }
+		pstr = grabstackstr(pout);
+		setinputstring(pstr);
         }
 	nlpp = &bqlist;
 	while (*nlpp)
@@ -1440,14 +1459,26 @@ done:
 	(*nlpp)->n = n;
 	/* Start reading from old file again. */
 	popfile();
-	/* Ignore any pushed back tokens left from the backquote parsing. */
-	if (oldstyle)
-		tokpushback = 0;
+
 	out = stnputs(str, savelen, stackblock());
-	if (oldstyle)
+
+	if (oldstyle) {
+		/* Ignore any pushed back tokens left from the backquote
+		 * parsing.
+		 */
+		tokpushback = 0;
+		if (chkeofmark) {
+			pstr[psavelen - 1] = '`';
+			out = stnputs(pstr, psavelen, out);
+		}
 		goto parsebackq_oldreturn;
-	else
+	} else {
+		if (chkeofmark) {
+			out = commandtextcont(n, out);
+			USTPUTC(')', out);
+		}
 		goto parsebackq_newreturn;
+	}
 }
 
 /*
@@ -1459,7 +1490,12 @@ parsearith: {
 		      synstack->prev ?: alloca(sizeof(*synstack)),
 		      ARISYNTAX);
 	synstack->dblquote = 1;
-	USTPUTC(CTLARI, out);
+	if (chkeofmark)
+		USTPUTC(c, out);
+	else {
+		STADJUST(-1, out);
+		out[-1] = CTLARI;
+	}
 	goto parsearith_return;
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
