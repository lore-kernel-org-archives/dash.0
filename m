Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC95AC4332F
	for <linux-dash@archiver.kernel.org>; Wed, 23 Nov 2022 02:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbiKWCUZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 22 Nov 2022 21:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKWCUY (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 22 Nov 2022 21:20:24 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A70BCC67DE
        for <dash@vger.kernel.org>; Tue, 22 Nov 2022 18:20:23 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 6C2A1110C;
        Wed, 23 Nov 2022 02:20:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 6C2A1110C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1669170019;
        bh=g1G/43+97+mAivwlfTbo2AxlLZtFx4R0eg/EdabjmIk=; l=1893;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=GR8Ez347TV8WoGMdtzPiY16Gdb90uXZq2z5M6XnrP5xSr1hrDf7IYehLFk9w19Rfj
         Gg+HtaW7pSxZytPEmkPjYZEeKSnaMIQ/5LDLDqK1s3MDKFxVyyJvIteuhEv6sxq7Le
         /RSUyaJQz1xJYIrWypzqMUbRjp3Z/nvUkciSqqI0=
Message-ID: <8710d1c3-d7c9-7332-4bc7-ce243a1cbd37@gigawatt.nl>
Date:   Wed, 23 Nov 2022 02:20:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0
Subject: Re: segfault with invalid shell script
From:   Harald van Dijk <harald@gigawatt.nl>
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
 <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
Content-Language: en-US
In-Reply-To: <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 21/11/2022 13:08, Harald van Dijk wrote:
> On 21/11/2022 02:38, Christoph Anton Mitterer wrote:
>> reject_filtered_cmd()
>> {
>>      reject_and_die "disallowed command${restrict_path_list:+ 
>> (restrict-path: \"${restrict_path_list//|/\", \"}\")}"
>> }
>>
>> reject_filtered_cmd
>[...]
> This should either result in the ${...//...} being skipped, or the "Bad 
> substitution" error. Currently, what happens instead is it attempts, but 
> fails, to skip the ${...//...}.

The reason it fails is because the word is cut off.

Variable substitutions are encoded as a CTLVAR special character, 
followed by a byte indicating the type of substitution, followed by the 
rest of the substitution data. The type of substitution is the VSNORMAL, 
VSMINUS, etc. seen in parser.h. An invalid substitution is encoded as a 
value of 0.

When we define a function, we clone the function body in order to 
preserve it. Cloning the function body is done by cloning each node. 
Cloning a "word" node (NARG) involves copying the characters that make 
up the word up to and including the terminating null byte.

These two interact badly. The invalid substitution is seen as 
terminating the word, the rest of the word is not copied, but the 
expansion code does not have any way of seeing that anything got cut off 
and happily continues attempting to process the rest of the word.

If dash decides to issue an error in this case, this is not a problem: 
the null byte is guaranteed to be copied, and if processing is 
guaranteed to stop if a null byte is encountered, everything works out.

If dash decides to not issue an error in this case, the encoding of bad 
substitutions needs to change to a non-null byte. It appears that if we 
set the byte to VSNUL, the expansion logic is already able to handle it, 
but I have not tested this extensively.

Cheers,
Harald van Dijk
