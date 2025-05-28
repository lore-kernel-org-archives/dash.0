Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6F17BA1
	for <dash@vger.kernel.org>; Wed, 28 May 2025 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748401267; cv=none; b=j5Z0Vr2W7WSYN7cZYn3njlapRl+57wyuNaDhxz53dF6YQP+m2gDvAohQ3ls+ETvuAIZ6Vi0uUHt78IawAPViT7O50gK67VU9PRlFda//ppFdEfyBXUnCw7J0DmvGXgb54jwf82dM1GrOgwEl5UvTJY3zzti9O/Sz3WOwREtM7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748401267; c=relaxed/simple;
	bh=P/LPfpxlb5AdQ4m33TTPlEk4NOOvw6xf9bx5hejqbVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdDcyvUY6FFnTdJ7fLO5D52NbW16Z/JG6RCKRAo5GMatnYGkUr/hvWw6tNSoGDZ/UWmTXVcywf5/hDbFGTqqIyEBknpyeWmWK5XlIoGY6PL/dJttVfyGQqsyi9YqhR+FincLclhN1FfsoJoPNCL7r3A5fz6n0BwtanGv3z1/Mr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ocxLLxMD; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ocxLLxMD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZtCJwK7sc/+23Csx4oppYSl3aCm0hOduGFnJRziAniU=; b=ocxLLxMDUmoT8Qy4pf/xkPFV9s
	SusXP+5OlALzae+MPlK+nV63/LgujCGoJFo+jl3LbcLIxBPtluDT+Upw3hlk81u1l9/Ofackb2yec
	0jj6rGYoanztxq2jhekmjbnurEiVsJ+BMz1D7/NZmV+G1GgFGjf2TJHw6ktqlbp7kHc3tj35cyS0R
	2C5HlYJ7dvd+3N6A/zTmgA84fDgTnROGBCaw3hoE6qlEutR1ZK7KseIgSQJWio9ar3z3196e0GyW9
	znOnCokTGUCMvNGVGF/Dx7rAOoXvBcd5TEug8o/v8NO1ZR7D6IFSzsTGFznl/2vlSTzIJiz60S2AF
	LDUVo/Og==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uK72B-009NBG-2o;
	Wed, 28 May 2025 11:00:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 May 2025 11:00:51 +0800
Date: Wed, 28 May 2025 11:00:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nathan Royce <nroycea+kernel@gmail.com>
Cc: DASH Mailing List <dash@vger.kernel.org>
Subject: [PATCH] input: Reset eof in reset_input
Message-ID: <aDZ8Y00WXGmi5ZFA@gondor.apana.org.au>
References: <CALaQ_hok_beXdXUkjCBVuatgPzua94kv3dfvZjpp=7aFoqNMMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALaQ_hok_beXdXUkjCBVuatgPzua94kv3dfvZjpp=7aFoqNMMA@mail.gmail.com>

On Tue, May 27, 2025 at 07:09:17PM -0500, Nathan Royce wrote:
> I hope I'm doing this correctly by contacting you, as I saw no process
> to go by (eg. via README)...

Thanks for the report.  This should go to the mailing list which
I have now cc'ed.

> Using the script sample below, the "read" for the "After" prompt which
> happens after the "loopRead" function which reads from a redirected
> "heredoc", ends up being skipped over (or rather, not waiting for user
> tty stdin, as if it was somehow still being read by the loop, even
> though it's out of scope?).
> 
> Success: 0.5.12
> Fail: b3e38adf6718801e7f06267b438c45caec9523bb
> Success: Bash - 5.2.037

It's the new EOF handling patch, which was not reset correctly
when stdin is redirected, causing the EOF to persist after redirection.

Here is a reproducer:

echo ok | {
        read x < /dev/null
        read x
        echo $x
}

---8<---
Ensure that the EOF state is reset in reset_input as otherwise
the new stdin may be treated as empty.

Reported-by: Nathan Royce <nroycea+kernel@gmail.com>
Fixes: 69786bc79f9b ("input: Fix pungetc on PEOF")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/input.c b/src/input.c
index 6388b83..1aff3d4 100644
--- a/src/input.c
+++ b/src/input.c
@@ -684,6 +684,7 @@ void __attribute__((noinline)) flush_input(void)
 
 void reset_input(void)
 {
-	flush_input();
 	stdin_istty = -1;
+	basepf.eof = 0;
+	flush_input();
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
