Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA300197
	for <dash@vger.kernel.org>; Fri, 21 Jun 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939826; cv=none; b=HmwDhumbZsvmcCzor6XKAABL438j6fSSb0rrrJVD6LQkCLudQqjwEPuBHA/OZrKaAeg/I7cVbT1z1h5w1yzQfql/TjxPqU+QVm7BIB1eIPd4sLKCu7BP6vtjnTGI5gArwMgrTlQnhLl12dbzaGqb6O+o+aPkjUQy9zPTmUdieXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939826; c=relaxed/simple;
	bh=m2BY5T1DdfzhReB6IrBi3kpq0NNivUTac2jFlT3Rvec=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T0yw4b3TPwV3KyEH+8rLbqKhGboKekmft5JvxY2wMWvL4ZVZzjKIclK3BDhXaUmy8PkfNAL9s3UUlXzLg5OAhzYPmy6MZbH9frLv92PQYAy9Gbkr6fTPf1NlAgv91HGVulctPo7BLig7BNjAJchNCN3zt8OMQfM/6n4y3tywjM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=joa7Ve6g; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="joa7Ve6g"
Received: from [IPV6:2a02:8010:68a1:0:4c2e:bdb0:6f5a:892e] (unknown [IPv6:2a02:8010:68a1:0:4c2e:bdb0:6f5a:892e])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id D63D951;
	Fri, 21 Jun 2024 04:07:52 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl D63D951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1718939272;
	bh=Y8r86NNEMUJxCg1MVElcB7crjrUX2/6vMOrhMZclpR0=; l=657;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=joa7Ve6g7z2LMeJ/t6TcMEMfV9/W81iTViADoVlTqs/eXvYiRdJuJRXv3eaGqdxAx
	 lXqzXH7gZGnyTbv7/aaZJ8aUNQDnpvisdd+/Zutzsd3XTRsT5CK/ww9NSvctjhShkU
	 zPBwVhOkNQgOrk+VWCvsBbyEwVEUNnFCoO78qSAo=
Message-ID: <49584a1b-3d12-4613-9bc4-e3a4dd291b4b@gigawatt.nl>
Date: Fri, 21 Jun 2024 04:07:51 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Field splitting regression on master branch
To: Martijn Dekker <martijn@inlv.org>,
 DASH shell mailing list <dash@vger.kernel.org>
References: <b19b7107-097e-4865-a0d9-26cdf316c1c4@inlv.org>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <b19b7107-097e-4865-a0d9-26cdf316c1c4@inlv.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/06/2024 02:33, Martijn Dekker wrote:
> As of commit c0674f487c7aec2a3bdf6795cea7e60c9530c360, field splitting 
> is broken. Minimal-ish reproducer:
> 
> $ dash -c 'IFS=:; v=" :: :: "; set $v; echo $#'
> 5
> 
> Expected output: 2

This results in 5 in bash, ksh, older dash, yash, everything I can think 
to test. Whitespace IFS characters is meant to be handled differently 
from non-whitespace IFS characters, I think 5 is the correct result.

But with IFS=": " instead of IFS=:, the output was previously 4, is 
supposed to be 4, and has changed to 2; I agree that it looks like dash 
has introduced a bug here.

Cheers,
Harald van Dijk
