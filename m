Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DFC433F5
	for <linux-dash@archiver.kernel.org>; Sun, 28 Nov 2021 16:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhK1RDC (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhK1RBB (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 28 Nov 2021 12:01:01 -0500
X-Greylist: delayed 8939 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 Nov 2021 08:57:45 PST
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E3FC061746
        for <dash@vger.kernel.org>; Sun, 28 Nov 2021 08:57:45 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:7982:e2b0:bbb7:1729] (unknown [IPv6:2a02:8010:68a1:0:7982:e2b0:bbb7:1729])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id AA7B219C;
        Sun, 28 Nov 2021 16:57:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl AA7B219C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1638118664;
        bh=9s8JNc4yCemsKofMLurRTGWpzftkJqAfUTSSQuZOKQg=; l=711;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KT9x3ygaSSygBjIL5cfw6WF0wkhCkruIUclDKj8yqZjn9gJ2lGx/PBRCsHRwkgrF2
         GTATVpzruf0qTEySvFmE8So2XZ/Y9+rxVh0DjLaWhdi7OjwfXhj288YKOaryGL+jIT
         vdwozooSAef9bAW6uPYtwiPMlTFWUmq8FEsr4HtY=
Message-ID: <da2913f2-b675-7bc0-9f8b-f2bfddedb9ca@gigawatt.nl>
Date:   Sun, 28 Nov 2021 16:57:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:95.0) Gecko/20100101
 Thunderbird/95.0
Subject: Re: no match should be no string ?
Content-Language: en-GB
To:     Marc Chantreux <mc@unistra.fr>
Cc:     dash@vger.kernel.org
References: <YaOOIf2d6tLP8xtw@prometheus.u-strasbg.fr>
 <65da119f-ad21-ff18-11cd-3157b02cb22d@gigawatt.nl>
 <YaOwJ9TVHsDrnIbM@prometheus.u-strasbg.fr>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <YaOwJ9TVHsDrnIbM@prometheus.u-strasbg.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 28/11/2021 16:36, Marc Chantreux wrote:
> * the ambiguity when $# is 1: there is no way to know if i have no match
>    or if a very bad person named its file \*no_way_this_glob_matches\*.

Agreed that that is annoying.

If your pattern includes literal characters, there is a complicated 
workaround that you can apply directly in the pattern: use the pattern

   *[n]o_way_this_glob_matches*

If you get back exactly '*[n]o_way_this_glob_matches*', that is because 
the glob did not match anything. A file by that name would not be picked 
up by the glob. If you get back anything else, it was found by the glob.

Otherwise, you would need to 'test -e' to double-check.

Cheers,
Harald van Dijk
