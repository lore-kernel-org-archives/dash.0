Received: from mekboy.ru (mekboy.ru [45.135.135.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4B43822A1
	for <dash@vger.kernel.org>; Sun, 10 May 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.135.135.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416649; cv=none; b=VGZfEepaWlnqMiSIBj8ljxyvfdAVwBtqcUCzCrdzPnJ8RBODFWACrAPeS1C8c38K2einWjGTpJ+lOGDa2m+QURjK2mZvHGLdAMcERFnM3iV/im5y99AJkSpRXZZEeoh6EzPNwn9yBDRy/upVJ6ZcGHStlAwLzdnHdgl85pY+QFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416649; c=relaxed/simple;
	bh=5ultmRTleJDkBT2D3g4l6CUk5pqr+TgoT6Wo4pHgEo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXVTpAiFjtLNNVq9pAnTL0bS36WwbX/YT8WmKPiRbcgNoXEDX8GylVTOuZZ7F+y2+CaHBraMxHCehVboXtrBIyPNZCPeUfa4Fk8/Gkt1VwhJciy+jU8mzAt1vu9cJD8AEIild1mySuf+669owpU0IHAeVeM75nbDI1gstFGZpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mekboy.ru; spf=pass smtp.mailfrom=mekboy.ru; dkim=pass (2048-bit key) header.d=mekboy.ru header.i=@mekboy.ru header.b=1Tjef9pU; arc=none smtp.client-ip=45.135.135.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mekboy.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mekboy.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mekboy.ru header.i=@mekboy.ru header.b="1Tjef9pU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mekboy.ru; s=mail;
	t=1778416645; bh=5ultmRTleJDkBT2D3g4l6CUk5pqr+TgoT6Wo4pHgEo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1Tjef9pUGHeJLXZmBWjVcLKmA1H3nU1sSzFeBo7/KP3cCHdlpI9uoV4bRaUchZ1M4
	 23NevwlZV/TYWcbpAnCbUFIzsAaUBO6Y/HaKkC4W/blH0ilFjxs4+GkSzZIKyqElXT
	 teyPUFs34hUfyfk2Zj3FAbgKaAZWShLqPPLKcXSScDSQMlkhRCSlNU7GwBxwnaV4Sh
	 4F787r2HaRM0Wybg2sBCYRmL8bRT1zlk6CenKaTB/DMjwY5vutQi7j1F3zZPGS3ZuC
	 aA20K5p9QpbY9bVjXRDCQENg9vCleF7AFmfORvoxLpw+hmBJzyT8i+14VCJmWHq5pU
	 6L/iKHITN1fpg==
Date: Sun, 10 May 2026 15:37:24 +0300
From: dash-shell-80d677ffb5cf@mekboy.ru
To: Sam James <sam@gentoo.org>
Cc: dash@vger.kernel.org
Subject: Re: Can't build with GCC 16.1.0 - libatomic problem
Message-ID: <agB7jvYvfE3dy1z3@micropc>
References: <agBwF7x-EtgAZMXy@micropc>
 <87y0hrqwyj.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y0hrqwyj.fsf@gentoo.org>

On 2026-05-10, Sam James wrote:
>This is a bug in the `musl-gcc` wrapper (other than possibly some
>concern about the dash build system wrt flags):
>https://gcc.gnu.org/PR125235

Hi Sam,
When building other programs I successfully worked around it by using
-fno-link-libatomic, dash is the only exception so far.
