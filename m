From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: Tests [ 0 -eq $UID ] don't work as in bash
Date: Wed, 7 Sep 2016 21:02:18 +0100
Message-ID: <20160907200218.GA28963@chaz.gmail.com>
References: <CAFOXTdceLsR_xBcs=B2QajQHW_UJyBKTr6R8fQvUNCxikYn77w@mail.gmail.com>
 <1473263700.7265.3.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38859 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbcIGUCW (ORCPT <rfc822;dash@vger.kernel.org>);
        Wed, 7 Sep 2016 16:02:22 -0400
Received: by mail-wm0-f43.google.com with SMTP id 1so52049894wmz.1
        for <dash@vger.kernel.org>; Wed, 07 Sep 2016 13:02:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1473263700.7265.3.camel@mad-scientist.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Paul Smith <paul@mad-scientist.net>
Cc: Andrey Voropaev <voropaev.andrey@gmail.com>, dash@vger.kernel.org

2016-09-07 11:55:00 -0400, Paul Smith:
> On Wed, 2016-09-07 at 16:44 +0200, Andrey Voropaev wrote:
> > if [ 0 -eq $UID ]
> 
> The variable UID is not defined to be automatically set by the shell in
> POSIX; having it set is a bash extension.  dash doesn't set it
> automatically for you.
> 
> You'll have to set it yourself:
> 
>   UID=$(id -u)
> 
> Also you should quote variable references, in general:
> 
>   if [ 0 -eq "$UID" ]
> 
> Be sure that if your scripts rely on bash-isms you start them with
> #!/bin/bash and if you don't want them to rely on bash-isms, you start
> them with #!/bin/sh.
[...]

Note that both zsh and bash have it, both from the start, both
copied from tcsh ($uid in tcsh).

In zsh, you can also set UID (and USERNAME and EUID, and GID...)
to change your uid (assuming you have the permission to do so).

$ sudo zsh -c 'id; UID=1000; id; UID=0'
uid=0(root) gid=0(root) groups=0(root)
uid=1000(chazelas) gid=0(root) groups=0(root)
zsh:1: failed to change user ID: operation not permitted

In bash, UID is read-only.

-- 
Stephane
