From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] error: Remove USE_NORETURN ifdef
Date: Tue, 2 Jun 2020 21:52:55 +1000
Message-ID: <20200602115255.GB6951@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.hmeau.com ([216.24.177.18]:56312 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFBLw5 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 2 Jun 2020 07:52:57 -0400
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

The USE_NORETURN was added because gcc was buggy almost 20 years
ago.  This is no longer needed and this patch removes it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/error.h b/src/error.h
index 94e30a2..661a8a0 100644
--- a/src/error.h
+++ b/src/error.h
@@ -116,11 +116,7 @@ void __inton(void);
 #define int_pending() intpending
 
 void exraise(int) __attribute__((__noreturn__));
-#ifdef USE_NORETURN
 void onint(void) __attribute__((__noreturn__));
-#else
-void onint(void);
-#endif
 extern int errlinno;
 void sh_error(const char *, ...) __attribute__((__noreturn__));
 void exerror(int, const char *, ...) __attribute__((__noreturn__));
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
