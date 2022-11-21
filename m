Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA11C433FE
	for <linux-dash@archiver.kernel.org>; Mon, 21 Nov 2022 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKUNIu (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiKUNIt (ORCPT <rfc822;dash@vger.kernel.org>);
        Mon, 21 Nov 2022 08:08:49 -0500
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF012D107
        for <dash@vger.kernel.org>; Mon, 21 Nov 2022 05:08:46 -0800 (PST)
Received: from [IPV6:2a02:8010:68a1:0:26d4:234:5292:8b5e] (unknown [IPv6:2a02:8010:68a1:0:26d4:234:5292:8b5e])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id 40C471F92;
        Mon, 21 Nov 2022 13:08:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl 40C471F92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1669036124;
        bh=M/aHd/2hT4BtVFBWkCn/qeVt+8cLSQRnW2ZfW2XKK7s=; l=3396;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kcFsW005irahhS5HD+J3JZ7RzrUqtlNMMgWOM2NpKYjIJ8jNKefZocIG1fkPQWpxi
         BHvxlWiTH29xFGbVs7gbInGbtEZhDFCG9uaJcqZxHuIiR4b0z7aLx6xnJytLfxaOQS
         83MhfmCtERzRxlj1xZaygblZzUzYSxR64ixnHkhs=
Message-ID: <6af07303-357f-6274-6c16-df00835c7f6c@gigawatt.nl>
Date:   Mon, 21 Nov 2022 13:08:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:107.0) Gecko/20100101
 Thunderbird/107.0
Subject: Re: segfault with invalid shell script
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        dash@vger.kernel.org
References: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <b2e298215b3d51d8284296484caa138faddaa0e4.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 21/11/2022 02:38, Christoph Anton Mitterer wrote:
> Hey.
> 
> 
> I found the following issue by chance, when converting a shell
> script[0] from bash to POSIX sh (well that + the use of "local"):
> 
> Below is a strongly reduced version of [0] which still causes the
> error:
> -------------------------------------------------------------------
> #!/bin/sh
> 
> 
> reject_and_die()
> {
>      exit 1
> }
> 
> 
> reject_filtered_cmd()
> {
>      reject_and_die "disallowed command${restrict_path_list:+ (restrict-path: \"${restrict_path_list//|/\", \"}\")}"
> }
> 
> reject_filtered_cmd
> -------------------------------------------------------------------
> 
> As you can see, I missed one bashism, namely the
> ${parameter//pattern/string} form of parameter expansion.

Right. This is intentionally accepted, like all non-standard 
substitutions, during parsing, but is supposed to raise a substitution 
error at runtime, so that scripts can do

   if shell_supports_subst; then
     echo ${var//a/b}
   else
     echo $var | sed s/a/b/g
   fi

Parsing this if statement requires parsing both sides of the branch, 
even ${var//a/b} will never be evaluated.

Actually performing this substitution should result in an error:

   $ dash -c 'echo ${$//1/2}'
   dash: 1: Bad substitution

> Now executing this with dash:
> $ dpkg -l dash | grep ^ii
> ii  dash           0.5.11+git20210903+057cd650a4ed-9 amd64        POSIX-compliant shell
> $ dash ssh_filter_btrbk.sh
> Segmentation fault
> $
> 
> With kernel log:
> Nov 21 03:31:37 heisenberg kernel: dash[145217]: segfault at 1 ip 000055fa32ef8cd4 sp 00007ffd79a75140 error 4 in dash[55fa32ef3000+13000]
> Nov 21 03:31:37 heisenberg kernel: Code: e2 01 4c 8d 34 42 48 8d 05 61 d9 00 00 49 01 c6 89 f0 83 e0 02 89 85 fc fe ff ff 74 17 c7 85 fc fe ff ff 00 00 00 00 83 e3 fd <41> 80 3f 7e 0f 84 c2 05 00 00 48 8b 35 8b 58 01 00 48 8b 05 5c 53
> 
> 
> Shouldn't that rather give some parsing error?

What the intended behaviour here is though, is unclear. The substitution 
containing ${...//...} is evaluated but the ${...//...} is skipped 
because $restrict_path_list is unset.

This should either result in the ${...//...} being skipped, or the "Bad 
substitution" error. Currently, what happens instead is it attempts, but 
fails, to skip the ${...//...}.

Fixing this so it produces "Bad substitution" should be easy, almost 
trivial. Fixing this so it skips the substitution is probably more 
complicated, but would probably better reflect the intent of the current 
code.

Cheers,
Harald van Dijk

> One some other system (where I cannot really test any further since I
> have no root) it even may have caused some more:
> [10527194.157467] ssh_filter_btrb[816610]: segfault at 0 ip 000055c8ac34a698 sp 00007ffd4a997080 error 4 in dash[55c8ac344000+13000]
> [10527194.157482] Code: 85 c4 01 00 00 48 83 c4 68 4c 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 1f 00 48 83 c2 02 eb a2 66 90 4c 89 fa 4d 85 f6 78 98 <48> 8b 36 bf 01 00 00 00 eb 8e 66 0f 1f 44 00 00 0f b6 42 01 48 83
> [10527195.790531] traps: pool-tracker-st[816482] trap int3 ip:7f94e8271295 sp:7f94deffc770 error:0 in libglib-2.0.so.0.6400.6[7f94e8235000+84000]
> 
> Not sure whether that traps is in anyway related or just some
> coincidence.
> 
> 
> 
> Thanks,
> Chris.
> 
> 
> [0] https://github.com/digint/btrbk/blob/master/ssh_filter_btrbk.sh
> 
