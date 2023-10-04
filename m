Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B9FE7B604
	for <linux-dash@archiver.kernel.org>; Wed,  4 Oct 2023 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjJDMes (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Oct 2023 08:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJDMes (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Oct 2023 08:34:48 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 05:34:43 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2D1A93
        for <dash@vger.kernel.org>; Wed,  4 Oct 2023 05:34:43 -0700 (PDT)
Received: from [IPV6:2a02:8010:68a1:0:5f15:791d:7617:b54] (unknown [IPv6:2a02:8010:68a1:0:5f15:791d:7617:b54])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 09555177;
        Wed,  4 Oct 2023 13:28:01 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 09555177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1696422481;
        bh=Vupmyr3us0KZrV2BdyW73EKufTlDWRN3Ep0zkApq9nE=; l=2192;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=M0pFyfv0Ip+IK5Dcl3UJGanHQM59HoTjGWZmI3IWxZlIiKDR5SosM1V0rtk3o83zW
         Pw7iAu1RV1LIkMaq5NldxzFy/JgXVUvsN/Ab5R+5EPV5qI7v/O7QE70EG+BtwCOWMQ
         VzwQuvEZLYgH/4piBHiSO1Q7jzQ9GSE8gHFuooKY=
Message-ID: <15ef5aaa-8766-48f7-9f3d-6b11838a0b95@gigawatt.nl>
Date:   Wed, 4 Oct 2023 13:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Printing C:\abc in a portable way
Content-Language: en-US
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>, dash@vger.kernel.org
References: <bc35891262faa710fa1f0dc08233c5fe@aegee.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <bc35891262faa710fa1f0dc08233c5fe@aegee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 04/10/2023 09:47, Дилян Палаузов wrote:
> Hello,
> 
> I want to print C:\abc in a portable way.  Or rather, store the value 
> C:\abc in a variable.  I have bash 5.2.15-3.fc38 and dash 0.5.12-1.fc38. 
>   /bin/sh is a symlink to bash.
> 
> In interactive bash
> 
> echo "C:\\abc"
> 
> prints
> 
> C:\abc . The same happens when I store in a file and execute it:
> 
> #!/bin/bash
> echo "C:\\abc"
> 
> 
> #!/bin/bash --posix
> echo "C:\\abc"
> 
> 
> #!/bin/sh
> echo "C:\\abc"
> 
> With dash it is different:
> 
> #!/bin/dash
> echo "C:\\abc"
> 
> prints C:bc .  When I replace above a with k, echo "C:\\kbc" prints 
> C:\kbc .

In dash, backslash acts as an escape character within echo. In bash, it 
is configurable, it can either act as an escape character the same way 
by default, or it can limit escape sequence processing to when the -e 
option is used. In bash, the behaviour can be changed via
shopt -s xpg_echo and shopt -u xpg_echo. The default varies between systems.

> When I replace the double quotes with single quotes, echo 'C:\\abc' , 
> dash prints C:\abc, but bash (interactive, /bin/sh and bash --posix) 
> prints C:\\abc .

With shopt -s xpg_echo, this also prints C:\abc in bash. Note that this 
configuration option is independent of POSIX mode, as POSIX allows 
either behaviour.

To print a variable literally, without special treatment of backslash, 
use the printf builtin instead.

   printf "%s\n" "$var"

will output exactly the string that is stored in $var. If it contains 
backslashes, this will print backslashes. And this works the same way in 
dash and bash.

> All that said I think this is a bug in dash.
> 
> The above echos are simplified use case, in reality I want to execute 
> A="C:\\abc" ./script and the script shall see C:\abc as value to the 
> variable A.

What you have there already achieves that. The special handling of 
backslash in the echo command is specific to the echo command. For 
passing environment variables to other processes, nothing special 
happens (at least, nothing special that relates to backslashes).

> Kind regards
>    Dilyan

Cheers,
Harald van Dijk
