Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510E529CB3C
	for <dash@vger.kernel.org>; Sat,  9 Aug 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747550; cv=none; b=NOs1wxLpLJM4NfGB/T+/l8UfvZWl2QrSpWY6Hhg70ir/u3MywTMADmmF+ZvXTkGl4CChGxNAU7fiOldguJ5GacNL0O9FaAFshBFSg/xaHtUQkXoqcbE2cK/R/peD8Lfru7qlVDB68SsIWVJC1QNtZlAuC9+z4O8VGLx5ZGW2iEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747550; c=relaxed/simple;
	bh=6bBZDDTwSjNbqf0R9uPmVtzkkyCZioiBEK/LhcRcEVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MHg4Yd94N21AcbWyz6PajH0Sjf8cispYmqt/XY++Nf1i0yrVOjHqWKl+NjToOfEHPkW6dk7QMgbwyvI3F0fEfKR73oNf5z31bH9h69jYfJS6fhAXFo2VfOF/FnSMrKYNcZS+3mXgxYbzRfQ16E5bHBcaKSa3sp8+NSYsMC9uEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=OycJSeQa; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="OycJSeQa"
Received: from [192.168.178.21] (unknown [31.94.68.53])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id C8BAD91;
	Sat,  9 Aug 2025 14:52:18 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C8BAD91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754747539;
	bh=6KoEQSWgIoKbaRiKmjaNYrur7/9RVAbzdoVCevn+JPQ=; l=534;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OycJSeQaFKcUv8TDzmj0Gi82YJJ+A9bVB7qC2vEywoRz7SgL7irdHAXdhKcCOfK2M
	 rvq6G9XLZz6BcTZu24FTtb3+QgT+uStkqXl24uw6mh5+/3gnVOwMqv2LLzjaq0KWgJ
	 fs80IAPi4oSRQIpTimCbSfHVKOACDj0HHt83fHrw=
Message-ID: <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
Date: Sat, 9 Aug 2025 14:52:17 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Looking at "int vforked" in signal handler is racy
Content-Language: en-GB
To: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 09/08/2025 14:29, Denys Vlasenko wrote:
> struct job *vforkexec(union node *n, char **argv, const char *path, int 
> idx)
> {
>          struct job *jp;
>          int pid;
> 
>          jp = makejob(1);
> 
>          sigblockall(NULL);
>          vforked++;
> 
> <<<< Parent can get a signal here.
The sigblockall(NULL) is meant to prevent that from happening. Likewise 
for the next one you point out. Is sigblockall(NULL) insufficient for 
some reason?

Cheers,
Harald van Dijk
