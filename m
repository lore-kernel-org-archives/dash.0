Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EE92D29D0
	for <dash@vger.kernel.org>; Mon, 11 Aug 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917141; cv=none; b=sz47aiSU6IPobWgFkCpHnI0A8MgamsZ6hkt9JM39C12julUfDEqGOFGogQLl/nmn4u1uUaxrB+TgxFcshAUAzPiXTcOz0QQmxOJu0aSN6oDJfh8UxCogifwTnq1BOv//8deJkfXVykVElK3yHzSpSKuWmGOjd5GaTZH/EzU9pus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917141; c=relaxed/simple;
	bh=qyM4TVIe0dGpR847MuaJHFpQCA6O7nWuBFuVeKODarg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIiACOpm3q/SlOnjT+HxzkEDQOk5WxuIIdOlSX1pMZa2oOvAE/SKym6M4KZi8JFSv37ebrEUbTTp2Om8rHXxkF5yQjtIpCzM34+EpQWJ95rKwK8YY3y2qRrivLPD30HrULgJ8rqgNLdiMn1tSZTdp6F8mD9hF2lqVmAJcCrn8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=QPvOeIi5; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="QPvOeIi5"
Received: from [10.96.0.68] (185-177-124-97.hosted-by-worldstream.net [185.177.124.97])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 5A9DE420;
	Mon, 11 Aug 2025 13:58:56 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 5A9DE420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1754917136;
	bh=yAhEJK9wEbpQ7aPuHJoeuiIaunMgYYi5X/ZjIrlPzfo=; l=662;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QPvOeIi5rC3hrUSk79YbazPBmXm0L3vNeTRf+5anxVfal4KDJMRsIc8ZGyJ7CfLx9
	 r4jh6CTAzpQIKZwAsaNzMZ/wj1lUi0908RNQSO+vtWavNou1p/OOyVN0FwIk3/+AFM
	 iONN49j3r7i7DGIKvkSmHhjT//Is2g8GAFZcxACs=
Message-ID: <c03cf64c-5e12-4317-861e-16a0bf413d95@gigawatt.nl>
Date: Mon, 11 Aug 2025 13:58:55 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Looking at "int vforked" in signal handler is racy
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
 <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
 <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
 <b6a063f8-9844-4f81-90a8-0f65e7c819bf@gigawatt.nl>
 <aJl4_WsQeHF6PI0N@gondor.apana.org.au>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aJl4_WsQeHF6PI0N@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 06:00, Herbert Xu wrote:
> On Sun, Aug 10, 2025 at 11:20:40PM +0100, Harald van Dijk wrote:
>>
>> That approach seems solid to me at a very quick glance. I think you don't
>> even need separate have_vfork_sibling and vfork_parent_pid variables, just
>> make the existing vforked variable a pid, or 0. A mostly untested patch
>> using that:
> 
> Looks good to me.  Could you turn this into a patch please? If
> you could run some quick speed tests on this versus the existing
> code that would be even better :)

It will be a little while before I can do meaningful measurements, but I 
will do so when I can.

Cheers,
Harald van Dijk
