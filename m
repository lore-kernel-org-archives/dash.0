From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: % in $PATH
Date: Mon, 10 Nov 2014 23:15:24 +0000
Message-ID: <20141110231524.GC3938@chaz.gmail.com>
References: <20141105115946.GA4029@chaz.gmail.com>
 <20141110132002.GA8372@gondor.apana.org.au>
 <20141110213048.GA3938@chaz.gmail.com>
 <20141110215938.GA25437@hal.lan>
 <20141110222332.GB3938@chaz.gmail.com>
 <20141110223951.GB25437@hal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59327 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaKJXP1 (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 18:15:27 -0500
Received: by mail-wi0-f174.google.com with SMTP id d1so12205590wiv.13
        for <dash@vger.kernel.org>; Mon, 10 Nov 2014 15:15:25 -0800 (PST)
Received: from chaz.gmail.com (5ec33b79.skybroadband.com. [94.195.59.121])
        by mx.google.com with ESMTPSA id ci9sm15153903wid.24.2014.11.10.15.15.24
        for <dash@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 15:15:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141110223951.GB25437@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2014-11-10 23:39:51 +0100, Guido Berhoerster:
[...]
> That leaves the /path%func
> case but there is precendence with FPATH as a solution if "%" is
> to be completely eliminated from PATH.
[...]

Where ash's $PATH handling is superior to $FPATH is that you can
specify which fpath component has precedence over which path
component and over builtins.

My problem as reported is that the namespace reserved by ash
(any component with % in it) was too wide (and
unnecessarily so). If you make it any component ending in %func
or %builtin, that's far less of an issue (as long as it's
documented).

I won't shed a tear if that feature is removed. I'm just feeling
it's not necessary to remove it, it could just be made more
innocuous.

-- 
Stephane
