Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12D34BA50
	for <dash@vger.kernel.org>; Mon,  6 Oct 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759721171; cv=none; b=drIhl2/cAW5bgQBCf+HlF0XgGYP42C6ikB4gojnZwgkl8fHWn+oxa6JSwAI0Uy4g1fryV7QJTkM5/dI/ALMSfA63hcG7Vq+sSCzHdF0fXm3YtR/f4mIw8cHM+0IzBD1jBVw3673knk7qI4iXQ2gPXQ4baSnDZgKGz6TfyezM8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759721171; c=relaxed/simple;
	bh=8+UJ5IzKjWfhy+M73uQXpOeatmUFnLPXMqUTFcS8TLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eiGZv19JKq109cs8gF5baa5XLACWIcPwLR9Sz1OC6lJH8DDM1gzdPVjna7mugts7tOGDCiteRGv6m9vRLBQVpISvr7uAADrYwAbqsPUq/9r89DStapwp1SdfFXWq2Uik3W26PpqHbXha+cxIzuKWc0DceQVVQwE6SZHpezEjWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=auG4mMCz; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="auG4mMCz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=OeOytx13INHKwyXIzhlkwZmf1K8418LXSxD5ICDRKQE=; b=auG4mMCzEdYuiS28Luj9DNodRD
	AcmcFtYhh49GnYrIKWPFB1FeyJQPqesXw89K0tR+XiE5fjxGf8GUCSsvdlgkKamMAdNCK38QWFxxW
	cALIpFlUW61arEOf/itXMT6Q376RV/28UraWAS9vsyTtE1QW8hOEA6QL9/elLgNMex5od2UGsLf8z
	WcE8mkRysmfG68CYJ0IkXG3hbCN/Fondon5SNpD1CpGZH3iMQzuZNLjoNuWYvE+2GuLLgk+AExBKq
	LnCPrivDOEtS6rDTosirvekRJsSOpFBW07XhrA9Ol9gUGzuRnUwDgs7CGMGbo0qPlPw9nBzEhQCVl
	FuVnSQqQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1v5brO-00Agmf-0d;
	Mon, 06 Oct 2025 11:26:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 06 Oct 2025 11:26:02 +0800
Date: Mon, 6 Oct 2025 11:26:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Juergen Daubert <j.daubert@posteo.de>
Cc: dash@vger.kernel.org
Subject: [PATCH] builtin: Keep backslash on quotes outside of dollarsq
Message-ID: <aOM2ykncn3sL2LsJ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOEPAl49li-HH7ou@jue>
X-Newsgroups: apana.lists.os.linux.dash

Juergen Daubert <j.daubert@posteo.de> wrote:
> I'm using dash 0.5.13 with the two patches 
> 
>  [PATCH] expand: Fix off-by-one bug in expmeta
>  [PATCH] expand: Fix typo in pmatch for wildcard search
> 
> as /bin/sh and get the folling breaking while building 
> GNU inetutils:
> 
> ...
> make[2]: Entering directory '/tmp/inetutils/src/inetutils-2.6/src'
>  CC       hostname.o
>  CC       traceroute.o
>  CC       inetd.o
> <command-line>: error: expected expression before '/' token
> inetd.c:166:31: note: in expansion of macro 'PATH_INETDPID'
>  166 | static const char *pid_file = PATH_INETDPID;
>      |                               ^~~~~~~~~~~~~

Thanks for the report! This is due to an unintended change in behaviour
of echo '\"'.  Thie patch should fix the problem.

---8<---
Only dollar single quote should eat the backslash character before
a quote.  Make the skipping of the backslash conditional on mbchar
in conv_escape.

Reported-by: Juergen Daubert <j.daubert@posteo.de>
Fixes: 776424a8f915 ("parser: Add dollar single quote")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/bltin/printf.c b/src/bltin/printf.c
index ff576ff..106aecd 100644
--- a/src/bltin/printf.c
+++ b/src/bltin/printf.c
@@ -339,7 +339,7 @@ unsigned conv_escape(char *str0, char *out0, bool mbchar)
 
 	switch (ch) {
 	default:
-		if (ch == '"' || ch == '\'')
+		if (mbchar && (ch == '"' || ch == '\''))
 			break;
 
 		if (ch == 'U') {
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
