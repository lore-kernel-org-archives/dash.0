From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: dash arithmetic expression bug (1 << 1 + 1 | 1)
Date: Tue, 9 Mar 2010 12:59:49 +0800
Message-ID: <20100309045949.GA8665@gondor.apana.org.au>
References: <20100308233854.GA64452@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:33425 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932197Ab0CIE7w (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 8 Mar 2010 23:59:52 -0500
Content-Disposition: inline
In-Reply-To: <20100308233854.GA64452@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Tue, Mar 09, 2010 at 12:38:54AM +0100, Jilles Tjoelker wrote:
>
> Noncommutative operators break more easily, for example
> Input:
>     echo $((3 - 3 * 3 - 3))
> Expected result:
>     -9
> Actual result:
>     -3

This should fix it:

commit 9655c1ac5646bde1007ecba7c6271d3aa98f294b
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue Mar 9 12:52:30 2010 +0800

    [ARITH] Fix binary operator parsing
    
    Jilles Tjoelker reported that binary operator parsing doesn't
    respect operator precedence correctly in the case where a lower-
    precedence operator is followed by a higher-precedence operator,
    and then by a lower-precedence operator.
    
    This patch fixes this by stopping when we encounter a binary
    oeprator with a precedence lower than one that we have already
    encountered.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 3e68917..8dfd747 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-03-09  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix binary operator parsing.
+
 2009-11-26  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix off-by-one recordregion in readcmd.
diff --git a/src/arith_yacc.c b/src/arith_yacc.c
index f4857fe..74b95f8 100644
--- a/src/arith_yacc.c
+++ b/src/arith_yacc.c
@@ -74,6 +74,8 @@ static const char prec[ARITH_BINOP_MAX - ARITH_BINOP_MIN] = {
 	ARITH_PRECEDENCE(ARITH_BOR, 7),
 };
 
+#define ARITH_MAX_PREC 8
+
 static void yyerror(const char *s) __attribute__ ((noreturn));
 static void yyerror(const char *s)
 {
@@ -81,9 +83,14 @@ static void yyerror(const char *s)
 	/* NOTREACHED */
 }
 
+static inline int arith_prec(int op)
+{
+	return prec[op - ARITH_BINOP_MIN];
+}
+
 static inline int higher_prec(int op1, int op2)
 {
-	return prec[op1 - ARITH_BINOP_MIN] < prec[op2 - ARITH_BINOP_MIN];
+	return arith_prec(op1) < arith_prec(op2);
 }
 
 static intmax_t do_binop(int op, intmax_t a, intmax_t b)
@@ -174,7 +181,7 @@ again:
 	}
 }
 
-static intmax_t binop2(intmax_t a, int op, int noeval)
+static intmax_t binop2(intmax_t a, int op, int prec, int noeval)
 {
 	for (;;) {
 		union yystype val;
@@ -188,15 +195,18 @@ static intmax_t binop2(intmax_t a, int op, int noeval)
 		b = primary(token, &val, yylex(), noeval);
 
 		op2 = last_token;
-		if (op2 < ARITH_BINOP_MIN || op2 >= ARITH_BINOP_MAX)
-			return noeval ? b : do_binop(op, a, b);
-
-		if (higher_prec(op2, op)) {
-			b = binop2(b, op2, noeval);
-			return noeval ? b : do_binop(op, a, b);
+		if (op2 >= ARITH_BINOP_MIN && op2 < ARITH_BINOP_MAX &&
+		    higher_prec(op2, op)) {
+			b = binop2(b, op2, arith_prec(op), noeval);
+			op2 = last_token;
 		}
 
-		a = do_binop(op, a, b);
+		a = noeval ? b : do_binop(op, a, b);
+
+		if (op2 < ARITH_BINOP_MIN || op2 >= ARITH_BINOP_MAX ||
+		    arith_prec(op2) >= prec)
+			return a;
+
 		op = op2;
 	}
 }
@@ -209,7 +219,7 @@ static intmax_t binop(int token, union yystype *val, int op, int noeval)
 	if (op < ARITH_BINOP_MIN || op >= ARITH_BINOP_MAX)
 		return a;
 
-	return binop2(a, op, noeval);
+	return binop2(a, op, ARITH_MAX_PREC, noeval);
 }
 
 static intmax_t and(int token, union yystype *val, int op, int noeval)

> Another change I'm making to the arith code is making || return 0 or 1
> only, matching C, POSIX and other shells.

Please send a patch.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
