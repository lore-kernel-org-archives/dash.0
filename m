Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3FDC3DA7D
	for <linux-dash@archiver.kernel.org>; Tue,  3 Jan 2023 11:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbjACLrZ (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Jan 2023 06:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjACLrQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Jan 2023 06:47:16 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F205CBC2
        for <dash@vger.kernel.org>; Tue,  3 Jan 2023 03:47:11 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 63C7FDC7;
        Tue,  3 Jan 2023 11:47:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 63C7FDC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1672746428;
        bh=pSyYEX8m+dFoly/CjSIdU3idux8jnX4nhdj8Ie7Eogk=; l=1460;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YWMu1kQcwTXKHaVdOR4/0Jia22qD3l5j6BWBl+tioBcukvWY0N2V33/OXEER0DtKw
         1Afc+2nywNh7Ajd3iGe76CWUnc0SV8NVLqmwXJh69wqw9M4yQUFkI5ViYaq9Yob5zw
         yBu6TzK6qo+U6G/va8KHxfHYxiSXXn5GYRAyws+0=
Message-ID: <bb422d70-0ba5-e29b-3ec8-8fc1c4630233@gigawatt.nl>
Date:   Tue, 3 Jan 2023 11:47:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: Re: [PATCH v2 2/3] parser: synerror: explicitly consume the entire
 invalid line
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     dash@vger.kernel.org
References: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <Y7OKk/jM53zRE4xg@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 03/01/2023 01:53, Herbert Xu wrote:
> наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
>>
>> synerror(const char *msg)
>> {
>>         errlinno = plinno;
>> +
>> +       /* If we see a syntax error in a command, read the rest of the
>> +        * line now before reporting the error. This ensures we get error
>> +        * reporting that does not depend on buffering details. */
>> +       skipline();
> 
> This is broken.  What if we already read a newline just before
> the syntax error (e.g., synexpect(TDO))?

In order for this to be a problem, we need something where the newline 
itself triggers a syntax error. For synexpect(TDO), is that possible? In 
all cases where synexpect(TDO) is called, a newline is permitted, and it 
is the token after the newline that the error will be reported on, no? 
In that situation, reading the rest of the line is correct.

I'm not going to rule out that there is a potential for problems, but if 
there is, it's not the situation you say.

> This needs to be dealt with in the input layer.

Handling it in the input layer after the error has already been reported 
means we get inconsistent error handling when running with dash -isv. 
The error may, depending on whether the rest of the line was in the 
buffer already, be reported either in the middle of the input line, or 
on the next line.

Just try changing sh -i to sh -iv in the reproducer and seeing what what 
happens with your patch.

Cheers,
Harald van Dijk
