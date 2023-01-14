Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0FC46467
	for <linux-dash@archiver.kernel.org>; Sat, 14 Jan 2023 11:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjANLKo (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 14 Jan 2023 06:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjANLKn (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 14 Jan 2023 06:10:43 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70AC65A2
        for <dash@vger.kernel.org>; Sat, 14 Jan 2023 03:10:41 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C2A31DC7;
        Sat, 14 Jan 2023 11:10:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C2A31DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673694640;
        bh=33Rme2WiHSzJEqLAHLA15M6Rm7hyUJatvna629istvc=; l=3122;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ni9ZqZSkgqAAz1cqBqoIgBK57W43hi2XCssgMdYD2j0pXIPDCm/UGIeTDwP+7VqH3
         2Qr4NAuI3h84n7Q1neelNq0o0cRGNk0nroJFE+oAIVZRg8VtlrJEFuV4XS1+GndfTY
         lps18F0nW2AWiZ+WkLGfqiDWwabq4yoyAIXNeRGw=
Message-ID: <6469ba41-e905-c873-f239-21448af0d853@gigawatt.nl>
Date:   Sat, 14 Jan 2023 11:10:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogQnVnIGluIGRhc2g6IEluY29ycmVjdCBiZWhhdmlv?=
 =?UTF-8?Q?ur_of_=24LINENO_in_function?=
Content-Language: en-US
To:     "anonymous4feedback@outlook.com" <anonymous4feedback@outlook.com>,
        Marc Chantreux <mc@unistra.fr>
Cc:     "dash@vger.kernel.org" <dash@vger.kernel.org>
References: <PS2PR03MB38309A4880282F1C60C3094092C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
 <Y8J4PmYwjp9fE7/y@prometheus.u-strasbg.fr>
 <PS2PR03MB3830467E11C8D6047363FCA392C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <PS2PR03MB3830467E11C8D6047363FCA392C39@PS2PR03MB3830.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 14/01/2023 10:57, anonymous4feedback@outlook.com wrote:
> Sorry I didn't explain this clearly, and I made some wrong assumption in the first email.
> 
> I made another simpler test
> 
> # line 1 is empty
> # line 2 is empty
> foo(){ # line 2
>    echo $LINENO; } # line 3
> foo # line 4
> 
> dash prints 2, (line number in function, counting from 1)
> bash and ksh prints 4, (line number in whole script)
> and zsh prints 1 (line number in function, counting from 0)
> 
> More test moving the lines around confirms the guess in parens.
> 
> Can I say that none of these is wrong because there is no standard about this?

Hi,

You are correct that dash is setting LINENO to the line number within 
the function.

There is a standard about this, but it, in my opinion, is unclear what 
the correct behaviour is. It says:

   LINENO
     Set by the shell to a decimal number representing the current 
sequential line number (numbered starting with 1) within a script or 
function before it executes each command. [...]

When LINENO appears in a script and a function at the same time, because 
the function is within a script, this does not say which of the two is 
used as a basis for determining LINENO's value.

There are a few more cases with LINENO that prove problematic, see also 
my response to an earlier bug report at 
<https://marc.info/?l=dash&m=153725795810101>.

Cheers,
Harald van Dijk

> 发件人: Marc Chantreux <mc@unistra.fr>
> 发送时间: 2023年1月14日 17:39
> 收件人: anonymous4feedback@outlook.com <anonymous4feedback@outlook.com>
> 抄送: dash@vger.kernel.org <dash@vger.kernel.org>
> 主题: Re: Bug in dash: Incorrect behaviour of $LINENO in function
>   
> hello,
> 
>> It seems dash stores the line number of the parameter substitution and the line number of the function definition
> 
> which is what we expect from a variable expansion. what you need here
> is an alias because it works like a minimal but dynamic preprocessor
> 
> those are the tricks about aliases:
> 
> * they really act as a preprocessor so
> 
>          alias warn='>&2 echo here at $LINENO'
>          f() warn first
>          alias warn='>&2 echo another message at $LINENO'
>          g() warn last
>          f;g
> 
>          # does
> 
>          here at 1 first
>          another message at 1 last
> 
> * interpolation comes first so
> 
>          entering() {
>                  echo entering "$@"
>                  "$@"
>          }
>          f() echo doing things in functions
>          alias damn='echo oops ...'
>          entering f
>          entering damn
> 
>          entering f
>          doing things in functions
>          entering damn
>          /home/mc/src/vendor/dash/src/dash: 3: damn: not found
> 
> conclusion:
> 
> * use functions as long as you can
> * in this case, you can't. your solution is
> 
>          alias warn='>&2 echo here at $LINENO'
> 
> HTH,
> Marc Chantreux
