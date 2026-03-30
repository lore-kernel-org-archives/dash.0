Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71190382F10
	for <dash@vger.kernel.org>; Mon, 30 Mar 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903625; cv=none; b=jcjdSaIV34XtcCWnwelNrmhxJkflsfRRNgS93m1slMpho3xX0IBjKJFaasuRglHRgToyqKevewHdK3z/g6stjan+V6oy+o6sRkmLdIylM/82dIGTeCxq4O+QveBxeTA6H2ydiqcEvnd6OBWSHq5hkpN2y3rlm4Fqm0tcufBtE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903625; c=relaxed/simple;
	bh=SHNkXUNafMz5hkSxPoWS1WpjgdFFiXy1yTfE/n0SUqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTUz9yqOivhu455WtGaUsncOKsUNTNAZdd8b48RryhlrVqA6YMj7XG1ONzcgDJAg/OqNwCeDcvyDZajHLnseXVwFgcxWP2MlkmIL1WJDfA8r/bms3uDEZeLAjf4Sumlr0QxttG59E8TA+REnIlWIWnJuT/Zrld1yRnSFVOBhfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chazelas.org; spf=pass smtp.mailfrom=chazelas.org; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chazelas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chazelas.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8AFBB58145D
	for <dash@vger.kernel.org>; Mon, 30 Mar 2026 20:35:10 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AFC53EC98;
	Mon, 30 Mar 2026 20:35:02 +0000 (UTC)
Date: Mon, 30 Mar 2026 21:35:02 +0100
From: Stephane Chazelas <stephane@chazelas.org>
To: Dan Jacobson <jidanni@jidanni.org>
Cc: dash@vger.kernel.org
Subject: Re: Closing parenthesis doesn't raise error in backticked command
 substitution
Message-ID: <acrdeiP1S6QkTz7S@chazelas.org>
References: <871ph1h8p1.3.fsf@jidanni.org>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871ph1h8p1.3.fsf@jidanni.org>
X-GND-Sasl: stephane@chazelas.org
X-GND-Cause: dmFkZTGbCUiFEF4mvOiTW9i87PnLjn+XE89PtgUTz/BjbahXuoStzoEZgA7whJELROI6oP9pAXGH4eWyD84wFB/pZhuEcz6jYGqy0ADe6qmW0+jeWy1Ed/Igk6ieGBtEBf+CXAvlM8LmjVLPg6f0hVMOJSnfbzls/z416ZnFG0CnjhyvbRZxojMPvL7oe1h64o/Hg/bfHIf8MJI7qkX7wdl8jx2eGpEwOa/jPzgD+IU+fD+1E+fXNCEaBTARsAsfmhb+aTWS6twOgk16wLgQqsO4KeZTlfPVVsvpMNwWVqt6TIuOGVonpMEhceIzOkqHpfE7IQE8LEZ16jljJ5Bx7UlgZIGnQ5yB0yvI0cB1lN6D8/IWz9arD22NTP9rZ31IYnyHuAsSFdIwp1/8GpiOCRGaTPDWGnGYOP45kzX3gYTe8wG4rCuhkbSMPVsyOg7z1IomR/4TiCP4Qd9Q+XHSuIZZicDofVJKzEwdPnLc3DRkNRVxFCKdfMVaFRJhed1220l1dAXkMIUpe9wK1nV1/s1DrpnCdryf9oAf0UkCH/32ZF2bpqGRtogUuqSE5t16R2632PT6T3lDLqLR5VPxRJ3Xy9DCMv2Kgh8ZAUUJsgEljdyqJ2Jt3n2GGpCmM8S+2T+IOHEvlrm0WVA5Cw0dkfHRvyjhZnI3hty+xrpNqwjcQljEyw
X-GND-State: clean
X-GND-Score: 0

2026-03-30 19:12:58 +0800, Dan Jacobson:
> Please see https://unix.stackexchange.com/questions/805208
> 
> $ ls -og /bin/sh
> lrwxrwxrwx 1 4 2025-02-04  /bin/sh -> dash
> $ m=`seq 1 2 3)`
> 
> Since when is it "OK" to have a trailing ) after the 3?
> 
> $ n=$(seq 4 5 6))
> sh: 2: Syntax error: ")" unexpected
> 
> That's better. (But what is 2? No, it's not line 2 since I started the shell.)
> 
> Package: dash                            
> Version: 0.5.12-12

For the record, that same "bug" in NetBSD sh on which dash I
beleive is initially based on was fixed in
https://github.com/NetBSD/src/commit/fbbbd4fe8c79ac320acd6cc1e6405efa509710b6
in 2008.

https://gnats.netbsd.org/cgi-bin/query-pr-single.pl?number=11317

-- 
Stephane
