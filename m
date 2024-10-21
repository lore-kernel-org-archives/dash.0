Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E14634
	for <dash@vger.kernel.org>; Mon, 21 Oct 2024 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485280; cv=none; b=MK0W5y4/hk5CDOP3fmFaCTciDvN6xpegWKJjHxye4WaUFLvEgLgjJ4MyG7jsBtuIdGrgUR8F7pPepmzX0F3bz9kkFr0e2IbGV7+Cc8tLRTJwPivVfsk3MFIRub0zMfAt8e9rSkfvWWC2WPUROqON590/FDEE3/yJz+v0rjUVfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485280; c=relaxed/simple;
	bh=i0v/ro8SBW4s9hMrF54JJL2iVjyInNfYXv6q83MR4mc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DZaXiMEn+X2gV2fvbVvmz9jLpUB/JLa4P06DHSIBAY6yLidAlqob6AbZx5kgPpy3KyB1rXF+bpSPW2nloiS3JDnA9uhdWSxkxMAju14iwjlcr5ZwV1FKCMIeM3BHUxthZY7y7MF3eKwRT2tKTQZwDf7heNYARQZpc0DeC34+erg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=QCQ1C7PL; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="QCQ1C7PL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Eccd3TGhVq28dZEShP77PtdLQhmkPmsr5Q37XC/j81M=; b=QCQ1C7PLNXsfCKf98I6CpxWQ89
	vChdIFTATaF4CDOe0T6/izrLx3V/VRPFzWQyRhM/rTqA0g3OkoLMDVjAseJXcnC/8PRM2A018/nJV
	5YnRjeIEK96wZ8lQCvKetfho6GtXqbsZ02VSuVOIAjqRZVWGwKHt4P5r/Be0u5cYarOhza8BudSbs
	Ibk/8pSh0Fo6nS4Edtt0lkPT/vpKuknnI4iAfPoJq3WCxR9EknACUXjhUQKyrkVSYNUAf0FxkWL+a
	gjmhNY/Np8Q2k03eEE11IaGMaG9IUGxxHNJg2LMdjXS4oXGX5IbM/ZLdKGzlVPnTKt7f0ftA2Y778
	TWOfnFRw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t2k7c-00Arlt-1I;
	Mon, 21 Oct 2024 12:34:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 21 Oct 2024 12:34:24 +0800
Date: Mon, 21 Oct 2024 12:34:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: dash@vger.kernel.org
Subject: Re: =?utf-8?B?wqsgZWNobyAnIlwkeicgwrsg4oCU?= =?utf-8?Q?_difference?=
 =?utf-8?Q?s?= between dash and bash in POSIX mode irrespective of xpg_echo
Message-ID: <ZxXZ0Omt_GWMh2DN@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f71540061aef0eb970b23ed3ad7e12faf8b7815.camel@aegee.org>
X-Newsgroups: apana.lists.os.linux.dash

Дилян Палаузов <dilyan.palauzov@aegee.org> wrote:
> 
> I download https://ftp.gnu.org/gnu/gdb/gdb-15.2.tar.xz and run there ./configure . configure has on line 19728
> 
>   echo 'cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&' &&

The issue is that echo(1) with a backslash character is not portable.
The portable solution is printf(1).  If you cannot use printf(1),
perhaps use a here-document instead:

	cat <<- EOF &&
		cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&
	EOF

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
