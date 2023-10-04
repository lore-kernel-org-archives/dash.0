Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E5FE8FDDB
	for <linux-dash@archiver.kernel.org>; Wed,  4 Oct 2023 08:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjJDIrR (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Wed, 4 Oct 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjJDIrQ (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 4 Oct 2023 04:47:16 -0400
Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755F98
        for <dash@vger.kernel.org>; Wed,  4 Oct 2023 01:47:12 -0700 (PDT)
Received: from webmail.aegee.org (localhost [127.0.0.1])
        by mail.aegee.org (8.17.2/8.17.2) with ESMTP id 3948lBKF3795601
        for <dash@vger.kernel.org>; Wed, 4 Oct 2023 08:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1696409231; i=dkim+sm-localhost@aegee.org;
        bh=o5EHD3SYsE/aSTCKIJG8ABMBHsk7OmXLNbiuoKaVJNA=;
        h=Date:From:To:Subject;
        b=Blb7zYlTp5K/aGjOjwYXA2/A9NUWtNNUfkPwqyNE6iUvDIYqdCnmbGg+dW/H1Mj43
         Q9sCf8sr5KxoXZag9uKmhzX9/nwYTPM1elmdQv71vZtog2rOgqbZwign5W+ENVpybM
         ttZuWIe99hIQZCq2w12qIMZRR9B1tO+3JHVceI/4qY3GkV+xcdDeM3iY6cmyVxQMfW
         KOLUmNIODq55m8KoPnU15653vErDppDYHA2YYHU0+RduwRqlmhAID1ssYSL9Fr2emT
         oOwbMoEBup1NZtbtjJmURgbLGaUxp2WhIoy3QLteeGoKUad11xNX9Wt7HxwHftG+tc
         q8NyRy+AKuG79TN9RSUX6yiR1vRRDiA5J3ha5lUmSjg1Pu8PBeZkvUwacYkTIae09f
         LRX1Kiz/C24F4Y5DIMLzV9KBH2TtVLHGtlizyeRXe7UIRQrMtVzYaUzbrFM8brXEt/
         BB5SuXxDnQnQM8SXFfpS383fv9/HmyOfeuLn2FjW91gLTmtH2MvT3QlCfRvBNGmgil
         ardNEM/U6WFRS540EKCTKhTlC7eO26jgGFomXA+nTRn4Q4LTXpqbjLACf4dDA8tcw2
         r2kI+FBA+zke+oJPD15X7WDrYA+NSFFWeKwvreDzWrtOw5TgplrC4mWNxVY0PIMW6d
         3I0gI2j8uPesIqwa5uInjMRw=
Authentication-Results: mail.aegee.org/3948lBKF3795601; dkim=none
MIME-Version: 1.0
Date:   Wed, 04 Oct 2023 10:47:10 +0200
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_=D0=9F=D0=B0=D0=BB=D0=B0?=
         =?UTF-8?Q?=D1=83=D0=B7=D0=BE=D0=B2?= <dilyan.palauzov@aegee.org>
To:     dash@vger.kernel.org
Subject: Printing C:\abc in a portable way
Message-ID: <bc35891262faa710fa1f0dc08233c5fe@aegee.org>
X-Sender: dilyan.palauzov@aegee.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

Hello,

I want to print C:\abc in a portable way.  Or rather, store the value 
C:\abc in a variable.  I have bash 5.2.15-3.fc38 and dash 0.5.12-1.fc38. 
  /bin/sh is a symlink to bash.

In interactive bash

echo "C:\\abc"

prints

C:\abc . The same happens when I store in a file and execute it:

#!/bin/bash
echo "C:\\abc"


#!/bin/bash --posix
echo "C:\\abc"


#!/bin/sh
echo "C:\\abc"

With dash it is different:

#!/bin/dash
echo "C:\\abc"

prints C:bc .  When I replace above a with k, echo "C:\\kbc" prints 
C:\kbc .

When I replace the double quotes with single quotes, echo 'C:\\abc' , 
dash prints C:\abc, but bash (interactive, /bin/sh and bash --posix) 
prints C:\\abc .

All that said I think this is a bug in dash.

The above echos are simplified use case, in reality I want to execute 
A="C:\\abc" ./script and the script shall see C:\abc as value to the 
variable A.

Kind regards
   Dilyan
