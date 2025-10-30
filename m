Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3933F365
	for <dash@vger.kernel.org>; Thu, 30 Oct 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823526; cv=none; b=QhAcZxhRYDKZAPj/UlqAWyTZmqNvXD/3MCasnv6KT1ve2007pKJbcV2avtGl6EhsU1Ir84HQT+X/njfY/decHpkEwLFmwN5qEJ6xZL0j4xJYJxyLSEPAOqwmx1RX5MvI6Pg2boto9YJQ4oJ7ZPkpDoRhaO0afHWWda3YsEtI5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823526; c=relaxed/simple;
	bh=Z71AngdNv+4twfDi6aY/+cft5fb4XfNQigeYqtIefo4=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=Tav2B6n/yBZmHkyl/4V7HfS/AZIvTgkSHZeO9RTlL1sd9Pq19yzJaiXaIjWO4dU7qYLD8twmtPTllsBM5WvOrwTSuWjDE0gJc33RIaU3hAXRDRkDpv6wCoX31Ms8aqwF4/9ykav0wcADk6wZZLHCAmVgY9t83nC9Z8REJYxwsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=O88SSsH7; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="O88SSsH7"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9B4FD240029
	for <dash@vger.kernel.org>; Thu, 30 Oct 2025 12:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761823514; bh=Z71AngdNv+4twfDi6aY/+cft5fb4XfNQigeYqtIefo4=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=O88SSsH7agfJghHL7/e0wVmELcozmOiXhv0Yg2k25HrjFXBy0tvcCzqlxy/iF8m1b
	 gNOytixA8Rxf+fXsj7Fc5ZMNxIrBJY82iXn5XjJMANI7cu+b+Pt57M8jMzkdOWDUQE
	 l7m28YkaGYCm8nP225fqHQtfsuzg6kv4UQseuByADrPOVEVp4YwYyVjXL1naVMcQsN
	 J8t80KxA6st+OhV0WqS5r3qXEVBXBsPOC+t7velKiNpqHAF9KHkSM8ecIxk+4icb4u
	 GMU+5uPKGvTz3o+5K0P8s0LYIKygkmTF5xQdYJh5Zxz5bsL21SrqCjRjsfaiRQ7LDQ
	 ITVu2IQaozUFw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cy1xP6rlvz6v2S
	for <dash@vger.kernel.org>; Thu, 30 Oct 2025 12:25:13 +0100 (CET)
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 11:25:14 +0000
From: j.daubert@posteo.de
To: Dash <dash@vger.kernel.org>
Subject: dash 0.5.13.1: strange pipe behaviour
Message-ID: <118bb4c89dfd2b3e1f44cf2b4b831812@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

With dash 0.5.13.1 together with your latest patch I got this:

$:~> echo date | /bin/sh
$:\w> Do 30. Okt 12:21:36 CET 2025
$:\w>
/bin/sh: 1: Cannot set tty process group (No such process)
$:~>

with dash 0.5.12 and bash this works:

$:~> echo date | /bin/bash
Do 30. Okt 12:22:52 CET 2025
$:~>

Greetings
Juergen
