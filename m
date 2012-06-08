From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Command parsing problem and tracefile
Date: Fri, 8 Jun 2012 16:30:18 -0500
Message-ID: <20120608213018.GA13550@burratino>
References: <4FD22F1B.3090208@gmail.com>
 <20120608171730.GG10380@burratino>
 <4FD26CA5.6090602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40612 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651Ab2FHVa2 (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 8 Jun 2012 17:30:28 -0400
Received: by yhmm54 with SMTP id m54so1630988yhm.19
        for <dash@vger.kernel.org>; Fri, 08 Jun 2012 14:30:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FD26CA5.6090602@gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Richard H Lee <ricardohenrylee@gmail.com>
Cc: dash@vger.kernel.org

Richard H Lee wrote:

> It didn't occur to me to try other shells. I get the same error with
> bash. It makes me wonder why it occurs on three different shells?

Yes, that's because it's a bug in the configure script, not dash.

Your best bet is to contact whoever provided that configure script
and explain that --enable-static is not working for you.  The
specification that defines POSIX shell script syntax can be found at
<http://unix.org/2008edition/>.

Good luck,
Jonathan
