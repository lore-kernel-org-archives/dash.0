Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E6C433EF
	for <linux-dash@archiver.kernel.org>; Fri, 22 Oct 2021 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703E1610A4
	for <linux-dash@archiver.kernel.org>; Fri, 22 Oct 2021 11:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhJVLWm (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Fri, 22 Oct 2021 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVLWm (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 22 Oct 2021 07:22:42 -0400
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Oct 2021 04:20:25 PDT
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36487C061764
        for <dash@vger.kernel.org>; Fri, 22 Oct 2021 04:20:25 -0700 (PDT)
Received: from postfix01.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout01.mail.de (Postfix) with ESMTP id 1BC5BA0B4A
        for <dash@vger.kernel.org>; Fri, 22 Oct 2021 13:11:45 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
        by postfix01.mail.de (Postfix) with ESMTP id 02AA78002F
        for <dash@vger.kernel.org>; Fri, 22 Oct 2021 13:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde202009; t=1634901105;
        bh=/hs6RxbhJ7VLzNmYVdp9s7TfHkYcgFIfzwXb7cuBuqw=;
        h=To:From:Subject:Date:From;
        b=wJCnm61WE8cV128lvcl3E1WNM9QmumP2cChA+S2ztGJ1Hp3X1LgfdmQBhZBzHpROz
         Dck5B5FXdzOECXmZmW9HDVa31IzAl3wm11rB5p86s2llG9ghX2FRuICSJrV8TdPO3L
         i/4f/+WQKQ39cBOYWwMZ0lVpLxr6lq6d7+nKGTfq+gRpuggDm1ZQI+/Abh7sjdw4MP
         Es2JRzxOTQhjgFy8ZJN0mhVN2YePCw+5W3q+hrihqy37ZToQKA2Nzp0RiJnwg7t+mF
         ODvg/ZblmfoBNe42VZC/kPIiNmqwU6w4pJvZbCM2WpEKz1EEO4JyNmckQegfZTq3uh
         WeHcUsQn+hfGA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp01.mail.de (Postfix) with ESMTPSA id 7BB751000CE
        for <dash@vger.kernel.org>; Fri, 22 Oct 2021 13:11:44 +0200 (CEST)
To:     dash@vger.kernel.org
From:   Tycho Kirchner <tychokirchner@mail.de>
Subject: stdin should be consumed line by line
Message-ID: <6640a8ee-eda0-1e35-df1a-c8b303440ca1@mail.de>
Date:   Fri, 22 Oct 2021 13:11:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 495
X-purgate-ID: 154282::1634901104-00006C31-07C42DCC/0/0
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Dear DASH developers,
I think stdin should be consumed line by line in order to make passing 
to other commands possible. Please consider the following difference 
between the stdin "consumption" between bash and dash

$ stdintest(){ printf 'echo one\ndash -c "while read -r row; do echo got 
row \$row; done" \necho two\n'; }
$ stdintest | dash
one
two
$ stdintest | bash
one
got row echo two
$


I think bash behaves "correct" here.

Thanks and kind regards
Tycho Kirchner
