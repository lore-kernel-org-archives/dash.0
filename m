Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0982323406
	for <dash@vger.kernel.org>; Tue,  3 Feb 2026 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116136; cv=none; b=Y7M+w+vFTn5aBt4Nh7+GiCtsyfZK1hUDkPEmgdKPaKhfYNoX2yF7+D03Q0HvrIiyaY98638SVSXdW7DSFohbM/p9x8Be5a7d3pLBZMdSUXukcCC5J+UbqP5nmQUSDumR0u9shIXhSb8avdhfEkaESwGKZzDlM9WkCY3TLgk/uVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116136; c=relaxed/simple;
	bh=NT2IB/uMmcrBpdGrpyhyXFsAmx9Jvhii/UCCiischdg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lHT940vc7Us6dYShYYEdl38fwhl3UWfeQ9SKmZSKNtYTFs/Jh+0wLjTj8W8nHJ3jr6M5zCw2OgjFyC9QfpRezHIdKlmwmdaITm07pAEiWybnewsXrXcGHvn7TXDHO4n2boR64lokIM+2v50Mp9rvIl4lytyFnR/o5pNFS/8h06o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com; spf=pass smtp.mailfrom=benettiengineering.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=AjjlxuTc; arc=none smtp.client-ip=62.149.156.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benettiengineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="AjjlxuTc"
Received: from [192.168.50.220] ([84.33.84.190])
	by Aruba SMTP with ESMTPSA
	id nE1BvZjL8P2aDnE1Bv234C; Tue, 03 Feb 2026 11:52:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1770115945; bh=NT2IB/uMmcrBpdGrpyhyXFsAmx9Jvhii/UCCiischdg=;
	h=Date:MIME-Version:To:From:Subject:Content-Type;
	b=AjjlxuTc07x1XP2Y6KDPVCrC1eEZ3g7zsN8pkzwbGq5gU8x7YZTIY9IRbrXKX4PWI
	 6Piqq+0OYByBQT8i7T7EB/MJdqTyYXbz80SCkfDjbp7MjBtaeIi9uuO+mJTFjMfGem
	 v0P/NCCSR+KjaGJZ7HYezP6Kh5zNSObiA/h28c3l7F5yNKajxwX/Fi17f1Kw6pufya
	 v3Zk7azobIc3cDQ5qC+2TXSobSDrSgVtWp59u1XYx9t17t1VMCbUsX5vXWazHJAA07
	 um1cGJDXrMJp6nOSXdM9oUQ2nyMj211aU7oyEfMapkWPAnw8r+XgH8rbxqBVkL/lZn
	 TWwOo35Gdiopw==
Message-ID: <7c705a63-90a7-4437-8c75-24a117e66b1c@benettiengineering.com>
Date: Tue, 3 Feb 2026 11:52:24 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dash@vger.kernel.org
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: Missing v0.5.13.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfB/wYdbS/OlnWzU3NCstOtY+4yZ+5/gDnPYvp8yxhli+pVk7AYQbuez9rTdrQMI9CH12Ac3+nqelVdmtMP9nncZbtFFI3oy0PEI+ePfJKg7bvVO/PPra
 MM//o7Dt+Zf8aJkiZXG266JEMT0+xKU3hm9gpa629XQO75EqilTIaWmOk2nZTa2lqUn0/qwqGQArRx67oIdPzs2Gzku2jefuyzI=

Hello,

can you please tag version v0.5.13.1?

Thank you
Best regards

-- 
Giulio Benetti
