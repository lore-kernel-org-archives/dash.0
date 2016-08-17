From: Olof Johansson <olof@ethup.se>
Subject: Re: Parameter expansion, patterns and fnmatch
Date: Wed, 17 Aug 2016 16:50:33 +0200
Message-ID: <20160817145033.GE23983@brutus.ethup.se>
References: <20160809092832.GB23983@brutus.ethup.se>
 <0ce0bca2-3bdd-a1f5-169e-0291a49cd6c7@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from brutus.ethup.se ([85.17.45.102]:56486 "EHLO brutus.ethup.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbcHQOui (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 17 Aug 2016 10:50:38 -0400
Content-Disposition: inline
In-Reply-To: <0ce0bca2-3bdd-a1f5-169e-0291a49cd6c7@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>, dash@vger.kernel.org

On 2016-08-09 23:39 +0200, Harald van Dijk wrote:
> Yes, this looks like a bug in dash. With the default
> --disable-fnmatch code, when dash encounters [ in a pattern, it
> immediately treats the following characters as part of the set. If
> it then encounters the end of the pattern without having seen a
> matching ], it attempts to reset the state and continue as if [ was
> treated as a literal character right from the start. The attempt to
> reset the state doesn't look right, and has been like this since at
> least the initial Git commit in 2005.
> 
> This also affects
> 
>     case [a in [?) echo ok ;; *) echo bad ;; esac
> 
> which should print ok.
> 
> Attached is a patch that attempts to reset the state correctly. It
> passes your test and mine, but I have not yet tested it extensively.

Thanks a lot! For what it's worth, I've been using dash with this
patch this for about a week now, including building a lot of open
source software (via OpenEmbedded). I haven't seen any issues yet.

-- 
Olof Johansson                            https://github.com/olof
