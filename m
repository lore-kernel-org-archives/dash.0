Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7838C54EBC
	for <linux-dash@archiver.kernel.org>; Wed, 11 Jan 2023 02:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjAKCBL (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 10 Jan 2023 21:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjAKCBK (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 10 Jan 2023 21:01:10 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BC75E0E0
        for <dash@vger.kernel.org>; Tue, 10 Jan 2023 18:01:03 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a] (unknown [IPv6:2a02:8010:68a1:0:f140:f5fb:7038:8e8a])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 7B5512075
        for <dash@vger.kernel.org>; Wed, 11 Jan 2023 02:01:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 7B5512075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673402462;
        bh=KRtGqClVw1gV5eUdfEU7YvgNlwDfyk3Do8HHQYNAaQU=; l=1412;
        h=Date:To:From:Subject:From;
        b=Rd1S7ucWmG7AR2SY8XJpVaoEdQnf8OMrbmL62QTqa8cGTr7wCknU6uFsHDzcPEcyh
         PYpKwZFUiCgGaUAu8M1BGqJpWBz5WXUwH9jCZyX0wMrE8bgiUWYiu2b76NOQQKcm7f
         ktfFEbFuTwvtugz+1jy9236DvVKrFL4Y19REgv4c=
Message-ID: <444eaa61-35a8-15f4-5aeb-14a56aa38d07@gigawatt.nl>
Date:   Wed, 11 Jan 2023 02:01:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Content-Language: en-US
To:     DASH shell mailing list <dash@vger.kernel.org>
From:   Harald van Dijk <harald@gigawatt.nl>
Subject: alias confusion due to internal word representation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

Please consider

   alias $(printf "\204")="exit 2"
   $(:)
   echo ok

This is a perfectly valid shell script. The alias command is permitted 
to either succeed or fail, and if it succeeds, it defines an alias whose 
name is the single byte '\204'. No command by that name is ever 
executed, so this script is required to then print 'ok' and exit 
successfully.

This is not what happens. Internally, '\204' is the value of CTLBACKQ, 
and the word $(:) gets translated to an internal representation of just 
that -- coupled with a pointer to the parsed command. Since the word 
$(:) contains zero quote characters, it is subjected to alias expansion, 
and picks up this alias definition that makes the command expand to
exit 2.

Consider also:

   alias $(printf "\201")="echo ok" $(printf "\201\201")="echo bad" &&
   eval $(printf "\201")

This should either print "ok", or reject the aliases. Instead, it prints 
"bad". This happens because '\201' is the internal representation of 
CTLESC, and a literal byte of that value is represented by escaping it 
with CTLESC. Therefore, it triggers the expansion of the \201\201 alias.

Supporting alias names containing non-ASCII characters, while not 
required by POSIX, seems desirable, and almost all other shells (mksh 
being the exception) do appear to support this. I am not yet seeing a 
good way of solving this.

Cheers,
Harald van Dijk
