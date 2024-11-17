Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67383634
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731836305; cv=none; b=jvI9DT0PXAG1YgmY5///s12ytjpy+L/cKnIb1WqfYPXCANIey17Zzai/SaSpeky2kO0Wh9aNSQrMF7dAkd2OkVLppx4rua2xEh6vNgu4VuWsVPfK2TosRvgkqTYfnacYD74Lc2f+HhKE174vaPe/ZklCXrnZNfNB3VoZuKIZnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731836305; c=relaxed/simple;
	bh=wiowxxVDQC0XUujBlkg8TyBsEU/waDlAvCV5nBRW2X4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=rCYAvOTLUt5bmvlBhNq9v7F+7BicbY1aZ3l4RkWJ4F2eYJFgc7gM/cJDyN0wpMDZ+H5jyCfquAuVnIUu75R/7BgQ5dEJv9g+GKJIA3Apz3ierkK6n7k76bdRmLhfHjYuCtkdHYRySsxVVZsZne1aXY04Y8Hc7u9HjmSNCIUk/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AH9cEos207201
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 10:38:15 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AH9cCgD414101
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 10:38:14 +0100
Message-ID: <ac8f500e-63fb-4f5e-a7a3-550c8e7fb63c@knaff.lu>
Date: Sun, 17 Nov 2024 10:38:12 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: P*rtability of dash to legacy systems, such as AT&T Unix PC :
 04-mksignames
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Language: en-US
Autocrypt: addr=alain@knaff.lu; keydata=
 xsDiBEk9qFcRBADO4trPtib39qvAEBlkAIcBGnZ137EmmNLU1pFZC5acLyJ4wYhVdcol97lC
 4ZkD0DJek6DVidQfz4hA7JbZy2W8l6O/o2k/Ja2bWkb8qtrcUNVDJzdJjNqXmmxdsyLd5QVt
 uCHgi3Zz0kq9aJnRCVuAyfrjMdaUsOThi07u1EyEywCgjxVKODAifumqfdjVxS5NoV7x7TkD
 /0k2F3/5/NYchgLz6Qu3As5MVtPs7NkJ0Mpal4Gy8CaKefHcynY+zCziM/oBw0+PIFxyFud0
 uT9HRIdEp1DlaTTUYlt95HeDYmCUh0Wt1PwNNRWcm+vTUuK7tOxzYadUqbzO+F6C+WN8msxA
 hcxzUgsL/YyXVilvL8XqB+RlS5bBA/9OxXc2mJs01nWu5khvVFNwUCDS8FRYyoHeodVZFGLC
 UG1PrV9nHva5vYJk1QlZP3qEotnK+6l4708X9yhdw2+UCtxvseTQ6JWBtIdJyo+Qv7apSQA3
 kkau6Om7SOyW1i/2LcCZU84SC923uBH7VNeUzCnzelVFubk6eRwzjNvrj80cQUxBSU4gS05B
 RkYgPGFsYWluQGtuYWZmLmx1PsJgBBMRAgAgBQJJPahXAhsDBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQyAYxsm9DGWFEsgCeOSavzyOp8Bj3nOP8hC6XeCX/3k4Anj0KegsyeIVxuj5X
 TUnh535vXfZvzsFNBEk9qFoQCACt2vctXYAr+ndRbaeR4ygJ8rKH8ARu68nDuQuxOKCasaQr
 xm8+/RxvmTfriP00tYZAca2tmCjwntKVsK4eNSivvo6c7BwziCnQx/vW+kJK4ctckMHSZPqe
 4a1HWYURg5oxaqGo4f06YAn9O0yDo6xdGGNUMpYHv2O1/jsAEgAM/c/US+gNctzsNKQ4lVwp
 HH4NEabev+zlisnTO3V39iXijZbe9AYlD4qZH/0nFBDCCt9EDTe+/6IFfvIrnVx7o367U9XL
 SCLVQt4k7xqCIow7RP5BlOYLDV50yMva8c62yhWpDYKSyJsQGn/nGiiv6P4Ye/monfkQD+PC
 nKPXDYCjAAMFB/9D2FSYHyikvOoXXMTfjGHUyIQK6FCtKINTFfBPuwlWOWCukrQrzH0BmTVC
 /WuMOrrmxl0IFHGtOV2Zp+bdsjhlzgZ4kXAmqw1Qiphb/YLD6VY5TQ59Tkl7+nCQ0wjcRim1
 Sg6OzmoNttHpTt9eAvLZMz7yi9Nq40yKXh+zXZtzHIgdsXG+tO9+LEWojdbXgIdZin2yUKYt
 KxbpwyM0qCN9oGtKTAi0GX+tuHdAqWwYEgVnd27LcBGLTs6QJPsjQKHiAtYJwu6MWiF7bvCr
 iBNyVG3yU3inZcQvIdYxO0VUN3wVSEIbRHcNzG2u1UD6ZuF+3bv39dh54m1CQzbzzRepwkkE
 GBECAAkFAkk9qFoCGwwACgkQyAYxsm9DGWHNLwCfWr4DLrBZMktv9RTGbcIZ+/NgTswAn3aG
 LBuTFPDEO0bfA+7PlpCctCJT
