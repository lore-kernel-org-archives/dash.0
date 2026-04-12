Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB036C0C8
	for <dash@vger.kernel.org>; Sun, 12 Apr 2026 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775987112; cv=none; b=DgvvY5KWBiR1Df8WII3J+X11ZedRoaUMxuHaHW0eDgk/ycIgCfZCfncgaur9uql/EfK3o8ksuY7AEzrB1wP/Gt8xDjH1G7Tuth2nA4WHoD7Bx4i2oAAzLzkV4SZlCeMEKQlPbJwh9tGcbxXE3I+qwe2eWqUk6LNZojSxdPSEuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775987112; c=relaxed/simple;
	bh=ESoAPIXd++Yf6qK6Q2lNLAUOmZjUnTt14GNKUIfT3jg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dhs8+ompShfm41+mIl4Bo+sQaDefTI1z0Ubg20VMipO9xkhS4Kv1vh/gVKHJM7wx2iwbqQiqigGUY5W7uGAjIGxnw08xr9pJ3p6orZ4iTdssRlcUcxbli7zKn4EXhu72B+zJM/awBj5CYJ3A1qekdVqRhjKz0hj5Xvy95SCPVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=TaqrSG/S; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="TaqrSG/S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=mPqqL9yO2vEpHX44dHFAI4QoWiGo4AK7hris+1HiKzc=; b=TaqrSG/S1OrUYYaHPeoYtwBhWk
	fYpBW1KZGkZpfKJkxsDNdtB3pJVoTs6XFgPDnt0zupnkN9cIJfpadjABqwFwmUr3+fsekpJQkTAMZ
	LzPWLyOdeDMHsOGqcD3mOuZHRdhcoTv8v9eMCTEByGoNkxaJyQqSmb+VF61R/G5nRhPDWdPWvDVCo
	Gm5wsLa9VAdW6gtoaWVCmK7s0K9eMUynEI7/WO3VZ4iWfs85EyHRpvIjPX9dFDrr0dY5vn/na0IsB
	X4lmiXNZyoxhcD+7Ojnsha0OWuz5Wlekb9b+6oG2HdjCHbbihhBW2jWuDTPR3BhTUyiNYdb1L6g2L
	BzH5oA4A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wBqxr-005UiZ-06;
	Sun, 12 Apr 2026 17:45:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 12 Apr 2026 17:45:05 +0800
Date: Sun, 12 Apr 2026 17:45:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc: dash@vger.kernel.org
Subject: [PATCH] parser: Only reject non-word tokens in case pattern
Message-ID: <adtpoV0A0LkTXW6X@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e89cc83-a890-42ec-8e8c-13c5e65905d6@green-communications.fr>
X-Newsgroups: apana.lists.os.linux.dash

Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr> wrote:
> This syntax is accepted by all shells except dash 0.5.13.2:
> 
> case "$test" in
> in) echo input;;
> out) echo output;;
> do) echo start;;
> done) echo stop;;
> esac
> 
> on dash 0.5.13.2, it fails with "Syntax error: "in" unexpected (expecting word)".
> Reverting e8c0324af64c("parser: Catch bogus case patterns") fixes it.
> 
> POSIX says that only esac should be recognized as a keyword when parsing the 
> first pattern of a case.
> 
> An example of a real script broken by this change:
> 
> https://salsa.debian.org/debian/netplug/-/blob/debian/unstable/scripts/netplug?ref_type=heads

Thanks for the report.  This patch should fix the problem:

---8<---
Allow keywords to be used as case patterns and only reject non-word
tokens.

Reported-by: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Fixes: e8c0324af64c ("parser: Catch bogus case patterns")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index bbee1e3..bea4148 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -442,7 +442,7 @@ next_case:
 			cp->type = NCLIST;
 			app = &cp->nclist.pattern;
 			for (;;) {
-				if (lasttoken != TWORD)
+				if (lasttoken < TWORD)
 					synexpect(TWORD);
 				*app = ap = (union node *)stalloc(sizeof (struct narg));
 				ap->type = NARG;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
