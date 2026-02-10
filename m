Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051331A0BE0
	for <dash@vger.kernel.org>; Tue, 10 Feb 2026 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770689329; cv=none; b=h2y7mi4yYH+SQmu7uG9rWvcaRTZSQ8S2TZsYo3fdTKW2BDpaRdDDorLWhC4UiPxGIrM2JvdmRH1iTl4gkXlt3SsTyKQwj9uce0ksnnhJ+lrVoK5L8RzZzhDv7NVh8NOm/WNaRQpdLeICawvF1R+idt93LVglQMKV+qCyMKffAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770689329; c=relaxed/simple;
	bh=WQwFAgrQxxjOPkpIXvaqP42Cps8NvYffUwQDEPT4ipg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CFpYm6qyMcDxUTZe8d922J51feXkW7MRdkO/SFFzpvYWWlZRnpP4K3zgAusR3QvEUZa0vsSkoLrCD5G0YW/K4YZaK+yNqQ9OE0LQI/IGzN6UxabKbM1WlYqqHOeKNzwJIzV5RjzZmDfmW+cBhVqwq+9/B+TKpmibcu/VYo90StU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=HVYYvaPR; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="HVYYvaPR"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C27FCA4393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1770688819;
	bh=LAYjzNiXPUFZzffoglPz4aysd304GHlYoYAUx1NH7M0=; l=1333;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HVYYvaPRmVseBuN9oV3cb4+mcSBeP1OD56uPFXVcNLBoJ18Z0q41bYJVeefS+u8pS
	 YRzyAJztw8JF5CAMdIqysdE9YNmZTarF009AUmvy34OSMW+77HqgZCF7AsXLk1SeU/
	 MA0Uo4xM5OREQjk9QNoUE4FF3l+TfMyuJi5JBPQw=
Received: by mail.gigawatt.nl (Postfix) id C27FCA4393;
	Tue, 10 Feb 2026 02:00:19 +0000 (UTC)
Message-ID: <f13da815-0438-44be-b224-a6f5c5ee4454@gigawatt.nl>
Date: Tue, 10 Feb 2026 02:00:18 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Surprising behaviour when reading from a named pipe and standard
 input
To: Earnestly <zibeon@gmail.com>, dash@vger.kernel.org
References: <aYqFr-Twb-njdsDh@teapot>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aYqFr-Twb-njdsDh@teapot>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/02/2026 01:11, Earnestly wrote:
> I came across this behavioural difference between dash and sh(bash),
> bash and zsh.
> 
> When attempting to read from a named pipe and stdin at the same time in
> a backgrounded process I appear to be losing stdin:
> 
>      #!/bin/dash --
> 
>      f() {
>          mkfifo pipe
> 
>          cat pipe - <&0 &
In both bash and dash, backgound commands have an implicit </dev/null 
redirection unless an explicit redirection is provided, but they 
disagree on exactly how that works.

In bash, <&0 suppresses the implicit </dev/null, meaning the outer 
environment's stdin gets used.

In dash, internally, <&0 is a no-op because redirecting stdin to itself 
shouldn't change anything. Because it is a no-op, it does not suppress 
the implicit </dev/null.

In dash, effectively, it is as if <&0 overrides rather than suppresses 
the implicit </dev/null: the implict </dev/null is performed, and then 
<&0 overrides that but at that point fd 0 is already /dev/null, so after 
that, it is still /dev/null.

I have mixed feelings on which behaviour makes more sense, but for 
better or worse this is something that portable shell scripts just need 
to avoid. You can make this work by temporarily duplicating stdin to a 
different fd and then back:

   { cat pipe - <&3 & } 3<&0

Cheers,
Harald van Dijk
