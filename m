Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7932A41
	for <dash@vger.kernel.org>; Mon, 21 Oct 2024 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729488433; cv=none; b=j+VtuSFIQuILvleJJHFz2v7esqMwvZyQLHCAVYdGatVyCEd6CkdssAoJumii57QvNuUQ3Q3TO/uhhigb1AZAgqmTbNJ++63oj1Q8EyxatZ4M7Akd6Zpdt/A7YugZFjoDhg0iLZr1KDRTgbVz8wAq26go7QKJTTrs1Y5ki9wA744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729488433; c=relaxed/simple;
	bh=SGjTKPL6OEVoymDTXykRignMGKiT/cjK6OuBckSPHjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rs5TRAjHMBZDdW5PVMmuz89ipj4qdoVcVDi++OAYR9gvY3hXk9Globy+SinTDcZErKHj4PtT6ccPyYidBBh9XjwLcn319dwB8n3wdRIlMMlP/+Ls5ieaYq8FlCR+H6Nq0Ekc/wjqAoJ/Ur2Jg96JOaQz7ek/SWEg13OFwobGJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=NM0AIRjH; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="NM0AIRjH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AgHTwLQ5/beCdeTHAkaiav9xGLN3O9ReTrdjBob2lwk=; b=NM0AIRjHc7WT9Te3aN/OVgctw2
	Gic56bZUY0PpI3Gl2iCzjXitedC3245+LVvPIoBoGtpcxE3kmnN46CXYmIObI/7aHtCckwf/mtRTg
	yI7ZPTtIlI64eDMhqqaM/DjjSZpxApas9RTawZY/g7IKy7Ik92AGrqbgIkbJ3SFglDUovJGWVlu7d
	i+NPfizV2mjqA8Wo+bLlZzBFulwHFieQuxJ3m5Wo64ydU0Ig6+9pBXI8ym3p/OLyyUenpzqappKFQ
	pzAvIhVqElAJJFCDsAtbE9WXOkrAqcEdNjK0iFh+9mPaQdAAh+78GlpkiJ4v85zgPn0Cv6ltVfuvW
	KH4DAtOw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t2kwV-00As6F-0j;
	Mon, 21 Oct 2024 13:27:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 21 Oct 2024 13:26:59 +0800
Date: Mon, 21 Oct 2024 13:26:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald van Dijk <harald@gigawatt.nl>
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>,
	dash@vger.kernel.org
Subject: [PATCH] builtin: Keep backslash on undefined escape sequences
Message-ID: <ZxXmIzmhdNq-08Xo@gondor.apana.org.au>
References: <ZxXZ0Omt_GWMh2DN@gondor.apana.org.au>
 <ffa48796-347b-4a7e-8cb3-c47f22fab897@gigawatt.nl>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffa48796-347b-4a7e-8cb3-c47f22fab897@gigawatt.nl>

On Mon, Oct 21, 2024 at 06:01:53AM +0100, Harald van Dijk wrote:
>
> This particular use of echo with a backslash character used to work the same
> way across shells and is widely used in configure scripts in a large number
> of packages (specifically: any that use AC_SUBST_FILE). It was changed by
> commit 776424a8 (parser: Add dollar single quote) without that commit
> indicating that this would change; are you really sure this should not be
> viewed as a bug? The impact will be massive.

Fair enough.  This behaviour should be reverted.

---8<---
A lot of scripts (in particular, autoconf) relies on echo keeping
undefined backslash sequences intact.  Preserve this behaviour by
only interpreting the few sequences required for dollar single quote.

Repoted-by: Дилян Палаузов <dilyan.palauzov@aegee.org>
Fixes: 776424a8f915 ("parser: Add dollar single quote")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index 2c18e93..46c6295 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -339,8 +339,8 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 	switch (ch) {
 	default:
 		if (!isodigit(ch)) {
-			value = ch ?: '\\';
-			str -= !ch;
+			value = '\\';
+			str--;
 			break;
 		}
 
@@ -428,6 +428,12 @@ hex:
 		ch = 8;
 		goto hex;
 
+	case '\\':
+	case '\"':
+	case '\'':
+		value = ch;
+		break;
+
 	case 'a':	value = '\a';	break;	/* alert */
 	case 'b':	value = '\b';	break;	/* backspace */
 	case 'e':	value = '\033';	break;	/* <ESC> */
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
