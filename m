Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E6C761A6
	for <linux-dash@archiver.kernel.org>; Fri, 31 Mar 2023 16:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjCaQGu (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaQGt (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 31 Mar 2023 12:06:49 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 09:06:47 PDT
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E06F91EA38
        for <dash@vger.kernel.org>; Fri, 31 Mar 2023 09:06:47 -0700 (PDT)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id C948DDC7;
        Fri, 31 Mar 2023 17:00:11 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl C948DDC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1680278411;
        bh=W5NKGPBvypEfDNBrVZVumo47lFDn+RFpde1qwo/IyE8=; l=1339;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=m34+ASViD/e0oZUBHkS9VG3REGEDMgWtlDHfwsn3yv+w+Vy9x9WwGTilBYzifaHK8
         eLidfMUra2A5UixHAzR/B9MJCMl3cuhTtAQW+VQE3phqvUXhA8q15OF/8y35UYbtpt
         uGZLA9Fsk/TbANARiIyaIIwZQYNiSOYNNSn6F1uE=
Message-ID: <e371ef6a-f330-b319-781d-774d88e05602@gigawatt.nl>
Date:   Fri, 31 Mar 2023 17:00:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: Bug: cd BOGUSDIR/.. always works
To:     Denys Vlasenko <vda.linux@googlemail.com>,
        DASH shell mailing list <dash@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <CAK1hOcPzt0+SOct3LZ1-go6zzKUVkceoAtS0bZ5=Pqb363cjXQ@mail.gmail.com>
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CAK1hOcPzt0+SOct3LZ1-go6zzKUVkceoAtS0bZ5=Pqb363cjXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 31/03/2023 15:46, Denys Vlasenko wrote:
> cd DIR
> 
> does the foillowing: cdcmd() -> docd() -> updatepwd(), and updatepwd
> has the code which "normalizes" the DIR: prepends current dir if DIR
> is not absolute, then eliminates "SUBDIR/.." sections.
> 
> The bug is, it does not care whether SUBDIR exists.
> 
> cd BOGUSDIR/..
> 
> always works - it chdir's into current directory.

Indeed, POSIX says that '..' should only remove the previous path 
component if the previous path component refers to a directory, so this 
behaviour is in conflict, and most (not all) other shells issue the 
error you expect.

Note though that the normalisation is also part of the spec for 'cd -L' 
(the default): if we have

   a/
   a/b/
   c -> a/b

then

   cd c/..

is supposed to be valid and return you to the current directory, despite 
c/.. referring to a. To go into a using c/.., cd -P c/.. is needed.

A corner case is what to do when '.' does not refer to a directory, as in

   mkdir a
   cd a
   rmdir ../a
   cd ..

By the same logic, this should result in an error as well. Most shells 
don't report anything. bash does in POSIX mode, in accordance with the 
spec, but does not report anything in its default mode. There may be 
unexpected fallout if this too is made a hard error in dash.

Cheers,
Harald van Dijk
