Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A69C433F5
	for <linux-dash@archiver.kernel.org>; Sun, 28 Nov 2021 14:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358022AbhK1OjI (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 28 Nov 2021 09:39:08 -0500
Received: from mail.gigawatt.nl ([51.68.198.76]:47934 "EHLO mail.gigawatt.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357929AbhK1OhI (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 28 Nov 2021 09:37:08 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Nov 2021 09:37:08 EST
Received: from [IPV6:2a02:8010:68a1:0:7982:e2b0:bbb7:1729] (unknown [IPv6:2a02:8010:68a1:0:7982:e2b0:bbb7:1729])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 6EF264AC;
        Sun, 28 Nov 2021 14:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 6EF264AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1638109724;
        bh=WPi8NkMNWWMFvBzk5G6AycCrc1WM36Ps2IcnuZIJ24M=; l=1124;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=CfE/91+zlVM9lablP5ENfbpnJT1eDDKhhA2WDhruxFtO6utU1K57lVMsH3X0dWq19
         0ZASdncYfmqTpweSPbHdBL6BrNc6I0iwKnhn3R+CrMzq8NntaWdqUiEkCQMUabvjrn
         6MEZ+C90MiiZJSfVOo6TBdKjVoUhZ1kzDOXv91/I=
Message-ID: <65da119f-ad21-ff18-11cd-3157b02cb22d@gigawatt.nl>
Date:   Sun, 28 Nov 2021 14:28:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: no match should be no string ?
Content-Language: en-GB
To:     Marc Chantreux <mc@unistra.fr>, dash@vger.kernel.org
References: <YaOOIf2d6tLP8xtw@prometheus.u-strasbg.fr>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <YaOOIf2d6tLP8xtw@prometheus.u-strasbg.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 28/11/2021 14:11, Marc Chantreux wrote:
> hello people,
> 
> I'm porting scripts from zsh to dash using version
> 0.5.11+git20200708+dd9ef66-5 from debian and
> surprised to realize that the result of a glob failure is the glob
> itself (when i expected an empty string).

Hi, yes, this is expected, this is standard POSIX sh behaviour and 
implemented by all POSIX sh-compatible shells. It should even be what 
zsh does when running in POSIX mode, but I do not have it installed 
right now to check.

In bash, it is optional, you get the glob itself by default, but there 
is a "nullglob" shell option you can set to get what you are asking for.

In ksh, it is optional, you get the glob itself by default, but there is 
a special thing where you can start a glob with ~(N) to change only that 
glob only to expand to nothing if there is no match.

Both of those are valid extensions that don't affect POSIX conformance.

I personally suspect dash will not want to implement either extension 
until POSIX decides which extension, if either/any, to standardise at 
some point.

Cheers,
Harald van Dijk
