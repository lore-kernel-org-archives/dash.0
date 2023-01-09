Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D13C54EBC
	for <linux-dash@archiver.kernel.org>; Mon,  9 Jan 2023 00:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjAIACO (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sun, 8 Jan 2023 19:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjAIACN (ORCPT <rfc822;dash@vger.kernel.org>);
        Sun, 8 Jan 2023 19:02:13 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E0718FCC
        for <dash@vger.kernel.org>; Sun,  8 Jan 2023 16:02:12 -0800 (PST)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id D41DD10D7
        for <dash@vger.kernel.org>; Mon,  9 Jan 2023 00:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl D41DD10D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1673222531;
        bh=bTHQAGlPMgndtfmU2hpImPFTEERV+65NSTRQuYPZCSs=; l=479;
        h=Date:From:Subject:To:From;
        b=keLQ88wk9ptUB3rfAKf8Wa3LXpZt3bynpu2urffdS+VdwzItkMItaIwmjJp6pW/rU
         6JoJDjXvS16Bya+nsEn2fT5oGZx9RD7fN6F9PW20/tmcPacYbzqZmrUskiNmL/3RY3
         34wk6oC5FhdpTB+RN9DX7jf8MFvKnaLTi71Vlixk=
Message-ID: <696b6e2b-be79-77a7-a880-66de28012c57@gigawatt.nl>
Date:   Mon, 9 Jan 2023 00:02:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101
 Thunderbird/109.0
Content-Language: en-US
From:   Harald van Dijk <harald@gigawatt.nl>
Subject: Out-of-bounds access in alias command
To:     DASH shell mailing list <dash@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

Consider

   alias ""

In aliascmd(), we have

     while ((n = *++argv) != NULL) {
       if ((v = strchr(n+1, '=')) == NULL) { /* n+1: funny ksh stuff */

When *n == '\0', the strchr(n+1, '=') searches past the end of the string.

I have not yet been able to construct a test case where this causes 
problems, because my attempts have resulted in the memory following this 
empty string not containing any = before another null byte appears.

Cheers,
Harald van Dijk
