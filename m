Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061C1B974
	for <dash@vger.kernel.org>; Sun, 21 Apr 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713733015; cv=none; b=JEzWVvHBAHcNzTZXbu+BAo7S/S14LoQeUaLADJmDzj9QsPhnRpr+ZH5kRa7KkkzuHpJzozmEhpYNDoRqQAq4Qy9AxKO9r92Oi8fe+CH5HyvJjVxuHUWn3lydTGzrR3XOwCQK7ATtRProUHVbREy3tiAoKy71Ilt2MvkSD3y3kZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713733015; c=relaxed/simple;
	bh=JXwaO2/5JUk1GX4gVfRpxN9U6DJsjyKAxWdkYANJzPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F3smmCfwTGdGC0kYnQDswMpTpBph4W/+rEcCYw+UpSYQyVuvscmL8XbbufmQ5hYhM27Yj8rqO0gIsWptL4dy5E5x7kqn+Rg+UEvMwsKdNzk4Ey61Qz/4BCfTGNLEYhKZk3bzP8lSG5ioxjWMawg38oKj+09QhPhsCPi9nFtVw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se; spf=pass smtp.mailfrom=lxm.se; dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b=R98+Yha6; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lxm.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b="R98+Yha6"
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id D0F8E3004371
	for <dash@vger.kernel.org>; Sun, 21 Apr 2024 22:48:16 +0200 (CEST)
Received: from s979.loopia.se (unknown [172.22.191.6])
	by s807.loopia.se (Postfix) with ESMTP id C11F92E2D019
	for <dash@vger.kernel.org>; Sun, 21 Apr 2024 22:48:16 +0200 (CEST)
Received: from s474.loopia.se (unknown [172.22.191.6])
	by s979.loopia.se (Postfix) with ESMTP id BFC7410BC393
	for <dash@vger.kernel.org>; Sun, 21 Apr 2024 22:48:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.21
X-Spam-Level:
Authentication-Results: s474.loopia.se (amavisd-new); dkim=pass (2048-bit key)
	header.d=lxm.se
Received: from s979.loopia.se ([172.22.191.5])
	by s474.loopia.se (s474.loopia.se [172.22.190.14]) (amavisd-new, port 10024)
	with LMTP id ICXfm7Dj-fUW; Sun, 21 Apr 2024 22:48:15 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: henrik@lxm.se
X-Loopia-Originating-IP: 92.35.23.126
Received: from pc.arpa.home (c-7e17235c.012-196-6c6b701.bbcust.telenor.se [92.35.23.126])
	(Authenticated sender: henrik@lxm.se)
	by s979.loopia.se (Postfix) with ESMTPSA id 4D8C110BC385;
	Sun, 21 Apr 2024 22:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxm.se;
	s=loopiadkim1708025221; t=1713732495;
	bh=zqpfghey5osY9Vrc2bZ2DIY4Tg1iio9jahPrv5eIAxM=;
	h=From:To:Cc:Subject:Date;
	b=R98+Yha67hVXY6v8bsnSJlU5Mbv7pLncLGilBcPLAwWMRyQCj4bU4cRUR/vbxH43b
	 Wr3jrWmQfC5W6A9V1g5Yl5iOuMrD3wXis8ED2sedsEHnK95HzSRPoEi6mbRyLTHg6E
	 SHHFO3hzyQ2l5wUZyUqVIs+9B1bXKN1x8EtJvx2k+3XpC1FT+rzSZIsdxFwWZcHtvw
	 9v46l1NOhPRB9t1hPy3kHIruOChXWvJgfjBPsiLk9Po91DOlqhA6h/NOeuvOZ6OqHQ
	 6YROskplKh3se5Q0oSA8jK8TyZBAV8OuHhVo0mzUxVz+A+/wusgHvHCrgI799k1zQu
	 7erHBl1ETNrxg==
From: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
To: dash@vger.kernel.org
Cc: =?UTF-8?q?Henrik=20Lindstr=C3=B6m?= <henrik@lxm.se>
Subject: [PATCH] Generate signal names at runtime
Date: Sun, 21 Apr 2024 22:46:48 +0200
Message-Id: <20240421204648.1156887-1-henrik@lxm.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