In-Reply-To: <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The fourth part of the patch set rewrites mksignames in such a way
that it works in a cross-compilation environment. It uses gcc -E to
generate the bulk of the signames file, and only does minimal
processing on the build system, in order to avoid accidentally getting
the build system's signal definitions instead of the target system's.

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+03-name-max/src/Makefile.am dash-0.5.12+04-mksignames/src/Makefile.am
--- dash-0.5.12+03-name-max/src/Makefile.am	2020-06-03 02:23:24.000000000 +0000
+++ dash-0.5.12+04-mksignames/src/Makefile.am	2024-10-20 06:53:24.431287243 +0000
@@ -64,6 +64,11 @@
 signames.c: mksignames
 	$(AM_V_GEN)./$^
 
+mksignames: mksignames.c mksignames.h
+
+mksignames.h: mksignames.tmpl.h
+	$(AM_V_CC)$(COMPILE) -E $< | sed '1,/START_MKSIGNAMES_H/d' >$@
+
 mksyntax: token.h
 
 $(HELPERS): %: %.c
diff -X ../exclude.txt -urN dash-0.5.12+03-name-max/src/mksignames.c dash-0.5.12+04-mksignames/src/mksignames.c
--- dash-0.5.12+03-name-max/src/mksignames.c	2020-06-03 01:19:23.000000000 +0000
+++ dash-0.5.12+04-mksignames/src/mksignames.c	2024-10-20 06:53:24.431287243 +0000
@@ -21,344 +21,8 @@
 
 #include <stdio.h>
 #include <sys/types.h>
-#include <signal.h>
 #include <stdlib.h>
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
+#include "mksignames.h"
 
 void
 write_signames (stream)
@@ -372,7 +36,7 @@
   fprintf (stream, "#include <signal.h>\n\n");
   fprintf (stream,
 	   "/* A translation list so we can be polite to our users. */\n");
-  fprintf (stream, "const char *const signal_names[NSIG + 1] = {\n");
+  fprintf (stream, "const char *const signal_names[%d] = {\n", LASTSIG + 2);
 
   for (i = 0; i <= LASTSIG; i++)
     fprintf (stream, "    \"%s\",\n", signal_names[i]);
