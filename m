Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.181.231.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393496;
	b=VBZAE1mG2mv2qF5TKgxlbL/OtXaLKNmZs7JZWX20Sm59ZwrfHfHDcQVEHwbtkKOiNZNN
	 L1wQzpRmIqZYmven4kduPMJW4hMVeswBQIILR6R/jePz0txOn3T5enqmGZ9jLX6UcNdV8
	 iCQ/AJUWecRQ4raszoZEjwxdX9czxLzVj0agIjQ+2Xwwd89PHCCLivkH2gR577LQimtpU
	 QnJU73fxl/KpPSzQiSOwnhKcoLh1qegiPl2XR+/rBfQH/UWAMps9k0fBsZtT8j1N8uO6V
	 b94ul/WUrtqQHvlg8HKBJUJOlh2VgiU/u3tmnYJQ0AHBoU0XSDvcBC7lHwUkV0ep8OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393496;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=mTWEIqQr67FddiK88PHFlMv+9RXZ0OzucMZW6uOAqNY=;
	b=QIgagn/dMLkdyTp0w0yBN99XFRHC1VRIC/PXso7IjkSSaW7HfHjaCtcchXr4GB6WAcCt
	 Mu2DaayNzDhtLudy5d5ZY4h0pJbbPtAoThGWekHNYTRkzLp4lH0b71kOkPZwdofHndAUn
	 cuvQLvy2F5+zRd4qsjZVR2ad6HshfT66xGoMnawaiNR10NE78gAmwvROHf8GCAKMe8RCt
	 7H0FnZHWBPeX9LITlJUZrSLNZVlkV5UNb6yk0BhwN4LlDW3JkcFLZT4aP8QKVLCxVT3Yd
	 0wiTMONxxvHGNMkamlEVDxFFUSFatfF30cnqjiMHRFPVcM26LlMXbSoZAcS58D33oSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gondor.apana.org.au;
	spf=pass smtp.mailfrom=gondor.apana.org.au;
	dkim=pass header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=tAPnoAcV;
	arc=none smtp.remote-ip=180.181.231.80
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641F60A3834
	for <dash@vger.kernel.org>; Wed, 11 Nov 2026 10:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4641F60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.a=rsa-sha256 header.s=h01 header.b=tAPnoAcV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=mTWEIqQr67FddiK88PHFlMv+9RXZ0OzucMZW6uOAqNY=; 
	b=tAPnoAcVaObvaDCNqafVEUuykGzeOo/AierhtCVob+SIZVAeGPT7fHfgZurqyAOkI5yv2M9YHeR
	ilKB5moobeJRWD99GryHOA0NNMx3A4rnSEVsN3y6U+PSC78PBYUlBiKHinOHZN20OSTAxTfBqrxpF
	/6+R1HQD7DUe6t/GQNs+mEYMKQyhP5r+09cW2zxHLTCx6Q+HjH9MvBrM1IK4v71+2kaDSCJqkmDnJ
	gFrp5xGrWxdOHPbNDyEcxGO0Dm2gSWcg94UZR40fbFHkYcsOsJ3FcFk09Lg3DlpkwLvbdEOWxlIWi
	2Mcng3vmLfQ/5d01/3R+iIh+ZXLe4FXsfQmQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1xR5iU-0000000DlfM-42cG;
	Wed, 11 Nov 2026 18:38:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Nov 2026 18:38:10 +0800
Date: Wed, 11 Nov 2026 18:38:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Anders Kaseorg <andersk@mit.edu>
Cc: j.daubert@posteo.de, Dash <dash@vger.kernel.org>
Subject: [PATCH] expand: Drop incorrect CTLESC cast in argstr
Message-ID: <avRFkg95wTMWt9i8@gondor.apana.org.au>
References: <df9d5e861c3fc9bf6754fecc113616c1@posteo.de>
 <aPeKvExPB1HluHly@gondor.apana.org.au>
 <c6f2b0db-e5e3-483c-aeb2-eaabb574112a@mit.edu>
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Post: <mailto:dash@vger.kernel.org>
List-Help: <mailto:dash+help@vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dash+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6f2b0db-e5e3-483c-aeb2-eaabb574112a@mit.edu>

On Wed, Nov 11, 2026 at 12:51:43AM -0800, Anders Kaseorg wrote:
> There’s another instance of this in argstr() case CTLMBCHAR:
> 
>  		case CTLMBCHAR:
>  			c = (signed char)*p--;
>  			mb = mbnext(p);
>  			ml = (mb >> 8) - 2;
>  			if (flag & (QUOTES_ESC | EXP_MBCHAR)) {
>  				length = (mb >> 8) + (mb & 0xff);
> 				if (c == (char)CTLESC)
> 
> Since (signed char)CTLESC is negative, it never equals (char)CTLESC on
> unsigned char architectures.
> 
> Reproduction:
> 
> $ uname -m
> aarch64
> $ dash -c 'IFS=ë; set -- ${u-a\ëb}; echo $#'
> 2
> 
> (Expected 1, as on x86_64.)

Thanks for the report.  Please try this patch.

---8<---
CTLESC needs to be cast to char when it's compared against a char
value.  However, when it is compared against an integer that was
promoted from signed char, it must not be cast.

Reported-by: Anders Kaseorg <andersk@mit.edu>
Fixes: 6c44f4ee0c2b ("parser: Add support for multi-byte characters")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/src/expand.c b/src/expand.c
index 7ebb841..b0f6cf8 100644
--- a/src/expand.c
+++ b/src/expand.c
@@ -372,7 +372,7 @@ addquote:
 			ml = (mb >> 8) - 2;
 			if (flag & (QUOTES_ESC | EXP_MBCHAR)) {
 				length = (mb >> 8) + (mb & 0xff);
-				if (c == (char)CTLESC)
+				if (c == CTLESC)
 					startloc += length;
 				break;
 			}
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
