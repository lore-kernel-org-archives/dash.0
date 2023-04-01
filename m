Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773D8C6FD1D
	for <linux-dash@archiver.kernel.org>; Sat,  1 Apr 2023 19:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDATOA (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 1 Apr 2023 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDATOA (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 1 Apr 2023 15:14:00 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7966CA00
        for <dash@vger.kernel.org>; Sat,  1 Apr 2023 12:13:58 -0700 (PDT)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 414B6739;
        Sat,  1 Apr 2023 20:13:57 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 414B6739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1680376437;
        bh=JmjafdJ4YAhGeegAMcYOR8W9xpbEmG9vuo9xD810/fk=; l=3882;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VAifF4cBoNrazku5oyTol/HCfT3qjbOrlKZx7CUoGo52wJioEHKDdg8KpqLsHwCvh
         mro2/g+AsnYu3bNHPf9vmWFU8z7O3cfHKX0snX5qkLu8StPL0IhX7bkmRIUAswVjqI
         P+utBrZ5eiJwJVWeYvDXD+rfFCoMTHYytX96KfEs=
Message-ID: <e69d7554-6047-f527-9489-0d8e872643ae@gigawatt.nl>
Date:   Sat, 1 Apr 2023 20:13:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
To:     Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 01/04/2023 19:46, Denys Vlasenko wrote:
> ash allows PATH to contain "%builtin" and "DIR%func"
> pseudo-directories.
> 
> %builtin shows in what order builtins to be found
> relative to searching directories for external commands.

Indeed. This is a desirable feature, regardless of whether the current 
implementation is the right way of doing it. POSIX intends for it to be 
possible to have a way to specify that a directory in PATH takes 
precedence over built-in commands. The way it tried to specify this was 
broken, and did not have the desired effect. The way it is implemented 
in dash using %builtin is one way of doing something that works.

I am not a fan of the precise way %builtin is implemented, and took that 
out in my fork, but do intend to make the feature available in *some* 
way again at some point and would suggest not just dropping it without a 
replacement in dash.

> DIR%func allows to have a directory of "auto-loadable" functions.
> (dash git tree seems to have an example of it as src/funcs/*).

When I used dash, I did use this feature. It is roughly equivalent to 
ksh's FPATH feature. In my own fork of dash I modified it to support 
that instead, and dropped %func since it no longer served a purpose, but 
if I were still using dash, I would still be using %func.

> I tried a few searches on the internet and this feature
> seems to be almost entirely not documented. I found exactly one
> manpage documenting it:
> 
> https://www.unix.com/man-page/minix/1/ash/
> 
>      Path Search
> 
>         When locating a command, the shell first looks to see if it has 
> a shell function by that name.  Then, if PATH does not contain an entry for
>         "%builtin", it looks for a builtin command by that name.  
> Finally, it searches each entry in PATH in turn for the command.
> 
>         The value of the PATH variable should be a series of entries 
> separated by colons.  Each entry consists of a directory name, or a  
> directory
>         name followed by a flag beginning with a percent sign.  The 
> current directory should be indicated by an empty directory name.
> 
>         If  no  percent    sign  is  present,  then  the entry causes 
> the shell to search for the command in the specified directory.  If the 
> flag is
>         ``%builtin'' then the list of shell builtin commands is 
> searched.  If the flag is ``%func'' then the directory is searched for a 
> file which
>         is read as input to the shell.  This file should define a 
> function whose name is the name of the command being searched for.
> 
> Here is an example of a user having a problem because he has a PATH with
> directory containing "GNU%2fLinux" string in its name:
> 
> https://unix.stackexchange.com/questions/126955/percent-in-path-environment-variable

This is unfortunate. It is well-known that arbitrary directory names 
cannot be used in PATH -- directory names containing : cannot be -- but 
it is less well-known that this extends to other directory names.

> So... maybe we can drop it?
> 
> I assume it's rarely (never?) used in the wild.
> It interferes with valid directories with percents in names.
> It's non-standard, and not a typical feature of other Bourne-like shells
>    (maybe we (ash family) are the only ones?)
> Code complication to support it is a chore.

It is not clear to me whether you mean "non-standard" as "conflicts with 
the standard", or "not required by the standard". It is an extension, 
but it is now a permitted extension: POSIX is being changed to permit 
this behaviour. In the latest POSIX draft, PATH lookup specifies:

   If PATH is unset or is set to null, or if a path prefix in PATH
   contains a <percent-sign> character ('%'), the path search is
   implementation-defined.

Cheers,
Harald van Dijk
