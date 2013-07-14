From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: "command -p" does not correctly limit search to a safe PATH
Date: Sun, 14 Jul 2013 21:54:58 +0200
Message-ID: <51E30212.3030901@gigawatt.nl>
References: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010403030505080300030307"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:46142 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753108Ab3GNU5B (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 14 Jul 2013 16:57:01 -0400
In-Reply-To: <CAL=-wemDL=2-7Rco761LTgGrFeAA_-zvz0ECpk4xZE7QJsGUEg@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Craig Loomis <cploomis@gmail.com>
Cc: dash@vger.kernel.org

This is a multi-part message in MIME format.
--------------010403030505080300030307
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/13 20:18, Craig Loomis wrote:
>   Dash (0.5.7 and git master) does not implement 'command -p'
> according to the standard, and opens an intriguing security hole to
> anyone trying this scheme.
> 
>   When using 'command -v' to simply print the path to an executable,
> '-p' has no effect:

You're right. dash has never supported combining -p with -v, but back in
2005 this was seemingly accidentally changed from reporting a syntax
error to silently ignoring the -p option, only about a month after dash
moved to git.

Making sure that -p is respected even when -v is used is easy enough,
see attached patch. Tested even with explicit PATH overrides:
  PATH=/path/to/some/other/dash command -pv dash
correctly outputs /bin/dash on my system.

> the path that 'command -p cmd' uses is a compiled-in constant
> from dash's src/var.c:defpathvar, which starts with
> "/usr/local/sbin:/usr/local/bin". To me, that is both completely
> unexpected and pretty scary -- /usr/local/bin is (very) often less
> well secured or checked than, say, /bin:

Agreed. However, IMO, it does make sense for defpathvar to start with
/usr/local/*: it has two separate functions, it also serves as the
default path (hence the name) when dash is started with no PATH set at
all. I think fixing this should be done in a way so that command -p does
not use defpathvar, not by changing defpathvar. bash uses the same
confstr function for this that getconf uses, and it shouldn't be too
much work to make dash use that too. If no one else comes up with a
working patch or a better approach, I'll try to get that working.

Cheers,
Harald

--------------010403030505080300030307
Content-Type: text/x-patch;
 name="dash-command-pv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-command-pv.patch"

commit 475e328589fd2e843c138d49fb96699a2a66151d
Author: Harald van Dijk <harald@gigawatt.nl>
Date:   Sun Jul 14 21:23:01 2013 +0200

    command: allow combining -p with -v

diff --git a/src/exec.c b/src/exec.c
index 79e2007..e56e3f6 100644
--- a/src/exec.c
+++ b/src/exec.c
@@ -96,7 +96,7 @@ STATIC void clearcmdentry(int);
 STATIC struct tblentry *cmdlookup(const char *, int);
 STATIC void delete_cmd_entry(void);
 STATIC void addcmdentry(char *, struct cmdentry *);
-STATIC int describe_command(struct output *, char *, int);
+STATIC int describe_command(struct output *, char *, const char *, int);
 
 
 /*
@@ -727,21 +727,21 @@ typecmd(int argc, char **argv)
 	int err = 0;
 
 	for (i = 1; i < argc; i++) {
-		err |= describe_command(out1, argv[i], 1);
+		err |= describe_command(out1, argv[i], pathval(), 1);
 	}
 	return err;
 }
 
 STATIC int
-describe_command(out, command, verbose)
+describe_command(out, command, path, verbose)
 	struct output *out;
 	char *command;
+	const char *path;
 	int verbose;
 {
 	struct cmdentry entry;
 	struct tblentry *cmdp;
 	const struct alias *ap;
-	const char *path = pathval();
 
 	if (verbose) {
 		outstr(command, out);
@@ -840,20 +840,23 @@ commandcmd(argc, argv)
 		VERIFY_BRIEF = 1,
 		VERIFY_VERBOSE = 2,
 	} verify = 0;
+	const char *path = pathval();
 
 	while ((c = nextopt("pvV")) != '\0')
 		if (c == 'V')
 			verify |= VERIFY_VERBOSE;
 		else if (c == 'v')
 			verify |= VERIFY_BRIEF;
+		else if (c == 'p')
+			path = defpath;
 #ifdef DEBUG
-		else if (c != 'p')
+		else
 			abort();
 #endif
 
 	cmd = *argptr;
 	if (verify && cmd)
-		return describe_command(out1, cmd, verify - VERIFY_BRIEF);
+		return describe_command(out1, cmd, path, verify - VERIFY_BRIEF);
 
 	return 0;
 }

--------------010403030505080300030307--
