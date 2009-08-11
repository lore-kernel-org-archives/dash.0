From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Bug#429251: Debian Bug#429251: [PATCH] honor tab as IFS whitespace when splitting fields
Date: Tue, 11 Aug 2009 12:45:13 +1000
Message-ID: <20090811024512.GC10700@gondor.apana.org.au>
References: <200905302233.05407.stefan.potyra@informatik.uni-erlangen.de> <200906100953.37597.stefan.potyra@informatik.uni-erlangen.de> <20090628041902.GA27613@gondor.apana.org.au> <200907050045.54463.stefan.potyra@informatik.uni-erlangen.de>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>, 429251@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.429251.B429251.1249958724319@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <200907050045.54463.stefan.potyra@informatik.uni-erlangen.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Stefan Potyra <stefan.potyra@informatik.uni-erlangen.de>
Cc: dash@vger.kernel.org, 429251@bugs.debian.org
List-Id: dash@vger.kernel.org

I really loved your patch because it actually made dash smaller!

On Sun, Jul 05, 2009 at 12:45:49AM +0200, Stefan Potyra wrote:
>
> +static void
> +readcmd_handle_line(char *line, char **ap, size_t len)
> +{
> +	struct arglist arglist;
> +	struct strlist *sl;
> +	char *s, *backup;
> +
> +	/* ifsbreakup will fiddle with stack region... */
> +	s = grabstackstr(line + len);
> +	/* need a copy, so that delimiters aren't lost
> +	 * in case there are more fields than variables */
> +	if (len > 0) {
> +		backup = sstrdup(line);
> +	} else {
> +		/* len==0, so just nullify all arguments...
> +		 * otherwise memcpy (from sstrdup) would be called 
> +		 * with equal memory regions.
> +		 */

I think this is unnecessary.  See my revised patch below.  When
given the choice between a speed optimisation of an unusual case
and a smaller dash, the latter always wins :)

> +			ungrabstackstr(backup, 0);
> +			ungrabstackstr(s, 0);

The lovely thing about object stacks is that you don't have to
free the memory in places like this.  When read(1) completes the
whole object stack is obliterated so everything is freed.  As
this function is called just before read(1) returns we don't need
to free anything.
 
>  int
>  readcmd(int argc, char **argv)
>  {
> @@ -75,14 +150,14 @@ readcmd(int argc, char **argv)
>  	char c;
>  	int rflag;
>  	char *prompt;
> -	const char *ifs;
>  	char *p;
> -	int startword;
> -	int status;
>  	int i;
> +	int res;
> +	int status;

For future reference, please don't mix code clean-ups with actual
changes like this.  This makes it harder for people who read the
patch (possibly years later) to identify what has really changed.

I've gone through your patch and removed the bits which are merely
cosmetic fixes.  You're welcome to resubmit those that are still
applicable as a separate patch.

Anyway, this is what I ended up with:

diff --git a/ChangeLog b/ChangeLog
index e6a1d26..247b6e8 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-08-11  Stefan Potyra <stefan.potyra@informatik.uni-erlangen.de>
+
+	* Honor tab as IFS whitespace when splitting fields in readcmd.
+
 2009-06-27  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Fix quoted pattern patch breakage.
diff --git a/src/expand.c b/src/expand.c
index 7995d40..48c45e5 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -117,9 +117,6 @@ STATIC char *evalvar(char *, int);
 STATIC size_t strtodest(const char *, const char *, int);
 STATIC void memtodest(const char *, size_t, const char *, int);
 STATIC ssize_t varvalue(char *, int, int);
-STATIC void recordregion(int, int, int);
-STATIC void removerecordregions(int); 
-STATIC void ifsbreakup(char *, struct arglist *);
 STATIC void ifsfree(void);
 STATIC void expandmeta(struct strlist *, int);
 #ifdef HAVE_GLOB
@@ -412,7 +409,7 @@ lose:
 }
 
 
-STATIC void 
+void 
 removerecordregions(int endoff)
 {
 	if (ifslastp == NULL)
@@ -1001,7 +998,7 @@ value:
  * string for IFS characters.
  */
 
-STATIC void
+void
 recordregion(int start, int end, int nulonly)
 {
 	struct ifsregion *ifsp;
@@ -1028,7 +1025,7 @@ recordregion(int start, int end, int nulonly)
  * strings to the argument list.  The regions of the string to be
  * searched for IFS characters have been stored by recordregion.
  */
-STATIC void
+void
 ifsbreakup(char *string, struct arglist *arglist)
 {
 	struct ifsregion *ifsp;
diff --git a/src/expand.h b/src/expand.h
index 1862aea..405af0b 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -67,6 +67,9 @@ void expari(int);
 #define rmescapes(p) _rmescapes((p), 0)
 char *_rmescapes(char *, int);
 int casematch(union node *, char *);
+void recordregion(int, int, int);
+void removerecordregions(int); 
+void ifsbreakup(char *, struct arglist *);
 
 /* From arith.y */
 intmax_t arith(const char *);
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 3f91bc3..cca0f6c 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -55,14 +55,73 @@
 #include "miscbltin.h"
 #include "mystring.h"
 #include "main.h"
+#include "expand.h"
+#include "parser.h"
 
 #undef rflag
 
 
+/** handle one line of the read command.
+ *  more fields than variables -> remainder shall be part of last variable.
+ *  less fields than variables -> remaining variables unset.
+ *
+ *  @param line complete line of input
+ *  @param ap argument (variable) list
+ *  @param len length of line including trailing '\0'
+ */
+static void
+readcmd_handle_line(char *line, char **ap, size_t len)
+{
+	struct arglist arglist;
+	struct strlist *sl;
+	char *s, *backup;
+
+	/* ifsbreakup will fiddle with stack region... */
+	s = grabstackstr(line + len);
+
+	/* need a copy, so that delimiters aren't lost
+	 * in case there are more fields than variables */
+	backup = sstrdup(line);
+
+	arglist.lastp = &arglist.list;
+	recordregion(0, len, 0);
+	
+	ifsbreakup(s, &arglist);
+	*arglist.lastp = NULL;
+	removerecordregions(0);
+
+	for (sl = arglist.list; sl; sl = sl->next) {
+		/* remaining fields present, but no variables left. */
+		if (!ap[1]) {
+			size_t offset;
+			char *remainder;
+
+			/* FIXME little bit hacky, assuming that ifsbreakup 
+			 * will not modify the length of the string */
+			offset = sl->text - s;
+			remainder = backup + offset;
+			rmescapes(remainder);
+			setvar(*ap, remainder, 0);
+
+			return;
+		}
+		
+		/* set variable to field */
+		rmescapes(sl->text);
+		setvar(*ap, sl->text, 0);
+		ap++;
+	}
+
+	/* nullify remaining arguments */
+	do {
+		setvar(*ap, nullstr, 0);
+	} while (*++ap);
+}
 
 /*
  * The read builtin.  The -e option causes backslashes to escape the
- * following character.
+ * following character. The -p option followed by an argument prompts
+ * with the argument.
  *
  * This uses unbuffered input, which may be avoidable in some cases.
  */
@@ -75,9 +134,7 @@ readcmd(int argc, char **argv)
 	char c;
 	int rflag;
 	char *prompt;
-	const char *ifs;
 	char *p;
-	int startword;
 	int status;
 	int i;
 
@@ -97,10 +154,7 @@ readcmd(int argc, char **argv)
 	}
 	if (*(ap = argptr) == NULL)
 		sh_error("arg count");
-	if ((ifs = bltinlookup("IFS")) == NULL)
-		ifs = defifs;
 	status = 0;
-	startword = 1;
 	backslash = 0;
 	STARTSTACKSTR(p);
 	for (;;) {
@@ -111,10 +165,10 @@ readcmd(int argc, char **argv)
 		if (c == '\0')
 			continue;
 		if (backslash) {
-			backslash = 0;
-			if (c != '\n')
-				goto put;
-			continue;
+			if (c == '\n')
+				goto resetbs;
+			STPUTC(CTLESC, p);
+			goto put;
 		}
 		if (!rflag && c == '\\') {
 			backslash++;
@@ -122,28 +176,13 @@ readcmd(int argc, char **argv)
 		}
 		if (c == '\n')
 			break;
-		if (startword && *ifs == ' ' && strchr(ifs, c)) {
-			continue;
-		}
-		startword = 0;
-		if (ap[1] != NULL && strchr(ifs, c) != NULL) {
-			STACKSTRNUL(p);
-			setvar(*ap, stackblock(), 0);
-			ap++;
-			startword = 1;
-			STARTSTACKSTR(p);
-		} else {
 put:
-			STPUTC(c, p);
-		}
+		STPUTC(c, p);
+resetbs:
+		backslash = 0;
 	}
 	STACKSTRNUL(p);
-	/* Remove trailing blanks */
-	while ((char *)stackblock() <= --p && strchr(ifs, *p) != NULL)
-		*p = '\0';
-	setvar(*ap, stackblock(), 0);
-	while (*++ap != NULL)
-		setvar(*ap, nullstr, 0);
+	readcmd_handle_line(stackblock(), ap, p - (char *)stackblock());
 	return status;
 }
 

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
