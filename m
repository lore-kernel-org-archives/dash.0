From: Harald van Dijk <harald@gigawatt.nl>
Subject: [Partial patch] IFS and read builtin
Date: Sat, 21 Aug 2010 21:18:53 +0159
Message-ID: <4C7026B5.2070902@gigawatt.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050006040105060101040804"
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:49500 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab0HWGx7 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Aug 2010 02:53:59 -0400
Received: from cp1107341-a.dbsch1.nb.home.nl ([84.31.115.1] helo=[192.168.1.68])
	by hosting12.csv-networks.nl with esmtpa (Exim 4.68)
	(envelope-from <harald@gigawatt.nl>)
	id 1OmtRy-0007RJ-AH
	for dash@vger.kernel.org; Sat, 21 Aug 2010 21:09:54 +0200
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006040105060101040804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

  Hi, as has been reported already dash currently has a bug where the 
read builtin ignores the read environment's IFS setting. As a result,

   echo a:b | { IFS=: read a b; echo $a; }

will write out a:b. I tried to see what changed between 0.5.5.1 and 
0.5.6, and found that the old code used bltinlookup("IFS"). So, I made 
the new code also use that. The above example works properly with the 
attached patch.

However, testing further, I found that there is bad interaction (even 
without my patch, where the IFS assignment below should just be ignored) 
between the code that handles variable assignments, and read. Try this:

   $ src/dash -c 'printf "a\t\tb\n" | { IFS=$(printf "\t") read a b c; 
echo "|$a|$b|$c|"; }'
   |a||b|
   $ src/dash -c 'printf "a\t\tb\n" | { IFS="$(printf "\t")" read a b c; 
echo "|$a|$b|$c|"; }'
   |a|b||

This happens because expbackq is correctly called without EXP_QUOTED, 
which makes it call recordregion, which isn't cleared by the time read 
calls ifsbreakup. I'm not sure how that should be solved, and if there 
are more cases where it would fail. The simplest way to solve this for 
read is to call removerecordregions(0) before recordregion(0, len - 1, 
0). I have tested that locally, and it works. I am not familiar enough 
with the code to judge whether the same situation can also happen in 
other cases that would also need fixing, which is why I have not 
included that part in the attached patch.

Cheers,
Harald

--------------050006040105060101040804
Content-Type: text/plain;
 name="dash-read-ifs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-read-ifs.patch"

diff --git a/src/expand.c b/src/expand.c
index f2f964c..3ba1a38 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -205,7 +205,7 @@ expandarg(union node *arg, struct arglist *arglist, int flag)
 	 * TODO - EXP_REDIR
 	 */
 	if (flag & EXP_FULL) {
-		ifsbreakup(p, &exparg);
+		ifsbreakup(p, &exparg, 0);
 		*exparg.lastp = NULL;
 		exparg.lastp = &exparg.list;
 		expandmeta(exparg.list, flag);
@@ -1022,9 +1022,11 @@ recordregion(int start, int end, int nulonly)
  * Break the argument string into pieces based upon IFS and add the
  * strings to the argument list.  The regions of the string to be
  * searched for IFS characters have been stored by recordregion.
+ * If bltin is set, use bltinlookup to search for IFS in the
+ * environment of the currently executing built-in command.
  */
 void
-ifsbreakup(char *string, struct arglist *arglist)
+ifsbreakup(char *string, struct arglist *arglist, int bltin)
 {
 	struct ifsregion *ifsp;
 	struct strlist *sp;
@@ -1040,7 +1042,13 @@ ifsbreakup(char *string, struct arglist *arglist)
 	if (ifslastp != NULL) {
 		ifsspc = 0;
 		nulonly = 0;
-		realifs = ifsset() ? ifsval() : defifs;
+		if (!bltin)
+			realifs = ifsset() ? ifsval() : defifs;
+		else {
+			realifs = bltinlookup("IFS");
+			if (realifs == NULL)
+				realifs = defifs;
+		}
 		ifsp = &ifsfirst;
 		do {
 			p = string + ifsp->begoff;
diff --git a/src/expand.h b/src/expand.h
index 405af0b..8eb5f07 100644
--- a/src/expand.h
+++ b/src/expand.h
@@ -69,7 +69,7 @@ char *_rmescapes(char *, int);
 int casematch(union node *, char *);
 void recordregion(int, int, int);
 void removerecordregions(int); 
-void ifsbreakup(char *, struct arglist *);
+void ifsbreakup(char *, struct arglist *, int bltin);
 
 /* From arith.y */
 intmax_t arith(const char *);
diff --git a/src/miscbltin.c b/src/miscbltin.c
index 5ab1648..898ab09 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -87,7 +87,7 @@ readcmd_handle_line(char *line, char **ap, size_t len)
 	arglist.lastp = &arglist.list;
 	recordregion(0, len - 1, 0);
 	
-	ifsbreakup(s, &arglist);
+	ifsbreakup(s, &arglist, 1);
 	*arglist.lastp = NULL;
 	removerecordregions(0);
 

--------------050006040105060101040804--
