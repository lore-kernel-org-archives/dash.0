From: Stephane Chazelas <stephane.chazelas@gmail.com>
Subject: Re: % in $PATH
Date: Mon, 10 Nov 2014 22:23:32 +0000
Message-ID: <20141110222332.GB3938@chaz.gmail.com>
References: <20141105115946.GA4029@chaz.gmail.com>
 <20141110132002.GA8372@gondor.apana.org.au>
 <20141110213048.GA3938@chaz.gmail.com>
 <20141110215938.GA25437@hal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38099 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaKJWXg (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 17:23:36 -0500
Received: by mail-wi0-f182.google.com with SMTP id d1so12107324wiv.9
        for <dash@vger.kernel.org>; Mon, 10 Nov 2014 14:23:34 -0800 (PST)
Received: from chaz.gmail.com (5ec33b79.skybroadband.com. [94.195.59.121])
        by mx.google.com with ESMTPSA id u5sm15049135wiz.9.2014.11.10.14.23.33
        for <dash@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 14:23:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141110215938.GA25437@hal.lan>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

2014-11-10 22:59:38 +0100, Guido Berhoerster:
[...]
> A much nicer solution would be to do something similar to the
> original Korn shell and assign additional builtins a virtual
> path which can be freely assigned in PATH and with which they can
> be explicitly called. No more "%" in PATH and the feature can
> be retained.
[...]

Sounds to me like it's what dash does. It has %builtin (or
/%builtin) where ksh93 has /opt/ast/bin.

With ksh93, that's only for a few extra builtins that are only
enabled if you add /opt/ast/bin to $PATH (or you can call them
with "command /opt/ast/bin/cat").

I wouldn't say it's much better, it's still bad as being the
hijacking of one namespace for something else.

dash's %builtin (as opposed to /path/to/functions%func) is
potentially dangerous though because if you have that in your
$PATH, you're vulnerable to attackers planting %builtin
directories (in /tmp for instance) which will be considered by
other things than dash/ash when looking up $PATH.

That's worked around by using /%builtin instead of %builtin
though.

-- 
Stephane
