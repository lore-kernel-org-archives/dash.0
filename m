Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B73DFC7E
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353534; cv=none; b=D5IIvFcuDzLeCwCV6/DIz6/vHRvunnhCptBR+zJf+nmUeJnCp7KblfDeXUca3qOxCL4kbtcDQXpU9E8rlbKfaiFx7cNhN69/nTnuUbrt3xXIU4KqeIjnVAsIlv26to25tsP3DcVGINdRMeQHY+qIHUwxpsb7PuvQORQnP/5KPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353534; c=relaxed/simple;
	bh=xZEQ8ivn14KeYHkdvpVzPQsZeslOBYnfFGDFu18C6cw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DNK07TsMf8fe8SeLbXV/YfxX5fRBDokZwOx5bMlMrOfB1eXkh/h9gJ75kTfGZJIwnwbPEEFWVMzTz06yBUIrTazGeQP6LVEwSvii1muDSYN/NsGB7FyH8fJBUgpAc59HZpQgCv6LV55ONNzFn7FEufezzq2/2Awfiz4hSUphlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=hykBP9QM; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="hykBP9QM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=1lgO7fhKSVQYjw5Qw8Y6qi5RYCTFYyd5yMK1+Tc+6sI=; b=hykBP9QMyK4oP/C21w8R3P0U2b
	H2ngGHislM/jypXYhIZ+4zQdXK0Qbt3K62VcNORQNF29F6YMWsDanMqscBqcTFB8NO/bGm/e6uxXN
	Bw8ZOtKIsghI8jN3ASYzGS89aCXP33EDHrv3xKNgIkVdf9/Q51NQZctBtWwetNd0hduSoIdyeqmIj
	cnU3z33SrBU8wYoUZAalMp3QHpHQPO6I4qWVyUwIH7D3DIK/hurXv7AhEgYamp3TLE+ih/qDWQCug
	dKRWU46vHPWgziBkBYrukNBbSFLt3hAYmhPKVnlog0CMrYkSwR63AkGuWbqN1JweQhGifOxKmZH5k
	zo+1iEtg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYNQV-0000000592G-36Y4;
	Sat, 13 Jun 2026 20:25:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 20:25:27 +0800
Date: Sat, 13 Jun 2026 20:25:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vladimir Kudrya <vladimir.csp@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] var: Call setlocale when LC variables are set
Message-ID: <ai1MN3hk3ihI7FBf@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5b51fec-6647-4c61-9986-5fc539c438d5@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Vladimir Kudrya <vladimir.csp@gmail.com> wrote:
> Hi!
> It seems that this commit c5bf9702 changed behavior of ${var#?} under 
> LC_ALL=C, which should consider characters to be one byte long and cut 
> accordingly.
> 
> This code:
> 
>        var=联;
>        LC_ALL=C
>        while [ -n "$var" ]; do
>                cut_var=${var#?}
>                byte=${var%"$cut_var"}
>                printf '>%02x<\n' "'$byte"
>                var=$cut_var
>        done
>        unset LC_ALL
> 
> should output:
> 
> >e8<
> >81<
> >94<
> 
> It works reliably in sh 0.5.12, also ash, bash, zsh (both in POSIX and 
> native modes), but is broken in dash 0.5.13.
> 
> More context can be found at:
> https://github.com/Vladimir-csp/app2unit/issues/17

Yes this is a consequence of dash only calling setlocale on startup.

This patch should fix the problem:

---8<---
When any shell-relevant locale environment variable changes, call
putenv followed by setlocale so that the change is effective for
the current shell.

Reported-by: Vladimir Kudrya <vladimir.csp@gmail.com>
Fixes: cb669294463e ("shell: Call setlocale")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/main.c b/src/main.c
index 5d25b8d..2ab506c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -32,7 +32,6 @@
  * SUCH DAMAGE.
  */
 
-#include <locale.h>
 #include <stdio.h>
 #include <signal.h>
 #include <sys/stat.h>
@@ -104,8 +103,6 @@ main(int argc, char **argv)
 	monitor(4, etext, profile_buf, sizeof profile_buf, 50);
 #endif
 
-	setlocale(LC_ALL, "");
-
 	state = 0;
 	if (unlikely(setjmp(main_handler.loc))) {
 		int e;
diff --git a/src/var.c b/src/var.c
index 90fc896..e76abe3 100644
--- a/src/var.c
+++ b/src/var.c
@@ -32,6 +32,7 @@
  * SUCH DAMAGE.
  */
 
+#include <locale.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -81,6 +82,12 @@ MKINIT char defoptindvar[] = "OPTIND=1";
 int lineno;
 char linenovar[sizeof("LINENO=")+sizeof(int)*CHAR_BIT/3+1] = "LINENO=";
 
+static void changelocale(const char *val)
+{
+	putenv((char *)val);
+	setlocale(LC_ALL, nullstr);
+}
+
 /* Some macros in var.h depend on the order, add new variables to the end. */
 struct var varinit[] = {
 #if ATTY
@@ -101,6 +108,11 @@ struct var varinit[] = {
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"TERM\0",	0 },
 	{ 0,	VSTRFIXED|VTEXTFIXED|VUNSET,	"HISTSIZE\0",	sethistsize },
 #endif
+	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_ALL\0",	changelocale },
+	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_COLLATE\0", changelocale },
+	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_CTYPE\0", changelocale },
+	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LC_NUMERIC\0", changelocale },
+	{ 0,	VSTRFIXED|VTEXTFIXED|VFULL|VUNSET, "LANG\0",	changelocale },
 };
 
 STATIC struct var *vartab[VTABSIZE];
@@ -160,6 +172,19 @@ static char *varnull(const char *s)
 	return strchrnul(s, '=') + 1;
 }
 
+static void varfunc(struct var *vp)
+{
+	const char *s;
+
+	if (!vp->func)
+		return;
+
+	s = vp->text;
+	if (!(vp->flags & VFULL))
+		s = varnull(s);
+	(*vp->func)(s);
+}
+
 /*
  * This routine initializes the builtin variables.  It is called when the
  * shell is initialized.
@@ -299,8 +324,8 @@ out_free:
 	vp->text = s;
 	vp->flags = flags;
 
-	if (vp->func && (flags & VNOFUNC) == 0)
-		(*vp->func)(varnull(s));
+	if (!(flags & VNOFUNC))
+		varfunc(vp);
 
 out:
 	return vp;
@@ -536,8 +561,8 @@ poplocalvars(void)
 				ckfree(vp->text);
 			vp->flags = lvp->flags;
 			vp->text = lvp->text;
-			if (vp->func && !(vp->flags & VNOFUNC))
-				(*vp->func)(varnull(vp->text));
+			if (!(vp->flags & VNOFUNC))
+				varfunc(vp);
 		}
 		ckfree(lvp);
 	}
diff --git a/src/var.h b/src/var.h
index f6fb320..3d837a7 100644
--- a/src/var.h
+++ b/src/var.h
@@ -48,7 +48,7 @@
 #define VSTACK		0x10	/* text is allocated on the stack */
 #define VUNSET		0x20	/* the variable is not set */
 #define VNOFUNC		0x40	/* don't call the callback function */
-/* #define VNOSET	0x80	   do not set variable - just readonly test */
+#define VFULL		0x80	/* pass value suitable for putenv */
 #define VNOSAVE		0x100	/* when text is on the heap before setvareq */
 
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
