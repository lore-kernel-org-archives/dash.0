Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37856C433FE
	for <linux-dash@archiver.kernel.org>; Sat, 12 Nov 2022 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKLMJn (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Sat, 12 Nov 2022 07:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLMJm (ORCPT <rfc822;dash@vger.kernel.org>);
        Sat, 12 Nov 2022 07:09:42 -0500
X-Greylist: delayed 449 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Nov 2022 04:09:40 PST
Received: from mail.gigawatt.nl (mail.gigawatt.nl [IPv6:2001:41d0:801:2000::19e9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E559B2250A
        for <dash@vger.kernel.org>; Sat, 12 Nov 2022 04:09:40 -0800 (PST)
Received: from [192.168.178.32] (uk.gigawatt.nl [51.148.134.205])
        by mail.gigawatt.nl (Postfix) with ESMTPSA id AB04F1E54;
        Sat, 12 Nov 2022 12:02:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.gigawatt.nl AB04F1E54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigawatt.nl;
        s=default; t=1668254529;
        bh=NGwQiEdX1v11euACvWICyPNV3mlq26PCBq2eJZv4EAw=; l=1306;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YvqCapr8cWwapQil56iykcDLWYloDchq+pq3HUDWTLHrj80ywVEOxGXNZ8GrG42CC
         CkivH645KZje1ztJxMn18jO9xhgTgMOv57X0jimUIHlyMLubxZregttLCGHHttonID
         MtceSPteyOairpyUl/uIvTg9zKx9fHMsBTcb+Q9w=
Message-ID: <2d4016af-dc0d-141c-91e4-e808bda33e4d@gigawatt.nl>
Date:   Sat, 12 Nov 2022 12:02:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: EXIT trap does not fire
To:     Akbarkhon Variskhanov <akbarkhon.variskhanov@gmail.com>,
        dash@vger.kernel.org
References: <CANeoM1GQ6XsittRZAE-hZLQYngjF_B5Rm7f786cB3vLQY6dLmw@mail.gmail.com>
From:   Harald van Dijk <harald@gigawatt.nl>
In-Reply-To: <CANeoM1GQ6XsittRZAE-hZLQYngjF_B5Rm7f786cB3vLQY6dLmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hi,

On 12/11/2022 11:02, Akbarkhon Variskhanov wrote:
> In bash, however, it seems to work fine. The action is executed and
> the exit status is preserved.

This is not actually the case. bash will run EXIT actions on any signal 
that it installs a handler for, but it does not install a handler for 
all signals.

   $ bash -c 'trap "echo exit" EXIT; kill -PWR $$; echo still here'
   Power failure
   $ bash -c 'trap "echo exit" EXIT; trap "exit" PWR; kill -PWR $$; echo 
still here'
   exit

> I'm not sure what The Open Group is planning to do and whether or not
> we're getting any clarification regarding this.

POSIX is making it unspecified what happens here:

   https://austingroupbugs.net/view.php?id=621

     The EXIT condition shall occur when the shell terminates normally
     (exits), and may occur when the shell terminates abnormally as a
     result of delivery of a signal (other than SIGKILL) whose trap
     action is the default.

The original proposed resolution listed a number of signals that would 
be required to be caught and to have EXIT handlers run. There were 
objections to that proposed resolution, it seemed unreasonable to 
require shells to install signal handlers for signals that scripts do 
not explicitly request signal handlers for.

Cheers,
Harald van Dijk
