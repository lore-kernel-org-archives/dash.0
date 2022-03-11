Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205CC433F5
	for <linux-dash@archiver.kernel.org>; Fri, 11 Mar 2022 10:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiCKKNm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiCKKNl (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 11 Mar 2022 05:13:41 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48F09B2D69
        for <dash@vger.kernel.org>; Fri, 11 Mar 2022 02:12:38 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:d0d4:d13c:6697:df13] (unknown [IPv6:2a02:8010:68a1:0:d0d4:d13c:6697:df13])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id F1C85C1;
        Fri, 11 Mar 2022 10:12:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl F1C85C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1646993556;
        bh=XK1GaI+ENZ9LQueOTDGUV1SDcHamYjV21FdG0wjNdcA=; l=1070;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Q3ZwOK7NVx8p2lCKpP4AweW3f6wm/jaa9xndsFVtXS/dxfw/By8U/A8tsytUu8IpZ
         GkwzNq2/PzqmBLjTmC11AuGhw7xIiGgY51s+4S4E/KSuKKTLzzpljk6bKEsaEJ3Mr3
         tq6oEfXWBOozMLJlyH5yJZfMxn5DZsiTaauf7vy4=
Message-ID: <fdfed8d3-d654-74de-67f5-85d21ae4c630@gigawatt.nl>
Date:   Fri, 11 Mar 2022 10:12:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:98.0) Gecko/20100101
 Thunderbird/98.0
Subject: Re: possible wrong behaviour when -s and -c are both used
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
References: <3574fa7e81a2c56fdb720ea0df259ae3df92c3b2.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <3574fa7e81a2c56fdb720ea0df259ae3df92c3b2.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 11/03/2022 04:25, Christoph Anton Mitterer wrote:
> Hey.
> 
> I've noted that dash gives different behaviour when both -s and -c are
> used, depending on their order:

The order is irrelevant.

> calestyo@heisenberg:~$ cat script
> date
> calestyo@heisenberg:~$
> 
> calestyo@heisenberg:~$ dash -s -c 'echo foo' script
> foo
> $     <--- this is dash's prompt, and it reads input from stdin

This has -s and -c options. Contrary to your analysis below, as has been 
answered on your Austin Group bug report, this has unspecified 
behaviour. dash can do whatever it wants here.

> calestyo@heisenberg:~$ dash -c 'echo foo' -s script
> foo

This only has a -c option. -s appears after 'echo foo', which is a 
non-option, and is therefore also a non-option. This is required to set 
$0 to -s, $1 to script, and then try to print 'foo', which dash 
correctly implements.

The syntax to have both -s and -c options, but have -s appear after -c, is

   dash -c -s 'echo foo' script

which behaves the same as the -s -c case.

Cheers,
Harald van Dijk
