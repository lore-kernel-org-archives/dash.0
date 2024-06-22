Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8B9449
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719066329; cv=none; b=dbCcAXT7WP9dCp3f8SfvHEC3evnAzlInfiHd687H6LrnemWrRyrpGs67p/Fxy+l1G3PLx8IK28SxzxcN/5NT3otAqKNAGMr5WU9FRHfzvrts0kDIy29EIq2CoDsRBGS/8Zs8vzpHCLEh553HjYI5xFE0Z8DFmKGMGdTUwYvf1rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719066329; c=relaxed/simple;
	bh=htNbQFwW4JYkOW1R8eMxe443u6ipmhc4rOw+4Lb0aaA=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:To:Subject; b=f8NRofsxBmBzx7D6zTAt/D1e0nPT1rAOlR4+EWb6msuDZwtPqVuHcBfjfRwz5nKuI3kXNScxQv8MXc/Dc9E1VTDlCQhWzRUby62Kz+Jiya58Qo/xRT5NNPj3zsCYH56aLmFugxd0wFjAGg7+WwgmLqvatjLR4YEg775oshzxPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=dvoWRF7P; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="dvoWRF7P"
Received: from [IPV6:2a00:23c6:5398:5e01:4c17:9df7:7a66:fce1] ([IPv6:2a00:23c6:5398:5e01:4c17:9df7:7a66:fce1])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 45MEPF5j030702
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Sat, 22 Jun 2024 16:25:15 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1719066315; bh=htNbQFwW4JYkOW1R8eMxe443u6ipmhc4rOw+4Lb0aaA=;
	h=From:From;
	b=dvoWRF7PQC1fOQB8gkSGi/LTaIeIGmyi2nmljTY9djDUAV8NDKNSU8fLHIgL9oDod
	 6fS6buJFe++7MWbA212k0rtZdDsnN+Olz0r7rVgIhDUDUzGTmB6e60XexninEx3mX2
	 Vo4+Ye+NjJ2ntKpiETGmjEnTBlwHUA34LVgBrYnY=
Content-Type: multipart/mixed; boundary="------------9RaS5HFzVnMJdd6UlD96S0ox"
Message-ID: <4ac525c0-f48e-4e27-87e2-9f1f8eb84434@inlv.org>
Date: Sat, 22 Jun 2024 15:25:14 +0100
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
Subject: [PATCH] fix build on systems without memrchr(3)

This is a multi-part message in MIME format.
--------------9RaS5HFzVnMJdd6UlD96S0ox
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

memrchr(3) is non-standard, and has been ported from glibc to FreeBSD, NetSBD 
and OpenBSD, but not to macOS, at least as of 12.7.5. So we need a test for 
it. As far as I can tell, *name is a zero-terminated C string, so it should 
work to use strrchr(3) as a fallback. Patch attached (to avoid whitespace errors).

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh
--------------9RaS5HFzVnMJdd6UlD96S0ox
Content-Type: text/plain; charset=UTF-8; name="memrchr.patch"
Content-Disposition: attachment; filename="memrchr.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCAzMzhkNWJk
Li5iYTQ4NTZhIDEwMDY0NAotLS0gYS9jb25maWd1cmUuYWMKKysrIGIvY29uZmlndXJlLmFj
CkBAIC04Nyw3ICs4Nyw3IEBAIEFDX0NIRUNLX0RFQ0woW1BSSWRNQVhdLCwKIAogZG5sIENo
ZWNrcyBmb3IgbGlicmFyeSBmdW5jdGlvbnMuCiBBQ19DSEVDS19GVU5DUyhic2VhcmNoIGZh
Y2Nlc3NhdCBnZXRwd25hbSBnZXRybGltaXQgaXNhbHBoYSBraWxscGcgXAotCSAgICAgICBt
ZW1mZF9jcmVhdGUgbWVtcGNweSBcCisJICAgICAgIG1lbWZkX2NyZWF0ZSBtZW1yY2hyIG1l
bXBjcHkgXAogCSAgICAgICBzaWdzZXRtYXNrIHN0cGNweSBzdHJjaHJudWwgc3Ryc2lnbmFs
IHN0cnRvZCBzdHJ0b2ltYXggXAogCSAgICAgICBzdHJ0b3VtYXggc3lzY29uZiB0ZWUpCiAK
ZGlmZiAtLWdpdCBhL3NyYy9leHBhbmQuYyBiL3NyYy9leHBhbmQuYwppbmRleCA2OTEyZTM5
Li43YjA4ZTNkIDEwMDY0NAotLS0gYS9zcmMvZXhwYW5kLmMKKysrIGIvc3JjL2V4cGFuZC5j
CkBAIC0xNjg0LDcgKzE2ODQsMTEgQEAgc3RhdGljIGNoYXIgKmV4cG1ldGEoY2hhciAqbmFt
ZSwgdW5zaWduZWQgbmFtZV9sZW4sIHNpemVfdCBleHBkaXJfbGVuKQogCQkJY3AgPSBhZGRm
bmFtZWFsdChlbmRkaXIsIGV4cGRpcl9sZW4pOwogCQlnb3RvIG91dF9vcGVuZGlyOwogCX0K
KyNpZmRlZiBIQVZFX01FTVJDSFIKIAlzdGFydCA9IG1lbXJjaHIobmFtZSwgJy8nLCBwIC0g
bmFtZSk7CisjZWxzZQorCXN0YXJ0ID0gc3RycmNocihuYW1lLCAnLycpOworI2VuZGlmCiAJ
aWYgKHN0YXJ0KSB7CiAJCWMgPSAqKytzdGFydDsKIAkJKnN0YXJ0ID0gMDsK

--------------9RaS5HFzVnMJdd6UlD96S0ox--
