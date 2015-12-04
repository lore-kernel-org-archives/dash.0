From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash: read does not ignore trailing spaces
Date: Fri, 4 Dec 2015 20:51:19 +0100
Message-ID: <5661EEB7.8080908@gigawatt.nl>
References: <n3nrqu$mj2$1@ger.gmane.org> <5660ADD6.4020308@gigawatt.nl>
 <20151203211748.GC9581@chaz.gmail.com> <5660C1A6.1010902@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060209000805040806040003"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:49281
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753456AbbLDTv0 (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 4 Dec 2015 14:51:26 -0500
In-Reply-To: <5660C1A6.1010902@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: Gioele Barabucci <gioele@svario.it>, dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209000805040806040003
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 03/12/2015 23:26, Harald van Dijk wrote:
> On 03/12/2015 22:17, Stephane Chazelas wrote:
>> 2015-12-03 22:02:14 +0100, Harald van Dijk:
>> [....]
>>>    $ for shell in bash mksh posh zsh; do printf %s: "$shell"; $shell
>>> -c 'IFS=,; echo a, | { read v; echo "<$v>"; }'; done
>>>    bash:<a>
>>>    mksh:<a>
>>>    posh:<a,>
>>>    zsh:<a,>
>>>
>>> As far as I can tell, the posh/zsh behaviour is the correct
>>> behaviour, but I'm not convinced yet my interpretation is correct.
>> [...]
>>
>> zsh and pdksh (and other descendants of the Forsyth shell) treat it as
>> separator (and are not compliant), mksh (derived from pdksh)
>> changed it recently. posh (also based on pdksh) still hasn't changed it.
>
> [...]
> I do see your point. Thanks for the clear example, I think I agree with
> you, the description of field splitting mentions that delimiters are
> used as terminators:
>
>    "The shell shall treat each character of the IFS as a delimiter and
> use the delimiters as field terminators to [...]"
>
> It should not be much of a problem to extend the patch I posted to cover
> the rules as you describe them, I will make an attempt at this later.

Here it is. Attached is an updated patch that ignores the complete 
terminator if only a single field remains, otherwise ignores only 
trailing IFS whitespace.

Cheers,
Harald van Dijk

--------------060209000805040806040003
Content-Type: text/plain; charset=UTF-8;
 name="dash-read-ifs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-read-ifs.patch"

diff --git a/src/expand.c b/src/expand.c
index b2d710d..c6e87d5 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -203,7 +203,7 @@ expandarg(union node *arg, struct arglist *arglist, int flag)
 	 * TODO - EXP_REDIR
 	 */
 	if (flag & EXP_FULL) {
-		ifsbreakup(p, &exparg);
+		ifsbreakup(p, 0, &exparg);
 		*exparg.lastp = NULL;
 		exparg.lastp = &exparg.list;
 		expandmeta(exparg.list, flag);
@@ -1016,9 +1016,11 @@ recordregion(int start, int end, int nulonly)
  * Break the argument string into pieces based upon IFS and add the
  * strings to the argument list.  The regions of the string to be
  * searched for IFS characters have been stored by recordregion.
+ * If maxargs is non-zero, at most maxargs arguments will be created, by
+ * joining together the last arguments.
  */
 void
-ifsbreakup(char *string, struct arglist *arglist)
+ifsbreakup(char *string, int maxargs, struct arglist *arglist)
 {
 	struct ifsregion *ifsp;
 	struct strlist *sp;
@@ -1054,12 +1056,58 @@ ifsbreakup(char *string, struct arglist *arglist)
 						start = p;
 						continue;
 					}
+					/* If only reading one more argument:
+					 * If we have exactly one field, read that field without its terminator.
+					 * If we have more than one field, read all fields including their terminators,
+					 * except for trailing IFS whitespace.
+					 *
+					 * This means that if we have only IFS characters left, and at most one
+					 * of them is non-whitespace, we stop reading here.
+					 * Otherwise, we read all the remaining characters except for trailing
+					 * IFS whitespace.
+					 *
+					 * To keep track of this, the variable s indicates what we've seen so far.
+					 * 0: only IFS whitespace.
+					 * 1: exactly one IFS non-whitespace character.
+					 * 2: non-IFS characters, or multiple IFS non-whitespace characters.
+					 *
+					 * In any case, q indicates the start of the characters to remove, or NULL
+					 * if no characters should be removed.
+					 */
+					if (maxargs == 1) {
+						int s = !ifsspc;
+						q = p;
+						for (;;) {
+							p++;
+							if (p >= string + ifsp->endoff) {
+								if (q)
+									*q = '\0';
+								goto add;
+							}
+							if (*p == (char)CTLESC)
+								p++;
+							if (strchr(ifs, *p)) {
+								if (strchr(defifs, *p)) {
+									if (!q)
+										q = p;
+									continue;
+								}
+								if (s == 0) {
+									s = 1;
+									continue;
+								}
+							}
+							s = 2;
+							q = 0;
+						}
+					}
 					*q = '\0';
 					sp = (struct strlist *)stalloc(sizeof *sp);
 					sp->text = start;
 					*arglist->lastp = sp;
 					arglist->lastp = &sp->next;
 					p++;
+					if (maxargs) maxargs--;
 					if (!nulonly) {
 						for (;;) {
 							if (p >= string + ifsp->endoff) {
diff --git a/src/expand.h b/src/expand.h
index 6a90f67..26dc5b4 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -69,7 +69,7 @@ char *_rmescapes(char *, int);
 int casematch(union node *, char *);
 void recordregion(int, int, int);
 void removerecordregions(int); 
-void ifsbreakup(char *, struct arglist *);
+void ifsbreakup(char *, int, struct arglist *);
 void ifsfree(void);
 
 /* From arith.y */
diff --git a/src/miscbltin.c b/src/miscbltin.c
index b596fd2..39b9c47 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -67,28 +67,21 @@
  *  less fields than variables -> remaining variables unset.
  *
  *  @param line complete line of input
+ *  @param ac argument count
  *  @param ap argument (variable) list
  *  @param len length of line including trailing '\0'
  */
 static void
-readcmd_handle_line(char *s, char **ap)
+readcmd_handle_line(char *s, int ac, char **ap)
 {
 	struct arglist arglist;
 	struct strlist *sl;
-	char *backup;
-	char *line;
 
-	/* ifsbreakup will fiddle with stack region... */
-	line = stackblock();
 	s = grabstackstr(s);
 
-	/* need a copy, so that delimiters aren't lost
-	 * in case there are more fields than variables */
-	backup = sstrdup(line);
-
 	arglist.lastp = &arglist.list;
 	
-	ifsbreakup(s, &arglist);
+	ifsbreakup(s, ac, &arglist);
 	*arglist.lastp = NULL;
 	ifsfree();
 
@@ -104,21 +97,6 @@ readcmd_handle_line(char *s, char **ap)
 			return;
 		}
 
-		/* remaining fields present, but no variables left. */
-		if (!ap[1] && sl->next) {
-			size_t offset;
-			char *remainder;
-
-			/* FIXME little bit hacky, assuming that ifsbreakup 
-			 * will not modify the length of the string */
-			offset = sl->text - s;
-			remainder = backup + offset;
-			rmescapes(remainder);
-			setvar(*ap, remainder, 0);
--------------060209000805040806040003--
