From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] implement privmode support in dash
Date: Thu, 22 Aug 2013 22:35:00 +0200
Message-ID: <20130822203500.GA21467@stack.nl>
References: <20130822175936.GA1260@google.com>
 <52166DA8.1000201@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:52002 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753042Ab3HVUqI (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 22 Aug 2013 16:46:08 -0400
Content-Disposition: inline
In-Reply-To: <52166DA8.1000201@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: Tavis Ormandy <taviso@google.com>, dash@vger.kernel.org, oss-security@lists.openwall.com

On Thu, Aug 22, 2013 at 09:59:36PM +0200, Harald van Dijk wrote:
> On 22/08/13 19:59, Tavis Ormandy wrote:
> > Hello, this is a patch to add privmode support to dash. privmode attempts to
> > drop privileges by default if the effective uid does not match the uid. This
> > can be disabled with -p, or -o nopriv.

> Your approach definitely has my support (FWTW), but there are two
> aspects that surprised me, and are different from bash and FreeBSD's sh:

> You named the option nopriv, while bash and FBSD use the name
> privileged. I think it is likely to confuse people if "bash -o
> privileged" and "dash -o nopriv" do the same thing, and that it would be
> better to match bash and give the option a positive name, such as
> "priv", or perhaps even match them exactly and use "privileged".

I think there is no reason to deviate from other shells here. Therefore,
please call it "privileged".

> In bash and FBSD, after starting with -p, set +p can be used to drop
> privileges. With your patch, dash accepts set +p, but silently ignores it.

> How does something like the attached, to be applied on top of your
> patch, look?

> [snip]
> +	if (!on && (uid != geteuid() || gid != getegid())) {
> +		setuid(uid);
> +		setgid(gid);
> +		/* PS1 might need to be changed accordingly. */
> +		choose_ps1();
> +	}
> +}

This code tries to use setuid() and setgid() to drop all privilege,
which is only correct if the privilege to be dropped is UID 0, or on BSD
systems. It would be better to use setresuid() or setreuid(), and change
the GID before changing the UID.

Apart from that, it is better to check the return value from setuid()
and similar functions. In particular, some versions of Linux may fail
setuid() for [EAGAIN], leaving the process running with the same
privileges.

-- 
Jilles Tjoelker