They were previously generated at buildtime by mksignames.c, but that
approach had two flaws:
1. The signal names were generated for the host system rather than the
   target system, resulting in broken cross-compiled builds.
2. The SIGRTMIN and SIGRTMAX macros are usually implemented as
   function calls and can only be surely known at runtime.

The new implementation has been tested to generate identical signal names
as before on these systems:
* Debian 12 (glibc, odd number of realtime signals)
* Alpine 3.18 (musl, even number of realtime signals)
* FreeBSD 14

Signed-off-by: Henrik Lindström <henrik@lxm.se>
---
 COPYING          |  24 ---
 src/.gitignore   |   2 -
 src/Makefile.am  |  17 +-
 src/TOUR         |   1 -
 src/jobs.c       |   6 +-
 src/mksignames.c | 415 -----------------------------------------------
 src/signalname.c | 150 +++++++++++++++++
 src/signalname.h |   4 +
 src/trap.c       |   7 +-
 9 files changed, 167 insertions(+), 459 deletions(-)
 delete mode 100644 src/mksignames.c
 create mode 100644 src/signalname.c
 create mode 100644 src/signalname.h

diff --git a/COPYING b/COPYING
index 37f8189..c591477 100644
--- a/COPYING
+++ b/COPYING
@@ -30,27 +30,3 @@ HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 SUCH DAMAGE.
-
-mksignames.c:
-
-This file is not directly linked with dash.  However, its output is.
-
-Copyright (C) 1992 Free Software Foundation, Inc.
-
-This file is part of GNU Bash, the Bourne Again SHell.
-
-Bash is free software; you can redistribute it and/or modify it under
-the terms of the GNU General Public License as published by the Free
-Software Foundation; either version 2, or (at your option) any later
-version.
-
-Bash is distributed in the hope that it will be useful, but WITHOUT ANY
-WARRANTY; without even the implied warranty of MERCHANTABILITY or
-FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-for more details.
-
-You should have received a copy of the GNU General Public License with
-your Debian GNU/Linux system, in /usr/share/common-licenses/GPL, or with the
-Debian GNU/Linux hello source package as the file COPYING.  If not,
-write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
-Boston, MA 02111 USA.
diff --git a/src/.gitignore b/src/.gitignore
index 644eccb..660bbdd 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -5,9 +5,7 @@ dash
 init.c
 mkinit
 mknodes
-mksignames
 mksyntax
 nodes.[ch]
-signames.c
 syntax.[ch]
 token.h
diff --git a/src/Makefile.am b/src/Makefile.am
index 1732465..8d1dc37 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -6,20 +6,20 @@ COMMON_CPPFLAGS = \
 
 AM_CFLAGS = $(COMMON_CFLAGS)
 AM_CPPFLAGS = -include $(top_builddir)/config.h $(COMMON_CPPFLAGS)
-AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS) 
+AM_CFLAGS_FOR_BUILD = -g -O2 $(COMMON_CFLAGS)
 AM_CPPFLAGS_FOR_BUILD = $(COMMON_CPPFLAGS)
 
 COMPILE_FOR_BUILD = \
 	$(CC_FOR_BUILD) $(DEFAULT_INCLUDES) $(AM_CPPFLAGS_FOR_BUILD) \
 	$(CPPFLAGS_FOR_BUILD) \
-	$(AM_CFLAGS_FOR_BUILD) $(CFLAGS_FOR_BUILD) 
+	$(AM_CFLAGS_FOR_BUILD) $(CFLAGS_FOR_BUILD)
 
 bin_PROGRAMS = dash
 
 dash_CFILES = \
 	alias.c arith_yacc.c arith_yylex.c cd.c error.c eval.c exec.c expand.c \
 	histedit.c input.c jobs.c mail.c main.c memalloc.c miscbltin.c \
-	mystring.c options.c parser.c redir.c show.c trap.c output.c \
+	mystring.c options.c parser.c redir.c show.c signalname.c trap.c output.c \
 	bltin/printf.c system.c bltin/test.c bltin/times.c var.c
 dash_SOURCES = \
 	$(dash_CFILES) \
