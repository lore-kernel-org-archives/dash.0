Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958281D95B3
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731869162; cv=none; b=gs+7MzxQ2ihY/rRcq+GJV/ccjRQJKOYVIyPYft+E3ZHMNCRjdOY7qrdRv2E02XmGoUCioRAPc8P2yJZNohoZ7G+a5too8ypY7hsPqqmWlJS63nEyydOrLt9Dvwn/BwY9VdbswwKWqju59PVNKeDkCk8zUZgs9+4OIO5MaookJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731869162; c=relaxed/simple;
	bh=UntQ9Yfs73IhHS30v4PVKqlouoLjlKhJpU7yDYAYQno=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aM3eeD3SkkhZoLHYbu5vazYaoKH/X1bYs5SOdky+tjsFS7N3s1LnMaR4FeYNAVrNszTZX0xlN54L9C8MagbxPmnpO1inOMsRUXNzz2B7EiRaSzs6h7C1AYlTVlIAOdEq9zjtxJK05Rqaog9cPl+feqgnv0oTB64AJn5MdS6qu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHIjmRm235446
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 19:45:49 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHIjkV2442921
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 19:45:48 +0100
Message-ID: <c2ac05a9-c038-46e4-99fc-52bb803421cd@knaff.lu>
Date: Sun, 17 Nov 2024 19:45:46 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 13-wait3-replacement
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
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

The 13th patch caters to unavailability of wait3() system call on older
SYSV systems such as UnixPC.

On these systems, only an always blocking wait() is available. In
order to get non-blocking wait, you have to use a SIGCLD handler (not
a typo, child signal handling on SYSV was subtly different from what
we are used to now). This handler sets a flag (gotsigchld) when a
child dies.

When upper layers request a non-blocking wait, we test for this
flag. If the gotsigchld flag is set, we can wait(), confident in the
knowledge that this call will return right away. Then clear the flag,
and re-instore SIGCLD handler.
If the gotsigchld flag is not set, we return right away with 0 ("process
does have children, but none have exited so far")


The "subtle difference" between SIGCLD and SIGCHLD is that SIGCLD is
"level triggered": i.e. the system continues raising the signal as long
as there is a terminated child around on which the parent has not yet
waited. Thus, SIGCLD should not be re-enabled in the handler, but only
after wait()

https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap02.html

"Some implementations (System V, for example) will deliver a SIGCLD
signal immediately when a process establishes a signal-catching
function for SIGCLD when that process has a child that has already
terminated. Other implementations, such as 4.3 BSD, do not generate a
new SIGCHLD signal in this way. In general, a process should not
attempt to alter the signal action for the SIGCHLD signal while it has
any outstanding children. However, it is not always possible for a
process to avoid this; for example, shells sometimes start up
processes in pipelines with other processes from the pipeline as
children. Processes that cannot ensure that they have no children when
altering the signal action for SIGCHLD thus need to be prepared for,
but not depend on, generation of an immediate SIGCHLD signal."

Actually, in a way we do "depend on" this peculiarity to implement
non-blocking wait(). However, if it is not available, the only thing
that breaks is "monitor mode" (notification of terminated children
when pressing return in an interactive shell).

Edit: contrarily to what I had announced this morning, there's no amendment 
needed here after all. I was misled by a wrong configure invocation line 
for dietlibc, which somehow led to #include files being included out of
order

Regards,

Alain
diff -X ../exclude.txt -urN dash-0.5.12+12-sigaction/configure.ac dash-0.5.12+13-wait3-replacement/configure.ac
--- dash-0.5.12+12-sigaction/configure.ac	2024-11-10 17:08:01.155025888 +0000
+++ dash-0.5.12+13-wait3-replacement/configure.ac	2024-11-10 20:26:19.105474215 +0000
@@ -117,7 +117,7 @@
 	       mempcpy memmove \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf \
-	       vfork sigaction sigprocmask lstat dup2 getgroups \
+	       vfork wait3 sigaction sigprocmask lstat dup2 getgroups \
 	       strstr stpncpy strcasecmp strerror strdup strtoul vsnprintf \
 	       readdir)
 
diff -X ../exclude.txt -urN dash-0.5.12+12-sigaction/src/jobs.c dash-0.5.12+13-wait3-replacement/src/jobs.c
--- dash-0.5.12+12-sigaction/src/jobs.c	2024-10-27 20:19:13.625231580 +0000
+++ dash-0.5.12+13-wait3-replacement/src/jobs.c	2024-11-10 21:51:55.911519696 +0000
@@ -1154,6 +1154,50 @@
 	return rpid;
 }
 
