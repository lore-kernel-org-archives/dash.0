Received: from freekahlil.inlv.org (freekahlil.inlv.org [46.19.33.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828619EEC1
	for <dash@vger.kernel.org>; Mon, 24 Jun 2024 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.33.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246248; cv=none; b=Y/vA7yb5EK05ugntrtPkuA9gTyIBTjz8hPBMBGa+wG6VDyR1BJYTSO4Yt27YqUD5SdZPFgBDos5FvQllF/LJVNnwwqsOmLYNy7TTNBnkweuGrLwGMWEl8ntY8CAN68WWzfszpzcFeJC8GZZ2drMo/ChWTlxAKCIxcTNEMvAUeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246248; c=relaxed/simple;
	bh=KsUhWC03xlo65dQa2YR/MsTdq0JWqsfdqDKRgtBBn0k=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=RUoOo13q9PP4+UrxQ92Y8paOrwBVEt4QPSv9F/nhT83nLTvUXATwnyMePVtfbaepuxWUyQPTMf+aGfpk7XtZgIqTaKw21CoZYi2yjbQitoxqUEBlTj3iCu8+n8DRP6nbV5zBY+InV7YyfC8JpX+9TR/PrSZHpSrtM7kboUKpuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org; spf=pass smtp.mailfrom=inlv.org; dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b=qRHApZz5; arc=none smtp.client-ip=46.19.33.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inlv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inlv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inlv.org header.i=@inlv.org header.b="qRHApZz5"
Received: from [IPV6:2a00:23c6:5398:5e01:8535:6a04:1e46:7dc6] ([IPv6:2a00:23c6:5398:5e01:8535:6a04:1e46:7dc6])
	(authenticated bits=0)
	by freekahlil.inlv.org (8.16.1/8.16.1) with ESMTPSA id 45OGNsM7047024
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO)
	for <dash@vger.kernel.org>; Mon, 24 Jun 2024 18:23:55 +0200 (CEST)
	(envelope-from martijn@inlv.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inlv.org; s=inlv;
	t=1719246235; bh=KsUhWC03xlo65dQa2YR/MsTdq0JWqsfdqDKRgtBBn0k=;
	h=From:From;
	b=qRHApZz5ZYa5zoT0dMFET22C1bw5YxhOlYWUifVtciImUoTwqEmdhP/Z6LhpNVV3S
	 V7bpGv067XVcUt1HwH5uejtEMt14W0wGp2x1VtNlIdZ3UJ47m56GbmfRXC6s3vydCB
	 tVXRZa+OhGUNFLlzRxLoF/fFgAWRq3CmdP0X+Fmw=
Content-Type: multipart/mixed; boundary="------------cmt0EEV0VD8lMYJTwWkn1v25"
Message-ID: <a64ad0a4-ea0f-4de3-aa2b-e377d3bef85d@inlv.org>
Date: Mon, 24 Jun 2024 17:23:54 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] fix build on systems without memrchr(3)
From: Martijn Dekker <martijn@inlv.org>
To: DASH shell mailing list <dash@vger.kernel.org>
References: <4ac525c0-f48e-4e27-87e2-9f1f8eb84434@inlv.org>
Content-Language: en-GB
In-Reply-To: <4ac525c0-f48e-4e27-87e2-9f1f8eb84434@inlv.org>

This is a multi-part message in MIME format.
--------------cmt0EEV0VD8lMYJTwWkn1v25
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 22-06-2024 om 15:25 schreef Martijn Dekker:
> memrchr(3) is non-standard, and has been ported from glibc to FreeBSD, NetSBD 
> and OpenBSD, but not to macOS, at least as of 12.7.5. So we need a test for 
> it. As far as I can tell, *name is a zero-terminated C string, so it should 
> work to use strrchr(3) as a fallback.

Reading the code more closely, that's nonsense, because 'p' does not point to 
the end of the string if metacharacters are found.

Guess the best we can do is provide a simple local fallback implementation of 
memrchr(3). Patch v2 attached.

-- 
||	modernish -- harness the shell
||	https://github.com/modernish/modernish
||
||	KornShell lives!
||	https://github.com/ksh93/ksh

--------------cmt0EEV0VD8lMYJTwWkn1v25
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
Li5lMzA1NmEwIDEwMDY0NAotLS0gYS9zcmMvZXhwYW5kLmMKKysrIGIvc3JjL2V4cGFuZC5j
CkBAIC0xNjMzLDYgKzE2MzMsMTcgQEAgc3RhdGljIGNoYXIgKmV4cG1ldGFfcm1lc2NhcGVz
KGNoYXIgKmVuZGRpciwgY29uc3QgY2hhciAqbmFtZSkKIAlyZXR1cm4gZW5kZGlyIC0gMTsK
IH0KIAorI2lmbmRlZiBIQVZFX01FTVJDSFIKK3N0YXRpYyB2b2lkICptZW1yY2hyKGNvbnN0
IHZvaWQgKnMsIGludCBjLCBzaXplX3QgbikKK3sKKwljb25zdCB1bnNpZ25lZCBjaGFyICpz
dHIgPSAoY29uc3QgdW5zaWduZWQgY2hhciAqKXM7CisJZm9yIChjb25zdCB1bnNpZ25lZCBj
aGFyICpjcCA9IHN0ciArIG4gLSAxOyBjcCA+PSBzdHI7IGNwLS0pCisJCWlmICgqY3AgPT0g
YykKKwkJCXJldHVybiAodm9pZCAqKWNwOworCXJldHVybiBOVUxMOworfQorI2VuZGlmCisK
IC8qCiAgKiBEbyBtZXRhY2hhcmFjdGVyIChpLmUuICosID8sIFsuLi5dKSBleHBhbnNpb24u
CiAgKi8K

--------------cmt0EEV0VD8lMYJTwWkn1v25--
