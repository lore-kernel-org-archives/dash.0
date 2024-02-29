Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC8132C1E
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232966; cv=none; b=mhIvBtA9FHY9j6tEd785uRx9uFvOARLiCq6TY6FVfvnoQ6bax1OamKuoDVnEZj5+0OhsanLh5fCYoo0W8Vi7UAyeg/NJdraQqn21SfceJbe90FGAqpk+VtstkLM97eJB/BPRenH9NoKeB50C1qyb/Ow+YAZapjYdP+cZXig89t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232966; c=relaxed/simple;
	bh=I7XPBgU11n2gscVP1Jv2Vuow8J+zWA1rt8yVqSmt7ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fqu2HfUtU9Rnk61CxUR6vTGT2tzBfdopGReyu2ZvoAHdau5DrZKjizkU3W7W/K0mfr38q5RctTHbB2WLNPF0/DAmHZ74DwQXhyJ0G658PyUSGGsT5vpzbEkFdZjAhSsKr3MDXtSKIbVkasVDElUnFKybNQnayPTfdhwr2Y9j1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=P6HEM+vN; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="P6HEM+vN"
Received: from [IPV6:2a02:8010:68a1:0:e69:c5c8:93ab:b95] (unknown [IPv6:2a02:8010:68a1:0:e69:c5c8:93ab:b95])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 45B90162B;
	Thu, 29 Feb 2024 18:56:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 45B90162B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1709232961;
	bh=cXqFIUR4C0tzCqNumEwQ44FenOH6RU05b7UYQ7eE+vI=; l=2668;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=P6HEM+vNx/3LMwX1NVSkjPMY4/W9vxK2QTHWc7ch3eOcg+W8/c5HwVP4mZvremYCK
	 +YLxDFeftMIm2HQBEjECc5mH5t31cWwJHT10MoRqoh8w1eW6ThJ3zkUvtyaCfU32lF
	 MFn3Q91AAXwT2t3C0KX//vmAui+OnTa+jmkBimis=
Message-ID: <6e4e70da-b137-44c9-944a-4b4eb4ef2174@gigawatt.nl>
Date: Thu, 29 Feb 2024 18:56:00 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wrong behaviour when unsetting/setting some variables
Content-Language: en-GB
To: Martijn Dekker <martijn@inlv.org>,
 DASH shell mailing list <dash@vger.kernel.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
 <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
 <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
 <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/02/2024 18:45, Martijn Dekker wrote:
> Op 29-02-2024 om 18:07 schreef Harald van Dijk:
>> On 29/02/2024 17:41, Martijn Dekker wrote:
>>> Op 28-02-2024 om 00:56 schreef Harald van Dijk:
>>>> However, trying to fix this I come across a corner case where it is 
>>>> not clear to me what the intended behaviour is.
>>>>
>>>>    set -a; readonly foo=bar; export # some shells export, not all
>>>
>>> IMO, the shell should export it in that case; POSIXly, 'set -a' 
>>> should cause the variable to be exported whenever a value is 
>>> effectively assigned to it (whether this is by a "true" shell 
>>> assignment, an assignment-argument, an expansion like ${foo=bar} or 
>>> ${foo:=bar}, indirectly by 'read' or 'getopts', or maybe other cases 
>>> I'm not thinking of).
>>
>> Spec-wise, the thing that troubles me is that the option is specified as
>>
>>  > When this option is on, the export attribute shall be set for each
>>  > variable to which an assignment is performed; see XBD Variable
>>  > Assignment.
>>
>> where XBD Variable Assignment is only about the assignment syntax of 
>> the shell, not other syntax or other commands even if they also cause 
>> variables to become assigned.
> 
> Yeah, that's confusing (and IMO should be fixed in the spec), but that 
> same paragraph goes on to mention 'getopts' and 'read' as examples of 
> utilities that perform assignments. In other words, though 'read var' is 
> no XBD "Variable Assignment" assignment, it's stated explicitly that 
> 'var', on which 'read' performs an assignment, should gain the export 
> attribute.

Good point, though by special-casing getopts and read, it kind of 
implies that it does not apply to other commands and utilities.

Anyway, now that I think we are on the same page about what shells 
*should* do: in dash, a quick search suggests this should be the following:

* Substitutions may perform assignment (the ones you mentioned, plus
   $((...)) arithmetic)
* The for command performs assignments to the loop variable.
* The cd command sets PWD and OLDPWD.
* The getopts command does not merely assign to the specified variable,
   also to OPTARG and OPTIND.
* The local and readonly commands perform assignments to specified
   variables.
* Every command causes a value to be assigned to LINENO.
* Every simple command causes a value to be assigned to _.

The way I implemented LINENO, the implicit export does not work for 
that, and for consistency, it should, even if no one is going to be 
relying on that. I have not gone over the other ones to check if they 
are all handled correctly.

Cheers,
Harald van Dijk
