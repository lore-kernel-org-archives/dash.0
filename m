Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51CAC46467
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 00:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAKAGM (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 10 Jan 2023 19:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjAKAGL (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 10 Jan 2023 19:06:11 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8F84CE22
        for <dash@vger.kernel.org>; Tue, 10 Jan 2023 16:06:05 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a] (unknown [IPv6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 15A37105F;
        Wed, 11 Jan 2023 00:06:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 15A37105F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673395564;
        bh=tWuQQJoBWxRhfjY7cOPz8uBS+rZg9nljc4donNMbYno=; l=1312;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=D9daKCxTwNrqM5yNba4jcBCDXJURLhLQq0xRiMTLrUV4gZJZ1e1v3DuhtpqJH786X
         gSvJsw41N656MbJ5MIRAv3frNqd6N/IMils7PmWerf77S18B981OC7iA42ffi7hga3
         Siwas0hQSrE9cJpcVDFFs1IUx9L1RwfFcfEzgpsQ=
Message-ID: <2251366a-a75e-7901-a47d-b9fa94e53fc5@gigawatt.nl>
Date:   Wed, 11 Jan 2023 00:06:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH v2] alias: fix name quoting in printalias
From:   Harald van Dijk <harald@gigawatt.nl>
To:     dash@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
References: <20230109001219.2ylktzb7uckoeti5@tarta.nabijaczleweli.xyz>
 <20230109001543.vpk6khjtqkjtrjox@tarta.nabijaczleweli.xyz>
 <7f1920ef-dc74-3a34-6453-507bbb349b8b@gigawatt.nl>
Content-Language: en-GB
In-Reply-To: <7f1920ef-dc74-3a34-6453-507bbb349b8b@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 09/01/2023 00:30, Harald van Dijk wrote:
> On 09/01/2023 00:15, наб wrote:
>> single_quote() over-writes the stack string, so just output the name
>> separately first.
>>
>> Fixes: commit 4ec545e8dc98a3f461cf56bed03adafa81c64aec ("alias: Quote
>>   name in printalias")
>> ---
>> really not my year sorry
> 
> This one works, thanks.
> 
> I'm wondering if we can save on code size by storing aliases differently 
> instead, allowing for a simpler fix here. If we store aliases in memory 
> in name=value form in a single block of memory, we only need a single 
> savestr() when creating the alias, we only need a single single_quote() 
> call here, we only need a single free() when we're done with the alias, 
> and may be able to share some code with src/var.c for checking the alias 
> name and stopping at the '='.
> 
> That'd be a larger change though, and even if it is possible, I am not 
> sure it's worth it.

Having implemented this, I am also seeing that this does achieve the 
result of reducing code size. The only visible change is that given e.g.

   alias foo=bar
   alias foo

we get

   'foo=bar'

rather than

   'foo'='bar'

which should be equally acceptable.

If there is interest in having this in dash, can adapt and submit it.

> Cheers,
> Harald van Dijk
