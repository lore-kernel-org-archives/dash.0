Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F201373
	for <dash@vger.kernel.org>; Thu, 28 Aug 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372338; cv=none; b=mvlXItUrcrJbuzjH3z1OiMTUrOFVxmnvNqSNzYAFMXDzuwSLlF2egbSZghAcXa8ZW1RHQ1CsrlGTv5ErNNY04Y7palG1WQ5cGqi6KCtW38BiBGFuMzP3gfJUk/w7aidBLdrL/aO1j6Foa5Ba5NJic+GFMv4nYf8aaiPGrT9+d9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372338; c=relaxed/simple;
	bh=l/pwVU2tF07SeZp9c4EWP3rnUywdSI4v3jwWakBHaYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBJCv0oIYpDrjhr4UNRw/WZeVstUjy5DQcgnrffly7hy5AFKp9k/AA2dkJpDYf9GP+hZNpirTIy5QLsiTa/F8eKqDxvPZMtV8JF4gP9a0VQ+zeI6891yL9CYCPJYMz8HavLVWutKF72acRdzQPnlENINmo7+S+2qmUVUd/sNv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=kL/9fAjB; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="kL/9fAjB"
Received: from [192.168.178.24] (unknown [31.94.68.85])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id E212311C3;
	Thu, 28 Aug 2025 10:12:05 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E212311C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1756372326;
	bh=X1nORgGRGBljSwZL2umsfTKoBtVJBN9wZ6KRTiSgMJ0=; l=498;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kL/9fAjBTc3IHS1xIqBmfOLp/LBfzeMVxni3FTIJRWVO+Ykbz59WsGMKzCo5WemJd
	 cUv7Ay1vzwwLiml8SeJeC3DHBg50hm3oO9ayMEXSMoRaF9//GfnePefzFuh9r8Gt4c
	 0/w9HhGZc7F7fpXSsAqmVehFZi8RWoIWAfe+l/qQ=
Message-ID: <b948f6b0-a7a3-4441-90dc-d1dc968700ac@gigawatt.nl>
Date: Thu, 28 Aug 2025 10:12:05 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin: Fix argv overrun in aexpr and oexpr
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Aleksander Ushakov <aushakov@astralinux.ru>
Cc: dash@vger.kernel.org
References: <aLAG4YtNOsfqcq1l@gondor.apana.org.au>
Content-Language: en-US
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aLAG4YtNOsfqcq1l@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/08/2025 08:36, Herbert Xu wrote:
> Aleksander Ushakov <aushakov@astralinux.ru> wrote:
>>
>> I think I fixed the problem here:
> 
> Thanks for the report.  I think the following patch should fix
> it too:

This patch fixes the buffer overrun but leaves the syntax error in the 
expression undetected, which is inconsistent with how dash treats other 
syntax errors in expressions, and inconsistent with how other shells 
treat missing operands to -a and -o.

Cheers,
Harald van Dijk
