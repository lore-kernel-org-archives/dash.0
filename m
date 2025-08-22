Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD435959
	for <dash@vger.kernel.org>; Fri, 22 Aug 2025 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826388; cv=none; b=UqlYKwN5VPEwuonP6HJGAu2idOi5POE+x79RuAsRY2VTeyyjCjfsUcG0rixZotkfFs1H7jMj3fIUsv9Aq+4iYfLXdCK+3xjAF62DVBNFUfNj96RJxvRoLmqqj6cwVrPE+gZ1DUU6Hld8N0GBK1WR20NB3q9Sb5UJuzcYge17+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826388; c=relaxed/simple;
	bh=12HiyhH7wb+A3BV0r8VPmY4V5COap4pojAWipuYsNJE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=NV8eAl5GhtkCp4SSmi6CyoEDuCDvmpdsh/KGPu6Jdrin2lBl9EsEUMAIN+dYKEafPFIIU8ARYW7Q7on3vEAKSRpvX/U1KBYII9igcpSsagRRpOmEaaFjooinAj9y5dM0Y+BvNn5CGy+K77bh2Wae0ZxJQDxEQOym9f25CojsbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=Hbmgb4mm; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="Hbmgb4mm"
Received: from [10.96.0.5] (185-177-124-88.hosted-by-worldstream.net [185.177.124.88])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id A79D691;
	Fri, 22 Aug 2025 02:32:55 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A79D691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1755826375;
	bh=RVjCnKNrUniMEcWM1bPdnmq3UyNnfo5EDhMgc7eGmGM=; l=3632;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Hbmgb4mmewTA0aBFQIf5Rsxfmfjoq0+jcF0tmanGU36ErQrMBfZnTa4Qgj/plEpVj
	 2BQh2grd4enMDyRQTqyb9M2RgAOu5hA3hOmLVPd/EpWCAVIduNWTe33bXUJUlEo3jX
	 qpF+0MQPeMXU/rzFn3lEVHMRe6p/YSHqcXyWt4T4=
Content-Type: multipart/mixed; boundary="------------EIP0eezQEe9qMUK0w6A3R4ym"
Message-ID: <44569fdb-3c8e-431f-9e26-25259bd268fe@gigawatt.nl>
Date: Fri, 22 Aug 2025 02:32:54 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Looking at "int vforked" in signal handler is racy
From: Harald van Dijk <harald@gigawatt.nl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
References: <dadfa485-b5ee-30d7-7154-362cf2eb04cd@redhat.com>
 <031e429e-e20c-4856-91dd-aedef155aae5@gigawatt.nl>
 <559d8542-bda1-15a0-2e68-9b3ea04db2e7@redhat.com>
 <b6a063f8-9844-4f81-90a8-0f65e7c819bf@gigawatt.nl>
 <aJl4_WsQeHF6PI0N@gondor.apana.org.au>
 <c03cf64c-5e12-4317-861e-16a0bf413d95@gigawatt.nl>
Content-Language: en-US
In-Reply-To: <c03cf64c-5e12-4317-861e-16a0bf413d95@gigawatt.nl>

This is a multi-part message in MIME format.
--------------EIP0eezQEe9qMUK0w6A3R4ym
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/08/2025 13:58, Harald van Dijk wrote:
> On 11/08/2025 06:00, Herbert Xu wrote:
>> On Sun, Aug 10, 2025 at 11:20:40PM +0100, Harald van Dijk wrote:
>>>
>>> That approach seems solid to me at a very quick glance. I think you 
>>> don't
>>> even need separate have_vfork_sibling and vfork_parent_pid variables, 
>>> just
>>> make the existing vforked variable a pid, or 0. A mostly untested patch
>>> using that:
>>
>> Looks good to me.  Could you turn this into a patch please? If
>> you could run some quick speed tests on this versus the existing
>> code that would be even better :)
> 
> It will be a little while before I can do meaningful measurements, but I 
> will do so when I can.

The impact on config.status --recheck, measured by running it 100 times 
with the patch, 100 times without, and averaging the run times, reveals 
that the impact is so low it is lost in the noise, and not even clear it 
is beneficial. One attempt showed an average of 2.225s without the 
patch, 2.221s with the patch. Doing the exact same measurements again 
showed an average of 2.221s without the patch, 2.223s with the patch.

