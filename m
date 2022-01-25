Return-Path: <dash-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71760C433F5
	for <linux-dash@archiver.kernel.org>; Tue, 25 Jan 2022 21:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiAYVUa (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 25 Jan 2022 16:20:30 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:46135 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiAYVU2 (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 25 Jan 2022 16:20:28 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 16:20:27 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643144901;
    s=strato-dkim-0002; d=lorke.de;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=+r8m05EleBbiGg6k8fNNgfFIZKot58IvDIBph0Va6mY=;
    b=dCaUOVq1Rb4f9Fe23GHv2MoU2AWeRBkAnrh/7+HH6FtoCqMvcGZeFTmLBkxWaZSgMa
    ATMheAbIH+WEZpXGAOq/yimiyYEtfql3t1gTf25VXc3gT3mUEAB7aLJLHVlVr/UGHEJJ
    Yki+22AX8CvXMhorAtDE0XOfV9s2dl3h6UcmrU1GStNv3wDIkMLhtXKEEbS2WRcM0Pi9
    QEDo8r0hsBlXwJuLbl+OtD9XZS6IOsIYV4aXs77gfkAcPvlnhdD37wqLZXqRiEploMyY
    H20mbuUQqoKs1tcth0P1NcxZqJ+dF5ACK7DG0LAEYPbdtnwk4QlElLrKhXeyoz5g639l
    6akg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkWYUind/sPg6+jpcKJzU88Td0kzv/qdwAut5fBNI54jQKR6GCTRo0Uz+h97EUi+PSA"
X-RZG-CLASS-ID: mo00
Received: from [141.23.174.45]
    by smtp.strato.de (RZmta 47.38.0 AUTH)
    with ESMTPSA id L37157y0PL8LKvk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <dash@vger.kernel.org>;
    Tue, 25 Jan 2022 22:08:21 +0100 (CET)
Message-ID: <bdc481b1-79b4-7f93-97da-8a4b01c41be0@lorke.de>
Date:   Tue, 25 Jan 2022 22:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     dash@vger.kernel.org
From:   Berthold Lorke <berthold@lorke.de>
Subject: PS1 is not implemented as specified in IEEE Std 1003.1-2017
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello!

The POSIX standard specifies for PS1 
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html


```
PS1

Each time an interactive shell is ready to read a command, the value of 
this variable shall be subjected to parameter expansion and written to 
standard error. The default value shall be "$ ". For users who have 
specific additional implementation-defined privileges, the default may 
be another, implementation-defined value. The shell shall replace each 
instance of the character '!' in PS1 with the history file number of the 
next command to be typed. Escaping the '!' with another '!' (that is, 
"!!" ) shall place the literal character '!' in the prompt. This volume 
of POSIX.1-2017 specifies the effects of the variable only for systems 
supporting the User Portability Utilities option.
```

Your manual pages say

```
PS1

The primary prompt string, which defaults to “$ ”, unless you are the 
superuser, in which case it defaults to “# ”.
```

I also tried it out, the exclamation mark functionality doesn't work.

Is this as intended?


Kind regards
Berthold Lorke
