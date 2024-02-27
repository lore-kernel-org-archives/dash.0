Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E2138497
	for <dash@vger.kernel.org>; Tue, 27 Feb 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029461; cv=none; b=Rshq3kKvhuX9e2qrUniLzW8vh/IxE4zNWI5DArOaPYA37yk+EqA8a/FuiIi6wxRQqZUDdd0Sqk0A2lDXOfhS+XJ/xS2cOvnsEi0/XCneCEOtJy9mfTg3RRASN8vu0JhrtbU1yw/PGxNCyEM1gfNpsvd76EuHU4LVMIXClHI9e04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029461; c=relaxed/simple;
	bh=LQECAdOZTBmqJHqBLHWsXuDZVpgjNo/WKr9PvWAxuaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O8t1K0NGKLjkmGcAxc6r+6EMRvsSaaHbaYdIvkSmiN7LY0g/I7DSimII1cuMFwep5gYT2122XQ8AwFsM7ZawzI4JabxnQvwiAPPT1geoGzLtMZ1r1kWe2HN+rKXeyxHdcLA2Y+WPTdihqLKndMlYm2L9hFmYZuj30urIakb6e3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=YylhgQhL; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="YylhgQhL"
Received: from [IPV6:2a02:8010:68a1:0:647e:b5f2:452b:ccb6] (unknown [IPv6:2a02:8010:68a1:0:647e:b5f2:452b:ccb6])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 286DB72C;
	Tue, 27 Feb 2024 10:24:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 286DB72C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1709029454;
	bh=gjFu3u+iybbiy1ovvD6GVRBxhu5FNNxbch5uX3WaV+0=; l=1334;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YylhgQhLnLq67eXiLUQFkQ7M5Rt2djaiVjKj/S5tMhuq4EY7OGtrLxvhapsTqwnLL
	 yQoSnf/vSWcc9hRGLGO3PSxyVEuH6MohR03fTm6IPGkpuCTZWDYQ9nb1iuT5jUp+ux
	 nGrlIHuGS4S1nQssQvKSut0x5JFxg6/VPoPxJsBU=
Message-ID: <9dba3a62-69dc-4c42-94b0-5bb3495ede2a@gigawatt.nl>
Date: Tue, 27 Feb 2024 10:24:11 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wrong behaviour when unsetting/setting some variables
Content-Language: en-GB
To: Christoph Anton Mitterer <calestyo@scientia.org>, dash@vger.kernel.org
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
 <18ce9b6d-f9fa-467a-ab3b-5a4ddc5ed36b@gigawatt.nl>
 <fdaa6e5ea49f1eecae637929d8c3e7feb84bbd5e.camel@scientia.org>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <fdaa6e5ea49f1eecae637929d8c3e7feb84bbd5e.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/02/2024 03:28, Christoph Anton Mitterer wrote:
> On Tue, 2024-02-27 at 03:07 +0000, Harald van Dijk wrote:
>> I suspect the reason you don't see it happen with TERM, LINENO, and
>> HISTSIZE is because you have built dash in a configuration in which
>> these variables are not special.
> 
> Ah, I see... well I merely took the Debian unstable version of it.
> 
> 
>> For special variables, we get to
>>
>>     flags |= vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
>>
>> where we preserve the VEXPORT of the previous value. In case of
>> VUNSET,
>> we should not be doing that. I agree with your expectations, unset
>> should clear the export attribute.
> 
> So is it really just:
>     --- a/src/var.c	2024-02-27 04:25:32.000000000 +0100
>     +++ b/src/var.c	2024-02-27 04:22:40.744456151 +0100
>     @@ -295,7 +295,7 @@
>      			goto out;
>      		}
>      
>     -		flags |= vp->flags & ~(VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
>     +		flags |= vp->flags & ~(VEXPORT|VTEXTFIXED|VSTACK|VNOSAVE|VUNSET);
>      	} else {
>      		if (flags & VNOSET)
>      			goto out;
> 
> I had even had that before, and it seemed to work, but wasn't really
> sure whether it doesn't mess anything up behind the scenes which I
> didn't understand.

This isn't right, this will unexport variables in other cases.

   export FOO; FOO=bar; export

Cheers,
Harald van Dijk
