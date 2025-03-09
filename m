Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4D1917ED
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741510320; cv=none; b=Gzw7rdRUV6Ymqxdm2pePZ/gJPt3w8ZyAF4fj9boFAck4qTnYHjiGce3xHFiZipXeP/ArGz6jG1MrczxO9YkClIi9CZIu6ogEHJIIIIr17nTStCcWu8whVoXHylALKW5cakLVa4KgRDQdCOk3NVgb7uuVpjdd09UsAaEMPhc0UGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741510320; c=relaxed/simple;
	bh=2JFJf22mlwq5NrN37DsRvrhBG7zMD1MwJNYq1LZl7eY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Aoz5MehFBp8sV09iYIGCgw6QqBp5PeZN3fTO/qdztvp11mpTnG0pZOf+8t19rTwWHAXGbjFhI7jJ07OQZiLCjhleGbS+5kKaZy79W9J7i45WuZ+0aBYQfeqDrmNt5MMiCcdWiokwe3klS+7E1EwJ0pAnt0i92RW1AW3ceK/r2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TM5R8Q19; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TM5R8Q19"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z+xB5dBvf/gSrK3+gG1gP5+fHboLtfl/nq8y+kozQqU=; b=TM5R8Q19rpFsbtY5MznSmQq4yl
	MpjLSgFEBnUf4VhUWFfIqlViMQaLF+TAkQUGOzZuE/JrLDLnep2MUgLhTl7sPnrEcZEgzbambBgaP
	wVbGeSQMyfVdrGkZMfTt5h27FTqRVpRva/z4vo+LgrZdbsj8vANad8RAWKMoOMQJP/p20kRO6mRaX
	fl+9vS1FCd0EDrouJ0klIfpzbMST7mNUGGlcpXg9QmqJ2BjVl0+i1YyKpaV5FgXl5NJgt622DBNrW
	gd2XLf6VlgWrZJY4aziyVmDqhnOpv6Hp+TqInMf4ZBPPFhcUTxoQUZxtB9XDHF+6pMsr4qMIKRITz
	tL+tk8bQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trCO1-0052Nj-0e;
	Sun, 09 Mar 2025 16:51:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 16:51:53 +0800
Date: Sun, 9 Mar 2025 16:51:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Johannes Altmanninger <aclopte@gmail.com>
Cc: dash@vger.kernel.org
Subject: expand: Fix scanright zero handling when fnmatch is disabled
Message-ID: <Z81WqTBtj9TRqQzy@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7mDhYBNOMKSJtEJ@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Johannes Altmanninger <aclopte@gmail.com> wrote:
> I noticed another regression in c5bf970 (expand: Add multi-byte
> support to pmatch, 2024-06-02).
> 
> This command now prints "abc-def" but used to print "ef".
> 
>        x=abc-def
>        y="${x##*d}"
>        echo "$y"

Fix this by setting s to the correct value in scanright based
on FNMATCH_IS_ENABLED.

Fixes: c5bf9702ea11 ("expand: Add multi-byte support to pmatch")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 7a30648..0066e1a 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -650,7 +650,7 @@ static char *scanright(char *startp, char *endp, char *rmesc, char *rmescend,
 
 		if (zero) {
 			*s = '\0';
-			s = rmesc;
+			s = FNMATCH_IS_ENABLED ? rmesc : startp;
 		}
 		match = pmatch(str, s);
 		*(FNMATCH_IS_ENABLED ? loc2 : loc) = c;

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
