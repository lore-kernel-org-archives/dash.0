From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG?] here documents, command substitution, and the { keyword
Date: Sat, 6 Nov 2010 21:30:02 -0500
Message-ID: <20101107023002.GA22887@burratino>
References: <20101107022121.GA22719@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53262 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0KGCaN (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 6 Nov 2010 22:30:13 -0400
Received: by gyh4 with SMTP id 4so2840026gyh.19
        for <dash@vger.kernel.org>; Sat, 06 Nov 2010 19:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101107022121.GA22719@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Jonathan Nieder wrote:

> $ sh test.sh
> hello
> test.sh: 7: {: not found
> 127
> hello
> test.sh: 10: Syntax error: "}" unexpected
> 
> bash, mksh, pdksh, and ksh93 all print hello as expected.  The problem
> is reproducible with all versions of dash in the git repo.

err, by this I mean:

 $ bash test.sh
 hello
 $

and that the strange dash behavior is reproducible with 016b529 and
05c1076ba2 (I didn't try the revisions in between).  Sorry for the noise.