The build was using clang 19.1.7 on x86_64, no special compiler flags, 
just -O2.

The patch that I tested is attached.

I welcome anyone doing their own measurements using better benchmarks to 
see if they can determine whether this patch is useful.

Cheers,
Harald van Dijk
--------------EIP0eezQEe9qMUK0w6A3R4ym
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-jobs-avoid-blocking-signals-on-vfork.patch"
Content-Disposition: attachment;
 filename="0001-jobs-avoid-blocking-signals-on-vfork.patch"
Content-Transfer-Encoding: base64

RnJvbSBhMTEyZTY1ODE1NDBiZjdkMzRiYjJmNDcwNDJlODkyN2JjZDk1ZDBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJhbGQgdmFuIERpamsgPGhhcmFsZEBnaWdhd2F0
dC5ubD4KRGF0ZTogRnJpLCAyMiBBdWcgMjAyNSAwMjowNToxNCArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIGpvYnM6IGF2b2lkIGJsb2NraW5nIHNpZ25hbHMgb24gdmZvcmsoKS4KCkFzIHBv
aW50ZWQgb3V0IGJ5IERlbnlzIFZsYXNlbmtvLCB3ZSBjYW4gYXZvaWQgYmxvY2tpbmcgc2ln
bmFscyBvbgp2Zm9yaygpIGJ5IG1ha2luZyB0aGUgc2lnbmFsIGhhbmRsZXIgb2YgYSB2Zm9y
ayBjaGlsZCBpbW1lZGlhdGVseQpyZXR1cm4uIFRoaXMgc2F2ZXMgYSBzeXNjYWxsLgotLS0K
IHNyYy9qb2JzLmMgfCA1ICstLS0tCiBzcmMvdHJhcC5jIHwgMiArLQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3Jj
L2pvYnMuYyBiL3NyYy9qb2JzLmMKaW5kZXggNTFlNmZhMS4uODNkOTY5NCAxMDA2NDQKLS0t
IGEvc3JjL2pvYnMuYworKysgYi9zcmMvam9icy5jCkBAIC05OTEsMjAgKzk5MSwxNyBAQCBz
dHJ1Y3Qgam9iICp2Zm9ya2V4ZWModW5pb24gbm9kZSAqbiwgY2hhciAqKmFyZ3YsIGNvbnN0
IGNoYXIgKnBhdGgsIGludCBpZHgpCiAKIAlqcCA9IG1ha2Vqb2IoMSk7CiAKLQlzaWdibG9j
a2FsbChOVUxMKTsKLQl2Zm9ya2VkKys7CisJdmZvcmtlZCA9IGdldHBpZCgpOwogCiAJcGlk
ID0gdmZvcmsoKTsKIAogCWlmICghcGlkKSB7CiAJCWZvcmtjaGlsZChqcCwgbiwgRk9SS19G
Ryk7Ci0JCXNpZ2NsZWFybWFzaygpOwogCQlzaGVsbGV4ZWMoYXJndiwgcGF0aCwgaWR4KTsK
IAkJLyogTk9UUkVBQ0hFRCAqLwogCX0KIAogCXZmb3JrZWQgPSAwOwotCXNpZ2NsZWFybWFz
aygpOwogCWZvcmtwYXJlbnQoanAsIG4sIEZPUktfRkcsIHBpZCk7CiAKIAlyZXR1cm4ganA7
CmRpZmYgLS1naXQgYS9zcmMvdHJhcC5jIGIvc3JjL3RyYXAuYwppbmRleCBhZWJmZmEwLi4y
MzgyOWE1IDEwMDY0NAotLS0gYS9zcmMvdHJhcC5jCisrKyBiL3NyYy90cmFwLmMKQEAgLTMx
Miw3ICszMTIsNyBAQCBpZ25vcmVzaWcoaW50IHNpZ25vKQogdm9pZAogb25zaWcoaW50IHNp
Z25vKQogewotCWlmICh2Zm9ya2VkKQorCWlmICh2Zm9ya2VkICYmIGdldHBpZCgpICE9IHZm
b3JrZWQpCiAJCXJldHVybjsKIAogCWlmIChzaWdubyA9PSBTSUdDSExEKSB7Ci0tIAoyLjQ3
LjIKCg==

--------------EIP0eezQEe9qMUK0w6A3R4ym--
