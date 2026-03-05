Received: from sender-op-o11.zoho.eu (sender-op-o11.zoho.eu [136.143.169.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB1273F9
	for <dash@vger.kernel.org>; Thu,  5 Mar 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674349; cv=pass; b=Xiz92RfgreuR6DVQar8b4DuFX67nqQAvWzoUjukXsXEMdNpdwVIGQIeLD+r0wcnomRl2xAWC6CxRkjrsY4PlOU+FRavMNaugfwIXzl9Hf+CH0ISOyOsQi0YZCDd0MjCtkjm/vwiC/FRJmcR0FPQTRx7m/jd53r1uagB41oY8Y9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674349; c=relaxed/simple;
	bh=pRHf3RggSlzFBULbeKtubuGH+4rnqBPltnHb+orRNEs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aQVLivszOh6sTzsPLGi7RHyl4PFgtoE/aFnqjdfYKAvf3H3BXpt7MMtkP9tAlx22w3+6QtEQr/pE8OH2cTBexTRxYcRG5s2+VhtEGl/3FmuL3HsBoupY+f0DpnizOzg0163/Beg0fI2GDb4Px9RpX3ZFF/NHdpeozcUghGyIyj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=placeviolette.net; spf=pass smtp.mailfrom=placeviolette.net; dkim=pass (1024-bit key) header.d=placeviolette.net header.i=dev@placeviolette.net header.b=rVnRlGdB; arc=pass smtp.client-ip=136.143.169.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=placeviolette.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=placeviolette.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=placeviolette.net header.i=dev@placeviolette.net header.b="rVnRlGdB"
ARC-Seal: i=1; a=rsa-sha256; t=1772674335; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ECO1AZMMmu7y6TzrruNDfZ+7v2xQ77jaDatqOW/HwrtiWB3aYk1SzD+s1nm4MTJaOsBXGMFrj7rYrrSRgDFerHuYRsW8VNoGkUvO8jDl8hsFvF3sTUrRVNagQb6fPEaDcxh85U9XwzduHWHDN/enrZS035kSKYhdwW1h+y982bo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1772674335; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=xKlhR3FUfHgOcDcX37zvYH6UotYzGrgr6rr39FhYjW4=; 
	b=gTOm692T9LdKvKzblScBEmn4oysZbDmLrgmaMjjmGmAHWwkfBaADWzkaxRQQZ9CuZ7T3gxZleMD62pjI+R9QEScX4/mttaP8TkMfJMAkPYe7wq2GtnZCoiRMGlodtA+aMERCeZiva1GMKe1qMsyBaYkiSBG9hKE7rDnmJC3WwpU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=placeviolette.net;
	spf=pass  smtp.mailfrom=dev@placeviolette.net;
	dmarc=pass header.from=<dev@placeviolette.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772674335;
	s=zmail; d=placeviolette.net; i=dev@placeviolette.net;
	h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xKlhR3FUfHgOcDcX37zvYH6UotYzGrgr6rr39FhYjW4=;
	b=rVnRlGdB71DQR+t5+pOg8qED/aO0LQLfHWF305mnha5xbvADp7efkWryM2ZVFHpd
	kEqhM8RQ1IEBKz1gfWIzDk/cSgybr3ETaj/Qx2fCdcDzeA2wl3Z9aP+IJDMP82mJhxZ
	Qz27BtpomzOU2dc+eydENkFw5xF9RKnZ1sPtnaGM=
Received: by mx.zoho.eu with SMTPS id 1772674333240889.0443257379213;
	Thu, 5 Mar 2026 02:32:13 +0100 (CET)
Message-ID: <11d5b164-f43e-4f8d-a3cc-895199bfe01c@placeviolette.net>
Date: Wed, 4 Mar 2026 20:32:10 -0500
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: dash@vger.kernel.org
From: classabbyamp <dev@placeviolette.net>
Subject: regression in parameter expansion with backslash escaped strings
Autocrypt: addr=dev@placeviolette.net; keydata=
 xjMEX5IvahYJKwYBBAHaRw8BAQdA6NvFAx7PdhZQy7XckUUC9KGeovQVfupAuStCWTeRqW/N
 JGNsYXNzYWJieWFtcCA8ZGV2QHBsYWNldmlvbGV0dGUubmV0PsKQBBMWCAA4FiEE6G0BZreX
 oeBx+e0Ea+B1WRikx/UFAmJMb/QCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQa+B1
 WRikx/VsBgD/X7zSJGjTcGosID+FUPTGttFyWaCYA1ARCHIeZ8Ae60MBAIIs8hVcgeaMt1tz
 BfUMRF00se++9IKaH8hAKoHklNcDzjgEX5I1/xIKKwYBBAGXVQEFAQEHQM+52k4NS7RGNFfY
 Tm/q8zp/6CJTXi5QkbE+s3E+iv0hAwEIB8J4BBgWCAAgFiEE6G0BZreXoeBx+e0Ea+B1WRik
 x/UFAl+SNf8CGwwACgkQa+B1WRikx/UoJwEA/hvtaeX9ZKBRCQ8uXsarfUk8G2pAwsb7fqLk
 BJmXvHsA/RnFexepvkpvn91JdDy+P7mxFMWDFU8z5f7/3BAzqE8D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

dracut-ng reports an issue with dash 0.5.13.1, where parameter expansion 
of strings containing backslash-escaped sequences interprets the 
sequences. This behaviour was bisected to
776424a8f9158bfe9f53aa55f931af9f73437caf parser: Add dollar single quote

A simple reproducing case is:

#!/bin/sh

str_replace() {
     local in="$1"
     local s="$2"
     local r="$3"
     local out=''

     while [ "${in##*"$s"*}" != "$in" ]; do
         chop="${in%%"$s"*}"
         out="${out}${chop}$r"
         in="${in#*"$s"}"
     done
     printf -- '%s' "${out}${in}"
}

str_replace "/dev/disk/by-label/dracut" '/' '\x2f'
echo
_name=$(str_replace "/dev/disk/by-label/dracut" '/' '\x2f')
echo "_name=$_name"

In bash and dash 0.5.12, this produces:

\x2fdev\x2fdisk\x2fby-label\x2fdracut
_name=\x2fdev\x2fdisk\x2fby-label\x2fdracut

In dash 0.5.13.1, this produces:

\x2fdev\x2fdisk\x2fby-label\x2fdracut
_name=/dev/disk/by-label/dracut

Github issue: https://github.com/dracut-ng/dracut-ng/issues/2280

-- 
classabbyamp

