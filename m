Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495763612EF
	for <dash@vger.kernel.org>; Sat, 13 Jun 2026 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315558; cv=none; b=XxIkl8S7Ku0//1D09XQgNxN2GjyoK/TJWDmWpZCYd1Uy+oN/4qputiXBCHfuQ65SEKJcB9HJ177bq5PDde8cjEIsCh8ocbCPryqGFNloGqM3aScetL9aAX9EFhwH7Mwz9SZbG9suYahybejwwGwl81dXcE0b4maHTVs0K9KKlU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315558; c=relaxed/simple;
	bh=/qlNqPG1FzMWwnDeu4c08HSTPjNvuVwIGRb3KLsXWik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A66i6y2Ujh4r97asHuNXtPcIQrwnNLLi+LtLmjzH/KAiJ1OmuYFA/G1ve83hzenxmsMDEFlke06bM5XGzyQSMlGQxoW2zVAk3yzcCqU49ziWARgFlLwAaW5jO5qjP8a1oyae6Vl+KM6HTMs9L1pDCTqSZCPXcCXfV+JkI3jahO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=T1sRiaKW; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="T1sRiaKW"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 04E36A0A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1781315550;
	bh=mgmJqcPub07e6X//fhddRMl6SqXneeBxwaJowWfqgFc=; l=1867;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T1sRiaKW9ml9L/aw2GXIopWVreat+dSexaQuJ3lC/qWD3AotKHlV+bN/hMzF/sMSg
	 diafpt192jrL8631u+WbG8WLY7liNyTl2UDxucOG/WpJYboZ1qmO62wdIeilaWnc0l
	 EdxPdRuDed1U0t1VJpMUN274pE9nQslYyIMfdCWk=
Received: by mail.gigawatt.nl (Postfix) id 04E36A0A74;
	Sat, 13 Jun 2026 01:52:29 +0000 (UTC)
Message-ID: <2896088e-bd54-4ea1-a0ed-537ba78bf548@gigawatt.nl>
Date: Sat, 13 Jun 2026 02:52:29 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: Print absolute paths for command location
 queries
To: Herbert Xu <herbert@gondor.apana.org.au>, Kerin Millar <kfm@plushkava.net>
Cc: calestyo@scientia.org, dash@vger.kernel.org
References: <aiy2x_l6g42HktZh@gondor.apana.org.au>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aiy2x_l6g42HktZh@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 02:47, Herbert Xu wrote:
> Kerin Millar <kfm@plushkava.net> wrote:
>> POSIX requires that, when reporting the location of a utility found by
>> searching PATH (or one named with a slash), the pathname written by
>> type, command -v and command -V be absolute:
>>
>>     Executable utilities, regular built-in utilities, command_names
>>     including a <slash> character, and any implementation-provided
>>     functions that are found using the PATH variable [...] shall be
>>     written as absolute pathnames.
>>
>> Presently, dash fails to conform in this regard. Address this issue by
>> prefixing relative pathnames with the logical current working directory,
>> provided that it still resolves to the current directory, and with the
>> physical current working directory otherwise. If the current working
>> directory cannot be determined, print the relative pathname instead.
>>
>> Link: https://lore.kernel.org/dash/2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org/
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>> Suggested-by: Harald van Dijk <harald@gigawatt.nl>
>> Signed-off-by: Kerin Millar <kfm@plushkava.net>
>> ---
>> src/cd.c   | 40 ++++++++++++++++++++++++++++++++++++----
>> src/cd.h   |  1 +
>> src/exec.c | 30 ++++++++++++++++++++++++++----
>> 3 files changed, 63 insertions(+), 8 deletions(-)
> 
> Even bash doesn't do this:
> 
> $ bash -o posix -c 'cd /; command -v bin/bash'
> bin/bash
> $

You're overlooking the "that are found using the PATH variable" from the 
spec. Because you included a / in the command, it is not looked up from 
PATH. Modifying your test to make sure PATH is used, we can see that 
bash does do this in POSIX mode:

$ bash -c 'cd /; PATH=bin command -v bash'
bin/bash
$ bash -o posix -c 'cd /; PATH=bin command -v bash'
/bin/bash

Cheers,
Harald van Dijk
