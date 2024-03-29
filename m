Received: from mail02.stack.nl (scw01.stack.nl [51.15.111.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F985942
	for <dash@vger.kernel.org>; Fri, 29 Mar 2024 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.15.111.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720769; cv=none; b=Cqtd0hxZ3n1lzo7caz4ADifRalt9BuBL9ublPKjlu+IvqMKX8B1xN4hgUeGRJShmEt5bMenQvnXCGOFXPZ+83X3lUr17k7h/slpXWocE0PJ+PB88h3Y6uAirodi2faATDqDMis4+QvGf8UeOYN2b0DWIPzLs/BD12DwmQkgNKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720769; c=relaxed/simple;
	bh=VfSlY0u9TMd/srEGp1Q73+gr7biYbRd88L3+fT2NMIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8UW8/p8q54KcvQMAaEUZ1WXMKAq0Iwim6Kh6+E7W/C8favGa+Xz/GD/CF2OzHablPsTXZ7JUWd5/lTCx8rpFlKvN+kZDasEYJsf6qXb3Q0km2GSSsxYuHwMy4MekToEwPBuL69efwWZAJ3tPkl40s3Vdq00ihy7cAAMscOpVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl; spf=pass smtp.mailfrom=stack.nl; arc=none smtp.client-ip=51.15.111.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stack.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stack.nl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail02.stack.nl (Postfix) with ESMTP id EA0451E0157;
	Fri, 29 Mar 2024 13:50:42 +0000 (UTC)
Received: from mail02.stack.nl ([127.0.0.1])
	by localhost (mail02.stack.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y28NP5zPpJpI; Fri, 29 Mar 2024 13:50:39 +0000 (UTC)
Received: from blade.stack.nl (blade.stack.nl [192.168.121.130])
	by mail02.stack.nl (Postfix) with ESMTP id D572E1E0156;
	Fri, 29 Mar 2024 13:50:39 +0000 (UTC)
Received: by blade.stack.nl (Postfix, from userid 1677)
	id C0284237C50; Fri, 29 Mar 2024 14:50:39 +0100 (CET)
Date: Fri, 29 Mar 2024 14:50:39 +0100
From: Jilles Tjoelker <jilles@stack.nl>
To: Johannes Altmanninger <aclopte@gmail.com>
Cc: harald@gigawatt.nl, dash@vger.kernel.org
Subject: Re: [PATCH v2] Allow trap to un-ignore SIGINT in asynchronous
 subshells
Message-ID: <20240329135039.GA20398@stack.nl>
References: <b42dbf13-989d-4609-bbcb-8b9eababbe65@gigawatt.nl>
 <20240329112419.1571653-1-aclopte@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329112419.1571653-1-aclopte@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Mar 29, 2024 at 12:24:00PM +0100, Johannes Altmanninger wrote:
> Unlike in Bash or Zsh, this asynchronous job ignores SIGINT, despite
> builtin trap explicitly resetting the SIGINT handler.

> 	dash -c '( trap - INT; sleep inf ) &'

> POSIX[*] Section 2.11 on Signals and Error Handling says about
> background execution:

> > If job control is disabled (see the description of set -m) when
> > the shell executes an asynchronous list, the commands in the list
> > shall inherit from the shell a signal action of ignored (SIG_IGN)
> > for the SIGINT and SIGQUIT signals.  In all other cases, commands
> > executed by the shell shall inherit the same signal actions as those
> > inherited by the shell from its parent unless a signal action is
> > modified by the trap special built-in (see trap)

> It is not clear to me from this description whether the trap builtin is
> supposed to un-ignore SIGINT and SIGQUIT in the above asynchronous job.
> I think yes because processes like "sh -c 'trap ...'"  can already
> do that, so why treat subshells differently.  The Bash maintainer
> seems to agree when responding to a related bug report[**]
> although that one is not about subshells specifically.

> > The issue is that the processes in this list have to ignore SIGINT
> > [...] but they have to be allowed to use trap to change the signal
> > dispositions (POSIX interp 751)

> This issue exists because we "hard-ignore" (meaning ignore
> permanently) SIGINT and SIGQUIT in backgrounded subshells; I'm
> not sure why.  Git blame is not helpful since this existed since
> the initial Git import. I failed to find a test suite; no luck at
> http://www.opengroup.org/testing/testsuites/vscpcts2003.htm where I
> get SSL errors.

> Since I don't see any reason for hard-ignore logic, remove it
> altogether.  This means that either of

> 	trap - INT; trap - QUIT
> 	set -i

> in a backgrounded subshell will now un-ignore SIGINT and SIGQUIT.
> I did not find other behavior changes but maybe there is a good reason
> for S_HARD_IGN?

> [*]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
> [**]: https://lists.gnu.org/archive/html/bug-bash/2023-01/msg00050.html

There is definitely a good reason for S_HARD_IGN: it implements the
following requirement of the trap builtin (XCU 2.14 Special Built-In
Utilities -> trap):

] Signals that were ignored on entry to a non-interactive shell cannot
] be trapped or reset, although no error need be reported when
] attempting to do so. An interactive shell may reset or catch signals
] ignored on entry.

The change that should be made is that the automatic ignore of SIGINT
and SIGQUIT in background subshells should not use hard ignore. Hard
ignore still applies if the shell inherits ignored signals from its
parent.

-- 
Jilles Tjoelker
