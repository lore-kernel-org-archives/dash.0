From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: dash drops exported bash functions
Date: Thu, 11 Feb 2016 14:46:37 +0000
Message-ID: <20160211144637.GA15471@chaz.gmail.com>
References: <alpine.LNX.2.00.1602110431550.61314@lxbroy10.informatik.tu-muenchen.de>
 <alpine.LNX.2.00.1602111309450.33198@lxbroy10.informatik.tu-muenchen.de>
 <alpine.LNX.2.00.1602111436050.40543@lxbroy10.informatik.tu-muenchen.de>
 <20160211141936.GC17349@brutus.ethup.se>
 <alpine.LNX.2.00.1602111526570.44882@lxbroy10.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33319 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcBKOql (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 11 Feb 2016 09:46:41 -0500
Received: by mail-wm0-f43.google.com with SMTP id g62so24370549wme.0
        for <dash@vger.kernel.org>; Thu, 11 Feb 2016 06:46:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1602111526570.44882@lxbroy10.informatik.tu-muenchen.de>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Makarius <makarius@sketis.net>
Cc: Olof Johansson <olof@ethup.se>, dash@vger.kernel.org

2016-02-11 15:30:59 +0100, Makarius:
[...]
> The problem is a deeper one, though: export -f in bash no longer
> works for systems that have /bin/sh -> dash (i.e. Debian and
> Ubuntu).
[...]

Note that pdksh/posh/mksh also strip those variables which it
can't map to shell variable names (and have for decades).

-- 
Stephane
