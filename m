Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7313D53C
	for <dash@vger.kernel.org>; Fri,  2 Jan 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386899; cv=none; b=WLTzyljIfAmUssEx/jLHrxGL7N7136jTT1M+m/ffW2XwBjQOfcDpMXDztL9ntmIFMDQ0ntaadqVCKvvPf81RCP9wVOzpCY8IosLZk+LqDcxjizZc7uSfAlv+qx3odOozYqsb9+3lLZELqPIqmxXb6+UpA7l3fXs8IPkR0S5D3Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386899; c=relaxed/simple;
	bh=dLvLRAxwuHVgzZgvrE9O5iLH6FA3+j0g+GXg0my4xkg=;
	h=Message-Id:Date:From:To:Subject; b=a8G2+WDFUjI1sXb7LbJ+vb0N7rPT39EYQAbEi1k5SEVz/MbthPGN3g7RbZa2mAos/IuPr9h6DLeHzsvcTYjSqVw+ynwa/P36364p+ZtoK+r4hRVA6jvc44QtRfQBhtnORNnVmShoj985mrkVQ8RHjk5N41fVCBgUnjiV/WQZ/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VfAqrtoV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VfAqrtoV"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 09A20266FD;
	Fri,  2 Jan 2026 21:41:38 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yT79lHcbYdK6; Fri,  2 Jan 2026 21:41:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1767386497; bh=dLvLRAxwuHVgzZgvrE9O5iLH6FA3+j0g+GXg0my4xkg=;
	h=Date:From:To:Subject;
	b=VfAqrtoVS9NmwxZ7sgLYJu8fhTtigF/fN5eLTLq1Wicdf8oWJUk/G/VKsQikS8A9c
	 hbOxr3fyF45PUKWHW7ESpL9GiHRfH+Sl79xb7aas0+4OTlT+yhrMoqZCuN9kzw/ckX
	 aswmKDpcWE7HachkoGTLKBXMpHiTo3uyyDa8+nwCYucJ7zf13nY9W7e6BdsKEH4v+I
	 kTHBw0AWzrXs7xK1KLUa4yYidY8N1dsVP1MsRyWB3QSEWbCk0K2JmT8orEwqorX1Xu
	 lakGgHLu0p7BONsh0mRq3TZp6BBcaFi3Qj2dTeekgaqXuikG/Zz0PFR9FYRHeUl0Ei
	 LwZYp70bBdcfQ==
Message-Id: <KJFldfHRfPi3GtR2lgeOY1U4TdB3PqG4@disroot.org>
Date: Fri, 02 Jan 2026 20:18:25 +0000
From: avidseeker@disroot.org
To: Dash Mailing List <dash@vger.kernel.org>
Subject: fc -s causes infinite loop
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>

I'm trying to mimic zsh re-run ("r") behavior. The Posix way for that is
fc -s which works as expected in bash and zsh when aliased as alias r="fc -s"

$ pacman -Q dash
dash 0.5.12-1
$ dash
$ echo test
$ fc -s
test
echo test
test
echo test
test
echo test
test
echo test
test
echo test
test
echo test
....

Avid
