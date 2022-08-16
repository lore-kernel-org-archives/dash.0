Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E72C25B0E
	for <linux-dash@archiver.kernel.org>; Tue, 16 Aug 2022 14:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiHPOGs (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiHPOGo (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 16 Aug 2022 10:06:44 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA5AA0608
        for <dash@vger.kernel.org>; Tue, 16 Aug 2022 07:06:42 -0700 (PDT)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C9390744;
        Tue, 16 Aug 2022 15:06:40 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C9390744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1660658800;
        bh=tuiQyVw6kf0Dv6ME9I2d/tP3WsqRm2gemHoGgDTr48c=; l=2321;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=aa7eOPmQcbHiHiOKZpFu6LiX8TC9IA7SCdHki5Vr04KewmFfrQz7mtxcccGRxndBh
         1mE1VjI6tA2s9Vy0zG+i0SV4vOZ7LwsGUeu9+kkkqdAUjDVC0oeEEw7rLQQpRxo9qJ
         oiQV5YCao217fmjeRRatoMplpRTOhuoRuV8/lynQ=
Message-ID: <296789cd-17a7-90aa-7f81-0612ebf1310a@gigawatt.nl>
Date:   Tue, 16 Aug 2022 15:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: command -v ../foo when ../foo is a directory
To:     Simon Josefsson <simon@josefsson.org>, dash@vger.kernel.org
References: <87zgg41gx3.fsf@latte.josefsson.org>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <87zgg41gx3.fsf@latte.josefsson.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 16/08/2022 14:01, Simon Josefsson wrote:
> Hi.
> 
> I noticed a (to me) unexpected difference between bash and dash, compare
> bash behaviour:
> 
> jas@latte:~$ mkdir -p foo foo/bar
> jas@latte:~$ cd foo/bar
> jas@latte:~/foo/bar$ command -v ../bar
> jas@latte:~/foo/bar$ echo $?
> 1
> jas@latte:~/foo/bar$
> 
> with dash behaviour:
> 
> $ mkdir -p foo foo/bar
> $ cd foo/bar
> $ command -v ../bar
> ../bar
> $ echo $?
> 0
> $
> 
> That is, dash's 'command -v' return success on directories for relative
> names.

It's not relative vs absolute, it's because names that don't involve / 
involve PATH lookup. If you try 'command -v /', dash will also print /.

>         I believe the dash behaviour is incorrect, but I'd appreciate if
> someone else read the POSIX spec here.  Do you agree?

Sadly, I don't. I think the current behaviour is what POSIX technically 
requires, and at the same time that what POSIX requires is bad and shell 
authors should use common sense and not implement it as written.

POSIX says for command -v:

 > Utilities, regular built-in utilities, command_names including a 
<slash> character, and any implementation-defined functions that are 
found using the PATH variable (as described in Command Search and 
Execution), shall be written as absolute pathnames.

../bar is a command_name including a <slash> character. There is nothing 
in here that says to check whether it is executable, POSIX just says to 
write it as an absolute pathname, and that is what dash does.

Even if this text is read as deferring to Command Search and Execution, 
that says:

 > If the command name contains at least one <slash>, the shell shall 
execute the utility in a separate utility environment with actions 
equivalent to calling the execl() function [...]

There is no "check if it is an executable file" here either, the shell 
is supposed to just execl() the directory and report the error. And in a 
way, it kind of makes sense that command -v reports that that is what 
the shell would attempt.

Despite this, dash is pretty much the only shell that behaves this way 
and I would encourage changing it to match other shells.

> This is on Debian bullseye with dash 0.5.11+git20200708+dd9ef66-5 and
> bash 5.1-2+deb11u1.
> 
> /Simon

Cheers,
Harald van Dijk
