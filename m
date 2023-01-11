Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB725C46467
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjAKSZ4 (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjAKSZw (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 11 Jan 2023 13:25:52 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5A5ADE95
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 10:25:49 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C1DC0744
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 18:25:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C1DC0744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673461548;
        bh=3/YB03XkE3DWIXWED9uU+Z5t12ZXhUQZKX7EUv9pkyA=; l=3869;
        h=Date:From:Subject:To:From;
        b=aYXN4KR8zg78dHvKyJmK0Rlr/rtzzVW65qvKKcuuV9SM3ac66wwNQI1UjvqYpSqgp
         2vkCFsDQCXUoxTC67gSakvoWWtupP3D8dpguLKg0JwOoJfvtKMZqeSnTTnhthSwnTG
         2k5CHG+nhvSD6APeCkfs9oAgxgWWCLsjkpVH6074=
Message-ID: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
Date:   Wed, 11 Jan 2023 18:23:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
From:   Harald van Dijk <harald@gigawatt.nl>
Subject: [PATCH] Simplify alias storage.
Content-Language: en-US
To:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Rather than storing the alias name and value separately, we can reduce
simplify code and reduce code size by storing them in name=value form.
This allows us to re-use some code from var.c to handle hashing and
comparisons, so long as we update that to account for aliases' special
handling of a leading = character. This is okay to do for variables as
well, as for variables the leading character is guaranteed to not be =.
---
  src/alias.c | 32 ++++++++++----------------------
  src/var.c   | 27 +++++++++++----------------
  src/var.h   | 15 +++++++++++++++
  3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/src/alias.c b/src/alias.c
index fcad43b..bb963a6 100644
--- a/src/alias.c
+++ b/src/alias.c
@@ -41,6 +41,7 @@
  #include "mystring.h"
  #include "alias.h"
  #include "options.h"	/* XXX for argptr (should remove?) */
+#include "var.h"
   #define ATABSIZE 39
  @@ -55,25 +56,26 @@ void
  setalias(const char *name, const char *val)
  {
  	struct alias *ap, **app;
+	size_t namelen;
   	app = __lookupalias(name);
  	ap = *app;
  	INTOFF;
  	if (ap) {
  		if (!(ap->flag & ALIASINUSE)) {
-			ckfree(ap->val);
+			ckfree(ap->name);
  		}
-		ap->val	= savestr(val);
  		ap->flag &= ~ALIASDEAD;
  	} else {
  		/* not found */
  		ap = ckmalloc(sizeof (struct alias));
-		ap->name = savestr(name);
-		ap->val = savestr(val);
  		ap->flag = 0;
  		ap->next = 0;
  		*app = ap;
  	}
+	namelen = val - name;
+	ap->name = savestr(name);
+	ap->val = ap->name + namelen;
  	INTON;
  }
  @@ -150,8 +152,7 @@ aliascmd(int argc, char **argv)
  			} else
  				printalias(ap);
  		} else {
-			*v++ = '\0';
-			setalias(n, v);
+			setalias(n, v + 1);
  		}
  	}
  @@ -190,36 +191,23 @@ freealias(struct alias *ap) {
   	next = ap->next;
  	ckfree(ap->name);
-	ckfree(ap->val);
  	ckfree(ap);
  	return next;
  }
   void
  printalias(const struct alias *ap) {
-	out1str(single_quote(ap->name));
-	out1fmt("=%s\n", single_quote(ap->val));
+	out1fmt("%s\n", single_quote(ap->name));
  }
   STATIC struct alias **
  __lookupalias(const char *name) {
-	unsigned int hashval;
  	struct alias **app;
-	const char *p;
-	unsigned int ch;
  -	p = name;
-
-	ch = (unsigned char)*p;
-	hashval = ch << 4;
-	while (ch) {
-		hashval += ch;
-		ch = (unsigned char)*++p;
-	}
-	app = &atab[hashval % ATABSIZE];
+	app = &atab[hashval(name) % ATABSIZE];
   	for (; *app; app = &(*app)->next) {
-		if (equal(name, (*app)->name)) {
+		if (varequal(name, (*app)->name)) {
  			break;
  		}
  	}
diff --git a/src/var.c b/src/var.c
index b70d72c..64d93aa 100644
--- a/src/var.c
+++ b/src/var.c
@@ -625,12 +625,7 @@ void unsetvar(const char *s)
  STATIC struct var **
  hashvar(const char *p)
  {
-	unsigned int hashval;
-
-	hashval = ((unsigned char) *p) << 4;
-	while (*p && *p != '=')
-		hashval += (unsigned char) *p++;
-	return &vartab[hashval % VTABSIZE];
+	return &vartab[hashval(p) % VTABSIZE];
  }
   @@ -644,19 +639,19 @@ hashvar(const char *p)
  int
  varcmp(const char *p, const char *q)
  {
-	int c, d;
-
-	while ((c = *p) == (d = *q)) {
-		if (!c || c == '=')
-			goto out;
+	int c = *p, d = *q;
+	while (c == d) {
+		if (!c)
+			break;
  		p++;
  		q++;
+		c = *p;
+		d = *q;
+		if (c == '=')
+			c = '\0';
+		if (d == '=')
+			d = '\0';
  	}
-	if (c == '=')
-		c = 0;
-	if (d == '=')
-		d = 0;
-out:
  	return c - d;
  }
  diff --git a/src/var.h b/src/var.h
index aa7575a..2aece9d 100644
--- a/src/var.h
+++ b/src/var.h
@@ -153,6 +153,21 @@ int unsetcmd(int, char **);
  void unsetvar(const char *);
  int varcmp(const char *, const char *);
  +static inline unsigned int hashval(const char *p)
+{
+	unsigned int hashval;
+
+	hashval = ((unsigned char) *p) << 4;
+	while (*p) {
+		hashval += (unsigned char) *p++;
+		if (*p == '=')
+			break;
+	}
+
+	return hashval;
+}
+
+
  static inline int varequal(const char *a, const char *b) {
  	return !varcmp(a, b);
  }
-- 
2.39.0

