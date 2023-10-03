Return-Path: <dash-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F9FE75440
	for <linux-dash@archiver.kernel.org>; Tue,  3 Oct 2023 10:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbjJCKFF (ORCPT <rfc822;linux-dash@archiver.kernel.org>);
        Tue, 3 Oct 2023 06:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbjJCKFD (ORCPT <rfc822;dash@vger.kernel.org>);
        Tue, 3 Oct 2023 06:05:03 -0400
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Oct 2023 03:04:56 PDT
Received: from mail.aegee.org (mail.aegee.org [144.76.142.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A01F0
        for <dash@vger.kernel.org>; Tue,  3 Oct 2023 03:04:56 -0700 (PDT)
Received: from webmail.aegee.org (localhost [127.0.0.1])
        by mail.aegee.org (8.17.2/8.17.2) with ESMTP id 3939sxCH3531742;
        Tue, 3 Oct 2023 09:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1696326899; i=dkim+sm-localhost@aegee.org;
        bh=E0dzK9yLFSp/5Dq7R7xWz043HOV2ITaQc54IWhT4WAo=;
        h=Date:From:To:Subject;
        b=BMOHEb6/WS4aGAPR7mjc6vQKCk9j5VLowMiNa8Zhfj+eLoIaqGN02ZvK1FrtAb+Wo
         4yyg46S7utyVyCy6okmzIGWQSsYXpaCkHSG7vYx90U6+FroqlJe8pyaXETVPfB2EX6
         7AyHkRhHP13i4gexJ6P3bTcG3PjtZv6JJXoji0n5YKka94oSA9FXY5fohLNXXDn3+3
         9lmiRz90LJu4feYeHe6Ml6BGw+94y8YcCxKodIeZLXc4KoqXnvstGrTWLwEw+ajkZM
         QeAy9XeGjmEJcy33k1UKw0N25xap+JY1MY9CebaW0EBaDNLCjeRv6RMGPAqLeODKu3
         UQqSOETTiZ9MQox5mPv+QKYhAX/+9nSH1WPt3zhNcspWEb1W2+DtraPRdzA0E0L4W1
         bKsB7Vu5sdmIkFHdrFS3zwmxvSg2YSHiSJId3nlYRzAeSxiRDALq792byf3V4hbV8S
         kK4uDPaTC5ozWTIYi83QITupj8AuK5jeZO2KOfy4cqThAcAtR+tKv9LdT37NpN9bi0
         72wdA/4CQpXHGaVr8UOWUuR4iGGc7Poz3tmGJb/G8I85nezNwR2bKGFgX6+ehbk3DU
         7ZcHzEpvVWKXd/0XjW0VN0KZQwteNBcqTyyJw+AMs46FZwCT2loCM4+0rCmVoKzv/C
         2iavHLDfDxtfZE607sTHhOa4=
Authentication-Results: mail.aegee.org/3939sxCH3531742; dkim=none
MIME-Version: 1.0
Date:   Tue, 03 Oct 2023 11:54:59 +0200
From:   =?UTF-8?Q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD_=D0=9F=D0=B0=D0=BB=D0=B0?=
         =?UTF-8?Q?=D1=83=D0=B7=D0=BE=D0=B2?= <dilyan.palauzov@aegee.org>
To:     dash@vger.kernel.org, 1053394@bugs.debian.org
Subject: dash should not propagate aliases to subshells
Message-ID: <0d627a69d4a68302a86801817751a84e@aegee.org>
X-Sender: dilyan.palauzov@aegee.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dash.vger.kernel.org>
X-Mailing-List: dash@vger.kernel.org

To: 1053394@bugs.debian.org, dash@vger.kernel.org

Hello,

https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_03_01 
says:

2.3.1 Alias Substitution

When used as specified by this volume of POSIX.1-2017, alias definitions 
shall not be inherited by separate invocations of the shell or by the 
utility execution environments invoked by the shell.


So a subshell shall have no knowledge about the aliases from the 
supershell, and backticks start a subshell.

These programs

#!/bin/bash
alias wslpath=echo
find `wslpath /tmp`

and

#!/bin/dash
alias wslpath=echo
find `wslpath /tmp`

produce different results (bash 5.2.15-3.fc38,  dash 0.5.12-1.fc38) when 
executed on a WSL2 system.  The former program shows the content of the 
current directory, the latter program shows the content of /tmp .

Moreover, I filled this initially towards the Debian Bug tracking system 
(cf. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1053394) , and 
was then told to check http://gondor.apana.org.au/~herbert/dash/ .

Please include in the repository 
https://git.kernel.org/pub/scm/utils/dash/dash.git links to 
http://gondor.apana.org.au/~herbert/dash/ and dash@vger.kernel.org , for 
instance in src/dash.1, so that it is documented where to report 
problems in dash.

Kind regards
   Dilyan
