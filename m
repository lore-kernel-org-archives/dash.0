From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] dash doesn't report syntax error when it should on stray
 "fi"
Date: Mon, 23 Apr 2012 14:54:58 -0500
Message-ID: <20120423195458.GB13576@burratino>
References: <4F958907.9030508@gmail.com>
 <20120423170339.GA9635@burratino>
 <4F95AD25.3060200@case.edu>
 <20120423194453.GA13576@burratino>
 <4F95B1F8.8080502@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40809 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab2DWTzE (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 23 Apr 2012 15:55:04 -0400
Received: by iadi9 with SMTP id i9so2437793iad.19
        for <dash@vger.kernel.org>; Mon, 23 Apr 2012 12:55:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F95B1F8.8080502@case.edu>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Chet Ramey <chet.ramey@case.edu>
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>, dash@vger.kernel.org

Chet Ramey wrote:

> The way I read 2.10.2, Posix requires that the "fi" resolve to the
> reserved word `fi' in this case, since it's in a position where a
> command name is expected (Rule 1, [Command Name]).  I would think that
> would make it a syntax error in any application, conforming or not.

Yes, I think you're right.

For some reason I thought that using reserved words in ways not
permitted by the grammar produced undefined behavior, to support
shells with extensions like the arithmetic "for".  But now that I read
more closely, it looks like "function", "[[", "]]", and "select"
produce unspecified behavior but everything else is pretty well
specified.  Thanks for clarifying.
