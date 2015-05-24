From: Fredrik Fornwall <fredrik@fornwall.net>
Subject: Re: [PATCH] Set LC_ALL instead LC_COLLATE in mkbuiltins
Date: Sun, 24 May 2015 23:05:48 +0200
Message-ID: <CAOhdH0uPNu3DN-iDRiiCvjpU6FPvK_4AvdEuZE3bQ8F3j9DuCg@mail.gmail.com>
References: <CAOhdH0uf7Kj2noz4vnuLo_06W2HZ4Xwh_Bm5vKC71VHfeswD_Q@mail.gmail.com>
	<20150522042531.GA30829@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:32998 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbEXVFv (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 24 May 2015 17:05:51 -0400
Received: by lami4 with SMTP id i4so39302381lam.0
        for <dash@vger.kernel.org>; Sun, 24 May 2015 14:05:48 -0700 (PDT)
In-Reply-To: <20150522042531.GA30829@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Fri, May 22, 2015 at 6:25 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> This causes any errors printed by sort to come out in English.
>
> Please fix this by simply setting LC_ALL to empty alongside
> LC_COLLATE=C.

A version with LC_ALL= follows:

diff -u -r ../dash-0.5.8/src/mkbuiltins ./src/mkbuiltins
--- ../dash-0.5.8/src/mkbuiltins 2014-09-28 04:19:32.000000000 -0400
+++ ./src/mkbuiltins 2015-05-17 19:08:00.076452891 -0400
@@ -78,7 +78,7 @@
  if ($i ~ /^-/)
  line = $(++i) "\t" line
  print line
- }}' $temp | LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
+ }}' $temp | LC_ALL= LC_COLLATE=C sort -k 1,1 | tee $temp2 | awk '{
  opt = ""
  if (NF > 2) {
  opt = substr($2, 2)
@@ -97,7 +97,7 @@
  */

 !
-sed 's/ -[a-z]*//' $temp2 | nl -b a -v 0 | LC_COLLATE=C sort -u -k 3,3 |
+sed 's/ -[a-z]*//' $temp2 | nl -b a -v 0 | LC_ALL= LC_COLLATE=C sort
-u -k 3,3 |
 tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ |
  awk '{ printf "#define %s (builtincmd + %d)\n", $3, $1}'
 printf '\n#define NUMBUILTINS %d\n' $(wc -l < $temp2)
