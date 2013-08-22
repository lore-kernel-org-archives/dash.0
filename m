From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH] implement privmode support in dash
Date: Thu, 22 Aug 2013 21:59:36 +0200
Message-ID: <52166DA8.1000201@gigawatt.nl>
References: <20130822175936.GA1260@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010302060307030107040903"
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter.csv-networks.nl ([84.244.149.121]:46714 "EHLO
	mailfilter.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754503Ab3HVT7v (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 22 Aug 2013 15:59:51 -0400
In-Reply-To: <20130822175936.GA1260@google.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Tavis Ormandy <taviso@google.com>
Cc: dash@vger.kernel.org, oss-security@lists.openwall.com

This is a multi-part message in MIME format.
--------------010302060307030107040903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 22/08/13 19:59, Tavis Ormandy wrote:
> Hello, this is a patch to add privmode support to dash. privmode attempts to
> drop privileges by default if the effective uid does not match the uid. This
> can be disabled with -p, or -o nopriv.

Hi Tavis,

Your approach definitely has my support (FWTW), but there are two
aspects that surprised me, and are different from bash and FreeBSD's sh:

You named the option nopriv, while bash and FBSD use the name
privileged. I think it is likely to confuse people if "bash -o
privileged" and "dash -o nopriv" do the same thing, and that it would be
better to match bash and give the option a positive name, such as
"priv", or perhaps even match them exactly and use "privileged".

In bash and FBSD, after starting with -p, set +p can be used to drop
privileges. With your patch, dash accepts set +p, but silently ignores it.

How does something like the attached, to be applied on top of your
patch, look?

Cheers,
Harald

--------------010302060307030107040903
Content-Type: text/x-patch;
 name="dash-priv-addon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dash-priv-addon.patch"

diff --git a/src/Makefile.am b/src/Makefile.am
index 2a37381..82d00fb 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -21,14 +21,14 @@ bin_PROGRAMS = dash
 dash_CFILES = \
 	alias.c arith_yacc.c arith_yylex.c cd.c error.c eval.c exec.c expand.c \
 	histedit.c input.c jobs.c mail.c main.c memalloc.c miscbltin.c \
-	mystring.c options.c parser.c redir.c show.c trap.c output.c \
+	mystring.c options.c parser.c priv.c redir.c show.c trap.c output.c \
 	bltin/printf.c system.c bltin/test.c bltin/times.c var.c
 dash_SOURCES = \
 	$(dash_CFILES) \
 	alias.h arith_yacc.h bltin/bltin.h cd.h error.h eval.h exec.h \
 	expand.h hetio.h \
 	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
-	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
+	myhistedit.h mystring.h options.h output.h parser.h priv.h redir.h shell.h \
 	show.h system.h trap.h var.h
 dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o
 
diff --git a/src/dash.1 b/src/dash.1
index 94fc642..0f35748 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -257,7 +257,7 @@ if it has been set).
 .It Fl b Em notify
 Enable asynchronous notification of background job completion.
 (UNIMPLEMENTED for 4.4alpha)
-.It Fl p Em nopriv
+.It Fl p Em priv
 Do not attempt to reset effective uid if it does not match uid. This is not set
 by default to help avoid incorrect usage by setuid root programs via system(3) or
 popen(3).
diff --git a/src/main.c b/src/main.c
index e106848..69e5e07 100644
--- a/src/main.c
+++ b/src/main.c
@@ -50,6 +50,7 @@
 #include "eval.h"
 #include "jobs.h"
 #include "input.h"
+#include "priv.h"
 #include "trap.h"
 #include "var.h"
 #include "show.h"
@@ -97,8 +98,6 @@ main(int argc, char **argv)
 	struct jmploc jmploc;
 	struct stackmark smark;
 	int login;
-	uid_t uid;
-	gid_t gid;
 
 #ifdef __GLIBC__
 	dash_errno = __errno_location();
@@ -154,17 +153,6 @@ main(int argc, char **argv)
 	setstackmark(&smark);
 	login = procargs(argc, argv);
 
-	/*
-	 * To limit bogus system(3) or popen(3) calls in setuid binaries, require
-	 * -p flag to work in this situation.
-	 */
-	if (!pflag && (uid != geteuid() || gid != getegid())) {
-		setuid(uid);
-		setgid(gid);
-		/* PS1 might need to be changed accordingly. */
-		choose_ps1();
-	}
-
 	if (login) {
 		state = 1;
 		read_profile("/etc/profile");
diff --git a/src/options.c b/src/options.c
index 99ac55b..c640a41 100644
--- a/src/options.c
+++ b/src/options.c
@@ -45,6 +45,7 @@
 #include "jobs.h"
 #include "input.h"
 #include "output.h"
+#include "priv.h"
 #include "trap.h"
 #include "var.h"
 #include "memalloc.h"
@@ -79,7 +80,7 @@ static const char *const optnames[NOPTS] = {
 	"allexport",
 	"notify",
 	"nounset",
-	"nopriv",
+	"priv",
 	"nolog",
 	"debug",
 };
@@ -184,6 +185,7 @@ optschanged(void)
 #ifdef DEBUG
 	opentrace();
 #endif
+	setprivileged(pflag);
 	setinteractive(iflag);
 #ifndef SMALL
 	histedit();
diff --git a/src/priv.c b/src/priv.c
new file mode 100644
index 0000000..26346c0
--- /dev/null
+++ b/src/priv.c
@@ -0,0 +1,27 @@
+#include <unistd.h>
+
+#include "priv.h"
+#include "var.h"
+
+uid_t uid;
+gid_t gid;
+
+void setprivileged(int on)
+{
+	static int is_privileged = 1;
+	if (is_privileged == on)
+		return;
+
+	is_privileged = on;
+
+	/*
+	 * To limit bogus system(3) or popen(3) calls in setuid binaries, require
+	 * -p flag to work in this situation.
+	 */
+	if (!on && (uid != geteuid() || gid != getegid())) {
+		setuid(uid);
+		setgid(gid);
+		/* PS1 might need to be changed accordingly. */
+		choose_ps1();
+	}
+}
diff --git a/src/priv.h b/src/priv.h
new file mode 100644
index 0000000..31b380b
--- /dev/null
+++ b/src/priv.h
@@ -0,0 +1,6 @@
+#include <unistd.h>
+
+extern uid_t uid;
+extern gid_t gid;
+
+void setprivileged(int on);
diff --git a/src/var.c b/src/var.c
index cafe407..277777f 100644
--- a/src/var.c
+++ b/src/var.c
@@ -192,13 +192,12 @@ initvar(void)
 void
 choose_ps1(void)
 {
-	if (vps1.flags & VEXPORT)
-		return;
--------------010302060307030107040903--
