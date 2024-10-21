Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC320309
	for <dash@vger.kernel.org>; Mon, 21 Oct 2024 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487407; cv=none; b=JF53N4lis950Ies1DuTU3Uw0YjyH8e/pzT2PIkrsr38dQEcLyVQxVPIOD030IGyOgbBeODMC4UDmwhJXhJUdWAh0Vzxc/tyV30eGvsAOG6/TafNylPa19ggS205QzKPeLdZlqOQBaMvAPYfemY1J3JsBDYTJHynpynY4AsVDO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487407; c=relaxed/simple;
	bh=mrwHyYakUGpAKd68yyk2wsI/KaRdS9lUAPMpCjtdQck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URs6cSOrCi0koNrp/ineksKawFt4pdqUa6cb41yxcc+AymajD938JlF/eMHwhU84ZbAk+m+qB+xTKAkzZRLav3/cSwrdS0YIglFSrgenKayuG3FOUE0WEndJwrkwCU8pUt97MShWqA0l38Ak9kyC1QFQJgwM/+brtQciR11dBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=GvwvoTx8; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="GvwvoTx8"
Received: from [IPV6:2a02:8010:68a1:0:25fe:51e5:a2b1:f3e6] (unknown [IPv6:2a02:8010:68a1:0:25fe:51e5:a2b1:f3e6])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id E0F2188;
	Mon, 21 Oct 2024 06:01:53 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl E0F2188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1729486914;
	bh=wJBIKNm0N+vxWEq6TRfI89uFAzpkUDrvF4nn1oPcIFQ=; l=812;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GvwvoTx84PKe7SZ9iqkT4kPd8DAgc4Llq3LOS+c6GKfeskp2sZhyvJ4IuGFtDLCT8
	 ZOwldlXUaAhn2s+MrnCYmz+tl+/IgWRpNJCXthzE8ltnuF+y1qzcwPmeDOVDD6I4dv
	 vZgxg3hX9Nxmd7N8RfGySolbGDTxqRbJFk2hR50g=
Message-ID: <ffa48796-347b-4a7e-8cb3-c47f22fab897@gigawatt.nl>
Date: Mon, 21 Oct 2024 06:01:53 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IMKrIGVjaG8gJyJcJHonIMK7IOKAlCBkaWZmZXJlbmNlcyBiZXR3?=
 =?UTF-8?Q?een_dash_and_bash_in_POSIX_mode_irrespective_of_xpg=5Fecho?=
To: Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>
Cc: dash@vger.kernel.org
References: <ZxXZ0Omt_GWMh2DN@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <ZxXZ0Omt_GWMh2DN@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/10/2024 05:34, Herbert Xu wrote:
> Дилян Палаузов <dilyan.palauzov@aegee.org> wrote:
>>
>> I download https://ftp.gnu.org/gnu/gdb/gdb-15.2.tar.xz and run there ./configure . configure has on line 19728
>>
>>    echo 'cat >>"\$ac_tmp/subs1.awk" <<\\_ACAWK &&' &&
> 
> The issue is that echo(1) with a backslash character is not portable.

This particular use of echo with a backslash character used to work the 
same way across shells and is widely used in configure scripts in a 
large number of packages (specifically: any that use AC_SUBST_FILE). It 
was changed by commit 776424a8 (parser: Add dollar single quote) without 
that commit indicating that this would change; are you really sure this 
should not be viewed as a bug? The impact will be massive.

Cheers,
Harald van Dijk
