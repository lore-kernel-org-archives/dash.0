Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6B233D62
	for <dash@vger.kernel.org>; Sun, 10 Nov 2024 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731211880; cv=none; b=dZc/VaSM+HiZDtFsBSXUlMyCnGkQ8Po0iAgBOArBGvXWdsdsy5tyKvahuD4hS9M/3hcwXLNeCFsojOWIPnTgz5Vj6onnc+lIsAGF19Zrw20wU4LiWMXrdY+wnu7OJs8NHM9ijuALH218HrBS3RtJO7aTTQmFZJNnEN8WGqqsbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731211880; c=relaxed/simple;
	bh=HhfIrhJrdK2ZjzGvHIs5MO78scRC9mP4aY91AjzFx90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IZcNhfwqInl3nNXC0/sVohSXjtJu3WATF1f9kP1IG24EtguXf6hW7X5pAUwhPoRnKxW2n9wFsfqWIDStmCBxUr1cZk5ie2Nv2TknbUK2uVOdQYDQ2g/IZaPGJRuWYw8zPv8QMF8tMQAQBSBuTBJEpvZzSsDLb6bB4feXHk3BHCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=GFVe90Ji; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="GFVe90Ji"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2086ytCq3QF/uv3iD7zm/7OjZEQwVcfJt1fI+/b5OQs=; b=GFVe90Ji0uKuoOMOzy74JwjFG2
	1NZd763fjY+pJRxDLKFvpDNEDDBOLx8k+FSL6Wawjlz6XAY0OmdQcbNAUEopsym11ocO3NudJWjmf
	LRtA7bZHUyuwsitFYNqs3A/OnztZACVSPyScw74eQ1dnTPmqeOToWaSHw7J994s+uDTE9jnZTqKG/
	V+zjBNkkVHfVGwfOjm36LXBaMJH4gNEWIs7uonAWJyQbuu28Cmr6ZGf1T/tdtC2QaJka6aeKPeQ1u
	5zBm6XMy4xxx3HeEz0K/2JTdYC5hJmftlzQ6v278Sle1gB7x355YpV4a0ItEzG9/z7+tehOzUebc+
	6k4xaXSw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t9zI9-00FkMm-1G;
	Sun, 10 Nov 2024 12:11:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 10 Nov 2024 12:11:13 +0800
Date: Sun, 10 Nov 2024 12:11:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: dash@vger.kernel.org
Subject: Re: set -e not ignored in AND-OR list
Message-ID: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c85323dbcf182c50cad4063742f4245d94daca8.camel@scientia.org>
X-Newsgroups: apana.lists.os.linux.dash

Christoph Anton Mitterer <calestyo@scientia.org> wrote:
>
> $ $(foo) || true
> a

This is simply undefined behaviour.  Some shells will ignore set -e
within the command substitution subshell as a result of the ||, some
won't.  Dash does the latter.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
