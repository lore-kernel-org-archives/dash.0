From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/4] [VAR] Add localvars nesting
Date: Thu, 27 May 2010 13:34:37 +1000
Message-ID: <20100527033437.GA5323@gondor.apana.org.au>
References: <20100526105948.GA26352@gondor.apana.org.au> <E1OHELf-0006sP-9S@gondolin.me.apana.org.au> <20100526215533.GA5679@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ringil.hengli.com.au ([216.59.3.182]:60113 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753983Ab0E0Dem (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 26 May 2010 23:34:42 -0400
Content-Disposition: inline
In-Reply-To: <20100526215533.GA5679@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org, pape@smarden.org

On Wed, May 26, 2010 at 11:55:33PM +0200, Jilles Tjoelker wrote:
>
> > @@ -950,13 +947,13 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
> >  	shellparam.p = argv + 1;
> >  	shellparam.optind = 1;
> >  	shellparam.optoff = -1;
> > +	pushlocalvars();
> >  	evaltree(&func->n, flags & EV_TESTED);
> > +	poplocalvars();
> >  funcdone:
> >  	INTOFF;
> >  	funcnest--;
> >  	freefunc(func);
> > -	poplocalvars();
> > -	localvars = savelocalvars;
> >  	freeparam(&shellparam);
> >  	shellparam = saveparam;
> >  	handler = savehandler;
> 
> This change does not do poplocalvars() if the function was exited with
> an error. While this is normally not a problem because the shell exits
> or executes the RESET actions, 'command eval', 'command .' and 'fc' will
> "catch" any errors and continue normally.
> 
> Example (with the below "disallow local outside a function" change):
>   dash -c 'f() { unset xyz; ${xyz?}; }; command eval f; local i'

Thanks for catching this! The following patch should fix that
problem.  BTW, the same issue has existed for redirections for
quite some time.  I will fix this in a subsequent patch.

> This change (failing local outside functions), while a good idea, should
> be mentioned in the commit message/changelog, as it might break certain
> scripts.

I will modify the Changelog to highlight this change.

commit 127788364951212c356aadc39deb21e01b0161c8
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu May 27 11:32:55 2010 +0800

    [VAR] Fix poplocalvar on abnormal exit from function
    
    The new localvar code broke the abnormal exit from functions
    and built-ins by not restoring the original localvar state.
    
    This patch fixes this by storing the previous localvar state so
    that we always unwind correctly in case of an abnormal exit.
    
    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index bf1f13c..c9b5e75 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2010-05-27  Herbert Xu <herbert@gondor.apana.org.au>
+
+	* Fix poplocalvar on abnormal exit from function.
+
 2010-05-26  Herbert Xu <herbert@gondor.apana.org.au>
 
 	* Replace cmdenviron with localvars.
diff --git a/src/eval.c b/src/eval.c
index a6981a9..2cd931b 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -681,6 +681,7 @@ evalcommand(union node *cmd, int flags, struct backcmd *backcmd)
 evalcommand(union node *cmd, int flags)
 #endif
 {
+	struct localvar_list *localvar_stop;
 	struct stackmark smark;
 	union node *argp;
 	struct arglist arglist;
@@ -703,7 +704,7 @@ evalcommand(union node *cmd, int flags)
 	/* First expand the arguments. */
 	TRACE(("evalcommand(0x%lx, %d) called\n", (long)cmd, flags));
 	setstackmark(&smark);
-	pushlocalvars();
+	localvar_stop = pushlocalvars();
 	back_exitstatus = 0;
 
 	cmdentry.cmdtype = CMDBUILTIN;
@@ -837,7 +838,6 @@ bail:
 			if (forkshell(jp, cmd, FORK_FG) != 0) {
 				exitstatus = waitforjob(jp);
 				INTON;
-				poplocalvars(0);
 				break;
 			}
 			FORCEINTON;
@@ -878,6 +878,7 @@ raise:
 
 out:
 	popredir(execcmd);
+	unwindlocalvars(localvar_stop);
 	if (lastarg)
 		/* dsl: I think this is intended to be used to support
 		 * '_' in 'vi' command mode during line editing...
diff --git a/src/var.c b/src/var.c
index 40bd3fd..f456fbd 100644
--- a/src/var.c
+++ b/src/var.c
@@ -144,8 +144,7 @@ INIT {
 }
 
 RESET {
-	while (localvar_stack)
-		poplocalvars(0);
+	unwindlocalvars(0);
 }
 #endif
 
@@ -570,7 +569,7 @@ poplocalvars(int keep)
 /*
  * Create a new localvar environment.
  */
-void pushlocalvars(void)
+struct localvar_list *pushlocalvars(void)
 {
 	struct localvar_list *ll;
 
@@ -580,6 +579,15 @@ void pushlocalvars(void)
 	ll->next = localvar_stack;
 	localvar_stack = ll;
 	INTON;
+
+	return ll->next;
+}
+
+
+void unwindlocalvars(struct localvar_list *stop)
+{
+	while (localvar_stack != stop)
+		poplocalvars(0);
 }
 
 
diff --git a/src/var.h b/src/var.h
index ef6d583..7e7e505 100644
--- a/src/var.h
+++ b/src/var.h
@@ -69,6 +69,8 @@ struct localvar {
 	const char *text;		/* saved text */
 };
 
+struct localvar_list;
+
 
 extern struct localvar *localvars;
 extern struct var varinit[];
@@ -139,8 +141,9 @@ int showvars(const char *, int, int);
 int exportcmd(int, char **);
 int localcmd(int, char **);
 void mklocal(char *);
-void pushlocalvars(void);
+struct localvar_list *pushlocalvars(void);
 void poplocalvars(int);
+void unwindlocalvars(struct localvar_list *stop);
 int unsetcmd(int, char **);
 void unsetvar(const char *);
 int varcmp(const char *, const char *);

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
