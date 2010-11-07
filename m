From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: sensible "local" support?
Date: Sun, 7 Nov 2010 12:28:23 -0600
Message-ID: <20101107182823.GB31470@burratino>
References: <871v6xclyb.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33359 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0KGS2f (ORCPT <rfc822;dash@vger.kernel.org>);
	Sun, 7 Nov 2010 13:28:35 -0500
Received: by gyh4 with SMTP id 4so2990506gyh.19
        for <dash@vger.kernel.org>; Sun, 07 Nov 2010 10:28:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871v6xclyb.fsf@meyering.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
Cc: dash@vger.kernel.org

Jim Meyering wrote:

> Would you be open to the idea of making dash's "local" work more
> like the scope modifier that its name implies than like a separate
> command in which assignments have different semantics?
>
> To be clear, "local" is not standardized, so the change I'm advocating
> would not be a bug fix ;-)  However, it would make dash align with
> bash and zsh, and imho, with common sense.

FYI:
https://www.opengroup.org/sophocles/show_mail.tpl?source=L&listname=austin-group-l&id=14935
