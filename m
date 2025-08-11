Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C42594
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875324; cv=none; b=QfmQ3LfN8wwZIr8zrppu0eGirqSXHsAktG7uuSMaMpun7XKo+Zw4Y5G4NBSPjtw+YAfbRpsW4+GkkSKELyZajEq35GKPAzDtmyPkNbHmuGI+kRPIlkUpPb0SRx+0SXoROZGIVIdI+OzJPFwQ13Aaf3AbFAH9+E0LPjtzK/DkeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875324; c=relaxed/simple;
	bh=uE+V4/d/xHoiiL8rEJMPWmnaoP9s3Un2ofJWKemC7qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e6CuGD20FakyHRfWirl5HSjXjvnk+ghSBXV1vdFUCsccJG6Wpaz4+BM1uAPPY8sOZWDQYppExj7P+/h5CS8aI/UWZFcpR7XQIZ5CT2UKIMfft76QUctmS5eo2I/Z/453Y932rgSqpCB2MLpXs04VvaJgbT8P08Toinl1wzKCnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=IQYtBxaN; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="IQYtBxaN"
Received: from [10.96.0.68] (185-177-124-97.hosted-by-worldstream.net [185.177.124.97])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id B0BF7E9;
	Mon, 11 Aug 2025 02:21:58 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl B0BF7E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754875318;
	bh=sDZVieXVv6r1I31eVpxVRW1/RKJxtypJzVtJcGaehS0=; l=809;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=IQYtBxaNv7eIcC1SHtxqlRQ8phYrzx1s6MeRvzwHY/MzhNqgrSRXRLCEUqc3bKPDQ
	 InbM8GAA/vUV8AlJN/hffBNN/zkac7rU1+0nK1QlBhpdd2m1vs8c4bqZMp7Lfa8mLF
	 V7po8S87ckznNATcGch5rOgmm5YKp4k+3572BKl8=
Message-ID: <a708d788-e496-4478-b1b2-48ccfae092fd@gigawatt.nl>
Date: Mon, 11 Aug 2025 02:21:57 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wait code is fishy
To: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <b9ce3783-0b6a-1b05-dc29-68e3d3b5aa74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2025 22:30, Denys Vlasenko wrote:
> The reason for "pid == 0" retrying NONBLOCK wait for more processes
> is unclear: if we got here, we already did wait for processes
> just now, got none, waited for signals and got a not-SIGCHLD one,
> so there should not be more processes to wait for.
> A comment explaining it would be nice?

A signal that gets sent to a process group can simultaneously be a 
nonfatal signal to the shell, and a fatal signal to the child, where the 
nonfatal signal to the shell may get processed by the shell before the 
SIGCHLD resulting from the fatal signal to the child. I do think it's 
possible for that extra loop iteration to find more processes that have 
terminated.

Whether this is an important case to handle, I do not know.

Cheers,
Harald van Dijk
