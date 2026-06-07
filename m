Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7952459E5
	for <dash@vger.kernel.org>; Sun,  7 Jun 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837926; cv=none; b=qQTwmKt33QC0FNvTWiTgA1ODZ2Z1rAg1tqbkwby4ROSaXyx3hfLz5ijMlvc7fomFhHDGHZuqSAp+fAHCS5L5bFgLiNU6TZU8+Cz2RSrMoItbzUVJLRR1fsyaQfraMnOvT/l3zFzfplohNPlON6n0UJ5+qCuTHXc+iCKmtxjNNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837926; c=relaxed/simple;
	bh=iqsoDKXSqd1DMSUqM5uT0ZkjjH0COgC5HtB0sYGsJ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do3js635OIVjYrbwNEe8O0FH47hC+x9hans62IPkvSNQIkdeTDBl7gWI15Enp1st0cwlO0amLDfECtSRwlgpJUQkR0GNhvm4+XOziHPg/V2DQZwXt/MLsHmXCO8d4aPYJkRINjeyRqM11lv4wExun4vYKGyMCwJC28uD49SAu50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=rDAiCNj4; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="rDAiCNj4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=kX3X2KL7d7zZYMAV5mwbsmWJ0tAo+lJfe9C1gLQHED0=; 
	b=rDAiCNj4D2K6+IgJ+ASbFEjCvxmFpxi2Lx+zYpSL/b2gHrDKu5SnFwchxf2cojNeegFaoo2hmTx
	tConCdlrsRSwkdJnOGGb8//bUojbZurWfhJAEB6UMtgjYRbCHgMrDNzyP4VIMytI/7fgfW3PdrheM
	a0zdnXuz7SxwrfEaVbDr+mycCTzdsUXwXlO5DIABLAVuflqCDq59rB1hoL6BB2xqDVozMqf6m8jRu
	c1xVCqTrNhstLUrSqG8z96UmlV/bfJEcf+SkYWutt0tvUecR8+Afg49WAsssRBdiSOY+xcm6PH/O/
	H7Ssh6w20OHUJ7YcuR0v+W7iMgpaPViAXF+Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wWDIF-003GNH-0r;
	Sun, 07 Jun 2026 21:12:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 Jun 2026 21:11:59 +0800
Date: Sun, 7 Jun 2026 21:11:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Print escapes for command substitution in EOF marker
Message-ID: <aiVuH2IrlX0L9xjo@gondor.apana.org.au>
References: <CALjJ9ccF26JgGbQmAf5OLdjRSRC-cKjXYLYhOi0wTJTChFEZ=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjJ9ccF26JgGbQmAf5OLdjRSRC-cKjXYLYhOi0wTJTChFEZ=Q@mail.gmail.com>

On Sat, Jun 06, 2026 at 02:34:07PM -0700, Nathan Mills wrote:
> 
> ** Crash #1: global-buffer-overflow **
> 
> Base64'd:
> 
> aFNudG5vG2wBAGB/YP3//3tiZmZmZmZcXFx3XE48PMTEAGB/YP3/Yi8keyMgfWBBQmBgYBgk/2Iv
> JHsjIH1gQUJgYGBpej0rVgwMDAwMDAxggYELBf//BSQkdHJhcAsLCwsmCwsLCy/9//n5+fn5+fn5
> +fn5+fn5+fn5+fn5+fn5+fn5+fn5hfn5+fn5YEZgYmBggP///4QvJHsjIGBiYGl6PehgCABgYGBg
> YGA/Pw==
> 
> Reproducible: every time with ASAN, but segfaults 1/2 of the time without ASAN.
> 
> Similar cause as crash #6 from my NixOS fuzzing campaign in 2025.
> Commit 57ed2701 attempted to fix #6, but with that commit, the code
> overruns the stackbase variable with the provided crasher.
> 
> Some variables' values at frame 5:
> stackbase is 0x5942af699dc0
> stacknleft is 80
> ml is 249
> p is <stackbase+391> "\371\371\371\371`F`b``\200\377\377\377\204/${#
> `b`iz=\350`\b``````??"
> q is <stackbase+388>
> "\371\205\371\371\371\371\371`F`b``\200\377\377\377\204/${#
> `b`iz=\350`\b``````??"
> sstrend is stackbase+512
> 
> The stackbase variable is 512 bytes long.
> 
> It seems Dash can't handle the sequence \x85\xF9 in a filename; Dash
> thinks this means a multi-byte character of length 249. \x85 is
> CTLMBCHAR.

This is caused by command substitution in a here-document EOF
marker not being produced with escape characters, which then
confuses rmescapes.

---8<---
When CHKEOFMARK was extended to command substitution, the string
produced does not contain escape characters, even though it will
be passed to rmescapes.

Fix this by essentially reverting that change for back quotes,
but also extend this to cover new-style command substitutions
by using the normal parser for both cases.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Fixes: 7a11b3e330a3 ("parser: Extend coverage of CHKEOFMARK")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/jobs.c b/src/jobs.c
index 4aa65b6..914b383 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -1264,20 +1264,13 @@ commandtext(union node *n)
 {
 	char *name;
 
-	STARTSTACKSTR(name);
-	commandtextcont(n, name);
+	STARTSTACKSTR(cmdnextc);
+	cmdtxt(n);
 	name = stackblock();
 	TRACE(("commandtext: name %p, end %p\n", name, cmdnextc));
 	return savestr(name);
 }
 
