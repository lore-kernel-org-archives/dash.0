Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BE8565D
	for <dash@vger.kernel.org>; Mon, 29 Apr 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.3.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408618; cv=none; b=IiJAKYbCO0bnSNYmK62FtUd9HbUrB753Ce3ItIpGhxpnn8BHRuZEKic4PibILJvNruC87NcqFXwci+ib90fm74YlZ2xzAfLMYwSr9EF1x6XMmiUINdujV36F8J1KRC3kTJBKYUxQQzssUm/0Ri+FX7WYJEa8bMK2ccJ6JOCpheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408618; c=relaxed/simple;
	bh=njXx+VOwHiotlcfhZ1cKSv8wrSwZSFqsWUQ8ddsoL2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cic+SfFxUzLur+Pr8Ytxz2D+Bu6LdbayZl4ONSmA1ShS4ewO+UleDRE0IFLJT7z49VmLwtXuF97ktCOJUUEP5SeWj1MUaaidO2d4HdOVB8QE0z+jtYZrjAMcDU1QhNu7NDWCxZl1tW9ZVd07OsKGvQRPiKdKxUGB6GvwfVKiOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se; spf=pass smtp.mailfrom=lxm.se; dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b=AVhPnttV; arc=none smtp.client-ip=93.188.3.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lxm.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lxm.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lxm.se header.i=@lxm.se header.b="AVhPnttV"
Received: from s807.loopia.se (localhost [127.0.0.1])
	by s807.loopia.se (Postfix) with ESMTP id 67A4F3012F8E
	for <dash@vger.kernel.org>; Mon, 29 Apr 2024 18:28:20 +0200 (CEST)
Received: from s980.loopia.se (unknown [172.22.191.6])
	by s807.loopia.se (Postfix) with ESMTP id 587202E2C533;
	Mon, 29 Apr 2024 18:28:20 +0200 (CEST)
Received: from s470.loopia.se (unknown [172.22.191.5])
	by s980.loopia.se (Postfix) with ESMTP id 559332201600;
	Mon, 29 Apr 2024 18:28:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Flag: NO
X-Spam-Score: -1.2
X-Spam-Level:
Authentication-Results: s470.loopia.se (amavisd-new); dkim=pass (2048-bit key)
 header.d=lxm.se
Received: from s979.loopia.se ([172.22.191.6])
 by s470.loopia.se (s470.loopia.se [172.22.190.34]) (amavisd-new, port 10024)
 with LMTP id NA-0cz7u6U2Q; Mon, 29 Apr 2024 18:28:20 +0200 (CEST)
X-Loopia-Auth: user
X-Loopia-User: henrik@lxm.se
X-Loopia-Originating-IP: 92.35.23.126
Received: from [10.123.0.42] (c-7e17235c.012-196-6c6b701.bbcust.telenor.se [92.35.23.126])
	(Authenticated sender: henrik@lxm.se)
	by s979.loopia.se (Postfix) with ESMTPSA id E9C7D10BC313;
	Mon, 29 Apr 2024 18:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxm.se;
	s=loopiadkim1708025221; t=1714408100;
	bh=Vz+efWfX+CvOMr5c88c9DqLmst76sBCQ2MYKU07Sas8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AVhPnttVObE+nYnMtC26Lnw6vwqyt3TNHSFp67CbidRhjVT3U5s3TOf3AzQo//5ib
	 EFYJdTLHTWGjlTZFTGJeGvaXvykiQ6mQsvUge2ZF7p06e3ODSkwDPz6BZucoy3ocRj
	 0luNy0AMig/pUlWCy1cRzKttgityQpCYhmpX0DfvUdBm6W/Vr88NBSzCAaRLf7IXT3
	 bkje3t6nkIXLvUXhGhBhh6AYZMR9oDtrPK5iXXsBAAlaVel+jy39/N/IlzGSJ5Egwh
	 Kl8OyyOCL3dN2SUbL2JSnHOBqvcXchy/tpLok1LWoCCKSXeH+fSr/qVrBMU6fu+j+h
	 PKjLRhHswNwXw==
Message-ID: <d28c0015-3fff-412a-bdb2-39cae101e57f@lxm.se>
Date: Mon, 29 Apr 2024 18:28:19 +0200
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Generate signal names at runtime
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org
References: <Zizl53et9J5Hg2D5@gondor.apana.org.au>
Content-Language: en-US
From: =?UTF-8?Q?Henrik_Lindstr=C3=B6m?= <henrik@lxm.se>
In-Reply-To: <Zizl53et9J5Hg2D5@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Getting the names from libc sounds ideal, but i don't think there's any way
to do that with musl, which is what i'm trying to cross compile to. That's
why i attempted a more universal solution in my patch, but perhaps there
would be interest in musl to add sigabbrev_np instead.

As for a fallback, shouldn't the goal be something more similar to my
attempt rather than the existing code? Silently building a broken version
of dash when cross compiling isn't ideal.

Thanks
Henrik

On 2024-04-27 13:47, Herbert Xu wrote:
> Henrik Lindström <henrik@lxm.se> wrote:
>> They were previously generated at buildtime by mksignames.c, but that
>> approach had two flaws:
>> 1. The signal names were generated for the host system rather than the
>>   target system, resulting in broken cross-compiled builds.
>> 2. The SIGRTMIN and SIGRTMAX macros are usually implemented as
>>   function calls and can only be surely known at runtime.
>>
>> The new implementation has been tested to generate identical signal names
>> as before on these systems:
>> * Debian 12 (glibc, odd number of realtime signals)
>> * Alpine 3.18 (musl, even number of realtime signals)
>> * FreeBSD 14
>>
>> Signed-off-by: Henrik Lindström <henrik@lxm.se>
> 
> Now that glibc has sigabbrev_np we should switch to using that
> on Linux, perhaps with the existing code as a fallback.  BSD
> has always had ways of getting the signal name, though it may
> not be very portable so we'd need different flavours if people
> cared enough to add them.
> 
> Thanks,
