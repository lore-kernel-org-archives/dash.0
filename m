Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D8335573
	for <dash@vger.kernel.org>; Mon, 26 Jan 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430306; cv=none; b=ccheWihvKJkwfwCmszHVDJhjSgKmtF272REjOLLX919mjXKCboPDMQLG35oY0zI2Bm0sTyNJXm71dvo2RtjrT4jhZx03hpBAYiWwwXCQKnHuL/oA5RNB4rJr4dNlw0MmhN0C76IfcYjoDjurB7TDozTA7lVDHo3HkfPAJKZObcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430306; c=relaxed/simple;
	bh=SXD7WWQSEQsOMfWNKE4LzaVY/Tu3wL8iRhp2hfygbMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hij0toqR0fm8S+b/Xcn4c3hWul4d8wpUx+QbmO9RPVGG2GetnczsJGcmtQGVvg5VkrdWm3g7NYdQP9ECq0qz1W9wpTEnUx2E1odEy2SuqkCTctrGSa8Es6I6hDRePfQ/jlVba82/STxT/92YX8ovihB2V/6+wYEoIwq9nM7U6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=F94DjKRT; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="F94DjKRT"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl B768DA41E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1769429923;
	bh=y+tLukOYsIjefGjGMvo7WItbLBRiqaqT7gf636CT+NU=; l=1323;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=F94DjKRTIMXUtMkFpzZanVNgTXUGxbvq0i1KZ53euNfYT/jIrioe6F/Kbfqwjj5je
	 H/W8wN1v6vJ3kUlNuFyOgiGMcFNA/EeujQPhVal/g/cxXVL/3MpRI+buyry2ZsHUMU
	 13w+VVRVIgjWXGvsEPdOAlRXZibaPwIIBIakAbRs=
Received: by mail.gigawatt.nl (Postfix) id B768DA41E6;
	Mon, 26 Jan 2026 12:18:43 +0000 (UTC)
Message-ID: <c3fb1adf-0ac5-40d5-b116-8238beebc79a@gigawatt.nl>
Date: Mon, 26 Jan 2026 12:18:42 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dash 0.5.12 bug - POSIX process substitution $() handling error
 with embedded comments
To: Jari Aalto <jari.aalto.fi@gmail.com>, dash@vger.kernel.org
References: <CAOU7Hif8YDD-EAvqEV24_YAP5N32j=gh7zca=oXY8MfbUPQcYA@mail.gmail.com>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAOU7Hif8YDD-EAvqEV24_YAP5N32j=gh7zca=oXY8MfbUPQcYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/01/2026 11:55, Jari Aalto wrote:
> The process substitution is defined in POSIX and
> should work identically in both cases.

It is defined by POSIX in such a way that it is not required to work 
identically in both cases.

> COMMAND:
> 
> bash -x <code>

As your testing will have shown, bash and dash behave the same here.

> # OK
> x=`# comment`

This works because ` is looked up without regard to shell syntax. But 
POSIX says this is undefined:

> The search for the matching backquote shall be satisfied by the first
> unquoted non-escaped backquote; during this search, if a non-escaped
> backquote is encountered within a shell comment, a here-document, an
> embedded command substitution of the $(commands) form, or a quoted
> string, undefined results occur.

This is precisely the case that is made undefined: your closing ` is 
encountered within a shell comment.

> #  Syntax error: end of file unexpected (expecting ")")
> x=$(# comment)
This doesn't work because ) is looked up with regard to shell syntax. A 
) in a comment is treated like any other character in a comment, it does 
nothing.

To use a comment in a command substitution, ensure the terminating 
newline is part of the command substitution.

x=`# comment
`

x=$(#comment
)

Cheers,
Harald van Dijk
