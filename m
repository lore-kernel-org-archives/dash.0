Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62C7826D
	for <dash@vger.kernel.org>; Thu, 29 Feb 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230073; cv=none; b=QnR2XU3o3T2S1XOgW/790vPiEPACAOpO5+JdRHXDWgga82tBI6WT4a5PC6g2MGxdMyNY22u8Y+Xqqfq3Lq1soznWHX0hJHO0nuh0PuADqjnjusIBcUaNxg/x3vQbTJ4tomqq1+Uom8ZVpubr+Tkc/ZoF6ULb3tuAcO8dkrrwH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230073; c=relaxed/simple;
	bh=HdyB0TNGXhqMHUeGelYK/NasZKzl1GASnAq0M+eQBG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PpV0St78PUUZN73FzcO40sfRu9msF2Qp0S1wRGFCBMBsGgEdu4RCMjcFBzsVyse3D7P512cPOpdMqB5cquIhU9r7SnhSYuhCZ+vhjMhdUa1tJ0n9CCzgl4YDB9qaiG2GFqd3qVfRo7leXCp7N0Viw/qQqymT1cyazv6YPBsGihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=JtJvYlbp; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="JtJvYlbp"
Received: from [IPV6:2a02:8010:68a1:0:8e44:96bc:3b05:fbd0] (unknown [IPv6:2a02:8010:68a1:0:8e44:96bc:3b05:fbd0])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id 0B64272C;
	Thu, 29 Feb 2024 18:07:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 0B64272C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1709230062;
	bh=rtWSsCprrDIi2CqYO+MKNQtXQtujdtpY40rAfTUna6k=; l=1483;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JtJvYlbpE3eEURY3xhyzvn+Yeh/oHgD4tf2dRw5BaPVCin11dUgqZZedP8wcvbBC2
	 uP7n1kcVMzrAUkMTceaPrFWdm95RyaacqQog/o4N6ujM1iltjB5kxoZPpLH0nyvhtu
	 NmbokBfupsb0dO4agif49Tt/pOe2BN6On+ELBijc=
Message-ID: <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
Date: Thu, 29 Feb 2024 18:07:40 +0000
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
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/02/2024 17:41, Martijn Dekker wrote:
> Op 28-02-2024 om 00:56 schreef Harald van Dijk:
>> However, trying to fix this I come across a corner case where it is 
>> not clear to me what the intended behaviour is.
>>
>>    set -a; readonly foo=bar; export # some shells export, not all
> 
> IMO, the shell should export it in that case; POSIXly, 'set -a' should 
> cause the variable to be exported whenever a value is effectively 
> assigned to it (whether this is by a "true" shell assignment, an 
> assignment-argument, an expansion like ${foo=bar} or ${foo:=bar}, 
> indirectly by 'read' or 'getopts', or maybe other cases I'm not thinking 
> of).

Spec-wise, the thing that troubles me is that the option is specified as

 > When this option is on, the export attribute shall be set for each
 > variable to which an assignment is performed; see XBD Variable
 > Assignment.

where XBD Variable Assignment is only about the assignment syntax of the 
shell, not other syntax or other commands even if they also cause 
variables to become assigned.

That said, I think I agree that this just does not make sense, and even 
if the spec says this, it is not what current versions of shells 
including bash and dash do, so even if my reading of the spec is 
correct, that makes it a spec bug, not a shell bug, and dash should not 
change behaviour here. (Of course, the originally reported bug should 
still be fixed.)

Cheers,
Harald van Dijk
