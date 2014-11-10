From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: % in $PATH
Date: Mon, 10 Nov 2014 23:39:51 +0100
Message-ID: <20141110223951.GB25437@hal.lan>
References: <20141105115946.GA4029@chaz.gmail.com>
 <20141110132002.GA8372@gondor.apana.org.au>
 <20141110213048.GA3938@chaz.gmail.com>
 <20141110215938.GA25437@hal.lan>
 <20141110222332.GB3938@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:39869 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbaKJWjk (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 10 Nov 2014 17:39:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id 03DD620514
	for <dash@vger.kernel.org>; Mon, 10 Nov 2014 23:39:39 +0100 (CET)
Received: from hal.lan (p5B219B24.dip0.t-ipconnect.de [91.33.155.36])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id 7C238200F6
	for <dash@vger.kernel.org>; Mon, 10 Nov 2014 23:39:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141110222332.GB3938@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* Stephane Chazelas <stephane.chazelas@gmail.com> [2014-11-10 23:23]:
> 2014-11-10 22:59:38 +0100, Guido Berhoerster:
> [...]
> > A much nicer solution would be to do something similar to the
> > original Korn shell and assign additional builtins a virtual
> > path which can be freely assigned in PATH and with which they can
> > be explicitly called. No more "%" in PATH and the feature can
> > be retained.
> [...]
> 
> Sounds to me like it's what dash does. It has %builtin (or
> /%builtin) where ksh93 has /opt/ast/bin.

That's kind of the point, this thread started about the trouble
that the "%" causes, using a virtual path like /usr/libexec/dash
or so instead should avoid the issue. That leaves the /path%func
case but there is precendence with FPATH as a solution if "%" is
to be completely eliminated from PATH.

> With ksh93, that's only for a few extra builtins that are only
> enabled if you add /opt/ast/bin to $PATH (or you can call them
> with "command /opt/ast/bin/cat").
> 
> I wouldn't say it's much better, it's still bad as being the
> hijacking of one namespace for something else.
> 
> dash's %builtin (as opposed to /path/to/functions%func) is
> potentially dangerous though because if you have that in your
> $PATH, you're vulnerable to attackers planting %builtin
> directories (in /tmp for instance) which will be considered by
> other things than dash/ash when looking up $PATH.
> 
> That's worked around by using /%builtin instead of %builtin
> though.
> 
> -- 
> Stephane
> --
> To unsubscribe from this list: send the line "unsubscribe dash" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Guido Berhoerster
