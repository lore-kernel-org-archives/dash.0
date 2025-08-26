Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79422D6E75
	for <dash@vger.kernel.org>; Tue, 26 Aug 2025 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186738; cv=none; b=FMkQ5h37kt9pRBX8n7Hn1y6tpWwriF6VmGK2PayqHo+f+18QTCCAAi8T9tzr43FmpEmfgzvaNcElPKI6/Bpp2AVRKtsxUGPRcjdzl5J58aLKHoAbM9kWod5FByFjE9Vbj6/L2JOTaTS43tPX1VDj2moFJ1xpyJb+WBE8gA/I6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186738; c=relaxed/simple;
	bh=/1FtinwxpHObGONHFa4cgDMAbkkVim6jP6NlkLE/Q6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SQlFV3f+4Guenbyj4RAXAbckT35mkk7/QXUAKOwk88cNUsDXp4HvS+lfGlFdIN2mrS7yvpIUV1PWPngL5rH4L3AvIg3lIYUazkFPq0OZSiZrsFHiz0e2ti7muM6Vobr+/izK7oFtA0dGxugOpDhgcdGzoxwQD+/rCx6qjolQ+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=huq2IMFg; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="huq2IMFg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eGamRoyQyKUmCVJsZU7Cejk0HR1ocG0cXHgXeAmQcBI=; b=huq2IMFgnomwR6ZNKssxXy2fjU
	k8aj2GE6HGY4hD2oGNKTXj1R2PyKk3T9MEnbmOPEhSnfKOeoDoEEQ4LYov4EbGBFROVhuune52Aj5
	4wY65HrkJIuSfG8usBICI9JLtNQnGFAmF0+Qr+8h8W9TZH92PTsD7VP37Ec9OtZKd8EIU+MjwW3+t
	+TDKil+6TQSW2v595L6xajREuluv5IVktFu73ZphOs1FOw47SCBNv2QUhL7J24a69twWAyODEGuo5
	mERmkneOwRe8dLRASjOVoai/ASaj8rpac6VQPBfingj4QwEPUfc3u7a253/l0Bwwo0en6waqusxlM
	44IPHw2Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uqm8u-00HIWh-37;
	Tue, 26 Aug 2025 13:38:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 26 Aug 2025 13:38:45 +0800
Date: Tue, 26 Aug 2025 13:38:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lawrence =?iso-8859-1?Q?Vel=E1zquez?= <vq@larryv.me>
Cc: nroycea+kernel@gmail.com, dash@vger.kernel.org
Subject: Re: Automatic Termination After Background Job Completes
Message-ID: <aK1IZXlbo2i-_rA6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11f69c85-4714-440a-b443-556a1d532c89@app.fastmail.com>
X-Newsgroups: apana.lists.os.linux.dash

Lawrence Velázquez <vq@larryv.me> wrote:
> On Fri, Apr 4, 2025, at 9:09 AM, Nathan Royce wrote:
>> Setting an emacs/vi flag when starting dash, and using an external
>> command for a background job, the shell terminates once the job
>> completes.
> 
> With dash 0.5.12, I'm seeing this behavior regardless of whether
> the background job uses a shell built-in or an external utility.
> 
>        zsh% PS1='dash$ ' dash -V
>        dash$ : &
>        dash$
>        zsh%

I cannot reproduce this.  Please try the latest git tree and if
it still happens, run it under strace and send me the result.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
