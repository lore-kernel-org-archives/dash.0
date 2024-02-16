Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518EB133981
	for <dash@vger.kernel.org>; Fri, 16 Feb 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106693; cv=none; b=VEJmNesH2zJJYRbHa6s3kRs37qjmd7WCBau6TXP/jaCwLE8Bv55eDYg9tCaTA8T6D9a2CEoOG8DXRPTaT04DPHy/aVplwy9oVCgL9lU3sw7jTX6MgKfhQdK5lLwaAqYKP3L571rE0e5DP59qnqMq4cAmnHYcG+QkLy22en1g3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106693; c=relaxed/simple;
	bh=k1ILPxocM8B1y4w4SEw4BpEjgENfIeSRWVVG7TAsrMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RUP2kWvNkf8P8sjexpoI5395dBd8tIo6Uo476X9bZEuaPglSy/ZmnzXrfIST0NU+O0PUXsD6lJJhz1dJ0aHYxObD+kbVf27Hg2zsMoSOkuRAxovH2uN8xoy8QqhHTYhDKI93rbzCgAgxbbeLyBT6xTf/rsio9taIc8k+STY4574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=lRNDO9SR; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="lRNDO9SR"
Received: from [10.19.204.115] (unknown [31.205.90.13])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 75847104C;
	Fri, 16 Feb 2024 17:55:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 75847104C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1708106147;
	bh=nowma1Mr9ngtjLhT2vOnYMTzwYeBarfwWgMyWSsHAyc=; l=1920;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lRNDO9SRxwFz5ug74C64S+Je3vOXb+aR4R0NetPYq38j0r0H+/1WduMP4t7DrjoNf
	 iC3paGgISiDtOCaQSo85RjRrbW7Onqp1DrG2cnEBbxvHfROcxuK97Aip8WKoFO3KFg
	 5dwbx7zEbQ+C23Dk5iKFXfyzemkh/ZrcRLDQtAnk=
Message-ID: <8fc1a12d-bbb2-48cd-8172-cc99f1db15fd@gigawatt.nl>
Date: Fri, 16 Feb 2024 17:55:46 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure.ac: drop -Wl,--fatal-warnings
Content-Language: en-GB
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, dash@vger.kernel.org
References: <20240216163319.860768-1-fontaine.fabrice@gmail.com>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20240216163319.860768-1-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 16/02/2024 16:33, Fabrice Fontaine wrote:
> Drop -Wl,--fatal-warnings with --enable-static to avoid the following
> static build failure:
> 
> configure:4778: checking for strtod
> configure:4778: /home/autobuild/autobuild/instance-8/output-1/host/bin/powerpc-buildroot-linux-uclibcspe-gcc -o conftest -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -mabi=spe -mfloat-gprs=single -Wa,-me500 -Os -g0  -static -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -static -Wl,--fatal-warnings conftest.c  >&5
> /home/autobuild/autobuild/instance-8/output-1/host/lib/gcc/powerpc-buildroot-linux-uclibcspe/8.4.0/../../../../powerpc-buildroot-linux-uclibcspe/bin/ld: warning: conftest has a LOAD segment with RWX permissions
> collect2: error: ld returned 1 exit status

Where is this warning coming from? Does it show a real problem that 
needs to be addressed?

As for the actual patch, you're right that configure should not be using 
-Wl,--fatal-warnings, it should be avoided there for the same reason 
-Werror should be, the warnings that get promoted to errors differ 
between toolchain versions and in general, it is not possible to ensure 
that all valid toolchains, all valid warning flags, result in no warnings.

I suspect though that it was added for a reason, that there were things 
that *should* cause configure checks to fail, that did not fail except 
with -Wl,--fatal-warnings. Whatever that reason may have been, it will 
need to be handled differently if -Wl,--fatal-warnings is dropped. 
Unfortunately, it was added to dash back in 2007 before the current 
mailing list existed, so I am having trouble finding any explanation for 
what those errors may have been.

Dropping it sounds good to me if no one can tell why it is there, but I 
would suggest some experimentation may be in order to try and figure 
that out first.

Cheers,
Harald van Dijk
