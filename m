Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D8258CD0
	for <dash@vger.kernel.org>; Sun, 12 Apr 2026 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775990169; cv=none; b=ZCu0V0UkqZt9OracbSSf6nxvjNnrZa3BaStVUwLM79GqKxPmZw276Wv61sxmTZAqBM56T8pKhsc4LsV6RCtY9yedtC31v50Wko6YeQ15AXEOMtgaYjuWTeyYnDcus0uE61getW5C+Y/bZSoe4MWhjP5B+1Qx9AS++zpHNtn+w18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775990169; c=relaxed/simple;
	bh=F7jMvJKpoBxNpeoAaI8LpU7q8FeARy/A3SmHAm/i9z8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cpe9S2ASjK77J1/HMle2WPulnbzFYCLQrs12rdQq7etT2TDbja7Xl52B2PE2e1CvjBRNJpXGy+0B0FA9Qqq4pFNZLe0mDO+AwNQHU5mDej7uwEx81m3ou71g+IWe4FZ06Xhs4FKN+P9OKTHVjN7BWa+iAgLuY+9SzspJ5YgtjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=RpNxhWYH; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="RpNxhWYH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=OuSKUzrmOtEPXijlt1pWofGd52qVSVqKhtnHNwhgcdo=; b=RpNxhWYHyciAZ3C7tx2lQHPEDx
	k3RsijAncFAfncxhz4AR4Fz1sT78yzDta5QAhl85XQ+ITwuWH5+MpxL3eay8U3vOc+iAion7GoA4m
	T5sHNakANFyGMEzOfrb5VnY7vTDTMQIvqn7PSHwDKprOEdAQs/Xp2ZBXE21HrIIF9Ls71foyN01Kw
	9Yzxr55Q7sSa/5WXBtvwcOI5d9gcVdNsfvm7WD8lGpLPiLv1TAmU4kXYZ5wlwtfHTK2Vo4doEBRZu
	9TysdVGSxj+b0yZK5lrzaYpFN1g7GCM7HktAKpBqAJug6Qq2Rb3UoSIa+tFDhHhCqAaPksdL0tvdS
	11q4YeYw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wBrl9-005V5i-2O;
	Sun, 12 Apr 2026 18:36:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 12 Apr 2026 18:36:02 +0800
Date: Sun, 12 Apr 2026 18:36:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ignacy =?utf-8?B?R2F3xJlkemtp?= <ignacy.gawedzki@green-communications.fr>
Cc: dash@vger.kernel.org
Subject: [v3 PATCH] input: Fix EINTR handling when reading from a pipe
Message-ID: <adt1kl_3p0r4E7PG@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e543oogxlemxnvt7kfbk3s7bugimyiza34kgbq7srofw7qu5i@b6atfz2nfkht>
X-Newsgroups: apana.lists.os.linux.dash

Ignacy Gawędzki <ignacy.gawedzki@green-communications.fr> wrote:
> When using tee to peek at stdin pipe, consider forwarding EINTR
> without attempting to read, otherwise pending signals don't get
> handled properly.
> 
> Signed-off-by: Ignacy Gawędzki <ignacy.gawedzki@green-communications.fr>
> ---
> src/input.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

Thanks for the patch.  I think we need to restrict the fallback
path even further.  In fact, only EINVAL should enter the fallback
path.

---8<---
Errors from tee(2) should not lead to the fallback path in every
case.  In fact, only EINVAL should trigger an attempt to call
read(2).

Every other error (and zero == EOF) returned by tee(2) should be
treated as if it came from read(2).

Reported-by: Ignacy Gawędzki <ignacy.gawedzki@green-communications.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/configure.ac b/configure.ac
index c37eefe..9a55ea0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -92,7 +92,7 @@ dnl Checks for library functions.
 AC_CHECK_FUNCS(bsearch faccessat getpwnam getrlimit isalpha killpg \
 	       memfd_create memrchr mempcpy \
 	       sigsetmask stpcpy strchrnul strsignal strtod strtoimax \
-	       strtoumax sysconf tee wait3)
+	       strtoumax sysconf wait3)
 
 dnl Check whether it's worth working around FreeBSD PR kern/125009.
 dnl The traditional behavior of access/faccessat is crazy, but
@@ -135,6 +135,10 @@ if test "$use_fnmatch" = yes && test "$enable_glob" = yes; then
 fi
 
 if test "$enable_tee" != no; then
+	AC_CHECK_FUNCS(tee, use_tee=yes)
+fi
+
+if test "$use_tee" = yes; then
 	AC_DEFINE([USE_TEE], [1], [Non-zero if tee(2) should be used])
 else
 	AC_DEFINE([USE_TEE], [0], [Non-zero if tee(2) should be used])
diff --git a/src/input.c b/src/input.c
index 71282fb..4e30010 100644
--- a/src/input.c
+++ b/src/input.c
@@ -183,7 +183,12 @@ static int stdin_tee(void *buf, int nr)
 
 	flush_tee(buf, nr, stdin_state.pending);
 
-	err = USE_TEE ? tee(0, stdin_state.pip[1], nr, 0) : -1;
+	if (USE_TEE)
+		err = tee(0, stdin_state.pip[1], nr, 0);
+	else {
+		errno = EINVAL;
+		err = -1;
+	}
 	stdin_state.pending = err;
 	return err;
 }
@@ -324,13 +329,13 @@ retry:
 	if (!fd && !stdin_bufferable()) {
 		nr = stdin_tee(buf, nr);
 		fd = stdin_state.pip[0];
-		if (nr <= 0) {
+		if (nr < 0 && errno == EINVAL) {
 			fd = 0;
 			nr = 1;
 		}
 	}
 
-	if (nr >= 0)
+	if (nr > 0)
 		nr = read(fd, buf, nr);
 
 	if (nr < 0) {
diff --git a/src/system.h b/src/system.h
index 8cb4726..2138989 100644
--- a/src/system.h
+++ b/src/system.h
@@ -119,13 +119,6 @@ long sysconf(int) __attribute__((__noreturn__));
 int isblank(int c);
 #endif
 
-#ifndef HAVE_TEE
-static inline ssize_t tee(int fd_in, int fd_out, size_t len, unsigned int flags)
-{
-	return -1;
-}
-#endif
-
 #ifndef HAVE_FNMATCH
 static inline int fnmatch(const char *pattern, const char *string, int flags)
 {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
