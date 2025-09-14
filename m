Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF41F5842
	for <dash@vger.kernel.org>; Sun, 14 Sep 2025 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757814330; cv=none; b=k0uHu4Mhjo+6ivsn3dNrn2S4FzeK15R/cu3GDKSrVUWtJ8mQBBHf3UfUzZV7O5R5ntnItry8AocQ67Qu0xV8EY2Yfl+sfWkHGZ9oarXZ60PAyvI8jNEk6yHJlcz0yedh1Rph3QOoqqr7DHhRVbJ/sZE8lvvK5nfOeFlQFJWuEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757814330; c=relaxed/simple;
	bh=vAXWcHCbek0rVyr9emFZipn2oKPCHPo+XENjTneuyPk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mfq/YRrS7sYplbn42+2J+2R4ywippsdQrtxWx9HGybC5oMyGvESezoOObZYsa5Km/R99YnUOx4yQm94Tx01YZWlNczz0ZCLtF6wVdUB/+5k+JttJ4PNBxr7hkRvwI8QsJ72dygS2pbN5PlIYFmkhSTNkMnLGt3HQN1bbCyBXfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=mAgBDENV; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="mAgBDENV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Uknz4WVY8SKw6bagswUMlUsFEVaXW5RMBgg89yZljzM=; b=mAgBDENVf45BB93+LGbwNUi1mf
	1SOOkFrkE0vQIq0x4Bt71w8fcvReZ880o5ZAhxNgr+HG7LpdQLYs+bT96ueI8MKfqfDwaJTLk+lkr
	9IXJP6rPr+qt0qLrxOBVbxcX08wTGD5vBHxQZxJd/AyZBYKZHU/8nvxRUXzrNhBRddHzyfrKl+cgN
	KAd310S731FFFuOP3LwKYM9GFzXZLsUhaXlaMCk80Tqzb7Tl813uMZUjBw2vb8690dSU1P6sODAHj
	h8cUvhLor+bEt+WdEHpMXuPYa+IWeH+eRJhk46veLvzVkTX9IDrQGJoScn0K29c5bjj1EluNqa+jH
	Qvs7hUJA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uxbYT-005FEL-2K;
	Sun, 14 Sep 2025 09:45:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 14 Sep 2025 09:45:22 +0800
Date: Sun, 14 Sep 2025 09:45:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Nurpmeso <steffen@sdaoden.eu>
Cc: dash@vger.kernel.org
Subject: [PATCH] options: Check stderr instead of stdout for interactivity
Message-ID: <aMYeMmAsiDwGNNrO@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927232652.bpLrmgJb@steffen%sdaoden.eu>
X-Newsgroups: apana.lists.os.linux.dash

Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
> 
> In an email communication with kre@ on NetBSD's tech-userlevel we
> came over
> 
>  commit a373e69a196cd8d45f2806d805e548fa65a982ba
>  Author:     kre <kre@NetBSD.org>
>  AuthorDate: 2017-07-24 12:35:37 +0000
>  Commit:     kre <kre@NetBSD.org>
>  CommitDate: 2017-07-24 12:35:37 +0000
> 
>      PR standards/52406
> 
>      Absent other information, the shell should be interactive if reading
>      from stdin, and stdin and stderr are ttys, not stdin and stdout.
> 
> and i had in mind that dash changed this already (i thought i saw
> a patch flying by on the ML?), but looking at procargs() there is
> 
>        if (iflag == 2 && sflag == 1 && stdin_istty && isatty(1))
>                iflag = 1;
> 
> where that would require
> 
>        if (iflag == 2 && sflag == 1 && stdin_istty && isatty(2))
>                iflag = 1;

Check stderr instead of stdout in procargs for interactivity.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/options.c b/src/options.c
index 3e6c450..c318e0f 100644
--- a/src/options.c
+++ b/src/options.c
@@ -138,7 +138,7 @@ procargs(char **xargv)
 			sh_error("-c requires an argument");
 		sflag = 1;
 	}
-	if (iflag == 2 && sflag == 1 && stdin_istty && isatty(1))
+	if (iflag == 2 && sflag == 1 && stdin_istty && isatty(2))
 		iflag = 1;
 	if (mflag == 2)
 		mflag = iflag;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
