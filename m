Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF33EC433FE
	for <linux-dash@archiver.kernel.org>; Mon, 21 Nov 2022 22:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKUW0G (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Nov 2022 17:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKUW0F (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Nov 2022 17:26:05 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36DDE66CAC
        for <dash@vger.kernel.org>; Mon, 21 Nov 2022 14:26:04 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id EE8EE744;
        Mon, 21 Nov 2022 22:26:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl EE8EE744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1669069563;
        bh=bnBGjS6gbXgBmoNTowi1eeUXNGAtBmIdtbTJctmE+uQ=; l=1999;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SSl98c/HTr9uBb59tESZo+FsGnHEajTDx8D/j8h2/DDIXBtr3P3lHwd8TWsiLawt2
         jk/LdZdLnRUluHI89wigSqFV6x8Y+CJe+og6Hagfj0AzMMME+KSzs6VNS2TOn/LJvZ
         EsAr8/OPqu/XEUNZcmpKP18t3PTHxFIK4wKxQusc=
Message-ID: <cc8169ff-1d09-9f6f-5208-0404b1a4fdfc@gigawatt.nl>
Date:   Mon, 21 Nov 2022 22:25:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0
Subject: Re: segfault with invalid shell script
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     dash@vger.kernel.org
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
 <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
 <b03e330140ee8f8bd963ed7de0abb7cc55028797.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <b03e330140ee8f8bd963ed7de0abb7cc55028797.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 21/11/2022 15:24, Christoph Anton Mitterer wrote:
> Hey Harald
> 
> On Mon, 2022-11-21 at 13:08 +0000, Harald van Dijk wrote:
>>
>> This is intentionally accepted, like all non-standard
>> substitutions, during parsing, but is supposed to raise a
>> substitution
>> error at runtime, so that scripts can do
>>
>>     if shell_supports_subst; then
>>       echo ${var//a/b}
>>     else
>>       echo $var | sed s/a/b/g
>>     fi
>>
>> Parsing this if statement requires parsing both sides of the branch,
>> even ${var//a/b} will never be evaluated.
> 
> Well, while I can understand the merit of this... it may also have some
> drawbacks.
> 
> 
>> Actually performing this substitution should result in an error:
>>
>>     $ dash -c 'echo ${$//1/2}'
>>     dash: 1: Bad substitution
> 
> It does here, too.
> 
>> What the intended behaviour here is though, is unclear. The
>> substitution
>> containing ${...//...} is evaluated but the ${...//...} is skipped
>> because $restrict_path_list is unset.
> 
> In the original script, it may be set. I just shortened it.

Sure, but you will not hit this bug if it is set: if it is set, you will 
get the Bad substitution error that is expected for that.

>> Fixing this so it produces "Bad substitution" should be easy, almost
>> trivial.
> 
> I, personally, would like that anyway better.
> 
> Conditionally choosing the variant of shell command language during
> runtime seems quite fragile.
> I'd rather see straight away, that I use something non-supported.

That is reasonable and some shells do issue errors during parsing for 
the example I posted earlier. POSIX explicitly makes it unspecified what 
happens here; dash has gone the other way.

> Is there some bugtracker for dash, so that it doesn't get forgotten?

There is a patch tracker, 
<https://patchwork.kernel.org/project/dash/list/>, but I am not aware of 
a bug tracker.

Cheers,
Harald van Dijk

> Thanks,
> Chris.
