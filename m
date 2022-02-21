Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FFC433FE
	for <linux-dash@archiver.kernel.org>; Mon, 21 Feb 2022 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiBURGo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:06:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiBURGn (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Feb 2022 12:06:43 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6225025EA2
        for <dash@vger.kernel.org>; Mon, 21 Feb 2022 09:06:18 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:d0d4:d13c:6697:df13] (unknown [IPv6:2a02:8010:68a1:0:d0d4:d13c:6697:df13])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C78D5739;
        Mon, 21 Feb 2022 17:06:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C78D5739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1645463174;
        bh=vYOSqSEhCda0LWY4kIV2dKNJNYBI+FWBEKs1dnn6UqI=; l=1773;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PkAFs+wI8futJ6TkOYG77787fTf6vAIw6cYzPMJmgwgli7XygOmlDAdef2dS7UrPw
         ys8UpW+mJ/9cnMKOx9o6SVz4b974qtaK/a0cGBN+NzfzCDYpO5JStWZACLMqarn1vA
         kMHl2GAGn96WLP+gMPLWbV1lDwuRtQA5GJ7gt/g4=
Message-ID: <6232ed8d-1c18-49ce-a7be-9e382245b5cc@gigawatt.nl>
Date:   Mon, 21 Feb 2022 17:06:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Subject: Re: [v2 PATCH] expand: Always quote caret when using fnmatch
Content-Language: en-US
To:     Eric Blake <eblake@redhat.com>,
        Stephane Chazelas <stephane@chazelas.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, calestyo@scientia.org,
        dash@vger.kernel.org
References: <YeZadfOkUDdN7JqS@gondor.apana.org.au>
 <c31fb498-0f82-dcdc-b1c6-212b8c919c07@gigawatt.nl>
 <YeejsuVQaGCkQ97t@gondor.apana.org.au>
 <20220220071544.7odyx5urgcwjsobd@chazelas.org>
 <20220221163908.hykzez677nlmve6x@redhat.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <20220221163908.hykzez677nlmve6x@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 21/02/2022 16:39, Eric Blake wrote:
> On Sun, Feb 20, 2022 at 07:15:44AM +0000, Stephane Chazelas wrote:
>> 2022-01-19 16:37:54 +1100, Herbert Xu:
>> [...]
>>> This patch forces ^ to be a literal when we use fnmatch.
>> [...]
>> The "fix" also seems incomplete and causes at least this
>> regression:
>>
>> $ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\^]'
>> dash->fnmatch("[\\\\^]", "\\", 0)                              = 0
>> match
>>
>> See how that added \ caused it to be included in the set. Compare with:
>>
>> +++ exited (status 0) +++
>> $ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\!]'
>> dash->fnmatch("[\\!]", "\\", 0)                                = 1
>> +++ exited (status 0) +++
>> $ ltrace -e fnmatch ./bin/dash -c 'case "\\" in ($1) echo match; esac' sh '[\x]'
>> dash->fnmatch("[\\x]", "\\", 0)                                = 1
>> +++ exited (status 0) +++
> 
> If you want to escape ^ to always be treated as a literal when calling
> fnmatch(), you have to spell it something like [[=^=]...], not [\^...]
> (that is, since \^ inside [] does NOT treat the \ as an escape
> character, but as yet another literal character as part of the brakcet
> group, you instead have to resort to calling out the literal character
> ^ via alternative spellings such as by a collation equivalent).

This is correct for regular expressions, unspecified for shell patterns 
in general after bug 1234 was resolved, and always incorrect for 
fnmatch() after bug 1190 was resolved. In fnmatch(), backslash has to 
work even inside bracket expressions. Whether it had to may not 
previously have been clear in the standard, but it has been made clear 
now and that is also how it works in glibc. That part of the patch is 
not a problem.

Cheers,
Harald van Dijk
