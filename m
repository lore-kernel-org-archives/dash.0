Received: from mail.gigawatt.nl (mail.gigawatt.nl [82.165.170.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6A1F4181
	for <dash@vger.kernel.org>; Tue, 27 Jan 2026 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.165.170.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769500165; cv=none; b=HJaWOc7dJdxT4sUkHGyt3TLwGFZHSQ/BsgkKOmrZa4iwwuIxV317Os5jw/otSWV3XFDaG7TzlDOV4z1IgK2+Nz0iOG1YfNYxPlP31//LZ8bGMs7qhi9IxlZfVgR4RZCd44nOk3/ewdYvCocrfzci75yXrW4dCmRcckVzSS3XWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769500165; c=relaxed/simple;
	bh=HZvPq3d8QgoA6qzH248AEwuXGCBn+z7FCKuMQGIWinI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YLuQvp2PnVviTBMmV3VloJ+qP9si6L+0m8OnCYSPnh19MqYlkRQ3MfPPG49cgGvyF6V5sOp2eBMj+kYJjhDQaVvJBje7BgB5aTVG0l+ejAnEndT2es7KPLwVf/bl4LYH7jQoKiGe19CgfCTZtvv3x2ldAV1k/Yse1fCKmm14Iq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=VfLTk6cW; arc=none smtp.client-ip=82.165.170.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="VfLTk6cW"
Authentication-Results: mail.gigawatt.nl; dmarc=fail (p=none dis=none) header.from=gigawatt.nl
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl AFAA0A006C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1769500162;
	bh=oPB4c1plZAreNPq+aTDu5y3ijclMLtzeBRZ03sffqIs=; l=414;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VfLTk6cWbGs6LdUfmbiMnvZPo2/iXwpPYveqTH6CIsaCY3MbiKRI8CX5ew60ytmk1
	 16/SZzOn2pVZJPsrJuWJtV7Ji09gj+upnS7Mt5C98QEWBrwbYpbZMsWhZHPnqOQzKo
	 BJ1W1AvjOjdxuOPDBhXRx6hOpCfkcS4s2jwlo3wM=
Received: by mail.gigawatt.nl (Postfix) id AFAA0A006C;
	Tue, 27 Jan 2026 07:49:22 +0000 (UTC)
Message-ID: <a3efe506-a5a6-417c-85ec-a8889b13c1bd@gigawatt.nl>
Date: Tue, 27 Jan 2026 07:49:20 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unreachable code in evalsubshell()?
To: Denys Vlasenko <vda.linux@googlemail.com>,
 DASH shell mailing list <dash@vger.kernel.org>
References: <CAK1hOcNHGv-7tkmD=XKw_oTy0s4NvZY0n1Mq4m_5_NX9miU2_Q@mail.gmail.com>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcNHGv-7tkmD=XKw_oTy0s4NvZY0n1Mq4m_5_NX9miU2_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/2026 04:26, Denys Vlasenko wrote:
>          switch (n->type) {
> ...
>          case NBACKGND:
>                  evalfn = evalsubshell;  //THIS IS THE ONLY USE OF evalsubshell
>                  goto checkexit;
> ...

The last line of that first ... is rather relevant though:

         case NSUBSHELL:
         case NBACKGND:
                 evalfn = evalsubshell;
                 goto checkexit;

evalsubshell may be called for NSUBSHELL and for NBACKGND.

Cheers,
Harald van Dijk
