From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [pape@smarden.org: Bug#455828: dash: 4-argument test "test \( ! -e \)" yields an error]
Date: Mon, 14 Jul 2008 09:26:32 +0800
Message-ID: <20080714012632.GA24961@gondor.apana.org.au>
References: <20080303120745.4107.qmail@95d002da9b2e0d.315fe32.mid.smarden.org> <20080713112241.GA20401@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:36806 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753118AbYGNB0i (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 13 Jul 2008 21:26:38 -0400
Content-Disposition: inline
In-Reply-To: <20080713112241.GA20401@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 455828@bugs.debian.org, 455828-submitter@debian.org
Cc: dash@vger.kernel.org

On Sun, Jul 13, 2008 at 07:22:41PM +0800, Herbert Xu wrote:
> 
> I've fixed as below.

You'll also want these two patches.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
commit 74fbf95549bb68a2d40c0f91fdb04a0a720e3920
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Jul 13 20:05:56 2008 +0800

    [BUILTIN] Made aexpr/oexpr non-recursive
    
    Making these functions non-recursive is straightforward since they
    carry no state.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index b2f7333..ef45102 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,6 +1,7 @@
 2008-06-13  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fixed 3,4-argument cases for test per POSIX.
+	* Made aexpr/oexpr non-recursive.
 
 2008-05-19  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 89d8d86..32a12fe 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -232,24 +232,31 @@ syntax(const char *op, const char *msg)
 static int
 oexpr(enum token n)
 {
-	int res;
-
-	res = aexpr(n);
-	if (t_lex(*++t_wp) == BOR)
-		return oexpr(t_lex(*++t_wp)) || res;
-	t_wp--;
+	int res = 0;
+
+	for (;;) {
+		res |= aexpr(n);
+		n = t_lex(t_wp[1]);
+		if (n != BOR)
+			break;
+		n = t_lex(*(t_wp += 2));
+	}
 	return res;
 }
 
 static int
 aexpr(enum token n)
 {
-	int res;
-
-	res = nexpr(n);
-	if (t_lex(*++t_wp) == BAND)
-		return aexpr(t_lex(*++t_wp)) && res;
-	t_wp--;
+	int res = 1;
+
+	for (;;) {
+		if (!nexpr(n))
+			res = 0;
+		n = t_lex(t_wp[1]);
+		if (n != BAND)
+			break;
+		n = t_lex(*(t_wp += 2));
+	}
 	return res;
 }
 
commit da1dd1f233b5235f2e5750cf2764ba87f06c590f
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Jul 13 22:07:08 2008 +0800

    [BUILTIN] Made t_lex reentrant
    
    The previous two changes were broken because t_lex uses global state.
    This patch removes that by making t_wp local to t_lex.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index ef45102..5565e06 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -2,6 +2,7 @@
 
 	* Fixed 3,4-argument cases for test per POSIX.
 	* Made aexpr/oexpr non-recursive.
+	* Made t_lex reentrant.
 
 2008-05-19  Herbert Xu <herbert@gondor.apana.org.au>
 
diff --git a/src/bltin/test.c b/src/bltin/test.c
index 32a12fe..8e7077a 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -142,8 +142,8 @@ static int nexpr(enum token);
 static int primary(enum token);
 static int binop(void);
 static int filstat(char *, enum token);
-static enum token t_lex(char *);
-static int isoperand(void);
+static enum token t_lex(char **);
+static int isoperand(char **);
 static int newerf(const char *, const char *);
 static int olderf(const char *, const char *);
 static int equalf(const char *, const char *);
@@ -207,7 +207,7 @@ testcmd(int argc, char **argv)
 		}
 	}
 
-	n = t_lex(*argv);
+	n = t_lex(argv);
 
 eval:
 	t_wp = argv;
@@ -236,10 +236,10 @@ oexpr(enum token n)
 
 	for (;;) {
 		res |= aexpr(n);
-		n = t_lex(t_wp[1]);
+		n = t_lex(t_wp + 1);
 		if (n != BOR)
 			break;
-		n = t_lex(*(t_wp += 2));
+		n = t_lex(t_wp += 2);
 	}
 	return res;
 }
@@ -252,10 +252,10 @@ aexpr(enum token n)
 	for (;;) {
 		if (!nexpr(n))
 			res = 0;
-		n = t_lex(t_wp[1]);
+		n = t_lex(t_wp + 1);
 		if (n != BAND)
 			break;
-		n = t_lex(*(t_wp += 2));
+		n = t_lex(t_wp += 2);
 	}
 	return res;
 }
@@ -264,7 +264,7 @@ static int
 nexpr(enum token n)
 {
 	if (n == UNOT)
-		return !nexpr(t_lex(*++t_wp));
+		return !nexpr(t_lex(++t_wp));
 	return primary(n);
 }
 
@@ -277,10 +277,10 @@ primary(enum token n)
 	if (n == EOI)
 		return 0;		/* missing expression */
 	if (n == LPAREN) {
-		if ((nn = t_lex(*++t_wp)) == RPAREN)
+		if ((nn = t_lex(++t_wp)) == RPAREN)
 			return 0;	/* missing expression */
 		res = oexpr(nn);
-		if (t_lex(*++t_wp) != RPAREN)
+		if (t_lex(++t_wp) != RPAREN)
 			syntax(NULL, "closing paren expected");
 		return res;
 	}
@@ -300,7 +300,7 @@ primary(enum token n)
 		}
 	}
 
-	if (t_lex(t_wp[1]), t_wp_op && t_wp_op->op_type == BINOP) {
+	if (t_lex(t_wp + 1), t_wp_op && t_wp_op->op_type == BINOP) {
 		return binop();
 	}
 
@@ -314,7 +314,7 @@ binop(void)
 	struct t_op const *op;
 
 	opnd1 = *t_wp;
-	(void) t_lex(*++t_wp);
+	(void) t_lex(++t_wp);
 	op = t_wp_op;
 
 	if ((opnd2 = *++t_wp) == (char *)0)
@@ -403,10 +403,10 @@ filstat(char *nm, enum token mode)
 	}
 }
 
-static enum token
-t_lex(char *s)
+static enum token t_lex(char **tp)
 {
 	struct t_op const *op;
+	char *s = *tp;
 
 	if (s == 0) {
 		t_wp_op = (struct t_op *)0;
@@ -414,8 +414,8 @@ t_lex(char *s)
 	}
 
 	op = getop(s);
-	if (op && !(op->op_type == UNOP && isoperand()) &&
-	    !(op->op_num == LPAREN && *(t_wp+1) == 0)) {
+	if (op && !(op->op_type == UNOP && isoperand(tp)) &&
+	    !(op->op_num == LPAREN && !tp[1])) {
 		t_wp_op = op;
 		return op->op_num;
 	}
@@ -424,15 +424,14 @@ t_lex(char *s)
 	return OPERAND;
 }
 
-static int
-isoperand(void)
+static int isoperand(char **tp)
 {
 	struct t_op const *op;
-	char *s, *t;
+	char *s;
 
-	if ((s  = *(t_wp+1)) == 0)
+	if (!(s = tp[1]))
 		return 1;
-	if ((t = *(t_wp+2)) == 0)
+	if (!tp[2])
 		return 0;
 
 	op = getop(s);
