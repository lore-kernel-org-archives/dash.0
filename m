Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F445248861
	for <dash@vger.kernel.org>; Sun, 15 Mar 2026 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773553500; cv=none; b=o9lzYOGA+8WmiPzGlyGtsJuSYs2WD3Wv7lkh02AtMOM/w8RwVhadSiPjcrRnlftFROzf2FPKkns9CDiYzbbUP6wCO4vcjyyEv/SUWsH+CEjTCBYDFFxqml+Lu+aU/NDkX/TC1HN2dMyzoi9nMa9X7YK2jmu6EFXdmK8J1fzdA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773553500; c=relaxed/simple;
	bh=q3mbGquBNL2Y+gx5G6ZObgfbYQw75UgqwVh/Bqo5/dE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BHpYXCXCAkETP5Q1PNFkxk+W60Gx3vO2scisz2nc6zoGETvQVPgmD1qebM3srUN+/cdKkk2PT/Js5mumOCqR0/nKpNu/0i7fBE2P5ISPMxFbKceBkMETPoWDVEQvX/ygk7wQ1/0jcsy00axv2LoS4P8mTelkYHpab3KUBdhLffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=gHwEuJRJ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="gHwEuJRJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=80ZfmJFGSYYoPrwsyLgquWLKPDp7qJIJeZqMNnYWSLY=; b=gHwEuJRJmPd9lWuhy3HS5z95Qm
	vCPCzzrBqES0x0ltlBwI+2EbknIyvzeaoRIGFPic+wJfXA/Ku4TuPILUFpACj5BE34s8WWf9l1zb7
	UV3/O5lMK/H20+YLO+Z+GZXDD56wi4WpKgmxX5ehBWgfMJc3NuOdVtksiJaSaGJ8Ko3+b0M4VQTSq
	4h90KueylboAw36VD/FDmSJbdSNAgwWAtqa89d0JStYQ29J4tRuV4UZ3CShVtbblO+bma6hJye+pM
	bLohlDmzyPRKXo3QpsgAAg15tB5S6+WD+ur/VONCTTTR8cK2bX6+Cuw/W3pxBZP4U/Klv866qlFnZ
	i+0+srmA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1eHV-00EXt4-2g;
	Sun, 15 Mar 2026 13:44:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 15 Mar 2026 14:44:53 +0900
Date: Sun, 15 Mar 2026 14:44:53 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aleksander Ushakov <retes672@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] parser: Catch bogus case patterns
Message-ID: <abZHVeTi6SS6uIaR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADdNFasDNSdX+krLXYqUnx8O1HF8P77SLukKJRHfZMu5OUE-gg@mail.gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Aleksander Ushakov <retes672@gmail.com> wrote:
>
>    case $PATH in 
>        *$PWD*)
>            echo \$PWD in \$PATH
>        ;;
>        ))

This is the cause of the issue in dash, an unexpected TRP token
causes an invalid word to be inserted into the case statement.

---8<---
If the token in a case statement pattern is not a TWORD, do not
insert it into the pattern list.  Instead abort the parsing with
a syntax error.

Reported-by: Aleksander Ushakov <retes672@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/parser.c b/src/parser.c
index 5714958..bbee1e3 100644
--- a/src/parser.c
+++ b/src/parser.c
@@ -442,6 +442,8 @@ next_case:
 			cp->type = NCLIST;
 			app = &cp->nclist.pattern;
 			for (;;) {
+				if (lasttoken != TWORD)
+					synexpect(TWORD);
 				*app = ap = (union node *)stalloc(sizeof (struct narg));
 				ap->type = NARG;
 				ap->narg.text = wordtext;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
