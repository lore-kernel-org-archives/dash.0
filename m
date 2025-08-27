Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFA3431F5
	for <dash@vger.kernel.org>; Wed, 27 Aug 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285997; cv=none; b=S3tduWuxpZF0QnHVbddkovnpW3mFW0j/Ss17oXQgBcZAEUKTIuslfqTXSuhr6flGz4CZHyN5hQD5fkrnihTwJLrcf6drYP1aJlJggGc5tW3Q5wSkPAmFqg/kCE22Kzsck43xAbjxtLs0vXCYmM8Inv8Hs6vr6Id6i7XTX/B25nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285997; c=relaxed/simple;
	bh=KtnNnJlpb2tv7hVkYB7K8L/64J/Ub3Lb76LC31TsOHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NHisZxuR7znZX+fBfpRmQSSX395+B8eujdak7hiAi1y7BkK6t1odv7f75w2HfuNhcv5SuTxl+ON3tYdxrUrReULuRqFJGzP8H2W8ecmdCr+evfOCGth0Ea/nKLRVsYjKM1qsCqw1PSkTdgKrqA/BXxvT4PM6LSDp7rmfSxthMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=K3L0ynn+; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="K3L0ynn+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Io2ADIAANv/6zJhjJ4quiXhYqkB4RDqhUBihuaKeahk=; b=K3L0ynn+x+Zgz0n2dgMou0KDUd
	nQjNonVX5qQXzV+YxCgBE+aXffohtb8uD5rq4/9VSTIVaUxtCA0/sg2KuPSAOsmv3a1PMAd+q0Cic
	rEvyYEa5R0FZgCg7r2ENie0nZe/jQeWEP0QVDuM0gy8D+fAcNfbG4lR0/DbtmaXA56rH76MuXaO+v
	pHgJZt8kbzjUgoG8o1rjGlYiG7vGrp6RRi/PWQ0iZiYdglAwl/2rSnxDAAwmXuZ3fTTzuJEO+oU7n
	MhWXztyuunx95DWzHkm+VH4u4N9ZctZ8NKrY+y4SYWNtbulXZe+QlHM8d96SbFJEe0PAY0FVaHQ2I
	Fvlk1TVQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1urBxq-000Ae2-1N;
	Wed, 27 Aug 2025 17:13:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 27 Aug 2025 17:13:02 +0800
Date: Wed, 27 Aug 2025 17:13:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
Subject: [PATCH] parser: Do not display prompts in expandstr
Message-ID: <aK7MHpNI5yG5Sg-0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7016eb2-44fb-4f7c-a457-ea0566641d03@astralinux.ru>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <aushakov@astralinux.ru> wrote:
> 
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit fd725b7a75 and would like to 
> report it. The details are provided below.
> The target crashed when reading from memory after it has been freed.
> ==131==ERROR: AddressSanitizer: heap-buffer-overflow on address 
> 0x5020000004f5 at pc 0x60bd0214d131 bp 0x7fff45c03700 sp 0x7fff45c02eb0
> READ of size 2 at 0x5020000004f5 thread T0
>     #0 0x60bd0214d130 in __interceptor_strlen 
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:389
>     #1 0x60bd02239fee in setinputstring /upstream/dash/src/input.c:593
>     #2 0x60bd0226936c in expandstr /upstream/dash/src/parser.c:1739
>     #3 0x60bd02215e18 in evalcommand /upstream/dash/src/eval.c:881
>     #4 0x60bd0220d9f0 in evaltree /upstream/dash/src/eval.c:305
>     #5 0x60bd0224b2eb in cmdloop /upstream/dash/src/main.c:246
>     #6 0x60bd0212643c in main /upstream/dash/src/main.c:180
> 
> 0x5020000004f5 is located 0 bytes to the right of 5-byte region 
> [0x5020000004f0,0x5020000004f5)
> allocated by thread T0 here:
>     #0 0x60bd021bb38f in __interceptor_malloc 
> ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
>     #1 0x60bd0224c728 in ckmalloc /upstream/dash/src/memalloc.c:66

I couldn't reproduce this, but I did notice that PS2 was being
incorrectly shown during PS4 expansion:

---8<---
Set needprompt to zero as it may have been set by the caller.  It
is safe to do so here as the only calls to expandstr within the
parser set needprompt to zero already.

Reported-by: Aleksander Ushakov <aushakov@astralinux.ru>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index aecc18f..a3b004b 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1742,6 +1742,7 @@ expandstr(const char *ps)
 	heredoclist = NULL;
 	saveprompt = doprompt;
 	doprompt = 0;
+	needprompt = 0;
 	result = ps;
 	savehandler = handler;
 	if (unlikely(err = setjmp(jmploc.loc)))
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
