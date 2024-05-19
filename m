Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F993D60
	for <dash@vger.kernel.org>; Sun, 19 May 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716110689; cv=none; b=jRPFnrlhtVD4y1S4IvtyVIPuWeSl5RPeEPEbjiPswNzMuPPqz/fK2dUcmKHIASsmalwYPnyLgvQCNZYmwCu5xhCA4dv277Ev4E+47mvI4SMa/EFg7KU6QiMivwsdAYJSvrVNz17UYeBJHa8LeL9bpRh2UJvEAF3trPrjwpW6jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716110689; c=relaxed/simple;
	bh=eQpjiGqA9QrcZC820tC9E8TtP3zqfAv18GOBs7996hE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pZbkODIUA2pQ6dvtpDyrUBpyHe5gERcz07bjtgkJ15IAblixC4ydaXS9OmjcPKxmzMq97qBmE1MjoL5w8GwZcjFCs2ZTQTpqfcl93HVd4PK/m1MP6H8smR8LcOsFZ6nU0CNFqlklvFMLUybU1MTL7YwGBS53bnJgdOeyow1K8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8cmY-00HISW-0C;
	Sun, 19 May 2024 17:24:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 19 May 2024 17:24:43 +0800
Date: Sun, 19 May 2024 17:24:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Martin Guy <martinwguy@gmail.com>
Cc: dash@vger.kernel.org
Subject: [PATCH] man: Document the value unlimited for ulimit
Message-ID: <ZknFW6bdlYsSi_Nc@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0529c8-872b-4ee5-9f9b-37f8b191d6ba@gmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Add a reference to the unlimited value for ulimit in the manual.

Reported-by: Martin Guy <martinwguy@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/dash.1 b/src/dash.1
index ff02237..b52a4ad 100644
--- a/src/dash.1
+++ b/src/dash.1
@@ -2180,8 +2180,13 @@ show or set the limit on the real-time scheduling priority of a process
 .Pp
 If none of these is specified, it is the limit on file size that is shown
 or set.
-If value is specified, the limit is set to that number; otherwise
-the current limit is displayed.
+If
+.Ar value
+is specified, the limit is set to that number; otherwise
+the current limit is displayed.  The special
+.Ar value
+.Cm unlimited
+represents the lack of any limit.
 .Pp
 Limits of an arbitrary process can be displayed or set using the
 .Xr sysctl 8
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
