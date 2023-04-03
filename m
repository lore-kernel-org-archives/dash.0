Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244CFC761A6
	for <linux-dash@archiver.kernel.org>; Mon,  3 Apr 2023 11:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjDCLfE (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 3 Apr 2023 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjDCLfE (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 3 Apr 2023 07:35:04 -0400
Received: from mail.gigawatt.nl (mail.gigawatt.nl [51.68.198.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 912964224
        for <dash@vger.kernel.org>; Mon,  3 Apr 2023 04:35:02 -0700 (PDT)
Received: from [192.168.178.37] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id DC7E2734;
        Mon,  3 Apr 2023 12:35:00 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl DC7E2734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1680521700;
        bh=LV2sBSgjopJ+71qp6zMYyqCClveal+s1AoiJkoJT/s4=; l=1215;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=epTTFEJf+l5fGisSppmH2R8M5SraTNX3yl1Vq+UwTVCx+kg29Id7+EH5h/vgnBre/
         xfsSvUMdOxs2xNAx4rTAhe1IYCB7zcepAwBNyqz4iwdiscDExWqEpcwEL/S+mJBxDi
         nPFb270E2ZEACwfsfedtdSR2ZvjPcE8oG38jmK9Q=
Message-ID: <3d9dd3d5-b8ae-3cf8-1e81-ef46cf9cf95a@gigawatt.nl>
Date:   Mon, 3 Apr 2023 12:35:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:110.0) Gecko/20100101
 Thunderbird/110.0
Subject: Re: Are there users of ash's "pathopts"? Do other shells have such a
 thing?
Content-Language: en-US
To:     Denys Vlasenko <dvlasenk@redhat.com>, dash@vger.kernel.org
References: <aad32205-1e0a-fea6-0825-8eb45c6ae915@redhat.com>
 <d92f3379-6d24-e4a9-035b-e928c13760c6@redhat.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <d92f3379-6d24-e4a9-035b-e928c13760c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

On 03/04/2023 10:35, Denys Vlasenko wrote:
> But it's not necessary, right? chkmail() does not actually uses
> pathopts. It can just call padvance_magic(..., 0)
> so as to ignore them.

chkmail() does use pathopt. It is used to customise the message that 
gets printed:

		if (!changed && statb.st_mtime != *mtp) {
			outfmt(
				&errout, snlfmt,
				pathopt ? pathopt : "you have mail"
			);
		}

POSIX also specifies the use of '%' for this (although dash's 
implementation is not entirely compatible):

   MAILPATH
     Provide a list of pathnames and optional messages separated by
     <colon> characters. If this variable is set, the shell shall inform
     the user if any of the files named by the variable are created or if
     any of their modification times change. (See the preceding entry for
     MAIL for descriptions of mail arrival and user informing.) Each
     pathname can be followed by '%' and a string that shall be subjected
     to parameter expansion and written to standard error when the
     modification time changes. If a '%' character in the pathname is
     preceded by a <backslash>, it shall be treated as a literal '%' in
     the pathname. The default message is unspecified.

Cheers,
Harald van Dijk
