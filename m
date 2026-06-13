Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203C1DFFD
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315277; cv=none; b=bfQSg6GAoqY+HXLpARpnY1bvmHe8pXo1upgR4umqcnR+UmyRxyB34GDPGJsNF+/XyRbeZuOtsFgcLLXeTu+j1Be5P9i1KXCZvdvIVo6UpFyaLxUgfFA1uN19ptbPw+NmDREOr9Mn+rmSXl8UQHVASIPt/X4kS37m0GVD36GMwc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315277; c=relaxed/simple;
	bh=Fx6S7y/KfUSDS3wTY+h5npAqebi6W1YVBKNuQfL1LG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k7lv60jQWyrwt6r6pIfqjnl6EOlJQHcvGFn3+EoT5o7THmmHfQ9ZQxy/LxeRm6YafM73450/v6ynANpRKzodoGOHeHH/pHD8XfktCPnKlYZ9x+gTezftLIl9I6qzoA8do6wrQHIbqGy+ebcrVrhDWqITNuKgEB0t22MgVnSRypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=SW9JNyT+; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="SW9JNyT+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=1uIpzpZjnZqpVRyEVYlERaeylMgLgDQnLpPWKMYnCLM=; b=SW9JNyT+e2AgGIUFtWTBNvKLjd
	74riKUYYbaZPH88vd+cEAZXdZYN/pAm+d4j7kVvoBeVQy77nAnfUHLUHErNFXxw7UH9CviaRUKShh
	ZdMkeUftGP7lNJm1D9jS8Z57WRNlgasxedMp/yYJTmKo3sJQr2uG4CXwoDwgRyU716Z+Cy0HsgUUA
	1aMcWNlUvk7MxKAXm4lEq+PR/1TML6Q6c73Z/tjz9DvIPqMK/rSGzfSTNDT4C+UzYX+7c2X1+tHC3
	0Eeh9eoln4BoXdZGmUCCXIctd8/UfWh1tW43IB02NO5jj288FYj17FWUehrYnXXLczA48YuzUNaBv
	oeMTjhhg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wYDTT-000000054YT-1FWG;
	Sat, 13 Jun 2026 09:47:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2026 09:47:51 +0800
Date: Sat, 13 Jun 2026 09:47:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kerin Millar <kfm@plushkava.net>
Cc: harald@gigawatt.nl, calestyo@scientia.org, dash@vger.kernel.org,
	kfm@plushkava.net
Subject: Re: [PATCH v2] exec: Print absolute paths for command location
 queries
Message-ID: <aiy2x_l6g42HktZh@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607001326.8561-1-kfm@plushkava.net>
X-Newsgroups: apana.lists.os.linux.dash

Kerin Millar <kfm@plushkava.net> wrote:
> POSIX requires that, when reporting the location of a utility found by
> searching PATH (or one named with a slash), the pathname written by
> type, command -v and command -V be absolute:
> 
>    Executable utilities, regular built-in utilities, command_names
>    including a <slash> character, and any implementation-provided
>    functions that are found using the PATH variable [...] shall be
>    written as absolute pathnames.
> 
> Presently, dash fails to conform in this regard. Address this issue by
> prefixing relative pathnames with the logical current working directory,
> provided that it still resolves to the current directory, and with the
> physical current working directory otherwise. If the current working
> directory cannot be determined, print the relative pathname instead.
> 
> Link: https://lore.kernel.org/dash/2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org/
> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
> Suggested-by: Harald van Dijk <harald@gigawatt.nl>
> Signed-off-by: Kerin Millar <kfm@plushkava.net>
> ---
> src/cd.c   | 40 ++++++++++++++++++++++++++++++++++++----
> src/cd.h   |  1 +
> src/exec.c | 30 ++++++++++++++++++++++++++----
> 3 files changed, 63 insertions(+), 8 deletions(-)

Even bash doesn't do this:

$ bash -o posix -c 'cd /; command -v bin/bash'
bin/bash
$ 

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
