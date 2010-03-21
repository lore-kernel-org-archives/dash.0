From: Ron <ron@debian.org>
Subject: Re: Bug#558989: dash reverses the established logic of test -nt
 -ot (and maybe others)
Date: Mon, 22 Mar 2010 01:44:56 +1030
Message-ID: <20100321151456.GG18169@audi.shelbyville.oz>
References: <20091201021344.14042.9206.reportbug@audi.shelbyville.oz>
 <20100319151146.23869.qmail@744038cb003b89.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from ppp118-210-118-127.lns20.adl2.internode.on.net ([118.210.118.127]:56910
	"EHLO audi.shelbyville.oz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751532Ab0CUPZI (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 21 Mar 2010 11:25:08 -0400
Content-Disposition: inline
In-Reply-To: <20100319151146.23869.qmail@744038cb003b89.315fe32.mid.smarden.org>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: 558989@bugs.debian.org
Cc: dash@vger.kernel.org


Hi Gerrit, Herbert,

On Fri, Mar 19, 2010 at 04:11:46PM +0100, Gerrit Pape wrote:
> severity 558989 important
> tags 558989 + wontfix
> quit
> 
> On Tue, Dec 01, 2009 at 12:43:44PM +1030, Ron wrote:
> > Dash should not implement -nt at all if it wants to be strict about
> > things that aren't POSIX.  If it is going to implement non standard
> > things from other sources, then it absolutely should not be inventing
> > entirely new behaviours for them from whole cloth, let alone completely
> > reversing the logic of existing long established code.
> 
> Hi, here's upstream's opinion on this
>  http://www.mail-archive.com/dash@vger.kernel.org/msg00208.html
> 
> I don't think we should make a Debian-specific change for that, hence I
> mark the bug wontfix.

I can sympathise with you not wanting to fork this from upstream (thus
opening a window for ever greater lulz), but if I accept the validity of
Herbert's argument - that this is a BSD shell, with longstanding and
documented behaviour - as a reason not to change this, then doesn't the
very same reasoning at least equally apply to silently changing the
behaviour of the Debian default bin/sh?

He does also say though, that "existing features are not removed unless
there is a very good reason".  Does widely adopting this as a distro
default shell, by a growing number of distros, not count here as a
"very good reason"?

Herbert, could we at least make this optional, so it could be disabled
at compile time?  Or perhaps better, have it disabled when it is called
as /bin/sh, leaving dash still compatible for people already calling it
specifically as that?

Cheers,
Ron


[ I do still consider this an RC issue for Debian, I wouldn't be happy
  releasing squeeze with a surprise like this in it for existing long
  time users.  But I'll save speculation on other options until we get
  some ack or nack from Herbert on the above.  They're surely among
  the easiest options I can see, and if all distros are going this way
  we're not going to be the only ones wanting some solution to it. ]