diff -X ../exclude.txt -urN dash-0.5.12+03-name-max/src/mksignames.tmpl.h dash-0.5.12+04-mksignames/src/mksignames.tmpl.h
--- dash-0.5.12+03-name-max/src/mksignames.tmpl.h	1970-01-01 00:00:00.000000000 +0000
+++ dash-0.5.12+04-mksignames/src/mksignames.tmpl.h	2024-10-20 06:53:24.431287243 +0000
@@ -0,0 +1,349 @@
+#include <sys/types.h>
+#include <signal.h>
+
+START_MKSIGNAMES_H
+
+#if !defined (NSIG)
+#  define NSIG 64
+#endif
+
+/*
+ * Special traps:
+ *	EXIT == 0
+ */
+static int LASTSIG = NSIG-1;
+
+char *signal_names[2 * NSIG + 3];
+#define ARRAY_SIZE (2 * NSIG + 3)
+
+#define signal_names_size (sizeof(signal_names)/sizeof(signal_names[0]))
+
+char *progname;
+
+/* AIX 4.3 defines SIGRTMIN and SIGRTMAX as 888 and 999 respectively.
+   I don't want to allocate so much unused space for the intervening signal
+   numbers, so we just punt if SIGRTMAX is past the bounds of the
+   signal_names array (handled in configure). */
+#if defined (SIGRTMAX) && defined (UNUSABLE_RT_SIGNALS)
+#  undef SIGRTMAX
+#  undef SIGRTMIN
+#endif
+
+#if defined (SIGRTMAX) || defined (SIGRTMIN)
+#  define RTLEN 17
+#  define RTLIM 256
+#endif
+
+void
+initialize_signames ()
+{
+  register int i;
+#if defined (SIGRTMAX) || defined (SIGRTMIN)
+  int rtmin, rtmax, rtcnt;
+#endif
+
+  for (i = 1; i < signal_names_size; i++)
+    signal_names[i] = (char *)NULL;
+
+  /* `signal' 0 is what we do on exit. */
+  signal_names[0] = "EXIT";
+
+  /* Place signal names which can be aliases for more common signal
+     names first.  This allows (for example) SIGABRT to overwrite SIGLOST. */
+
+  /* POSIX 1003.1b-1993 real time signals, but take care of incomplete
+     implementations. Acoording to the standard, both, SIGRTMIN and
+     SIGRTMAX must be defined, SIGRTMIN must be stricly less than
+     SIGRTMAX, and the difference must be at least 7, that is, there
+     must be at least eight distinct real time signals. */
+
+  /* The generated signal names are SIGRTMIN, SIGRTMIN+1, ...,
+     SIGRTMIN+x, SIGRTMAX-x, ..., SIGRTMAX-1, SIGRTMAX. If the number
+     of RT signals is odd, there is an extra SIGRTMIN+(x+1).
+     These names are the ones used by ksh and /usr/xpg4/bin/sh on SunOS5. */
+
+#if defined (SIGRTMIN)
+  rtmin = SIGRTMIN;
+  if(rtmin < ARRAY_SIZE)
+    signal_names[rtmin] = "RTMIN";
+#endif
+
+#if defined (SIGRTMAX)
+  rtmax = SIGRTMAX;
+  if(rtmax < ARRAY_SIZE)
+    signal_names[rtmax] = "RTMAX";
+#endif
+
+#if defined (SIGRTMAX) && defined (SIGRTMIN)
+  if (rtmax > rtmin)
+    {
+      rtcnt = (rtmax - rtmin - 1) / 2;
+      /* croak if there are too many RT signals */
+      if (rtcnt >= RTLIM/2)
+	{
+	  rtcnt = RTLIM/2-1;
+	  fprintf(stderr, "%s: error: more than %i real time signals, fix `%s'\n",
+		  progname, RTLIM, progname);
+	}
+
+      for (i = 1; i <= rtcnt; i++)
+	{
+	  if (rtmin+i < ARRAY_SIZE) {
+	    signal_names[rtmin+i] = (char *)malloc(RTLEN);
+	    if(signal_names[rtmin+i])
+	      sprintf (signal_names[rtmin+i], "RTMIN+%d", i);
+	  }
+	  if (rtmax-i < ARRAY_SIZE) {
+	    signal_names[rtmax-i] = (char *)malloc(RTLEN);
+	    if(signal_names[rtmax-i])
+	      sprintf (signal_names[rtmax-i], "RTMAX-%d", i);
+	  }
+	}
+
+      if (rtcnt < RTLIM/2-1 && rtcnt != (rtmax-rtmin)/2)
+	{
+	  if (rtmin+rtcnt+1 < ARRAY_SIZE) {
+	    /* Need an extra RTMIN signal */
+	    signal_names[rtmin+rtcnt+1] = (char *)malloc(RTLEN);
+	    if (signal_names[rtmin+rtcnt+1])
+	      sprintf (signal_names[rtmin+rtcnt+1], "RTMIN+%d", rtcnt+1);
+	  }
+	}
+    }
+#endif /* SIGRTMIN && SIGRTMAX */
+
+/* AIX */
+#if defined (SIGLOST)	/* resource lost (eg, record-lock lost) */
+  signal_names[SIGLOST] = "LOST";
+#endif
+
+#if defined (SIGMSG)	/* HFT input data pending */
+  signal_names[SIGMSG] = "MSG";
+#endif
+
+#if defined (SIGDANGER)	/* system crash imminent */
+  signal_names[SIGDANGER] = "DANGER";
+#endif
+
+#if defined (SIGMIGRATE) /* migrate process to another CPU */
+  signal_names[SIGMIGRATE] = "MIGRATE";
+#endif
+
+#if defined (SIGPRE)	/* programming error */
+  signal_names[SIGPRE] = "PRE";
+#endif
+
+#if defined (SIGVIRT)	/* AIX virtual time alarm */
+  signal_names[SIGVIRT] = "VIRT";
+#endif
+
+#if defined (SIGALRM1)	/* m:n condition variables */
+  signal_names[SIGALRM1] = "ALRM1";
+#endif
+
+#if defined (SIGWAITING)	/* m:n scheduling */
+  signal_names[SIGWAITING] = "WAITING";
+#endif
+
+#if defined (SIGGRANT)	/* HFT monitor mode granted */
+  signal_names[SIGGRANT] = "GRANT";
+#endif
+
+#if defined (SIGKAP)	/* keep alive poll from native keyboard */
+  signal_names[SIGKAP] = "KAP";
+#endif
+
+#if defined (SIGRETRACT) /* HFT monitor mode retracted */
+  signal_names[SIGRETRACT] = "RETRACT";
+#endif
+
+#if defined (SIGSOUND)	/* HFT sound sequence has completed */
+  signal_names[SIGSOUND] = "SOUND";
+#endif
+
+#if defined (SIGSAK)	/* Secure Attention Key */
+  signal_names[SIGSAK] = "SAK";
+#endif
+
+/* SunOS5 */
+#if defined (SIGLWP)	/* special signal used by thread library */
+  signal_names[SIGLWP] = "LWP";
+#endif
+
+#if defined (SIGFREEZE)	/* special signal used by CPR */
+  signal_names[SIGFREEZE] = "FREEZE";
+#endif
+
+#if defined (SIGTHAW)	/* special signal used by CPR */
+  signal_names[SIGTHAW] = "THAW";
+#endif
+
+#if defined (SIGCANCEL)	/* thread cancellation signal used by libthread */
+  signal_names[SIGCANCEL] = "CANCEL";
+#endif
+
+/* HP-UX */
+#if defined (SIGDIL)	/* DIL signal (?) */
+  signal_names[SIGDIL] = "DIL";
+#endif
+
+/* System V */
+#if defined (SIGCLD)	/* Like SIGCHLD.  */
+  signal_names[SIGCLD] = "CLD";
+#endif
+
+#if defined (SIGPWR)	/* power state indication */
+  signal_names[SIGPWR] = "PWR";
+#endif
+
+#if defined (SIGPOLL)	/* Pollable event (for streams)  */
+  signal_names[SIGPOLL] = "POLL";
+#endif
+
+/* Unknown */
+#if defined (SIGWINDOW)
+  signal_names[SIGWINDOW] = "WINDOW";
+#endif
+
+/* Common */
+#if defined (SIGHUP)	/* hangup */
+  signal_names[SIGHUP] = "HUP";
+#endif
+
+#if defined (SIGINT)	/* interrupt */
+  signal_names[SIGINT] = "INT";
+#endif
+
+#if defined (SIGQUIT)	/* quit */
+  signal_names[SIGQUIT] = "QUIT";
+#endif
+
+#if defined (SIGILL)	/* illegal instruction (not reset when caught) */
+  signal_names[SIGILL] = "ILL";
+#endif
+
+#if defined (SIGTRAP)	/* trace trap (not reset when caught) */
+  signal_names[SIGTRAP] = "TRAP";
+#endif
+
+#if defined (SIGIOT)	/* IOT instruction */
+  signal_names[SIGIOT] = "IOT";
+#endif
+
+#if defined (SIGABRT)	/* Cause current process to dump core. */
+  signal_names[SIGABRT] = "ABRT";
+#endif
+
+#if defined (SIGEMT)	/* EMT instruction */
+  signal_names[SIGEMT] = "EMT";
+#endif
+
+#if defined (SIGFPE)	/* floating point exception */
+  signal_names[SIGFPE] = "FPE";
+#endif
+
+#if defined (SIGKILL)	/* kill (cannot be caught or ignored) */
+  signal_names[SIGKILL] = "KILL";
+#endif
+
+#if defined (SIGBUS)	/* bus error */
+  signal_names[SIGBUS] = "BUS";
+#endif
+
+#if defined (SIGSEGV)	/* segmentation violation */
+  signal_names[SIGSEGV] = "SEGV";
+#endif
+
+#if defined (SIGSYS)	/* bad argument to system call */
+  signal_names[SIGSYS] = "SYS";
+#endif
+
+#if defined (SIGPIPE)	/* write on a pipe with no one to read it */
+  signal_names[SIGPIPE] = "PIPE";
+#endif
+
+#if defined (SIGALRM)	/* alarm clock */
+  signal_names[SIGALRM] = "ALRM";
+#endif
+
+#if defined (SIGTERM)	/* software termination signal from kill */
+  signal_names[SIGTERM] = "TERM";
+#endif
+
+#if defined (SIGURG)	/* urgent condition on IO channel */
+  signal_names[SIGURG] = "URG";
+#endif
+
+#if defined (SIGSTOP)	/* sendable stop signal not from tty */
+  signal_names[SIGSTOP] = "STOP";
+#endif
+
+#if defined (SIGTSTP)	/* stop signal from tty */
+  signal_names[SIGTSTP] = "TSTP";
+#endif
+
+#if defined (SIGCONT)	/* continue a stopped process */
+  signal_names[SIGCONT] = "CONT";
+#endif
+
+#if defined (SIGCHLD)	/* to parent on child stop or exit */
+  signal_names[SIGCHLD] = "CHLD";
+#endif
+
+#if defined (SIGTTIN)	/* to readers pgrp upon background tty read */
+  signal_names[SIGTTIN] = "TTIN";
+#endif
+
+#if defined (SIGTTOU)	/* like TTIN for output if (tp->t_local&LTOSTOP) */
+  signal_names[SIGTTOU] = "TTOU";
+#endif
+
+#if defined (SIGIO)	/* input/output possible signal */
+  signal_names[SIGIO] = "IO";
+#endif
+
+#if defined (SIGXCPU)	/* exceeded CPU time limit */
+  signal_names[SIGXCPU] = "XCPU";
+#endif
+
+#if defined (SIGXFSZ)	/* exceeded file size limit */
+  signal_names[SIGXFSZ] = "XFSZ";
+#endif
+
+#if defined (SIGVTALRM)	/* virtual time alarm */
+  signal_names[SIGVTALRM] = "VTALRM";
+#endif
+
+#if defined (SIGPROF)	/* profiling time alarm */
+  signal_names[SIGPROF] = "PROF";
+#endif
+
+#if defined (SIGWINCH)	/* window changed */
+  signal_names[SIGWINCH] = "WINCH";
+#endif
+
+/* 4.4 BSD */
+#if defined (SIGINFO) && !defined (_SEQUENT_)	/* information request */
+  signal_names[SIGINFO] = "INFO";
+#endif
+
+#if defined (SIGUSR1)	/* user defined signal 1 */
+  signal_names[SIGUSR1] = "USR1";
+#endif
+
+#if defined (SIGUSR2)	/* user defined signal 2 */
+  signal_names[SIGUSR2] = "USR2";
+#endif
+
+#if defined (SIGKILLTHR)	/* BeOS: Kill Thread */
+  signal_names[SIGKILLTHR] = "KILLTHR";
+#endif
+
+  for (i = 0; i < NSIG; i++)
+    if (signal_names[i] == (char *)NULL)
+      {
+	signal_names[i] = (char *)malloc (18);
+	if (signal_names[i])
+	  sprintf (signal_names[i], "%d", i);
+      }
+}