@@ -27,10 +27,10 @@ dash_SOURCES = \
 	expand.h \
 	init.h input.h jobs.h machdep.h mail.h main.h memalloc.h miscbltin.h \
 	myhistedit.h mystring.h options.h output.h parser.h redir.h shell.h \
-	show.h system.h trap.h var.h
-dash_LDADD = builtins.o init.o nodes.o signames.o syntax.o
+	show.h signalname.h system.h trap.h var.h
+dash_LDADD = builtins.o init.o nodes.o syntax.o
 
-HELPERS = mkinit mksyntax mknodes mksignames
+HELPERS = mkinit mksyntax mknodes
 
 BUILT_SOURCES = builtins.h nodes.h syntax.h token.h token_vars.h
 CLEANFILES = \
@@ -41,7 +41,7 @@ man_MANS = dash.1
 EXTRA_DIST = \
 	$(man_MANS) \
 	mktokens mkbuiltins builtins.def.in mkinit.c \
-	mknodes.c nodetypes nodes.c.pat mksyntax.c mksignames.c
+	mknodes.c nodetypes nodes.c.pat mksyntax.c
 
 token.h token_vars.h: mktokens
 	$(AM_V_GEN)$(SHELL) $^
@@ -61,9 +61,6 @@ nodes.c nodes.h: mknodes nodetypes nodes.c.pat
 syntax.c syntax.h: mksyntax
 	$(AM_V_GEN)./$^
 
-signames.c: mksignames
-	$(AM_V_GEN)./$^
-
 mksyntax: token.h
 
 $(HELPERS): %: %.c
diff --git a/src/TOUR b/src/TOUR
index e30836e..b554f13 100644
--- a/src/TOUR
+++ b/src/TOUR
@@ -26,7 +26,6 @@ programs is:
         mkbuiltins      builtins            builtins.h builtins.c
         mkinit          *.c                 init.c
         mknodes         nodetypes           nodes.h nodes.c
-        mksignames          -               signames.h signames.c
         mksyntax            -               syntax.h syntax.c
         mktokens            -               token.h
         bltin/mkexpr    unary_op binary_op  operators.h operators.c
diff --git a/src/jobs.c b/src/jobs.c
index 2a2fe22..6430cb3 100644
--- a/src/jobs.c
+++ b/src/jobs.c
@@ -71,6 +71,7 @@
 #include "error.h"
 #include "mystring.h"
 #include "system.h"
+#include "signalname.h"
 
 /* mode flags for set_curjob */
 #define CUR_DELETE 2
