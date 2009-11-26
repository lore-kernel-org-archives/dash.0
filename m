From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Rergession in readcmd (commit 55c46b7)
Date: Thu, 26 Nov 2009 11:54:59 +0800
Message-ID: <20091126035459.GA11843@gondor.apana.org.au>
References: <4AFA1115.6000000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from rhun.apana.org.au ([64.62.148.172]:36523 "EHLO
	arnor.apana.org.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932331AbZKZDy4 (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 25 Nov 2009 22:54:56 -0500
Content-Disposition: inline
In-Reply-To: <4AFA1115.6000000@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Alexey Gladkov <gladkov.alexey@gmail.com>
Cc: dash@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> 
> I found another example:
> 
> $ tr -d '[:print:]' < /etc/passwd |tr -d '\t\n' |wc -c
> 0
> 
> $ dash -c 'while read o p; do printf "[%s] [%s]\n" "$o" "$p"; done <
> /etc/passwd' |tr -d '[:print:]' |tr -d '[:space:]' |wc -c
> 61
> 
> bug is not fixed yet :(

This bug is caused by an off-by-one error in the recordregion
call in readcmd.  It included the terminating NUL in the region
which causes ifsbreakup to include the string after it for scanning.

Setting the correct length fixes the problem.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/ChangeLog b/ChangeLog
index fabb0e1..7be8e86 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,7 @@
+2009-11-26  Herbert Xu <herbert@gondor.apana.org.au>
+
+	Fix off-by-one recordregion in readcmd.
+
 2009-09-28  Jim Meyering  <meyering@redhat.com>
 
 	don't read-uninitialized for \177 in a here-doc
diff --git a/src/miscbltin.c b/src/miscbltin.c
index ec9872d..046f2f2 100644
--- a/src/miscbltin.c
+++ b/src/miscbltin.c
@@ -84,7 +84,7 @@ readcmd_handle_line(char *line, char **ap, size_t len)
 	backup = sstrdup(line);
 
 	arglist.lastp = &arglist.list;
-	recordregion(0, len, 0);
+	recordregion(0, len - 1, 0);
 	
 	ifsbreakup(s, &arglist);
 	*arglist.lastp = NULL;

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