+#ifndef HAVE_WAIT3
+
+# ifndef WNOHANG
+#  define WNOHANG 1
+# endif
+
+/* Replacement wait3 */
+STATIC inline pid_t
+wait3(int *wstatus, int options, void * rusage)
+{
+	pid_t pid;
+
+	/* if we are called as non-blocking, and have no SIGCLD
+	   pending, return */
+	if((options & WNOHANG) && !gotsigchld)
+		return 0; /* 0 is returned by wait3 if the process does have
+			   * children, but none have exited so far */
+	pid = wait(wstatus);
+	if(pid <= 0)
+		/* no process reaped, or error */
+		return pid;
+
+	
+	/* if we come here, we did indeed reap a process.  =>
+	 * clear gotsigchld, and re-instore SIGCLD handler.
+	 *
+	 * On old SYSV systems where there is no wait3 call,
+	 * signal(SIGCLD) is level-triggered, and will trigger as
+	 * long as there are still unwaited-for children
+	 * around. However, it is, like all other signals, disabled as
+	 * soon as its signal handler is invoked, which prevents storm
+	 * :-). So we need to re-enable it after wait(), in order to
+	 * be notified of further children dying.
+	 *
+	 * If more than one child had died since last reset of
+	 * gotsigchld, a signal will be delivered immediately after
+	 * re-activation of the signal, because it is level-triggered.
+	 */
+	gotsigchld = 0;
+	setsignal(SIGCLD);
+	return pid;
+}
+#endif
+
 /*
  * Do a wait system call.  If block is zero, we return -1 rather than
  * blocking.  If block is DOWAIT_WAITCMD, we return 0 when a signal
@@ -1182,7 +1226,15 @@
 #endif
 
 	do {
+#ifdef HAVE_WAIT3
+		/* reset gotsigchld *only* if we are not using a
+		 * replacement wait3(). Indeed, the replacement
+		 * wait3() needs original value of gotsigchld in order
+		 * to decide whether it does indeed need to
+		 * wait. Replacement wait3 will then reset gotsigchld
+		 * when done with it */
 		gotsigchld = 0;
+#endif
 		do
 			err = wait3(status, flags, NULL);
 		while (err < 0 && errno == EINTR && !pending_sig);
diff -X ../exclude.txt -urN dash-0.5.12+12-sigaction/src/system.h dash-0.5.12+13-wait3-replacement/src/system.h
--- dash-0.5.12+12-sigaction/src/system.h	2024-11-10 16:26:47.464166999 +0000
+++ dash-0.5.12+13-wait3-replacement/src/system.h	2024-11-10 14:53:08.418618090 +0000
@@ -159,6 +159,10 @@
 # define O_NONBLOCK O_NDELAY
 #endif
 
+#if !defined SIGCHLD && defined SIGCLD
+# define SIGCHLD SIGCLD
+#endif
+
 #ifndef FD_CLOEXEC
 # define FD_CLOEXEC 1
 #endif
diff -X ../exclude.txt -urN dash-0.5.12+12-sigaction/src/trap.c dash-0.5.12+13-wait3-replacement/src/trap.c
--- dash-0.5.12+12-sigaction/src/trap.c	2024-11-10 20:26:44.222071158 +0000
+++ dash-0.5.12+13-wait3-replacement/src/trap.c	2024-11-10 20:27:41.055421903 +0000
@@ -53,6 +53,7 @@
 #include "error.h"
 #include "trap.h"
 #include "mystring.h"
+#include "system.h"
 
 /*
  * Sigmode records the current value of the signal handlers for the various
@@ -87,6 +88,7 @@
 #ifdef mkinit
 INCLUDE "memalloc.h"
 INCLUDE "trap.h"
+INCLUDE "system.h"
 
 INIT {
 	sigmode[SIGCHLD - 1] = S_DFL;
@@ -302,7 +304,10 @@
 onsig(int signo)
 {
 #ifndef HAVE_SIGACTION
-	signal(signo, onsig);
+#ifdef SIGCLD
+	if(signo != SIGCLD)
+#endif
+		signal(signo, onsig);
 #endif
 	if (vforked)
 		return;

