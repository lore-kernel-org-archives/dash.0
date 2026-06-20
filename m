Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F3CA6B
	for <dash@vger.kernel.org>; Sat, 20 Jun 2026 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923917; cv=none; b=fm3ssxQxYfThGyFeZmcv9kT+ISUzXRdgf8U/+EacLo6YeMyKDHkaZJ8YEZDLdhf2/9MGGi21FWkQJbA2rKVwVsrkAeG2ysRx07cA8nA8kbGnyUyGhoW9DjTVPrfJdfYuWYnVDj6b1M2ByZ2fc+otKG99nayDVbWNCtIg/tx0AqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923917; c=relaxed/simple;
	bh=YuenKzctBH1e2R02zTcdnXyHlry8MuAVnN8WfYP0LS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPT4H+o4AF5U/QHOXDuzmX7tBSdvXSjwtk7V1Ut7freI7fXyuBVXI9yJUz8oLQgU0s4a8PF790cDps/9JqfmvEBzHnDcJpl+xtD/Eiq44K+nrVXvAcJmAP+Q3W0p0xFRoItaZZ3XWgHHdjH6EXvU6RPVmlqPNHJE0qnevKTezjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=j2wvguB0; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="j2wvguB0"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 0684FA0A76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1781923908;
	bh=eqXBF7VNhH+GkMyUyOHdrB+zoiu3NKDDpSWbrhj9Y/E=; l=1072;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j2wvguB0YPfm3hMXHMGHsBYBPuq+O7Nzy1UAxtYGYtTjvJ77WAYPvlDPDlJuA43m6
	 N0qYl9dMfqqXr0ez1yLA1d6Yp1UGTWPIqu/IF9I1x3dM3ZVDVrIXV0xdbRfDVHLID5
	 R2+RekO/gHpTffftT5c9EP69Z5/iby9mgqkSr8Gc=
Received: by mail.gigawatt.nl (Postfix) id 0684FA0A76;
	Sat, 20 Jun 2026 02:51:47 +0000 (UTC)
Message-ID: <5a68f305-572f-4691-9984-2a502e468b9c@gigawatt.nl>
Date: Sat, 20 Jun 2026 03:51:47 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The read builtin erroneously consumes null bytes
To: Alexis <flexibeast@gmail.com>, dash@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
References: <bf5516e9-e59f-444a-81c6-7b112b71563a@app.fastmail.com>
 <87h5myx9ji.fsf@gmail.com>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <87h5myx9ji.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/20/26 02:52, Alexis wrote:
> "Kerin Millar" <kfm@plushkava.net> writes:
> 
>> Consider the following test case. It demonstrates NUL being consumed 
>> by the read builtin, rather than by cat(1) as it should have been.
>>
>> $ printf 'a\n\0bc' | dash -c 'read x; cat' | od -An -t x1 -c
>>   62  63
>>    b   c
> 
> POSIX doesn't require a `read` _builtin_,

It is not possible to implement the read utility as an external utility 
because the read utility is required to modify shell variables, so 
effectively it is pretty much required to be a builtin.

>                                           but for the `read` _utility_, 
> it says:
> 
>> STDIN
>>
>> If the -d delim option is not specified, or if it is specified and
>> delim is not the null string, the standard input shall contain zero or
>> more bytes (which need not form valid characters) and shall not
>> contain any null bytes.

The input to 'read' does not contain any null bytes. The input to 'read' 
is just 'a' followed by a newline and 'read' is supposed to stop reading 
after that.

Cheers,
Harald van Dijk
