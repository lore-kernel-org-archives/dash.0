Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164F1E4AB
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719066915; cv=none; b=epjkpdK41oAubeV+R95SHSg0VYQpjkAlHjnMvrYFMvRCvrNCs+wP3G4pnnHMVHWijoc4IEsAnXpe7fUhsP/HTDOvhp/sv7yKdKsDh1brwtAYsb7FERifx06zBrq+mp5LwQ4w1ZMQimOFdF6N8V7asePCCJnVYQ4LNRgmyAM///E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719066915; c=relaxed/simple;
	bh=pqf/ZyqB7MmCRYCq5cGfdb+xyXo/WuKJFQNwJSaXCRE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=MjBdIzOAMQIfHtudRUqkSp89rFhIW4Z/BH1cC5svdMFdmaZxV1/eCWxy3aMAZHZRSA3hwf9ZD29bTZxBhxk7yzWE3U7GUdEagkjcc2kJWsMBmSf1hv0Ecmf4C+MqJT56EXNG4gK3etDVyO9hKAuBU2wq96iHGkVi8SvPjNUt5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=R0cRaDeW; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="R0cRaDeW"
Received: from [IPV6:2a00:23c6:5398:5e01:4c17:9df7:7a66:fce1] ([IPv6:2a00:23c6:5398:5e01:4c17:9df7:7a66:fce1])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 45MEZ8Nk030858
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 16:35:09 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1719066909; bh=pqf/ZyqB7MmCRYCq5cGfdb+xyXo/WuKJFQNwJSaXCRE=;
	h=From:From;
	b=R0cRaDeW06bMbA9W1IrhpVsOJt48TqklJCCWtsu5UgOyyLahyxF0RaAHPlDsLJ8MJ
	 TxvnzW1fxsgKJqnSBUvq0vbJqFcRouxkY6cYB7CRMg9cGetnsOPVTp+4D7SykM1Pm1
	 R3NfUOWmwXPpWwJROZXG3er5H+3Lt1IjIAdiONrE=
Message-ID: <6bf6cd67-7125-4d1f-8673-110e026fbaa5@inlv.org>
Date: Sat, 22 Jun 2024 15:35:08 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Martijn Dekker <martijn@inlv.org>
Content-Language: en-GB
To: DASH shell mailing list <dash@vger.kernel.org>
Subject: [BUG] 'case' broken for multi-byte characters
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

As of this commit:

> commit c5bf9702ea110bede687b57c0b5fa3fd0e15829e (HEAD, refs/bisect/bad)
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Sun Jun 2 09:28:59 2024 +0800
> 
>     expand: Add multi-byte support to pmatch
> 
>     Add CTLMBCHAR support to pmatch.
> 
>     POSIX equivalence classes and collating symbols are not unsupported.
> 
>     Enable CTLMBCHAR generation in mbtodest.
> 
>     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

...'case' is broken for multi-byte characters. The following test script, when 
saved in UTF-8, outputs 'BUG' instead of 'ok':

case "ρ" in
( "ρ" )	echo ok ;;
( * )	echo BUG; exit 1 ;;
esac

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
