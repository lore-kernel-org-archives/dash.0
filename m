Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22810E3
	for <dash@vger.kernel.org>; Fri, 21 Jun 2024 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718933882; cv=none; b=jfN0FBOMNVBbB30ySk17EapsvwNcWqH6OB16nlOx6eyLC40ysykDphAoJ+BhDRHK20sgFSXlZ13f5tQKFpSzvCxCquLxoLSMJuTD4FmMQ5k7Wu4GMr8UGF5DzOomTtEXU+jjmv/ceoCqHUx1QeXz6B4bI1L9uumD1uznXDr5308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718933882; c=relaxed/simple;
	bh=hXUqqsxH4mRqWujSq2Pr/CEyhZnQpuvQnt1gwJMKQLw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KQ/WBZs0Nbpj8c3EyxKtoiYbHuFLNOuARjScAOvDRXFZQUWTRTvut5J5dCxP4itA6AYh98djYGT+Nfq4s8lmsd2TV/fi5SDjd2Styd0ygsDJcN39yLKk6MU4/lWgXYLzLy91CvcyhQFMLlZvOT1PBSV4Lyb0wSLWawcA+/mzg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=mpQ9soVc; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="mpQ9soVc"
Received: from [IPV6:2a00:23c6:5398:5e01:61a5:abe2:ca5b:4544] ([IPv6:2a00:23c6:5398:5e01:61a5:abe2:ca5b:4544])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 45L1XMsL020162
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Fri, 21 Jun 2024 03:33:23 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1718933603; bh=hXUqqsxH4mRqWujSq2Pr/CEyhZnQpuvQnt1gwJMKQLw=;
	h=From:From;
	b=mpQ9soVcDjVMSmSZKGISPKMxCCxAePyF0l+Rea2+K/pl47SsfN0q3n3tSI/6M3DEV
	 docpKYVNiZXIkScpBuoaeobm8viyTKTg12UpzamtEJqmga7KJ0fBFrqtbVGYrFOTLo
	 UBopvJJDf1ynuAIFIT/cg3Cfu8T4GnC0CucAcfNA=
Message-ID: <b19b7107-097e-4865-a0d9-26cdf316c1c4@inlv.org>
Date: Fri, 21 Jun 2024 02:33:22 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martijn Dekker <martijn@inlv.org>
Content-Language: en-GB
To: DASH shell mailing list <dash@vger.kernel.org>
Subject: Field splitting regression on master branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As of commit c0674f487c7aec2a3bdf6795cea7e60c9530c360, field splitting is 
broken. Minimal-ish reproducer:

$ dash -c 'IFS=:; v=" :: :: "; set $v; echo $#'
5

Expected output: 2

FYI, this is a nice cross-platform script for testing for field splitting 
regressions (on dash as well):

http://web.archive.org/web/20051225040851/http://www.research.att.com/~gsf/public/ifs.sh

Dash passes this prior to the referenced commit, and fails it after, in 
informative ways.

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
