Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB906C61DA4
	for <linux-dash@archiver.kernel.org>; Fri, 10 Feb 2023 02:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjBJCwJ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Thu, 9 Feb 2023 21:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjBJCwH (ORCPT <rfc822;dash@vger.kernel.org>);
        Thu, 9 Feb 2023 21:52:07 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6461E765F3
        for <dash@vger.kernel.org>; Thu,  9 Feb 2023 18:51:36 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a] (unknown [IPv6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id A06FB72C;
        Fri, 10 Feb 2023 02:51:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl A06FB72C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1675997479;
        bh=IhWDBTNzMoQEqg44RWisXEzx5qeqYHiJab+Q4vkadKg=; l=1147;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pdye5w7LnC0hbBJJtxjGeoYKKUYtWFkkEwtbwi7OZznTTySzP3YXzexYRud+6x/Y8
         vMquGDp4A2eLwnBRg2w2tuCuWgS5QLvs72LM5C69/4kj76r2VyqtP1VDZwHJRLk/u3
         zqV1Cj6z/quJ+sksUst8TEXOeyrFiZWoyxu2KaRA=
Message-ID: <1d291f6d-30b2-720a-9a34-bf3471648534@gigawatt.nl>
Date:   Fri, 10 Feb 2023 02:51:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: [PATCH v2] Prototype all function definitions for C23 compat
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
References: <Y+R8SCX45HlQY8Xk@gondor.apana.org.au>
 <20230209131154.zbh3tagewd7u6vq5@tarta.nabijaczleweli.xyz>
 <Y+WvR6PY6vmVtUHr@gondor.apana.org.au>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y+WvR6PY6vmVtUHr@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 10/02/2023 02:43, Herbert Xu wrote:
> On Thu, Feb 09, 2023 at 02:11:54PM +0100, наб wrote:
>>
>>   STATIC int
>> -describe_command(out, command, path, verbose)
>> -	struct output *out;
>> -	char *command;
>> -	const char *path;
>> -	int verbose;
>> +describe_command(struct output *out, char *command,
>> +                 const char *path, int verbose)
> 
> This looks exactly the same as the first patch.  Did you send
> out the wrong one perhaps?

It is not the same as the first patch.

> Just to recap if we're touching the function definition they
> should now look like:
> 
> static int describe_command(struct output *out, char *command,
> 			    const char *path, int verbose)
> 
> Thanks,

It looks like наб took this as a request to break the parameters over 
multiple lines, and updated the patch accordingly. The initial patch had 
them all on a single line. This is also how I had read the request. It 
is only in this second message that I notice that you no longer have a 
line break before the function name, so to hopefully help avoid 
misunderstandings, I am spelling this out explicitly here.

Cheers,
Harald van Dijk
