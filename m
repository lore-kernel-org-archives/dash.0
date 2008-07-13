From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [pape@smarden.org: Bug#455828: dash: 4-argument test "test \( ! -e \)" yields an error]
Date: Sun, 13 Jul 2008 19:22:41 +0800
Message-ID: <20080713112241.GA20401@gondor.apana.org.au>
References: <20080303120745.4107.qmail@95d002da9b2e0d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:39960 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752076AbYGMLWq (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 13 Jul 2008 07:22:46 -0400
Content-Disposition: inline
In-Reply-To: <20080303120745.4107.qmail@95d002da9b2e0d.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 455828@bugs.debian.org, 455828-submitter@debian.org
Cc: dash@vger.kernel.org

On Mon, Mar 03, 2008 at 12:07:45PM +0000, Gerrit Pape wrote:
> forwarded 455828 upstream
> quit
> 
> Hi Herbert, please see http://bugs.debian.org/455828 and below.  I agree
> that this is a bug in dash, sorry, I can't suggest a patch.

I've fixed as below.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
commit 4df1e776cd079357f877f0d491a80a234f670452
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Jul 13 19:20:10 2008 +0800

    [BUILTIN] Fixed 3,4-argument cases for test per POSIX
    
    ----- Forwarded message from Gerrit Pape <pape@smarden.org> -----
    
    Subject: Bug#455828: dash: 4-argument test "test \( ! -e \)" yields an error
    Date: Fri, 28 Dec 2007 08:53:29 +0000
    From: Gerrit Pape <pape@smarden.org>
    To: Vincent Lefevre <vincent@vinc17.org>, 455828@bugs.debian.org
    
    On Thu, Dec 27, 2007 at 06:23:20PM +0100, Vincent Lefevre wrote:
    > On 2007-12-27 16:00:06 +0000, Gerrit Pape wrote:
    > > On Wed, Dec 12, 2007 at 02:18:47AM +0100, Vincent Lefevre wrote:
    > > > According to POSIX[*], "test \( ! -e \)" is a 4-argument test and is
    > > > here equivalent to "test ! -e". But dash (like ksh93 and bash) yields
    > > > an error:
    > > >
    > > > $ test \( ! -e \) || echo $?
    > > > test: 1: closing paren expected
    > > > 2
    > > > $ test ! -e || echo $?
    > > > 1
    > >
    > > Hi Vincent,
    > >
    > > the -e switch to test takes an argument, a pathname.
    >
    > According to POSIX, in both above examples, "-e" is *not* a switch,
    > just a string.
    >
    >   test \( ! -e \)
    >
    > means: return true if the string "-e" is empty, otherwhise return false.
    > The error in dash is that it incorrectly thinks that "-e" is a switch in
    > this context.
    
    I see, you're right.  Thanks, Gerrit.
    
    ----- End forwarded message -----
    
    This patch hard-codes the 3,4-argument cases in the way required by
    POSIX.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index 7cf15c0..b2f7333 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2008-06-13  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fixed 3,4-argument cases for test per POSIX.
+
 2008-05-19  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fixed non-leading slash treatment in expmeta.
diff --git a/src/bltin/test.c b/src/bltin/test.c
index bc8b175..89d8d86 100644
--- a/src/bltin/test.c
+++ b/src/bltin/test.c
@@ -155,9 +155,23 @@ static inline intmax_t getn(const char *s)
 	return atomax10(s);
 }
 
+static const struct t_op *getop(const char *s)
+{
+	const struct t_op *op;
+
+	for (op = ops; op->op_text; op++) {
+		if (strcmp(s, op->op_text) == 0)
+			return op;
+	}
+
+	return NULL;
+}
+
 int
 testcmd(int argc, char **argv)
 {
+	const struct t_op *op;
+	enum token n;
 	int res;
 
 	if (*argv[0] == '[') {
@@ -166,14 +180,42 @@ testcmd(int argc, char **argv)
 		argv[argc] = NULL;
 	}
 
-	if (argc < 2)
+	argv++;
+	argc--;
+
+	if (argc < 1)
 		return 1;
 
-	t_wp = &argv[1];
-	res = !oexpr(t_lex(*t_wp));
+	/*
+	 * POSIX prescriptions: he who wrote this deserves the Nobel
+	 * peace prize.
+	 */
+	switch (argc) {
+	case 3:
+		op = getop(argv[1]);
+		if (op && op->op_type == BINOP) {
+			n = OPERAND;
+			goto eval;
+		}
+		/* fall through */
 
-	if (*t_wp != NULL && *++t_wp != NULL)
-		syntax(*t_wp, "unexpected operator");
+	case 4:
+		if (!strcmp(argv[0], "(") && !strcmp(argv[argc - 1], ")")) {
+			argv[--argc] = NULL;
+			argv++;
+			argc--;
+		}
+	}
+
+	n = t_lex(*argv);
+
+eval:
+	t_wp = argv;
+	res = !oexpr(n);
+	argv = t_wp;
+
+	if (argv[0] != NULL && argv[1] != NULL)
+		syntax(argv[0], "unexpected operator");
 
 	return res;
 }
@@ -359,22 +401,18 @@ t_lex(char *s)
 {
 	struct t_op const *op;
 
-	op = ops;
-
 	if (s == 0) {
 		t_wp_op = (struct t_op *)0;
 		return EOI;
 	}
-	while (op->op_text) {
-		if (strcmp(s, op->op_text) == 0) {
-			if ((op->op_type == UNOP && isoperand()) ||
-			    (op->op_num == LPAREN && *(t_wp+1) == 0))
-				break;
-			t_wp_op = op;
-			return op->op_num;
-		}
-		op++;
+
+	op = getop(s);
+	if (op && !(op->op_type == UNOP && isoperand()) &&
+	    !(op->op_num == LPAREN && *(t_wp+1) == 0)) {
+		t_wp_op = op;
+		return op->op_num;
 	}
+
 	t_wp_op = (struct t_op *)0;
 	return OPERAND;
 }
@@ -385,18 +423,13 @@ isoperand(void)
 	struct t_op const *op;
 	char *s, *t;
 
-	op = ops;
 	if ((s  = *(t_wp+1)) == 0)
 		return 1;
 	if ((t = *(t_wp+2)) == 0)
 		return 0;
-	while (op->op_text) {
-		if (strcmp(s, op->op_text) == 0)
-			return op->op_type == BINOP &&
-			    (t[0] != ')' || t[1] != '\0');
-		op++;
-	}
-	return 0;
+
+	op = getop(s);
+	return op && op->op_type == BINOP;
 }
 
 static int
