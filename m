From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Dash's web presence
Date: Tue, 8 Mar 2011 01:38:25 -0600
Message-ID: <20110308073824.GA25856@elie>
References: <AANLkTi=eTw8jTtDGG-xBj6ycfnkvBGgY-G2W-r0WPBgy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gw0-f51.google.com ([74.125.83.51]:64877 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab1CHHic (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 8 Mar 2011 02:38:32 -0500
Received: by gwb15 with SMTP id 15so2992475gwb.10
        for <dash@vger.kernel.org>; Mon, 07 Mar 2011 23:38:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=eTw8jTtDGG-xBj6ycfnkvBGgY-G2W-r0WPBgy@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Dan Muresan <danmbox@gmail.com>
Cc: dash@vger.kernel.org

Hi,

Some quick answers.

Dan Muresan wrote:

> Does it look like a major project's page? Does the URL even look stable?

Yes, to me it does.  Lots of low-level tools with single maintainers
have pages like that --- e.g.,

	http://invisible-island.net/xterm/xterm.html

Was it lacking some information you needed?  Do you know someone
willing to buy up dash dot org to make it redirect there?

> Going further, where is dash's mailing list? The link on that
> "homepage" points to a read-only archive.

This complaint I agree with.  It might be a good idea to let Herbert
know so he can change the link to point to
http://vger.kernel.org/vger-lists.html#dash

> Why did I sign up for this list? I wanted to report a bug. By the way,
> where is dash's bug tracker?

A bug tracker makes no sense if no one is maintaining it.  Do you know
someone interested in doing that work?

> For the default Debian /bin/sh,

Debian has a bug tracker.

> I would expect a more dignified web presence

Do you know anyone interested in making a new web site?  That's how
many projects got their fancy pages --- someone had a better idea for
what the webpage should look like and the original page was changed to
redirect to their page.  See for example
http://mercurial.selenic.com/thepage/

> and a more transparent development.

I haven't noticed development going on behind doors.  What does this
even mean?  Patches get sent to the list, discussed on the list, then
committed to the git repository.

Hope that clarifies some things.
Jonathan
