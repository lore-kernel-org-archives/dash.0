Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEDB19B5A7
	for <dash@vger.kernel.org>; Sat,  4 Oct 2025 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759578726; cv=none; b=RYL1ZAmD1drFwM3di1byeAcf6ECnGinwBA/3S0/8VmvZ2x8PcsXuAdMhTX22UjJ5PwN6J8In3DFNWcxdHgrWnEWyHrzloUimzw+ENSFGPjyRhNgJsB+J7JbpRxENNthxgjzxw8v0KEX6pWauUnmngxRcDEsWk5lAhnadEARKac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759578726; c=relaxed/simple;
	bh=V5GnbDSCBcu3Uy1lHP/eqXd8S+5olD5JS3Y9gUAUjGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vq1JxUMH6l/cOV4VSpO1sDEMCR7afgi7ZW/wDayiRU+sPrMtNJG6HkUiW/Z76np3z7vrtPGuyR4X/Zvx5xdhZTAOm6gb00MZoUbk76xYZA0/8Ql3FmV2gW6Baq/TOp1DOmOYtUxx2vqBcYYj/I06sFsWnDNf4Nc5ctCAXqJ84NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=YCOVlzBW; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="YCOVlzBW"
Received: from [192.168.178.21] (unknown [31.94.20.81])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 53B51140;
	Sat,  4 Oct 2025 12:42:31 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 53B51140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1759578151;
	bh=VUOQf7hPDibv0b/OSAzS3brcmh1S2D8a7iHjjROotuc=; l=974;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCOVlzBWo68NAMiXL+Jc0OSWCOURxd/Op8VOFFRgQueMneonOUa6OSv5ihSORkx5h
	 y4UWRNxlHP0vAI0fmi4HUF74aL6a/cbXTU4HCRpxKRnE1P6CHyAcVU06N6QZMxPj8q
	 ZUXiMX2/tcUw1DbzbVcg1BSRMWPs2M5EvCpOk1lU=
Message-ID: <ab0f8c73-ffac-4817-bd87-dcebe21453bd@gigawatt.nl>
Date: Sat, 4 Oct 2025 12:42:30 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: < "$@" doesn't expand properly?
To: Marc Chantreux <mc@unistra.fr>, =?UTF-8?Q?Lawrence_Vel=C3=A1zquez?=
 <vq@larryv.me>
Cc: dash@vger.kernel.org
References: <aOBSZYeG7UDIbOE6@prometheus>
 <5a1befb9-0617-40b0-9c53-7bf6452f0dcd@app.fastmail.com>
 <aODE8547kOvhQPIf@prometheus>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aODE8547kOvhQPIf@prometheus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 04/10/2025 07:55, Marc Chantreux wrote:
> * it's a matter of consistency to me. why "$@" can't behave as "$@" ?

The word that follows a redirection operator is one of the special 
contexts where operations that split words into multiple fields are 
disabled for it. Variable assignment is another. This is why

   foo='multiple words'
   bar=$foo
   echo $foo > $bar

writes the string "multiple words" to a file named "multiple words". The 
second line does not run a "words" command (as 'bar=multiple words' 
would suggest), and the third line does not create a file called 
"multiple" (as 'echo multiple words > multiple words' would suggest).

It is this principle that dash follows when it expands "$@" as "$*" in 
these contexts. I agree with you that if users want that, they can just 
write "$*" instead, but I do think that when users do write "$@" anyway, 
treating it as "$*" is the least questionable interpretation.

Cheers,
Harald van Dijk
