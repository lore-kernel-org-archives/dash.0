Received: from mail2.dravanet.hu (mail-b.dravanet.hu [109.61.0.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDFC2010F5
	for <dash@vger.kernel.org>; Thu, 13 Feb 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.61.0.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463016; cv=none; b=nn4IXrC8jUjiCuVkBHCM2tCgJn3Yp+i6aEuKkRRTJZR7T1GOp+cstmAjqnwjMvxWlpSl8FLigA9WyUBZGFSbyvxxmZFjIYt46JS8Iyey8XJqtsrueRKmPdkYmLKoyzFhU/9xICQs4IeT1xFt/IxP5Jq/kN+pK/w7gZWFg09SX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463016; c=relaxed/simple;
	bh=7Gqj+ktFESOr0fRmQ1wLxp2MCboZVZ6Rh49y6urig/Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y46zCKyP8dHm0JvMGcG6gxiRE9P0d2Qr34ZHCKc/fpWv4HudwItbc+APi//ohR/bSwG13tJ0RnJAmolOY45g9Z3QQ8fN7UueVqxWBELf61idxrrJ6hTnQECIAh+ooivo6YQWLQ66bf4Z7Yf+WfOT2B3/UilNeh9cYgQqhmzBOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu.inter.net; spf=pass smtp.mailfrom=hu.inter.net; dkim=pass (2048-bit key) header.d=hu.inter.net header.i=@hu.inter.net header.b=YKqkrWUE; dkim=pass (2048-bit key) header.d=hu.inter.net header.i=@hu.inter.net header.b=UkiCzfNJ; arc=none smtp.client-ip=109.61.0.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu.inter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hu.inter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hu.inter.net header.i=@hu.inter.net header.b="YKqkrWUE";
	dkim=pass (2048-bit key) header.d=hu.inter.net header.i=@hu.inter.net header.b="UkiCzfNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hu.inter.net; s=s02;
	t=1739462459; bh=7Gqj+ktFESOr0fRmQ1wLxp2MCboZVZ6Rh49y6urig/Y=;
	h=Date:From:To:Subject:From;
	b=YKqkrWUETlBGw7mgPuAdCYM9/plug6jeAVdKQe2gjcw3e/BB2fcQ5zyr6btj1LmfE
	 3rjDxwolvGk7kKy7jjwz/gXMUpSbAxMYrpGD8YKnD1wFySZTwGD3inyEioxstolWOF
	 3wvnhBj6kj58BIJyXEiKuoTDvsy3d5IvAP7JxDco5j8f7325ff4Vi/0YjmJRyqYrw/
	 ACkEBoqkaSikrVzFUV5Zj5IG8+j7BdU4VC87XCOzX0crnTou68yiAfu6GoNnlFgr4Z
	 dHOELdRlaWyG19UPG4xeWnkT9sfHjedIMbSr9lseqCfJn8R84C5E199MYpjd9bt9xv
	 jsSvA3udpQBgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hu.inter.net; s=s01;
	t=1739462459; bh=7Gqj+ktFESOr0fRmQ1wLxp2MCboZVZ6Rh49y6urig/Y=;
	h=Date:From:To:Subject:From;
	b=UkiCzfNJQ8SdJlI9zMFs80kTPRUGZ5t1VE0+3q4kE6gKhX6m3BoTIrpseit3Nyodu
	 HqVXjH1h3+JYcrPqWEIQnWKirIk77kAQFPb2USNpQtG3DDhTiviFtiQmw+IpRCrcv5
	 vEayi+br+5E57gd4bcnJxhjYlq1sNzBy5Cn9e1DkrJs4+5h8oo7SCGM27VArTsn0Re
	 0AFLdbnExxtqGfh1r3DQ12mLd1HzVxM0H1TgnOfakYsuifcDgMUHhWYgyXOEW0YNx8
	 ms16mkes2IBrUqKOniQNypR+RBeyL+UaPO/rvnk+Dl0uezyD29rcv2QMMxGum214HD
	 YutCDB6/wrH7A==
Received: from stanc (84-236-92-64.pool.digikabel.hu [84.236.92.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail2.dravanet.hu (Postfix) with ESMTPSA id CB6C72C647B
	for <dash@vger.kernel.org>; Thu, 13 Feb 2025 17:00:59 +0100 (CET)
Received: from localhost ([127.0.0.1] helo=stanc)
	by stanc with esmtp (Exim 4.96)
	(envelope-from <szaszg@hu.inter.net>)
	id 1tibdi-00062g-0g
	for dash@vger.kernel.org;
	Thu, 13 Feb 2025 16:00:56 +0000
Date: Thu, 13 Feb 2025 16:00:55 +0000
From: =?utf-8?B?U3rDoXN6?= Gergely <szaszg@hu.inter.net>
To: dash@vger.kernel.org
Subject: bug: 64bit arithmetic/number parsing
Message-ID: <20250213160055.ymjwvpbwsgpvif3p@stanc>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

$ dash
$ echo $((0x8000000000000000))
9223372036854775807
$ printf %x\\n $((0x8000000000000000))
7fffffffffffffff
$ printf "%x %x\n" $((0x8000000000000000)) $((0x8000000000000000-1))
7fffffffffffffff 7ffffffffffffffe
$ echo $((-9223372036854775808))
-9223372036854775807
$ x=0x8000000000000000
$ echo $((x))
dash: 6: Illegal number: 0x8000000000000000
$ exit

$ bash
$ echo $((0x8000000000000000))
-9223372036854775808
$ printf %x\\n $((0x8000000000000000))
8000000000000000
$ printf "%x %x\n" $((0x8000000000000000)) $((0x8000000000000000-1))
8000000000000000 7fffffffffffffff
$ echo $((-9223372036854775808))
-9223372036854775808
$ x=0x8000000000000000
$ echo $((x))
-9223372036854775808

Thanks,
Gergely
