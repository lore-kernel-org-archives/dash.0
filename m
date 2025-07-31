Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F2B3C38
	for <dash@vger.kernel.org>; Thu, 31 Jul 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998203; cv=none; b=LNQNrEJF+dkpLiOKw5rbWpN+PWTm3VXV8TBIO6upNlhKJErCdvkDOlWgbE6v2ZcfBE9O4xk/MWPm9rj4ahLPIhEnOxIeqbNi0+PmGZstZ37iN19fEA1wYQSS6mA10XDZ3MQDFFuJHxXovcDqRBbyPw2l/+X5iwXfeX6kf+UsBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998203; c=relaxed/simple;
	bh=MQcWPYiSlf/t7382Imkqm+tlxw88ZYVpeMq5CkN5YTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l3Xyfj6uNgNjrG6Yo3J8vt4gbqa0KclwAxJK8/dLyvh/dhAU+BUp9DuD8CPU1EfGQeVjD06EDaIr5H3tRFLwxtifUFAkxx/h12ln2pUbEJzuga1qQPtlUqTE2iH6bYwclYcryU8OSks+ApHWE2zkRG546mph2X5QL3/QfqH8Yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=UyjLDHjZ; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="UyjLDHjZ"
Received: from [192.168.178.21] (unknown [31.94.68.113])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 856BB140;
	Thu, 31 Jul 2025 22:43:17 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 856BB140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1753998197;
	bh=2u4DO1vQWwT5hKMtsFO+h38Ubf8f26yFrhsq7hNl3hg=; l=1444;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=UyjLDHjZ/Baf0lIJvGF4ihGSOk4SBCOzI445x5pjCATZmrSASXVDFNQd+hRtk+gnA
	 rdoYJT6i52SEb9fmR2DdjrGO283yNVy3+khe4aJYPENmQdZ+vP9ODPmM05StJJKZ45
	 d/02SgjNMip8Ux1ordscQ5CvBg2fA8lCvG0FGshE=
Message-ID: <d233671c-473d-4e76-84ac-4e780e8d15ee@gigawatt.nl>
Date: Thu, 31 Jul 2025 22:43:15 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] applying zero offset to null pointer growjobtab()
 src/jobs.c:819:34
Content-Language: en-GB
To: Aleksander Ushakov <aushakov@astralinux.ru>, dash@vger.kernel.org
References: <02afc2e3-b996-4ab1-8b92-c79bcf8d789c@astralinux.ru>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <02afc2e3-b996-4ab1-8b92-c79bcf8d789c@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/07/2025 19:12, Aleksander Ushakov wrote:
> Hello Dash maintainers,
> 
> I encountered a bug in Dash in commit b4ef25d7 and would like to report
> it. The details are provided below.
> 
> 
> jobs.c:819:34: runtime error: applying zero offset to null pointer
>      #0 0x5adb67991deb in growjobtab /upstream/ubsan/dash/src/jobs.c:819:34
>      #1 0x5adb67991985 in makejob /upstream/ubsan/dash/src/jobs.c:774:9
>      #2 0x5adb679937a8 in vforkexec /upstream/ubsan/dash/src/jobs.c:992:7
>      #3 0x5adb6796edcc in evalcommand /upstream/ubsan/dash/src/eval.c:916:9
>      #4 0x5adb6796c0ac in evaltree /upstream/ubsan/dash/src/eval.c:305:12
>      #5 0x5adb6799818c in cmdloop /upstream/ubsan/dash/src/main.c:246:8
>      #6 0x5adb67997e4b in main /upstream/ubsan/dash/src/main.c:180:3
>      #7 0x7a95463ad249 in __libc_start_call_main csu/../sysdeps/nptl/ 
> libc_start_call_main.h:58:16
>      #8 0x7a95463ad304 in __libc_start_main csu/../csu/libc-start.c:360:3
>      #9 0x5adb6793a930 in _start (/upstream/ubsan/dash/src/dash+0x42930) 
> (BuildId: bf877a87a1c989c4907f14ce16668321dedc5edd)
> 
> SUMMARY: UndefinedBehaviorSanitizer: nullptr-with-offset jobs.c:819:34

I believe this is covered by the same retroactively applied language 
change as the mempcpy issue you reported. That is, this is valid code 
now and sanitizers need to be updated to no longer flag it.

Cheers,
Harald van Dijk
