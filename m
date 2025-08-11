Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B74311C08
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754931742; cv=none; b=URi0apcy2NolwLzo462VZcPtfgaZchSMi0oDajC+RqjatW6ocjDYF/4tWEcZ0q1AkMG91Ck+6nnz/80S6odU1VKw8fR5wORDA0L+2ZO8ZzYmMOPlD2kEgu8yhLfoyG4atg89IsE/iKfMkzaP1JOoYTgrs9ZCLGsVyNcdVSfZyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754931742; c=relaxed/simple;
	bh=XSV5j9uBxY/p4NwITS5W6JMZZFfNAOKKf7LZSi4rIaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P/vOvm4jEBP4oKkZ/IezL4XCBeB80Xdo9h+YCyT8+xj1ZSvUaH7ry6rnhr+WC3NBss8M3CnEej44ycBIaVovbTA7WYdt3G87KfFVVVKmob5+mpVNwBOf635YEtmSPRLefGMpUu8d/ZW5CVj5EQ1+lVmPqwfYJd2mniBBbmGqLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=lFbd3+wI; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="lFbd3+wI"
Received: from [10.96.0.68] (185-177-124-97.hosted-by-worldstream.net [185.177.124.97])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id C1DD991;
	Mon, 11 Aug 2025 18:02:16 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C1DD991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754931737;
	bh=3in26TzcWMscYubbGqOueU91zD5yBlhYmusYIWbMQjM=; l=667;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lFbd3+wIJBthEpH59+eJg/C+QIQ8ZLstE5CJ3wQnH5rfPJ3srJRH4+XSxjx6JsONQ
	 Ok08l5LNFb9a0ZYkTm4HNPmu/Rpa4F2mnEimOvHMkb/IH0xhAlaCikJxVxUDkUV8Yi
	 0ANhLPe+vDFpzPM4Z1+twXqzwJBGXDUt0tvWQC7w=
Message-ID: <dfedd45c-927f-46f3-a487-f31311fd5f38@gigawatt.nl>
Date: Mon, 11 Aug 2025 18:02:15 +0100
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
 <a708d788-e496-4478-b1b2-48ccfae092fd@gigawatt.nl>
 <5d9124b5-d687-d864-b73d-79d9bbcf160a@redhat.com>
 <c9366587-0723-4380-b50a-a43035678523@gigawatt.nl>
 <24b4a38f-5c88-729f-9b04-71a295f4efd8@redhat.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <24b4a38f-5c88-729f-9b04-71a295f4efd8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 17:30, Denys Vlasenko wrote:
> The last part is incorrect. I'm not saying that we know
> that there are no more processes that finished.
> I'm saying we don't care at this point: we know that we are "wait"
> builtin and we got interrupted by a signal.

Ah, thanks for clarifying. I wasn't thinking about wait's exit status. I 
think you're right that it does not matter for that. I was thinking 
about the child potentially being kept around as a zombie process 
unnecessarily until the next dowait().

> [...]
> But actually, my bigger point is that the code is awfully convoluted.

I'm in full agreement there.

Cheers,
Harald van Dijk
