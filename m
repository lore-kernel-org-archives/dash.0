From: Antti Kantee <pooka@rumpkernel.org>
Subject: Re: Dash commit 46d3c1a (in 0.5.8+) breaks BSD make
Date: Fri, 4 Mar 2016 14:24:17 +0000
Message-ID: <56D99A91.2010901@rumpkernel.org>
References: <20160304140635.GB2457@nodbug.lucina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail.cs.hut.fi ([130.233.192.7]:54204 "EHLO mail.cs.hut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbcCDOdV (ORCPT <rfc822;dash@vger.kernel.org>);
	Fri, 4 Mar 2016 09:33:21 -0500
In-Reply-To: <20160304140635.GB2457@nodbug.lucina.net>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org, rumpkernel-users@freelists.org

On 04/03/16 14:06, Martin Lucina wrote:
> Commit 46d3c1a ([VAR] Sanitise environment variable names on entry)
> restricts exported environment variables actually set by dash on entry to
> those reported as valid by endofname(). While this is technically correct
> and matches IEEE Std 1003.1, it breaks BSD make which uses '.' as a
> separator in variables exported via the environment to a sub-make.

I wouldn't go so far as to say it breaks BSD make.  Rather, it breaks a 
rare pattern where variables containing "." (where "." follows a certain 
convention) are passed to submakes via the shell (i.e. ".export" in the 
Makefile).

> Would the dash maintainers consider replacing 46d3c1a with a fix that
> performs the name validity check at "export -p" time instead? If yes, I can
> try my hand at a patch.

There are probably enough deployments of dash with this behaviour so 
that we need in any case need to remove the use of variables containing 
"." coupled with ".export" from Makefiles.  Changing dash doesn't sound 
useful to me.
