From: Guido Berhoerster <gber@opensuse.org>
Subject: Re: exec command and error checking
Date: Wed, 29 Jan 2014 00:18:16 +0100
Message-ID: <20140128231816.GC17217@hal.lan>
References: <CAEmTpZGqBfdBQDnmw-TozGTXpUxShCC=rWObhaP4zmKFJu4jUw@mail.gmail.com>
 <20140128131759.GA17217@hal.lan>
 <20140128215916.GA59221@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from multivac.heapoverflow.de ([78.47.51.218]:34255 "EHLO
	multivac.heapoverflow.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbaA1XSV (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 28 Jan 2014 18:18:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by multivac.heapoverflow.de (Postfix) with ESMTP id 6E37120680
	for <dash@vger.kernel.org>; Wed, 29 Jan 2014 00:18:20 +0100 (CET)
Received: from hal.lan (p5DC59457.dip0.t-ipconnect.de [93.197.148.87])
	by multivac.heapoverflow.de (Postfix) with ESMTPSA id 4504520259
	for <dash@vger.kernel.org>; Wed, 29 Jan 2014 00:18:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140128215916.GA59221@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

* Jilles Tjoelker <jilles@stack.nl> [2014-01-28 23:06]:
> On Tue, Jan 28, 2014 at 02:17:59PM +0100, Guido Berhoerster wrote:
> > That's either a bug or an intended deviation from the POSIX
> > standard, you'll have to ask on the bug-bash list about that.
> 
> The inconsistency appears to be in the behaviour on fatal errors in
> interactive shells. Strictly speaking, POSIX seems to require that the

bash actually exhibits this behavior as a non-interactive shell
and in POSIX mode as well.
-- 
Guido Berhoerster
