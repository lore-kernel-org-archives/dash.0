Received: from sendar.prophecy.lu (sendar.prophecy.lu [213.135.235.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D823AD
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.135.235.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731864470; cv=none; b=UuaO69pCbu8k0tcirkirZhw67LGLSYDrPUHRu4e40MyQiGZvm9yrPToaPmAI7tb3xlCY5WDucWz+CBaky+MardMNlJziQKtMuwiekkYsiyV/si4DkhSilUQlOmv0vCaDrURKCnZrxcXC0P5CAFgVKmbG4x0jMBpDssU0YnPyNVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731864470; c=relaxed/simple;
	bh=Rt4pyjxfMgTp5OBCvkQOOBGftmnriC9bMxuSiw8wmFA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oVdbGcPPak44/qBCjmXdd2QOjQn7xBCmVPXdArbGz2EUJlizVL92QZmxOx4sqHQ15UPkfO6CFkIk+tbDekPJ55ikz2Eo6k/Dac2dLlGLjrABwa2xSTa4fUqOod6tq8Qtp3IFGcKjpa9KLVvevt9G1uXZblR2tqjj3YENsMdiuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu; spf=pass smtp.mailfrom=knaff.lu; arc=none smtp.client-ip=213.135.235.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knaff.lu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knaff.lu
Received: from out.lll.lu ([IPv6:2001:7e8:f647:7601:109f:38a2:baed:e155])
	by prophecy.lu (8.15.2/8.15.2/Debian-22.1ubuntu3) with ESMTPS id 4AHHRZCm231437
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 17 Nov 2024 18:27:36 +0100
X-Envelope-To: dash@vger.kernel.org
Received: from [192.168.42.21] (vodsl-562.vo.lu [80.90.34.50])
	(authenticated bits=0)
	by lll.lu (8.17.1.9/8.17.1.9/Debian-2.1) with ESMTPSA id 4AHHRX1n438870
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 17 Nov 2024 18:27:34 +0100
Message-ID: <a389f2a5-0018-4ed1-a949-6ffda1d7bf5b@knaff.lu>
Date: Sun, 17 Nov 2024 18:27:33 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alain Knaff <alain@knaff.lu>
Subject: AT&T Unix PC : 12-sigaction
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

The 12th patch tests for availability of sigaction, and uses signal
instead if not available.

Without sigaction, signals have to be re-activated once triggered,
because signal does an implicit SA_RESETHAND on SYSV platforms.

Regards,

Alain

diff -X ../exclude.txt -urN dash-0.5.12+11-simplify-wait-loop/configure.ac dash-0.5.12+12-sigaction/configure.ac
--- dash-0.5.12+11-simplify-wait-loop/configure.ac	2024-11-10 17:06:50.301341251 +0000
+++ dash-0.5.12+12-sigaction/configure.ac	2024-11-10 17:08:01.155025888 +0000
@@ -73,6 +73,17 @@
 AC_TYPE_SSIZE_T
 AC_TYPE_UINT32_T
 
+AC_CHECK_TYPE([sig_atomic_t],,AC_DEFINE_UNQUOTED([sig_atomic_t],int,[Define atomic signal type]),[
+AC_INCLUDES_DEFAULT
+#include <signal.h>
+])
+
+AC_CHECK_TYPE([sigset_t],,AC_DEFINE_UNQUOTED([sigset_t],int,[Define type for signal mask, may be int where signal blocking is not supported at all]),[
+AC_INCLUDES_DEFAULT
+#include <signal.h>
+])
+
+
 AC_CHECK_TYPE([intmax_t],,AC_DEFINE_UNQUOTED([intmax_t],long,[Define intmax_t type, must also be supported by printf]))
 
 AC_CHECK_TYPE([uintmax_t],,AC_DEFINE_UNQUOTED([uintmax_t],unsigned long,[Define uintmax_t type, must also be supported by printf]))
@@ -106,7 +117,7 @@
 	       mempcpy memmove \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
 	       strtoumax sysconf \
-	       vfork lstat dup2 getgroups \
+	       vfork sigaction sigprocmask lstat dup2 getgroups \
 	       strstr stpncpy strcasecmp strerror strdup strtoul vsnprintf \
 	       readdir)
 
diff -X ../exclude.txt -urN dash-0.5.12+11-simplify-wait-loop/src/system.h dash-0.5.12+12-sigaction/src/system.h
--- dash-0.5.12+11-simplify-wait-loop/src/system.h	2024-11-10 16:26:48.720196946 +0000
+++ dash-0.5.12+12-sigaction/src/system.h	2024-11-10 16:26:47.464166999 +0000
@@ -48,9 +48,11 @@
 #pragma GCC diagnostic pop
 #endif
 #else
+# ifdef HAVE_SIGPROCMASK
 	sigset_t set;
 	sigemptyset(&set);
 	sigprocmask(SIG_SETMASK, &set, 0);
+# endif
 #endif
 }
 
diff -X ../exclude.txt -urN dash-0.5.12+11-simplify-wait-loop/src/trap.c dash-0.5.12+12-sigaction/src/trap.c
--- dash-0.5.12+11-simplify-wait-loop/src/trap.c	2024-11-10 14:59:12.583223512 +0000
+++ dash-0.5.12+12-sigaction/src/trap.c	2024-11-10 20:26:44.222071158 +0000
@@ -181,7 +181,16 @@
 	int action;
 	int lvforked;
 	char *t, tsig;
+#ifdef HAVE_SIGACTION
 	struct sigaction act;
+#define SIGNAL(signo) sigaction(signo, &act,0)
+#define HDLR act.sa_handler
+#else
+	typedef void (*sighandler_t)(int);
+	sighandler_t hdlr;
+#define SIGNAL(signo) signal(signo, hdlr)	
+#define HDLR hdlr
+#endif
 
 	lvforked = vforked;
 
@@ -222,6 +231,7 @@
 
 	t = &sigmode[signo - 1];
 	tsig = *t;
+#ifdef HAVE_SIGACTION
 	if (tsig == 0) {
 		/*
 		 * current setting unknown
@@ -244,23 +254,28 @@
 			tsig = S_RESET;	/* force to be set */
 		}
 	}
-	if (tsig == S_HARD_IGN || tsig == action)
+	if (tsig == action)
+		return;
+#endif
+	if (tsig == S_HARD_IGN)
 		return;
 	switch (action) {
 	case S_CATCH:
-		act.sa_handler = onsig;
+		HDLR = onsig;
 		break;
 	case S_IGN:
-		act.sa_handler = SIG_IGN;
+		HDLR = SIG_IGN;
 		break;
 	default:
-		act.sa_handler = SIG_DFL;
+		HDLR = SIG_DFL;
 	}
 	if (!lvforked)
 		*t = action;
+#ifdef HAVE_SIGACTION
 	act.sa_flags = 0;
 	sigfillset(&act.sa_mask);
-	sigaction(signo, &act, 0);
+#endif
+	SIGNAL(signo);
 }
 
 /*
@@ -286,6 +301,9 @@
 void
 onsig(int signo)
 {
+#ifndef HAVE_SIGACTION
+	signal(signo, onsig);
+#endif
 	if (vforked)
 		return;
 
@@ -441,8 +459,13 @@
 
 void sigblockall(sigset_t *oldmask)
 {
+#ifdef HAVE_SIGPROCMASK
 	sigset_t mask;
 
 	sigfillset(&mask);
 	sigprocmask(SIG_SETMASK, &mask, oldmask);
+#else
+	if(oldmask)
+		*oldmask = 0;
+#endif
 }
