From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Fri, 29 May 2015 00:39:10 +0200
Message-ID: <5567990E.3090902@gigawatt.nl>
References: <5567644F.3080909@inlv.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030806080205060008060703"
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:41096 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755116AbbE1XGf (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 28 May 2015 19:06:35 -0400
In-Reply-To: <5567644F.3080909@inlv.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Martijn Dekker <martijn@inlv.org>
Cc: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806080205060008060703
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2015 20:54, Martijn Dekker wrote:
> I'm writing a shell function that extends the functionality of the
> 'getopts' builtin. For that to work, it is necessary to call the
> 'getopts' builtin from the shell function.
>
> The POSIX standard specifies that OPTIND and OPTARG are global
> variables, even though the positional parameters are local to the
> function.[*] This makes it possible to call 'getopts' from a function by
> simply passing the global positional parameters along by adding "$@".
>
> My problem is that dash does not properly update the global OPTIND
> variable when getopts is called from a function, which defeats my
> function on dash. It updates the global OPTIND for the first option but
> not for subsequent options, so OPTIND gets stuck on 3. (It does
> accurately update the global OPTARG variable, though.)

That isn't the problem, not exactly anyway. The problem is that getopts 
is required to keep internal state separately from the OPTIND variable 
(a single integer is insufficient to track the progress when multiple 
options are combined in a single word), and that internal state is 
stored along with the positional parameters. The positional parameters 
are saved just before a function call, and restored when the function 
returns. The internal state of getopts should not be saved the same way. 
It should probably just be global to dash.

A quick patch to make sure it is global, and isn't reset when it 
shouldn't or doesn't need to be, is attached. You can experiment with 
it, if you like. Your script runs as expected with this patch. However, 
I should warn that I have done far too little investigation to actually 
submit this patch for inclusion at this point. I'll do more extensive 
checking, and testing, later. If someone else can check whether the 
patch is okay, and if not, in what cases it fails, that would be very 
welcome too.

Note that any changes could break existing scripts, that (incorrectly) 
rely on dash's current behaviour of implicitly resetting the state, and 
don't bother setting OPTIND to explicitly reset it when they want to 
parse a new set of arguments.

Cheers,
Harald van Dijk

--------------030806080205060008060703
Content-Type: text/plain; charset=windows-1252;
 name="getopts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="getopts.patch"

diff --git a/src/eval.c b/src/eval.c
index 071fb1b..59e7506 100644
--- a/src/eval.c
+++ b/src/eval.c
@@ -953,8 +953,6 @@ evalfun(struct funcnode *func, int argc, char **argv, int flags)
 	INTON;
 	shellparam.nparam = argc - 1;
 	shellparam.p = argv + 1;
-	shellparam.optind = 1;
-	shellparam.optoff = -1;
 	pushlocalvars();
 	evaltree(func->n.ndefun.body, flags & EV_TESTED);
 	poplocalvars(0);
diff --git a/src/options.c b/src/options.c
index 6f381e6..5b24eeb 100644
--- a/src/options.c
+++ b/src/options.c
@@ -163,8 +163,8 @@ setarg0:
 	}
 
 	shellparam.p = xargv;
-	shellparam.optind = 1;
-	shellparam.optoff = -1;
+	shoptind = 1;
+	shoptoff = -1;
 	/* assert(shellparam.malloc == 0 && shellparam.nparam == 0); */
 	while (*xargv) {
 		shellparam.nparam++;
@@ -316,8 +316,6 @@ setparam(char **argv)
 	shellparam.malloc = 1;
 	shellparam.nparam = nparam;
 	shellparam.p = newparam;
-	shellparam.optind = 1;
-	shellparam.optoff = -1;
 }
 
 
@@ -362,8 +360,6 @@ shiftcmd(int argc, char **argv)
 	}
 	ap2 = shellparam.p;
 	while ((*ap2++ = *ap1++) != NULL);
-	shellparam.optind = 1;
-	shellparam.optoff = -1;
 	INTON;
 	return 0;
 }
@@ -394,8 +390,8 @@ void
 getoptsreset(value)
 	const char *value;
 {
-	shellparam.optind = number(value) ?: 1;
-	shellparam.optoff = -1;
+	shoptind = number(value) ?: 1;
+	shoptoff = -1;
 }
 
 /*
@@ -412,20 +408,10 @@ getoptscmd(int argc, char **argv)
 
 	if (argc < 3)
 		sh_error("Usage: getopts optstring var [arg]");
-	else if (argc == 3) {
+	else if (argc == 3)
 		optbase = shellparam.p;
-		if ((unsigned)shellparam.optind > shellparam.nparam + 1) {
-			shellparam.optind = 1;
-			shellparam.optoff = -1;
-		}
-	}
-	else {
+	else
 		optbase = &argv[3];
-		if ((unsigned)shellparam.optind > argc - 2) {
-			shellparam.optind = 1;
-			shellparam.optoff = -1;
-		}
-	}
 
 	return getopts(argv[1], argv[2], optbase);
 }
@@ -438,10 +424,10 @@ getopts(char *optstr, char *optvar, char **optfirst)
 	int done = 0;
 	char s[2];
 	char **optnext;
-	int ind = shellparam.optind;
-	int off = shellparam.optoff;
+	int ind = shoptind;
+	int off = shoptoff;
 
-	shellparam.optind = -1;
+	shoptind = -1;
 	optnext = optfirst + ind - 1;
 
 	if (ind <= 1 || off < 0 || strlen(optnext[-1]) < off)
@@ -509,8 +495,8 @@ out:
 	s[1] = '\0';
 	setvar(optvar, s, 0);
 
-	shellparam.optoff = p ? p - *(optnext - 1) : -1;
-	shellparam.optind = ind;
+	shoptoff = p ? p - *(optnext - 1) : -1;
+	shoptind = ind;
 
 	return done;
 }
diff --git a/src/options.h b/src/options.h
index 975fe33..8295eb9 100644
--- a/src/options.h
+++ b/src/options.h
@@ -38,9 +38,9 @@ struct shparam {
 	int nparam;		/* # of positional parameters (without $0) */
 	unsigned char malloc;	/* if parameter list dynamically allocated */
 	char **p;		/* parameter list */
-	int optind;		/* next parameter to be processed by getopts */
-	int optoff;		/* used by getopts */
 };
+int shoptind;		/* next parameter to be processed by getopts */
+int shoptoff;		/* used by getopts */
 
 
 

--------------030806080205060008060703--
