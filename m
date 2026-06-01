Received: from mx.sdf.org (mx.sdf.org [205.166.94.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3642472AE
	for <dash@vger.kernel.org>; Mon,  1 Jun 2026 04:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.166.94.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780289518; cv=none; b=pKR7LacvU4qF74JT00rjXDs1wQZc7iblq1SN13NohY5FO5PbTnwcwk0JuhatOSoxpqmjCOJckTCT/PYz7K47HtoiPn5WnNRx7ENHxHhAUiRwk4kO8GREL1rl4GSJvNNshheQjcXUKwbqSdxxhC09y33Vw7UaKRDsJtz/GpM/RV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780289518; c=relaxed/simple;
	bh=7MCoD0xvNz+rIBg4YRgaqauO58eBsBbn/IJzBWBZkqY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3FilmW/eHkhmBhFUzfGzZG6Ne4s8re2GLmUsL0hof/hld9Gl9OLdZqA7TvD5wBGyXhWgbZbbmdWOimpH3ekM5f35Ol2vqOwBfAJDwBwfLxBRs6v5dtMgWswrPXhvhRhSqfTjysPAG/64FyNErz+VBQiN08hvSNZ7t1XXNqA0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stien.dev; spf=none smtp.mailfrom=stien.dev; arc=none smtp.client-ip=205.166.94.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stien.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stien.dev
Received: from HQ (pool-99-244-140-233.cpe.net.cable.rogers.com [99.244.140.233])
	(authenticated (0 bits))
	by mx.sdf.org (8.18.1/8.14.3) with ESMTPSA id 6514prWt008557
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO)
	for <dash@vger.kernel.org>; Mon, 1 Jun 2026 04:51:56 GMT
Date: Mon, 1 Jun 2026 01:51:53 -0300
From: =?iso-8859-1?Q?S=E9bastien?= Peterson-Boudreau <seb@stien.dev>
To: dash@vger.kernel.org
Subject: Re: [PATCH] Use literal > and < characters
Message-ID: <ah0P6fJyIvXrrgHA@HQ>
Mail-Followup-To: dash@vger.kernel.org
References: <agBSqlE8ZkrKmnIo@gondor.apana.org.au>
 <20260601045020.13133-1-seb@stien.dev>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601045020.13133-1-seb@stien.dev>

Email seems okay this time, but looks like it double sent... Sigh. Sorry
about that!
-- 
S.
