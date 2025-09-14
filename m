Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E841A83F7
	for <dash@vger.kernel.org>; Sun, 14 Sep 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757888548; cv=none; b=nzUSIu5ySPk0nptrCDg8ju+8Xxr1OpnZx/4yOEhZiqZJVYxOLvmwNWAY7vUf+wT1b6/t1+eI9uqW3+jPlNNA1/rvmnGOkT+MWFY1qF4dZIXkAcSq++wN1ET7PK3TZvZ1zg59t1iUFSHn//ViC+w8wTv7dfQ9elOJSVm2uWVpEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757888548; c=relaxed/simple;
	bh=mPzgk10XRAlZF8aTkFZ0UTmtVMpnlCTaufghE8sXK2A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQHct0y4i31AYec3k727Tfdp2GE8vWLuR1k990xwW4+MV172A8Y/ANZ0TcGEAi87VALFKdKJ2NMQVGzWGDvTlSGzrnjf0A3gz0OL45Oz4NZC3PxKFfL1f6YtHQFKEO8rbaf4YEDe+CvyL6TBC63gRwxHefiQGuPmv45tqPVEGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTJ1fZcX; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTJ1fZcX"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-80e2c52703bso315388685a.1
        for <dash@vger.kernel.org>; Sun, 14 Sep 2025 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757888546; x=1758493346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfc8Is/oW5RXhfjN9sAPJLK7rpITYXt+qi74O5CKLps=;
        b=mTJ1fZcXc7s4dhKSSanDGQ+Mfw0+j/CMiokPDNs5yYYMzHE7Dr+H3AF+RMuPETaGtx
         gJesnWJPJv65OAAxxzgOK8wMMeC3rW0FSsgwE/Awjgy6ruNk2hGPMGgI5CirbqYOkmGx
         745b/tHKNSR8SQsfHv2dzaoZ5WWw8gd0qJjPgHoFw3PXVcUCoq8WzaUD0rmd4h+AgFZQ
         6R+JLGiV37una4Hd35SWcpw3PG4r/iRcQ80cfQLLIRneAymBDZ2KZ1GVAxFahhIFmB9v
         olKlK4Xi4n1AqKh3pyyGGzGxDS7br0QkELfWrJohiYLBCZPfcUL2U7Ygrsz+nNpamR1j
         B6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757888546; x=1758493346;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfc8Is/oW5RXhfjN9sAPJLK7rpITYXt+qi74O5CKLps=;
        b=XF2tjlxKmaB9qhw5nVSl5OGppvpv3Qs1WZoQaEDISj3RonZHz5DS7RCjONuYnmgtgT
         H//f3wOSp6EoCJJg4mIANDtgun7G6wjFFfEnF2hpMWZ8giSyXG4jNH0PLARuODAeudPy
         4emnWu+G26WDhviKGgS5PqbAjfPVGXxsr+I++hpVKatWlHWOrVhH3hDuXME6PHtmfEbP
         wppgAku45A872dEHDLSPxYTWzqua+lUvUuZRAC9wofBuuz1yflFeD0Erpm8wq+BwpsLo
         pvx7iKr2Opxuorm2LTdqcVoVtJIE2h0s/EwhELs+eTV4U/IwgaFOOF9n3pvN3FYG8PFb
         q+6Q==
X-Gm-Message-State: AOJu0YzxLMa5ZxTtsmKFe7p+Q1g1U6R4J65+cR5v/HsT/iF520gAZsht
	7mQ+tAC8j3r7FaLK7FBHUNslxgtx/6leQEV6zRUamXHBkvyc068EludCY/ERGw==
X-Gm-Gg: ASbGncvUDfItOmL7Pa4JbU/XEobCRV3lwcOBpFNknFcZhhcFZSm1TVqoLIm9ozjKvMe
	dKBbs96ElKiysnX4MZREtZrr2rAMVqbkB9+FBSck4IthT6rtpGfp6QbXZpbQ60vAMfSZMeCL0WJ
	4oxJH7zABUgbe+vXQaXvCQx33kKTmpHpJ1BHVh81/c2yxMQgaB7X47BOoGXCyEd0U/x7mZTwG0B
	LlqOiVfEAkfv+2I9lc+ATRmpC5svsCrCZuoY4MXVA7LLxJ8k7rkwsGQKDwFbGNI0cfbc9bg1t7B
	GdUMTvVpIv61+1J2o2pPta6eclKHhv6xe/1txOGykoKOz9W+adEBDAgXRW6teyO4xJLcYHqaHUw
	5Jwc2tZCr3V1R/v4gGuazubAPAkdO9OGkYVhhtbna0wEWX2cb8H2SowGsAi9YUw==
X-Google-Smtp-Source: AGHT+IFY62IJhjjzyRvy9nlPCyH5P9hYEtxSIlQw6hsOo6tRy7EQr5NA3Bqhk3p7j57cHNjlkw+MVA==
X-Received: by 2002:a05:620a:3955:b0:805:feb3:debf with SMTP id af79cd13be357-823fed2e83emr1443661485a.27.1757888545848;
        Sun, 14 Sep 2025 15:22:25 -0700 (PDT)
Received: from HQ ([2607:fea8:e920:1ca::b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-828f8db3d60sm153048785a.40.2025.09.14.15.22.24
        for <dash@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 15:22:25 -0700 (PDT)
Date: Sun, 14 Sep 2025 19:22:00 -0300
From: Sebastien Peterson-Boudreau <sebastien.peterson.boudreau@gmail.com>
To: dash@vger.kernel.org
Subject: Re: [PATCH] [DNM] builtin: add source for Bash compat
Message-ID: <aMdACGW-YOTYzZXj@HQ>
Mail-Followup-To: dash@vger.kernel.org
References: <20250828211219.392014-2-eduardo.experimental@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828211219.392014-2-eduardo.experimental@gmail.com>

FWIW, this can also be done with a function inside the shell itself :)

	source () {
		. "$@"
	}

...hopefully I used the correct special parameter and quotes, but in
most cases you can probably just use $1 and be fine. 
-- 
S.
