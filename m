Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACD28366
	for <dash@vger.kernel.org>; Sun, 24 Nov 2024 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732449527; cv=none; b=eeuGhxIhG1Xia4yA8y4vCmFnhR3grrZ9kQBUeh+L80L+QU/y11vbk4yy5Sn4MT+BgPistjVvJDRN+uEM3LP0IiNQ8dCWYSlOPNrGE2C46f7t+p6C9jEykNhXwsnLAX+RmMdA4gYqmNX/4nzCPZJWahZz5Muk5GOC8krt8chlv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732449527; c=relaxed/simple;
	bh=XXV2UYCKYhCVnJNvOI5V70SEE5XD6cHUyclgk83Yy+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAUbot7fbTBqTraqPxNceHuWU40v+WkO7HdP9inKA922k93Lkc0bIdTSdTpJq8eENWaHUr+eN/oVWR664lw5XMeFeP3IGSPk2oQiizHqPp6ohLoJer7y8QMVEhOpF97k2bFy+rvWz/ZIn1tXLl9cvW22hq3MgRxC1X5/ees2EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=rwFhixKv; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="rwFhixKv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iuhLgedW/Q2Im4VhChsBL83l3ViqET+Z/IqKpqr/Ji8=; b=rwFhixKvt6xRANHjMIpvfwkn0J
	EuBaaTcDGUD1QScmnHx9BbwqaM0zNxSRYdr4Y8a9kg6aKJLBET6cTbXjcKIfkMjCj7IAHeKojE87E
	y4Ovuw2bn6VjyYIpTzrpbMS9kNZuAH43a8kk42JVq0nRnJvHF1051+C1zCIroBRSdng9nsfWQE5oF
	WkSVCiikN/f/h9j6jyU3iNtT3VF1G5InPLUkPF5opJX+R3lINqc9BcAMbfFLOaai1ntVOTXvVthiQ
	+NEM+uer7RmxBTbGZD6aiGHS/arHpkJUV48J6k/kVpnqs47GipjL6GfjWNau3QLwI99IzfcdZN+IR
	dhQqTb4A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFBFz-001IUp-1T;
	Sun, 24 Nov 2024 19:58:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Nov 2024 19:58:27 +0800
Date: Sun, 24 Nov 2024 19:58:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: set -e not ignored in AND-OR list
Message-ID: <Z0MU448KJwA-03C4@gondor.apana.org.au>
References: <ZzAyYf1ZWcSuPVJZ@gondor.apana.org.au>
 <b16286957f9b3d6409423b3b9b54c84c1c64fcb2.camel@scientia.org>
 <6496f8a6-bf07-4c4c-bbb6-3ce42dc378bd@gigawatt.nl>
 <85df2488f78032cfb64acc98ec2c483bc1fb03e5.camel@scientia.org>
 <65b72665-6d65-446f-b32b-968c6116ef1e@gigawatt.nl>
 <20715fc311f5d3655e2d6d9dc1a911e8cfbccc3f.camel@scientia.org>
 <be8c2692-ab69-46f2-a487-2f99452a0c2f@gigawatt.nl>
 <ff11abc014305b31343cc220fa503b927d3e4454.camel@scientia.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff11abc014305b31343cc220fa503b927d3e4454.camel@scientia.org>

On Sat, Nov 23, 2024 at 04:22:52AM +0100, Christoph Anton Mitterer wrote:
> 
> @Herbert, you've said that you believe dash's behaviour is POSIX
> compliant.
> But I still couldn't find anything in the text which would imply
> this... and Harald who typically knows things quite well also seems to
> believe that POSIX doesn't allow it.

It's simple really, POSIX says:

	or any command of an AND-OR list other than the last.

The word "command" refers to the commands that make up the AND-OR
list.  Command substitution is not part of that at all.

I agree that it is suboptimal for subshells to exit in dash,
but I think there is no ambiguity that the above statement applies
to subshells.  Just look at the shell grammar.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
