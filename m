Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA38739ADD
	for <dash@vger.kernel.org>; Thu, 25 Apr 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.68.198.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078383; cv=none; b=N119C6aisabpPc0+XSAtXu7+NPA/WgDhGX/mo3y8MN9zS0GQIMKFgyj+K9js+UaU66ynwouZtIkoGt+ZhbP0S12ltCqnpe+W/gZugFIJaFpFeo4H9YkKCkjo8wKW8Cxzzp95V33dnoeQR4d61ZIltWzXgd7ffCVkPdcwjZsbWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078383; c=relaxed/simple;
	bh=5Q9oou2U/lzy92KDJiCQ2rLe9p07v8+NTu/nOxGE80M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz/sZxK4XiEt0DDO8AyyHVpP+ozFvqEZyHupufOqO38SXYOtiUZD4Z6j5uf+q7nQTiNWGwuJ5VqWq7QnoqLqFAvGFQ8FLbMaSRkCdre6BJTtEgIEJNFFO7Hiulh9cwXKnqtK2g2JWyWE7NrlQyHreKOb3ho9/V9FlqPFstGqM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl; spf=pass smtp.mailfrom=gigawatt.nl; dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b=E6yx5BcO; arc=none smtp.client-ip=51.68.198.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigawatt.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gigawatt.nl header.i=@gigawatt.nl header.b="E6yx5BcO"
Received: from [IPV6:2a02:8010:68a1:0:4c43:b4ba:5189:61d2] (unknown [IPv6:2a02:8010:68a1:0:4c43:b4ba:5189:61d2])
	by mail.gigawatt.nl (Postfix) with ESMTPSA id ACF32759;
	Thu, 25 Apr 2024 21:46:46 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl ACF32759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
	s=default; t=1714078006;
	bh=OUgKbNDazN6KasqmWRlHERSy3LlEvOe3PRZYfnjeLWA=; l=1566;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E6yx5BcOhLzINrpzU53iLWtmc6K75k2M8B7XQ861h7NFM6VFeBz6MsmBD2qvnJnmn
	 dUFcqPk8fOzCsC4sthzv7JxUP1dKdqm4LiTrMkjFC7nKXVxMRwRRLrv2F/AxnZoInG
	 6/eTchrkZ0WvyiiP164oSBZcARj3mPA9USbRvGgY=
Message-ID: <b3609a6b-f47c-4aa6-a518-dac1be89fd01@gigawatt.nl>
Date: Thu, 25 Apr 2024 21:46:45 +0100
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Simplify alias storage.
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: DASH shell mailing list <dash@vger.kernel.org>
References: <c3903caf-06a7-e321-4fa9-5abe0a0f2ae9@gigawatt.nl>
 <ZhD3eVw1cXMZxZg6@gondor.apana.org.au>
Content-Language: en-GB
From: Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <ZhD3eVw1cXMZxZg6@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2024 08:19, Herbert Xu wrote:
> On Wed, Jan 11, 2023 at 06:23:41PM +0000, Harald van Dijk wrote:
>>
>>   	if (ap) {
>>   		if (!(ap->flag & ALIASINUSE)) {
>> -			ckfree(ap->val);
>> +			ckfree(ap->name);
>>   		}
> 
> I think this breaks ALIASINUSE.  When an alias is marked as INUSE,
> it will be freed by input.c (popstring).  However, your patch doesn't
> touch input.c at all.

You're quite right, thanks for spotting that. A test case that covers 
that is

   alias foo='
   alias foo="echo Hello"
   '
   foo
   foo

Here, the storage of the original 'foo' alias needs to be kept while the 
expansion is ongoing, even when the second 'alias' overwrites the 
original definition. This bug is fixed by below additional patch.

However, the patch conflicts with c8db655b because scanning 'name' will 
now find the '=' character and continue on from that to check the value. 
That should be relatively easy to avoid, but I am not sure it is worth it.

Cheers,
Harald van Dijk

diff --git a/src/input.c b/src/input.c
index 38969a7..4604945 100644
--- a/src/input.c
+++ b/src/input.c
@@ -386,7 +386,7 @@ pushstring(char *s, void *ap)
  	sp->ap = (struct alias *)ap;
  	if (ap) {
  		((struct alias *)ap)->flag |= ALIASINUSE;
-		sp->string = s;
+		sp->string = ((struct alias *)ap)->name;
  	}
  	parsefile->nextc = s;
  	parsefile->nleft = len;
@@ -405,7 +405,7 @@ static void popstring(void)
  		    parsefile->nextc[-1] == '\t') {
  			checkkwd |= CHKALIAS;
  		}
-		if (sp->string != sp->ap->val) {
+		if (sp->string != sp->ap->name) {
  			ckfree(sp->string);
  		}
  	}