@@ -262,7 +263,6 @@ out:
 
 int killcmd(int argc, char **argv)
 {
-	extern char *signal_names[];
 	int signo = -1;
 	int list = 0;
 	int i;
@@ -320,7 +320,7 @@ usage:
 		if (!*argv) {
 			outstr("0\n", out);
 			for (i = 1; i < NSIG; i++) {
-				outfmt(out, snlfmt, signal_names[i]);
+				outfmt(out, snlfmt, signalname(i));
 			}
 			return 0;
 		}
@@ -328,7 +328,7 @@ usage:
 		if (signo > 128)
 			signo -= 128;
 		if (0 < signo && signo < NSIG)
-			outfmt(out, snlfmt, signal_names[signo]);
+			outfmt(out, snlfmt, signalname(signo));
 		else
 			sh_error("invalid signal number or exit status: %s",
 				 *argv);
diff --git a/src/mksignames.c b/src/mksignames.c
deleted file mode 100644
index 192728b..0000000
--- a/src/mksignames.c
+++ /dev/null
@@ -1,415 +0,0 @@
-/* signames.c -- Create and write `signames.c', which contains an array of
-   signal names. */
-
-/* Copyright (C) 1992 Free Software Foundation, Inc.
-
-   This file is part of GNU Bash, the Bourne Again SHell.
-
-   Bash is free software; you can redistribute it and/or modify it under
-   the terms of the GNU General Public License as published by the Free
-   Software Foundation; either version 2, or (at your option) any later
-   version.
-
-   Bash is distributed in the hope that it will be useful, but WITHOUT ANY
-   WARRANTY; without even the implied warranty of MERCHANTABILITY or
-   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
-   for more details.
-
-   You should have received a copy of the GNU General Public License along
-   with Bash; see the file COPYING.  If not, write to the Free Software
-   Foundation, 59 Temple Place, Suite 330, Boston, MA 02111 USA. */
-
-#include <stdio.h>
-#include <sys/types.h>
-#include <signal.h>
-#include <stdlib.h>
-
-#if !defined (NSIG)
-#  define NSIG 64
-#endif
-
-/*
- * Special traps:
- *	EXIT == 0
- */
-#define LASTSIG NSIG-1
-
-char *signal_names[2 * NSIG + 3];
-
-#define signal_names_size (sizeof(signal_names)/sizeof(signal_names[0]))
-
-char *progname;
-
-/* AIX 4.3 defines SIGRTMIN and SIGRTMAX as 888 and 999 respectively.
-   I don't want to allocate so much unused space for the intervening signal
-   numbers, so we just punt if SIGRTMAX is past the bounds of the
-   signal_names array (handled in configure). */
-#if defined (SIGRTMAX) && defined (UNUSABLE_RT_SIGNALS)
-#  undef SIGRTMAX
-#  undef SIGRTMIN
-#endif
-
-#if defined (SIGRTMAX) || defined (SIGRTMIN)
-#  define RTLEN 14
-#  define RTLIM 256
-#endif
-
-void
-initialize_signames ()
-{
-  register int i;
-#if defined (SIGRTMAX) || defined (SIGRTMIN)
-  int rtmin, rtmax, rtcnt;
-#endif
-
-  for (i = 1; i < signal_names_size; i++)
-    signal_names[i] = (char *)NULL;
-
-  /* `signal' 0 is what we do on exit. */
-  signal_names[0] = "EXIT";
-
-  /* Place signal names which can be aliases for more common signal
-     names first.  This allows (for example) SIGABRT to overwrite SIGLOST. */
-
-  /* POSIX 1003.1b-1993 real time signals, but take care of incomplete
-     implementations. Acoording to the standard, both, SIGRTMIN and
-     SIGRTMAX must be defined, SIGRTMIN must be stricly less than
-     SIGRTMAX, and the difference must be at least 7, that is, there
-     must be at least eight distinct real time signals. */
-
-  /* The generated signal names are SIGRTMIN, SIGRTMIN+1, ...,
-     SIGRTMIN+x, SIGRTMAX-x, ..., SIGRTMAX-1, SIGRTMAX. If the number
-     of RT signals is odd, there is an extra SIGRTMIN+(x+1).
-     These names are the ones used by ksh and /usr/xpg4/bin/sh on SunOS5. */
-
-#if defined (SIGRTMIN)
-  rtmin = SIGRTMIN;
-  signal_names[rtmin] = "RTMIN";
-#endif
-
-#if defined (SIGRTMAX)
-  rtmax = SIGRTMAX;
-  signal_names[rtmax] = "RTMAX";
-#endif
-
-#if defined (SIGRTMAX) && defined (SIGRTMIN)
-  if (rtmax > rtmin)
-    {
-      rtcnt = (rtmax - rtmin - 1) / 2;
-      /* croak if there are too many RT signals */
-      if (rtcnt >= RTLIM/2)
-	{
-	  rtcnt = RTLIM/2-1;
-	  fprintf(stderr, "%s: error: more than %i real time signals, fix `%s'\n",
-		  progname, RTLIM, progname);
-	}
-
-      for (i = 1; i <= rtcnt; i++)
-	{
-	  signal_names[rtmin+i] = (char *)malloc(RTLEN);
-	  if (signal_names[rtmin+i])
-	    sprintf (signal_names[rtmin+i], "RTMIN+%d", i);
-	  signal_names[rtmax-i] = (char *)malloc(RTLEN);
-	  if (signal_names[rtmax-i])
-	    sprintf (signal_names[rtmax-i], "RTMAX-%d", i);
-	}
-
-      if (rtcnt < RTLIM/2-1 && rtcnt != (rtmax-rtmin)/2)
-	{
-	  /* Need an extra RTMIN signal */
-	  signal_names[rtmin+rtcnt+1] = (char *)malloc(RTLEN);
-	  if (signal_names[rtmin+rtcnt+1])
-	    sprintf (signal_names[rtmin+rtcnt+1], "RTMIN+%d", rtcnt+1);
-	}
-    }
-#endif /* SIGRTMIN && SIGRTMAX */
-
-/* AIX */
-#if defined (SIGLOST)	/* resource lost (eg, record-lock lost) */
-  signal_names[SIGLOST] = "LOST";
-#endif
-
-#if defined (SIGMSG)	/* HFT input data pending */
-  signal_names[SIGMSG] = "MSG";
-#endif
-
-#if defined (SIGDANGER)	/* system crash imminent */
-  signal_names[SIGDANGER] = "DANGER";
-#endif
-
-#if defined (SIGMIGRATE) /* migrate process to another CPU */
-  signal_names[SIGMIGRATE] = "MIGRATE";
-#endif
-
-#if defined (SIGPRE)	/* programming error */
-  signal_names[SIGPRE] = "PRE";
-#endif
-
-#if defined (SIGVIRT)	/* AIX virtual time alarm */
-  signal_names[SIGVIRT] = "VIRT";
-#endif
-
-#if defined (SIGALRM1)	/* m:n condition variables */
-  signal_names[SIGALRM1] = "ALRM1";
-#endif
-
-#if defined (SIGWAITING)	/* m:n scheduling */
-  signal_names[SIGWAITING] = "WAITING";
-#endif
-
-#if defined (SIGGRANT)	/* HFT monitor mode granted */
-  signal_names[SIGGRANT] = "GRANT";
-#endif
-
-#if defined (SIGKAP)	/* keep alive poll from native keyboard */
-  signal_names[SIGKAP] = "KAP";
-#endif
-
-#if defined (SIGRETRACT) /* HFT monitor mode retracted */
-  signal_names[SIGRETRACT] = "RETRACT";
-#endif
-
-#if defined (SIGSOUND)	/* HFT sound sequence has completed */
-  signal_names[SIGSOUND] = "SOUND";
-#endif
-
-#if defined (SIGSAK)	/* Secure Attention Key */
-  signal_names[SIGSAK] = "SAK";
-#endif
-
-/* SunOS5 */
-#if defined (SIGLWP)	/* special signal used by thread library */
-  signal_names[SIGLWP] = "LWP";
-#endif
-
-#if defined (SIGFREEZE)	/* special signal used by CPR */
-  signal_names[SIGFREEZE] = "FREEZE";
-#endif
-
-#if defined (SIGTHAW)	/* special signal used by CPR */
-  signal_names[SIGTHAW] = "THAW";
-#endif
-
-#if defined (SIGCANCEL)	/* thread cancellation signal used by libthread */
-  signal_names[SIGCANCEL] = "CANCEL";
-#endif
-
-/* HP-UX */
-#if defined (SIGDIL)	/* DIL signal (?) */
-  signal_names[SIGDIL] = "DIL";
-#endif
-
-/* System V */
-#if defined (SIGCLD)	/* Like SIGCHLD.  */
-  signal_names[SIGCLD] = "CLD";
-#endif
-
-#if defined (SIGPWR)	/* power state indication */
-  signal_names[SIGPWR] = "PWR";
-#endif
-
-#if defined (SIGPOLL)	/* Pollable event (for streams)  */
-  signal_names[SIGPOLL] = "POLL";
-#endif
-
-/* Unknown */
-#if defined (SIGWINDOW)
-  signal_names[SIGWINDOW] = "WINDOW";
-#endif
-
-/* Common */
-#if defined (SIGHUP)	/* hangup */
-  signal_names[SIGHUP] = "HUP";
-#endif
-
-#if defined (SIGINT)	/* interrupt */
-  signal_names[SIGINT] = "INT";
-#endif
-
-#if defined (SIGQUIT)	/* quit */
-  signal_names[SIGQUIT] = "QUIT";
-#endif
-
-#if defined (SIGILL)	/* illegal instruction (not reset when caught) */
-  signal_names[SIGILL] = "ILL";
-#endif
-
-#if defined (SIGTRAP)	/* trace trap (not reset when caught) */
-  signal_names[SIGTRAP] = "TRAP";
-#endif
-
-#if defined (SIGIOT)	/* IOT instruction */
-  signal_names[SIGIOT] = "IOT";
-#endif
-
-#if defined (SIGABRT)	/* Cause current process to dump core. */
-  signal_names[SIGABRT] = "ABRT";
-#endif
-
-#if defined (SIGEMT)	/* EMT instruction */
-  signal_names[SIGEMT] = "EMT";
-#endif
-
-#if defined (SIGFPE)	/* floating point exception */
-  signal_names[SIGFPE] = "FPE";
-#endif
-
-#if defined (SIGKILL)	/* kill (cannot be caught or ignored) */
-  signal_names[SIGKILL] = "KILL";
-#endif
-
-#if defined (SIGBUS)	/* bus error */
-  signal_names[SIGBUS] = "BUS";
-#endif
-
-#if defined (SIGSEGV)	/* segmentation violation */
-  signal_names[SIGSEGV] = "SEGV";
-#endif
-
-#if defined (SIGSYS)	/* bad argument to system call */
-  signal_names[SIGSYS] = "SYS";
-#endif
-
-#if defined (SIGPIPE)	/* write on a pipe with no one to read it */
-  signal_names[SIGPIPE] = "PIPE";
-#endif
-
-#if defined (SIGALRM)	/* alarm clock */
-  signal_names[SIGALRM] = "ALRM";
-#endif
-
-#if defined (SIGTERM)	/* software termination signal from kill */
-  signal_names[SIGTERM] = "TERM";
-#endif
-
-#if defined (SIGURG)	/* urgent condition on IO channel */
-  signal_names[SIGURG] = "URG";
-#endif
-
-#if defined (SIGSTOP)	/* sendable stop signal not from tty */
-  signal_names[SIGSTOP] = "STOP";
-#endif
-
-#if defined (SIGTSTP)	/* stop signal from tty */
-  signal_names[SIGTSTP] = "TSTP";
-#endif
-
-#if defined (SIGCONT)	/* continue a stopped process */
-  signal_names[SIGCONT] = "CONT";
-#endif
-
-#if defined (SIGCHLD)	/* to parent on child stop or exit */
-  signal_names[SIGCHLD] = "CHLD";
-#endif
-
-#if defined (SIGTTIN)	/* to readers pgrp upon background tty read */
-  signal_names[SIGTTIN] = "TTIN";
-#endif
-
-#if defined (SIGTTOU)	/* like TTIN for output if (tp->t_local&LTOSTOP) */
-  signal_names[SIGTTOU] = "TTOU";
-#endif
-
-#if defined (SIGIO)	/* input/output possible signal */
-  signal_names[SIGIO] = "IO";
-#endif
-
-#if defined (SIGXCPU)	/* exceeded CPU time limit */
-  signal_names[SIGXCPU] = "XCPU";
-#endif
-
-#if defined (SIGXFSZ)	/* exceeded file size limit */
-  signal_names[SIGXFSZ] = "XFSZ";
-#endif
-
-#if defined (SIGVTALRM)	/* virtual time alarm */
-  signal_names[SIGVTALRM] = "VTALRM";
-#endif
-
-#if defined (SIGPROF)	/* profiling time alarm */
-  signal_names[SIGPROF] = "PROF";
-#endif
-
-#if defined (SIGWINCH)	/* window changed */
-  signal_names[SIGWINCH] = "WINCH";
-#endif
-
-/* 4.4 BSD */
-#if defined (SIGINFO) && !defined (_SEQUENT_)	/* information request */
-  signal_names[SIGINFO] = "INFO";
-#endif
-
-#if defined (SIGUSR1)	/* user defined signal 1 */
-  signal_names[SIGUSR1] = "USR1";
-#endif
-
-#if defined (SIGUSR2)	/* user defined signal 2 */
-  signal_names[SIGUSR2] = "USR2";
-#endif
-
-#if defined (SIGKILLTHR)	/* BeOS: Kill Thread */
-  signal_names[SIGKILLTHR] = "KILLTHR";
-#endif
-
-  for (i = 0; i < NSIG; i++)
-    if (signal_names[i] == (char *)NULL)
-      {
-	signal_names[i] = (char *)malloc (18);
-	if (signal_names[i])
-	  sprintf (signal_names[i], "%d", i);
-      }
-}
-
-void write_signames(FILE *stream)
-{
-  register int i;
-
-  fprintf (stream, "/* This file was automatically created by %s.\n",
-	   progname);
-  fprintf (stream, "   Do not edit.  Edit support/mksignames.c instead. */\n\n");
-  fprintf (stream, "#include <signal.h>\n\n");
-  fprintf (stream,
-	   "/* A translation list so we can be polite to our users. */\n");
-  fprintf (stream, "const char *const signal_names[NSIG + 1] = {\n");
-
-  for (i = 0; i <= LASTSIG; i++)
-    fprintf (stream, "    \"%s\",\n", signal_names[i]);
-
-  fprintf (stream, "    (char *)0x0\n");
-  fprintf (stream, "};\n");
-}
-
-int
-main(int argc, char **argv)
-{
-  char *stream_name;
-  FILE *stream;
-
-  progname = argv[0];
-
-  if (argc == 1)
-    {
-      stream_name = "signames.c";
-    }
-  else if (argc == 2)
-    {
-      stream_name = argv[1];
-    }
-  else
-    {
-      fprintf (stderr, "Usage: %s [output-file]\n", progname);
-      exit (1);
-    }
-
-  stream = fopen (stream_name, "w");
-  if (!stream)
-    {
-      fprintf (stderr, "%s: %s: cannot open for writing\n",
-	       progname, stream_name);
-      exit (2);
-    }
-
-  initialize_signames ();
-  write_signames (stream);
-  exit (0);
-}
diff --git a/src/signalname.c b/src/signalname.c
new file mode 100644
index 0000000..437e07c
--- /dev/null
+++ b/src/signalname.c
@@ -0,0 +1,150 @@
+// This file is in the Public Domain.
+#include <signal.h>
+
+#include "shell.h"
+#include "output.h"
+#include "signalname.h"
+
+MKINIT char *signal_names[NSIG] = {0};
+#if defined(SIGRTMIN) && defined(SIGRTMAX)
+MKINIT int sigrtmin;
+MKINIT int sigrtmax;
+#endif
+
+char *signalname(int signo) {
+	static char buf[16];
+
+	if ((unsigned)signo < NSIG && signal_names[signo])
+		return signal_names[signo];
+
+#if defined(SIGRTMIN) && defined(SIGRTMAX)
+	if (signo > sigrtmin && signo < sigrtmax) {
+		int last_rtmin_signo = sigrtmin + (sigrtmax - sigrtmin) / 2;
+		if (signo <= last_rtmin_signo)
+			fmtstr(buf, sizeof(buf), "RTMIN+%d", signo - sigrtmin);
+		else
+			fmtstr(buf, sizeof(buf), "RTMAX-%d", sigrtmax - signo);
+		return buf;
+	}
+#endif
+
+	fmtstr(buf, sizeof(buf), "%d", signo);
+	return buf;
+}
+
+#ifdef mkinit
+INIT {
+#define set_name(signo, name) if (signo < NSIG) signal_names[signo] = name
+	// 0 is no signal, but the trap command needs this to parse EXIT as 0.
+	set_name(0, "EXIT");
+
+	// Posix signals
+#if defined(SIGRTMIN) && defined(SIGRTMAX)
+	sigrtmin = SIGRTMIN;
+	set_name(sigrtmin, "RTMIN");
+	sigrtmax = SIGRTMAX;
+	set_name(sigrtmax, "RTMAX");
+#endif
+#ifdef SIGABRT
+	set_name(SIGABRT, "ABRT");
+#endif
+#ifdef SIGALRM
+	set_name(SIGALRM, "ALRM");
+#endif
+#ifdef SIGBUS
+	set_name(SIGBUS, "BUS");
+#endif
+#ifdef SIGCHLD
+	set_name(SIGCHLD, "CHLD");
+#endif
+#ifdef SIGCONT
+	set_name(SIGCONT, "CONT");
+#endif
+#ifdef SIGFPE
+	set_name(SIGFPE, "FPE");
+#endif
+#ifdef SIGHUP
+	set_name(SIGHUP, "HUP");
+#endif
+#ifdef SIGILL
+	set_name(SIGILL, "ILL");
+#endif
+#ifdef SIGINT
+	set_name(SIGINT, "INT");
+#endif
+#ifdef SIGKILL
+	set_name(SIGKILL, "KILL");
+#endif
+#ifdef SIGPIPE
+	set_name(SIGPIPE, "PIPE");
+#endif
+#ifdef SIGQUIT
+	set_name(SIGQUIT, "QUIT");
+#endif
+#ifdef SIGSEGV
+	set_name(SIGSEGV, "SEGV");
+#endif
+#ifdef SIGSTOP
+	set_name(SIGSTOP, "STOP");
+#endif
+#ifdef SIGTERM
+	set_name(SIGTERM, "TERM");
+#endif
+#ifdef SIGTSTP
+	set_name(SIGTSTP, "TSTP");
+#endif
+#ifdef SIGTTIN
+	set_name(SIGTTIN, "TTIN");
+#endif
+#ifdef SIGTTOU
+	set_name(SIGTTOU, "TTOU");
+#endif
+#ifdef SIGUSR1
+	set_name(SIGUSR1, "USR1");
+#endif
+#ifdef SIGUSR2
+	set_name(SIGUSR2, "USR2");
+#endif
+#ifdef SIGPOLL
+	set_name(SIGPOLL, "POLL");
+#endif
+#ifdef SIGPROF
+	set_name(SIGPROF, "PROF");
+#endif
+#ifdef SIGSYS
+	set_name(SIGSYS, "SYS");
+#endif
+#ifdef SIGTRAP
+	set_name(SIGTRAP, "TRAP");
+#endif
+#ifdef SIGURG
+	set_name(SIGURG, "URG");
+#endif
+#ifdef SIGVTALRM
+	set_name(SIGVTALRM, "VTALRM");
+#endif
+#ifdef SIGXCPU
+	set_name(SIGXCPU, "XCPU");
+#endif
+#ifdef SIGXFSZ
+	set_name(SIGXFSZ, "XFSZ");
+#endif
+
+	// Non-posix signals
+#ifdef SIGIO
+	set_name(SIGIO, "IO");
+#endif
+#ifdef SIGWINCH
+	set_name(SIGWINCH, "WINCH");
+#endif
+#ifdef SIGPWR
+	set_name(SIGPWR, "PWR");
+#endif
+#ifdef SIGINFO
+	set_name(SIGINFO, "INFO");
+#endif
+#ifdef SIGEMT
+	set_name(SIGEMT, "EMT");
+#endif
+}
+#endif
diff --git a/src/signalname.h b/src/signalname.h
new file mode 100644
index 0000000..1d8e238
--- /dev/null
+++ b/src/signalname.h
@@ -0,0 +1,4 @@
+// This file is in the Public Domain.
+
+// Returned string is valid until the next call to signalname.
+char *signalname(int signo);
diff --git a/src/trap.c b/src/trap.c
index cd84814..9f6bdb3 100644
--- a/src/trap.c
+++ b/src/trap.c
@@ -51,6 +51,7 @@
 #include "error.h"
 #include "trap.h"
 #include "mystring.h"
+#include "signalname.h"
 
 /*
  * Sigmode records the current value of the signal handlers for the various
@@ -78,8 +79,6 @@ volatile sig_atomic_t pending_sig;
 /* received SIGCHLD */
 volatile sig_atomic_t gotsigchld;
 
-extern char *signal_names[];
-
 static int decode_signum(const char *);
 
 #ifdef mkinit
@@ -127,7 +126,7 @@ trapcmd(int argc, char **argv)
 				out1fmt(
 					"trap -- %s %s\n",
 					single_quote(trap[signo]),
-					signal_names[signo]
+					signalname(signo)
 				);
 			}
 		}
@@ -429,7 +428,7 @@ int decode_signal(const char *string, int minsig)
 		return signo;
 
 	for (signo = minsig; signo < NSIG; signo++) {
-		if (!strcasecmp(string, signal_names[signo])) {
+		if (!strcasecmp(string, signalname(signo))) {
 			return signo;
 		}
 	}
-- 
2.39.2

