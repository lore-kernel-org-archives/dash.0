Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE23B19D
	for <dash@vger.kernel.org>; Sun, 10 Mar 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108011; cv=none; b=X7OJsSI3lX8YEPPjvMe+8IgxQHfgVuBmJSTreux6dMoaqktVCADHqxlWikxvAWLGCmdTBifO4y0BiaVp7pgKUbxs7ef+qCkv8Gq2ftAGXompLYSCtOqdGXTeqdPSD7Px7HWECgZN5e7/GNUxJ8kJD2gZV5opTwRt7NOehXuwxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108011; c=relaxed/simple;
	bh=zWTU039GES5T0LgmDWHMG6RwbQBXC9XjUTblDgAJJTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bnaWcRRYcHIFb1D1Ll+9Nf0r1YKBsFypx+xwYWbcI9acd6SyNX8QD5So43dAlfOdm0IAbH2XrmxEnEile8L9V6NP2HWZlZlTv+xCXAPVmdUedPytEHUfJI/V704oTZ55mMDmSVadFJXK+3l3IB6CWD2nGQrRtlkVZPitXUKWpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=fJlBVNbL; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="fJlBVNbL"
Received: from [IPV6:2a00:23c6:5398:5e01:c814:cd21:9305:1670] ([IPv6:2a00:23c6:5398:5e01:c814:cd21:9305:1670])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 42ALXp0f014781
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 10 Mar 2024 22:33:51 +0100 (CET)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1710106431; bh=zWTU039GES5T0LgmDWHMG6RwbQBXC9XjUTblDgAJJTA=;
	h=From:From;
	b=fJlBVNbL1HNGLugqlmVAgsUL9nkKe/JKeVbpvaUj6+g5ksG84OODFILiEkO1uZUpp
	 mQQ38s6fGv+PlPocnhP75We5oInnKenDR3zwR10vvGth3J9ETB34Mrqzhw7qPJjc+O
	 mtOq2l1ysdCJjE13xCqjd1b4+lJEKRhinh/MZK68=
Message-ID: <d307bc34-f8f4-43d6-9c09-76e02df7d02f@inlv.org>
Date: Sun, 10 Mar 2024 21:33:51 +0000
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wrong behaviour when unsetting/setting some variables
Content-Language: en-GB
To: Harald van Dijk <harald@gigawatt.nl>,
        DASH shell mailing list <dash@vger.kernel.org>
References: <43f0631aea36f6b49e5c3dfdfe481a5a2b1fec6c.camel@scientia.org>
 <ac893750-085d-421a-b296-a182ae51f1ec@gigawatt.nl>
 <0fd6f8b9-7175-4cc9-9d99-586beb3ede48@inlv.org>
 <252ec2b0-70dc-4621-96c2-285aa915cce0@gigawatt.nl>
 <4bcfdb66-c60f-4172-9f4c-cc25c3e99ddc@inlv.org>
 <6e4e70da-b137-44c9-944a-4b4eb4ef2174@gigawatt.nl>
From: Martijn Dekker <martijn@inlv.org>
In-Reply-To: <6e4e70da-b137-44c9-944a-4b4eb4ef2174@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 29-02-2024 om 18:56 schreef Harald van Dijk:
> Good point, though by special-casing getopts and read, it kind of 
> implies that it does not apply to other commands and utilities.

I'd forgotten I'd filed an Austin Group bug for this about two years ago:
https://www.austingroupbugs.net/view.php?id=1555

It was resolved that the text in the next version of the standard will be:

| Set the export attribute for all variable assignments. When this option
| is on, whenever a value is assigned to a variable in the current shell
| execution environment, the export attribute shall be set for the variable.
| This applies to all forms of assignment, including those made as a
| side-effect of variable expansions or arithmetic expansions, and those made
| as a result of the operation of the cd, getopts, or read utilities.
|
| <small>Note: As discussed in Section 2.9.1, not all variable assignments
| happen in the current execution environment. When an assignment happens in
| a separate shell execution environment, the export attribute is still set
| for the variable, but that does not affect the current shell execution
| environment.</small>

HTH.

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

