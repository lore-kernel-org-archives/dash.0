Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64D2E7360
	for <dash@vger.kernel.org>; Sat,  6 Jun 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767352; cv=none; b=ty0BzvcnmsgyZf3ytHaAxQNiS0Vel6yrYdKqMShSILXNZt/ODEZhi/qHDLUwnOfdlrLFCFgcne/gwirx1ernkeyfhBNWwoQSMtJTU39BamMh8AUEoyKeDZH0gzluyzRUMBXgtH433ZzzCXfwlez7UXzu/6CcTErg6SzXS4Lx8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767352; c=relaxed/simple;
	bh=bu3QHWwmx3BwvG0TYW+520ourpxqzxQA6d4NxycU8aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGbDs6tIkyMG+zeeDj1fRVoz4jKfkdnkp8f8vHk1y9lokaqNyKh5GIaBjpfeDqlQFdYen8FSVVGRfT/GqgiSIRvuIAXs/8Ad01lriHwD5bY5/9G1USjgvbnj4gRdafaOGSRYg3yNi1Twlr//T7sUdK7U6xBdCdGgij9HMBiNZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=nEkyZmRM; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="nEkyZmRM"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 275B1A226C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1780766830;
	bh=vKY3SHeXgwlEieKPAFBdkK5v43wiT88WZfak9m5CY4o=; l=2037;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEkyZmRM0r2Kvi0r+VJcwyKOOSGYzU9QRV7nVug2T9jSgjkmdzkxaiSFrH1S22wum
	 Norpw5tg0KcX2zj/nykndnTm9lRHNid9xXP07n9Ofm9RYiuen7LVo0uXBCzRLu88Zi
	 Y72vw62hTbsI/2gnN9/bmJ4eN/sAPCwihDQ+aZU4=
Received: by mail.gigawatt.nl (Postfix) id 275B1A226C;
	Sat, 06 Jun 2026 17:27:10 +0000 (UTC)
Message-ID: <7dc9a5c3-7c50-4d52-b46d-7ad4477a24ae@gigawatt.nl>
Date: Sat, 6 Jun 2026 18:27:09 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Print absolute paths for command location queries
To: Kerin Millar <kfm@plushkava.net>, calestyo@scientia.org
Cc: dash@vger.kernel.org
References: <2d20377774340d1612d4f3a9243bfefd36afff60.camel@scientia.org>
 <20260606153634.119074-1-kfm@plushkava.net>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20260606153634.119074-1-kfm@plushkava.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/06/2026 16:36, Kerin Millar wrote:
> POSIX requires that, when reporting the location of a utility found by
> searching PATH (or one named with a slash), the pathname written by
> type, command -v and command -V be absolute:
> 
>      Executable utilities, regular built-in utilities, command_names
>      including a <slash> character, and any implementation-provided
>      functions that are found using the PATH variable [...] shall be
>      written as absolute pathnames.
> 
> Presently, dash fails to conform in this regard. Address this issue by
> incorporating a helper function that prefixes relative pathnames with
> the shell's cached current working directory.

Hi,

Although this ensures that the written path is absolute whenever 
possible, it does not ensure that the written path corresponds to the 
command that would be executed. Although curdir cannot be altered by the 
user, that does not mean it should be trusted for this purpose, because 
the file system may have changed after the current directory was set.

Consider:

   cd /tmp
   mkdir a
   cd a
   ln -s /bin/ls
   PATH=. command -v ls # should print /tmp/a/ls or /tmp/a/./ls
   mv /tmp/a /tmp/b
   PATH=. command -v ls # must not print /tmp/a/ls or /tmp/a/./ls

Printing /tmp/a/ls for that last line is worse than printing ./ls: ./ls 
may not be absolute but at least resolves to the command that would be 
executed.

bash does not appear to consider this requirement useful, so in 
non-POSIX mode just prints ./ls. In POSIX mode it prints /tmp/a/./ls twice.

ksh prints /tmp/a/ls twice, regardless of POSIX mode.

zsh prints ./ls twice, regardless of sh mode.

yash correctly prints /tmp/a/./ls, followed by /tmp/b/./ls.

My shell, gwsh, also prints /tmp/a/./ls, followed by /tmp/b/./ls.

I think leaving it as printing a correct relative path is better than 
printing a possibly wrong absolute path, personally. A change to print a 
correct absolute path would have my support though, for whatever that is 
worth.

Cheers,
Harald van Dijk
