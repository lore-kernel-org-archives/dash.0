Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A63283FE2
	for <dash@vger.kernel.org>; Mon, 25 Aug 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115628; cv=none; b=ZBVLztUcV2i93XZhTd2H40ACurBxtw8X7zow9BbAOFwgqRq9Th2tiCmsTJBWndlBtCMEejaLdYdA+kc8uKT+VzEgntKKbvO9ouCSUg3K/Grxs3yhtXn9WyJfFMPuxPOxK8kG998CfMYl/150gpYobuzeHy/+4TOrOTSF6LBQ6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115628; c=relaxed/simple;
	bh=IIqiTP8BJ8mprCpA9nsr2YeqsdokP8q8Qq8gdawD48A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KttY2o7dQMsjfaN2a8z0Yqyxji5Zs8Q6NyenGVOgYcXuN7ze6RMsM9WWpPopAW6c5U8y8AGUB2fLCgIGUmTJe2nToo9yIS1xzU1j3DfHbhAB7U+Nz1FRJfGnPArcx6XvW8zhMNh834Lbp5IcMuslDzfymlHdQx4nnuHgRIXf3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pBti+/Zk; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pBti+/Zk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NAjRqQdzu5+0NaEzbLNBQf8BCRr/HOoLAGpfxMr/fuc=; b=pBti+/ZkMUUYemQg8xV/441Lxn
	lc4DljtqcnD3QZIWOBUpqDSa2WD0OuLR9aS6YOKkgQD9pg9fUfzgoZdR6erUvgJyJcPncuT9LQrTy
	LbLnhn9toR0cCNhPWVCAl5e2y0EdQwDuh3EENkV8zclWty06jdjH6pYjVuo1L9B9QmhY/pXjJzWBd
	KcRocp1+TRrhdTZzXTVXgHkp+tBnLAHE2vxSQKhwmo8BRfWaCNdJdRP0IzT0t/qZ3eW+2BbbE0KBP
	yAR+4I6XN/ysE5aMILY74h643DFdMMfy+oqr00s1y7bFomk56XushzfI3sgevKPyaTNwh96PxBYDF
	MMcfnAhQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uqTdy-00H4I9-2o;
	Mon, 25 Aug 2025 17:53:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 25 Aug 2025 17:53:35 +0800
Date: Mon, 25 Aug 2025 17:53:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org
Subject: Re: wait code is fishy
Message-ID: <aKwyn3BbzGJhUzS4@gondor.apana.org.au>
References: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
 <a708d788-e496-4478-b1b2-48ccfae092fd@gigawatt.nl>
 <5d9124b5-d687-d864-b73d-79d9bbcf160a@redhat.com>
 <c9366587-0723-4380-b50a-a43035678523@gigawatt.nl>
 <24b4a38f-5c88-729f-9b04-71a295f4efd8@redhat.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b4a38f-5c88-729f-9b04-71a295f4efd8@redhat.com>

On Mon, Aug 11, 2025 at 06:30:10PM +0200, Denys Vlasenko wrote:
>
> If we got pid == 0, it happens in exactly one case:
> we did waitpid(WNOHANG), got 0 ("children exist but none yet
> changed its state"), then waited for a signal and got one,
> which wasn't SIGCHLD.

The pid == 0 case only happens on a blocking wait + signal, not
on a non-blocking wait.  A non-blocking wait would return with
err == -1.

> It's ok to leave the logic unchanged, but perhaps it should be
> tweaked to be more understandable. Unreadable code snippet example:
> 
>                 if (err || (err = -!block))
>                         break;
> 
> Assignment in the conditional, just what we need to be confused.

Yes patches to reorganise this are welcome.  But please make each
change small and easy to review as this area is complicated and
bug-prone.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
