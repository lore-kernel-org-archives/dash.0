Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B1B9476
	for <dash@vger.kernel.org>; Sat, 13 Sep 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757771147; cv=none; b=MqMN/8sJ82rMIRV3tgw+NyqHAg4RNuBibRnFbdKZzdjIdoYN5MMcs0AcO8Cfih7W1vnpeO95ZxbQxBVke+xLw+OD8eVeC3QO9mI4gj/Ui8UCKQ/vXRLnWHHfAr9K7AVrMwxC62rdGE5/mAC3Uv+nP/RF/1LSfcBxstgKP/C4sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757771147; c=relaxed/simple;
	bh=CoUKHD06OQdPmYIV8kLrLJhNjT7F9RCY2Qi4y5W9Xko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQhxPShnlc2+PX6uXQr10U08c3Ld6UNkjJ8pepdrvTgEhs0RAge8VSGxT2JQhaT/aYzdjV2IGa6qpRFWy4mUE15jh2waxvmLcMmaG+4CwhYrxLl2n/6oW95rRyZJRL7sNMrXQV2mKRZGo4QeskdpcY23jsWnSmhAODaye3bxuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WNFgrXWU; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WNFgrXWU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9Rebrnk/VzKRjZD7Z9MG5VJ2quQ78KD5nl9ZVCHTGyw=; b=WNFgrXWUcSLyzbWH4Nk6qLSyQa
	FSQOGlHdTYZh9ssV00s1FYbQYW+2Zt+RGjTpciMRs2eH6XsOBDGsTqfYzo+eT+VJeag3RhY7ZBqmU
	wu09CYd+eWTJcWmPDmD6vVPz8x+GzpbxQdlvOlgN5NcNxU+yTStCjwUBprC/ZHQtGU1oQ3jmv+WG3
	GymDnwwnwM4kWI3f6NdWTNHDzQYi87p76eBnQYKfTrq4c+NXFBMsOhABbKBDCMrTvMaskqh48OhRY
	Zt84HnyH31ew9cdETTo0bnOg59mDQJdNJdyUbtNdTXQZV2xoLuuvbiVPAecDmH756pzqsOJV/sN67
	W1ddNt1w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxQJz-00583y-1x;
	Sat, 13 Sep 2025 21:45:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Sep 2025 21:45:39 +0800
Date: Sat, 13 Sep 2025 21:45:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Mills <the.true.nathan.mills@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] parser: Fix USTPUTC overflow for new-style command
 substition here-doc marker
Message-ID: <aMV1g1maSRXAuMBH@gondor.apana.org.au>
References: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjJ9ccRuGV9fmydBvwzOua_om7QVoro-nSA-pv+9-nX1KLfGA@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:40:16PM -0700, Nathan Mills wrote:
>
> * Crash #70 is a global-buffer-overflow caused by trying to place the
> closing parenthesis in the buffer stacknxt when there is not enough
> space (out points to stacknxt+512 and it tries to append character
> #513) during an attempt to read an input with an unclosed $()
> backtick.
>
> ** Crash #70 global-buffer-overflow **
> 
> Base64'd
> djR0bm9lITw8XDwkZGViXGd3JHd4ZWMkAIEkAiQzZSQoXAopITw8XDwkf3ckd3hlY1MAgSQCJDNl
> JChcCilcZ3ckd3hlYySMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMAIEkAiQzZSQoXAopKQ==
> 
> FIX for #70:
> diff --git a/src/parser.c b/src/parser.c
> index aecc18f..d3b598b 100644
> --- a/src/parser.c
> +++ b/src/parser.c
> @@ -1616,6 +1616,7 @@ done:
>         } else {
>                 if (chkeofmark) {
>                         out = commandtextcont(n, out);
> +                       CHECKSTRSPACE(1, out);
>                         USTPUTC(')', out);
>                 }
>                 goto parsebackq_newreturn;

Thanks for the report.  That USTPUTC should be a STPUTC.

---8<---
Use STPUTC after aommdntextcont when parsing a new-style command
substitution used as a here-document marker.

Reported-by: Nathan Mills <the.true.nathan.mills@gmail.com>
Fixes: 7a11b3e330a3 ("parser: Extend coverage of CHKEOFMARK")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index a3b004b..488adfd 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -1616,7 +1616,7 @@ done:
 	} else {
 		if (chkeofmark) {
 			out = commandtextcont(n, out);
-			USTPUTC(')', out);
+			STPUTC(')', out);
 		}
 		goto parsebackq_newreturn;
 	}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
