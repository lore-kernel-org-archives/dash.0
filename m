Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AF226CFF
	for <dash@vger.kernel.org>; Thu,  7 Aug 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754599858; cv=none; b=p4VwKvMrJcuSiEN/48fu6cgF1qQMBcLtKhIe4woj1/ODQXeODv/CwL+b0OZSWoGZGY44Qz9IKrg+SaA/Ss89C/FtPqdNILR+3eAyITPGwuI2TRkB4bI45AHPJVKzDoyuw7yK8jt6Uf61CmUEPXw9CLpb4saQXeRTfHWtTA3TaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754599858; c=relaxed/simple;
	bh=m1+2/ZD9VhdyqX7VF/ORTkXgONI/KkQy0CmP0IhoyW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qIoFxpFLJ2gLNF7J7fBgiBs8wNo5UgbwqogrKmRj35hYw5b/I7ULEu/sKsovZnFj39oAGM8/Lb3a9Loor3XA2KLkEE1zX44ZROigWvV9QBMl//I3ANg5cJT72+J1KD/DXbAlvJGOUSfZhfjr4q9kof+6j4KDWVU08Frpmoub/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=NRCz21vh; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="NRCz21vh"
Received: from [192.168.178.24] (unknown [31.94.68.53])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id C3699140;
	Thu,  7 Aug 2025 21:50:44 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C3699140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754599844;
	bh=DXnEdxL0otPTvZGCO4TpxrhtkzWc7IxJHf1luN3NZEw=; l=611;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=NRCz21vhavwydvQajzyAfIkAipggYw2wdp2TSQ3Y77hGC6Y95nNxkYMI61Pn7Z7Gr
	 ouV5PBROwjq+4b264VszTBHR4sFXBFd9s8hXX70ty8mQehdeExwQZEs1sDI/YhhgyW
	 diLy4LOUkhps1hOzAH7l9eW5q/mufZCJVOBFgg7Y=
Message-ID: <3f276fe7-11ec-4056-b161-98513d035c4f@gigawatt.nl>
Date: Thu, 7 Aug 2025 21:50:42 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Handle line continuation in unquoted heredocs
To: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org,
 Herbert Xu <herbert.xu@redhat.com>
References: <20250807201015.11358-1-dvlasenk@redhat.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20250807201015.11358-1-dvlasenk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2025 21:10, Denys Vlasenko wrote:
> Testcases:
> 
> cat <<nice
> heredoc1
> ni\
> ce
> nice # this isn't heredoc end, the end is above

Interesting. I am having trouble telling from the POSIX wording whether 
this is meant to be valid. Is this the case that "It is unspecified 
whether the line containing the trailing delimiter is itself subject to 
this line continuation." is meant to apply to, or not?

> A more simplistic apparent solution for cases 1 and 2,
> s/pgetc/pgetc_eatbnl/, breaks cases 3 and 4

Would s/pgetc/pgetc_top(synstack)/ work instead?

Cheers,
Harald van Dijk
