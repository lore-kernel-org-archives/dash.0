Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F4634
	for <dash@vger.kernel.org>; Sun, 17 Nov 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731835849; cv=none; b=a6I4hGR/4dyypf6qK+PHX27qLQkrJyPZsgor2zMxErNxyj5vRadK80s78bMWEU5EQq7U8Ca0aZD3JbAWQZ2LNr7UbyBEJ1VeHfopH1BoVgfnykTyemIedaSkAc9vIUTAfTCN+o1s7/j4yF1Y4vk1spipnT0VEjPwzqKuGi75Zbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731835849; c=relaxed/simple;
	bh=t+dJiru1b2IVD0uvK5QZLblmz3/Gk0QdA8hsEmmgck0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DmjVIML47aN8d5Na8nPxouyCkWNb2QD35jro1V9UptF8c3cHnP4kYgK2Njr5715qJ2U5iW5aLp4LjZQM0ifs0amOgaNvQwWf9X6clzKnevBR20h8FpBB6fe6HUo5Ttw0H9F/Fyx/iIOc2iGCSTm7u+SYUFCYJxXPN4EBfJ4t6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Sx+alnBs; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Sx+alnBs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v8H8ztq0Nlg28tl1nuaeonIU2BQV0i1Vz0J/3EGR1ok=; b=Sx+alnBsvU9kPQttLMc1FdmtMG
	xpiLVmEn8vnu5wvtuVva0YTVxNtjNH/DETXlBHOt6FfL9A7bgBAS2ACnG1cUvjJihwX85q6tpRRYy
	2dpMj4DR1NTZu49wpqY0uEjDJPvVIDEYOfVwfvm0F5AHKPzaSg0AuNmKbCt+1pIYVtYQ0SgJh1Ukz
	oNJKdumDCQ/MShuxJp9kmtLW0VL2lbS1XpAXc4B4tXy/cAMxO0GvjQYLFxXsPFBtxJK/vur8lP9tQ
	7AcTMahVfDt2Mk5oYVeZ6coOGEhFK4mN/xXpgJtR3VRUQKZ+x86EBwczavbQ7CW/eKHsvlBXuTF3I
	05NAp8Ew==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tCbc9-00HPEF-2w;
	Sun, 17 Nov 2024 17:30:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 17 Nov 2024 17:30:41 +0800
Date: Sun, 17 Nov 2024 17:30:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: Another attempt of my work with a new subject, first item
Message-ID: <Zzm3weUNXckwVFVC@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a3d31c-964a-4131-b57e-b6fa7c18c5b4@knaff.lu>
X-Newsgroups: apana.lists.os.linux.dash

Alain Knaff <alain@knaff.lu> wrote:
> [Trying again as a new message rather than as a reply]

The threading doesn't matter.  It's the Subject that causes a
new patch to be created.

> Ok, so here goes 01. Please tell me how it goes, and if ok, I'll send the others.

Yes it worked.  But please use a more meaningful Subject for the
rest of your patches.

> If it goes well, can I send the others as replies to my initial message each, without repeating explanation text?

Each email should come with its own Subject and the body of the
email should describe what the patch does and why it's needed.

Both the Subject and body will be used to create the git commit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
