From: =?iso-8859-1?Q?Lo=EFc?= Minier <lool@dooz.org>
Subject: Re: exit-ing in a trap handler uses the wrong exit code
Date: Sat, 25 Sep 2010 23:42:23 +0200
Message-ID: <20100925214223.GA4254@bee.dooz.org>
References: <20100925115900.GA9732@bee.dooz.org>
 <20100925203404.GA93010@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from duck.dooz.org ([194.146.227.125]:49868 "EHLO duck.dooz.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab0IYVmd (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 25 Sep 2010 17:42:33 -0400
Content-Disposition: inline
In-Reply-To: <20100925203404.GA93010@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: dash@vger.kernel.org

On Sat, Sep 25, 2010, Jilles Tjoelker wrote:
> You are certainly right that POSIX requires this to be handled
> differently, but there are various other shells that are non-complian=
t
> in the same way as dash and it is easy to avoid the behaviour, so I
> would not recommend depending on it.

 I don't know why it was put there in the first place, but my first
 reaction was to send patch to remove the use of exit in the trap
 handler:
    http://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01803.html
 but the discussion led me to report this bug against dash

 Thanks for your detailed reply!  Am I also expected to log this issue
 somewhere for tracking?

    Cheers,
--=20
Lo=EFc Minier