-char *commandtextcont(union node *n, char *next)
-{
-	cmdnextc = next;
-	cmdtxt(n);
-	return cmdnextc;
-}
-
 STATIC void
 cmdtxt(union node *n)
 {
diff --git a/src/jobs.h b/src/jobs.h
index a58d2a2..2832d64 100644
--- a/src/jobs.h
+++ b/src/jobs.h
@@ -107,7 +107,6 @@ int forkshell(struct job *, union node *, int);
 struct job *vforkexec(union node *n, char **argv, const char *path, int idx);
 int waitforjob(struct job *);
 int stoppedjobs(void);
-char *commandtextcont(union node *n, char *next);
 
 #if ! JOBS
 #define setjobctl(on) ((void)(on))	/* do nothing */
diff --git a/src/parser.c b/src/parser.c
index 412e876..65c5fd6 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -92,6 +92,7 @@ struct synstack {
 	int innerdq;
 	int varpushed;
 	int dblquote;
+	int backq;		/* Inside back quotes (here-doc word only). */
 	int varnest;		/* levels of variables expansion */
 	int parenlevel;		/* levels of parens in arithmetic */
 	int dqvarnest;		/* levels of variables expansion within double quotes */
@@ -1004,7 +1005,7 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 	};
 	int chkeofmark = checkkwd & CHKEOFMARK;
 	struct synstack *synstack = &synbase;
-	bool sqheredoc = syntax == SQSYNTAX;
+	bool printesc = syntax == SQSYNTAX;
 	struct nodelist *bqlist = NULL;
 	int dollarsq = 0;
 	int c = firstc;
@@ -1035,9 +1036,10 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 			CHECKSTRSPACE((MB_LEN_MAX > 16 ? MB_LEN_MAX : 16) + 7,
 				      out);
 			fieldsplitting = synstack->syntax == BASESYNTAX &&
-					 !synstack->varnest ? 4 : 0;
+					 !(synstack->varnest |
+					   synstack->backq) ? 4 : 0;
 			ml = getmbc(c, out, fieldsplitting |
-					    (sqheredoc ? 2 : 0));
+					    (printesc ? 2 : 0));
 			if (ml == 1) {
 				if (out == stackblock())
 					return TBLANK;
@@ -1079,7 +1081,8 @@ readtoken1(int firstc, char const *syntax, char *eofmark, int striptabs)
 				}
 
 				if (
-					synstack->dblquote &&
+					(synstack->dblquote |
+					 synstack->backq) &&
 					c != '\\' && c != '`' &&
 					c != '$' && (
 						c != '"' ||
@@ -1182,13 +1185,19 @@ toggledq:
 				USTPUTC(c, out);
 				break;
 			case CBQUOTE:	/* '`' */
+				if (synstack->backq == 2)
+					goto end_backq;
 				USTPUTC('`', out);
 				PARSEBACKQOLD();
 				break;
 			case CEOF:
 				goto endword;		/* exit outer loop */
 			default:
-				if (fieldsplitting)
+				if (c == ')' && synstack->backq == 1) {
+end_backq:
+					synstack_pop(&synstack);
+					printesc = 0;
+				} else if (fieldsplitting)
 					goto endword;	/* exit outer loop */
 				USTPUTC(c, out);
 			}
@@ -1197,7 +1206,8 @@ toggledq:
 endword:
 	if (synstack->syntax == ARISYNTAX)
 		synerror("Missing '))'");
-	if (synstack->syntax != BASESYNTAX && eofmark == NULL)
+	if ((synstack->syntax != BASESYNTAX && eofmark == NULL) ||
+	    synstack->backq)
 		synerror("Unterminated quoted string");
 	if (synstack->varnest != 0) {
 		/* { */
@@ -1520,16 +1530,20 @@ parsebackq: {
 	char *pstr;
 	char *str;
 
-	if (!chkeofmark) {
-		STADJUST(oldstyle - 1, out);
-		out[-1] = CTLBACKQ;
-	}
-	if (!chkeofmark || !oldstyle) {
-		str = stackblock();
-		savelen = out - (char *)stackblock();
-		grabstackblock(savelen);
-		STARTSTACKSTR(out);
+	if (chkeofmark) {
+		synstack_push(&synstack,
+			      synstack->prev ?: alloca(sizeof(*synstack)),
+			      BASESYNTAX);
+		synstack->backq = oldstyle + 1;
+		printesc = 1;
+		goto parsebackq_out;
 	}
+	STADJUST(oldstyle - 1, out);
+	out[-1] = CTLBACKQ;
+	str = stackblock();
+	savelen = out - (char *)stackblock();
+	grabstackblock(savelen);
+	STARTSTACKSTR(out);
         if (oldstyle) {
                 /* We must read until the closing backquote, giving special
                    treatment to some slashes, and then push the string and
@@ -1571,10 +1585,6 @@ parsebackq: {
 			}
 			STPUTC(pc, pout);
                 }
-		if (chkeofmark) {
-			out = pout;
-			goto parsebackq_oldreturn;
-		}
 		pout[-1] = 0;
 		pstr = grabstackstr(pout);
 		setinputstring(pstr);
@@ -1612,6 +1622,7 @@ parsebackq: {
 
 	out = stnputs(str, savelen, stackblock());
 
+parsebackq_out:
 	if (oldstyle) {
 		/* Ignore any pushed back tokens left from the backquote
 		 * parsing.
@@ -1619,10 +1630,6 @@ parsebackq: {
 		tokpushback = 0;
 		goto parsebackq_oldreturn;
 	} else {
-		if (chkeofmark) {
-			out = commandtextcont(n, out);
-			STPUTC(')', out);
-		}
 		goto parsebackq_newreturn;
 	}
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
