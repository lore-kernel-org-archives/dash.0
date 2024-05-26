Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179FB640
	for <dash@vger.kernel.org>; Sun, 26 May 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716719286; cv=none; b=Sl/EhF4knCW0Kqj9KbX32y7oPsABM//yBAL/b6NxXhyzWW9QlnsVJvrzk9piS0k7fU6EuEaYxAdortQ77ngRbc7ECDUrl6XKIjKKn591qAIVjE6/Ep+6906bNvZV66MaF2T61lI4p0Z/ionMYPCwRBbJc/+6f6jG5V+Msc3qb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716719286; c=relaxed/simple;
	bh=RynFLzIrijPe+Z9+kOP4O0l8MQTFkLVyIn8kARPmDHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk/qM6+4t8O7CbSvSQrhr/ru7ilta6B4WwQlaqM6SKvnpk4iib/hvWPl1lRUdO0p0MIzARRZ6H/wIs01fn0yDTXyl2Fs7EpCjYSXEibxXENu4wirCMmrxrx6k1mZn/pxkAcm0OjDPjETKVKya7qxjq1Fqq0X4zuIUnDTQ95H7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sBB6G-002Dqs-13;
	Sun, 26 May 2024 18:27:37 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 26 May 2024 18:27:38 +0800
Date: Sun, 26 May 2024 18:27:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Johannes Altmanninger <aclopte@gmail.com>
Cc: Jilles Tjoelker <jilles@stack.nl>, harald@gigawatt.nl,
	dash@vger.kernel.org
Subject: Re: [PATCH v4] Allow trap to un-ignore SIGINT/SIGQUIT in async
 subshells
Message-ID: <ZlMOmlBwe4CRc6zS@gondor.apana.org.au>
References: <ZhKBHMHJRJdTdsVP@gondor.apana.org.au>
 <20240518084105.111682-1-aclopte@gmail.com>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518084105.111682-1-aclopte@gmail.com>

On Sat, May 18, 2024 at 10:38:30AM +0200, Johannes Altmanninger wrote:
> Unlike in Bash or Zsh, this asynchronous job ignores SIGINT, despite
> builtin trap explicitly resetting the SIGINT handler.
> 
> 	dash -c '( trap - INT; sleep inf ) & read _'
> 
> POSIX Section 2.11 on [Signals] and Error Handling says about
> background execution:
> 
> > If job control is disabled (see the description of set -m) when
> > the shell executes an asynchronous list, the commands in the list
> > shall inherit from the shell a signal action of ignored (SIG_IGN)
> > for the SIGINT and SIGQUIT signals.
> 
> Builtin [trap] has this requirement:
> 
> > Signals that were ignored on entry to a non-interactive shell
> > cannot be trapped or reset, although no error need be reported when
> > attempting to do so.
> 
> Apparently this only applies to signals that were inherited as ignored,
> not to the special case of SIGINT/SIGQUIT begin ignored in asynchronous
> subshells.
> 
> Make it so. This means that either of
> 
> 	trap - INT; trap - QUIT
> 	set -i
> 
> in a backgrounded subshell will now un-ignore SIGINT and SIGQUIT.
> 
> [Signals]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
> [trap]: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap
> 
> {{{ Test cases:
> 
> shell=src/dash
> 
> set -e
> 
> SubshellWith() {
> 	parent_pid=$(setsid "$shell" -c "( $1; sleep 99 ) </dev/null >/dev/null 2>&1 & echo \$\$")
> 	sleep 1
> 	subshell_pid=$(ps -o pid= -$parent_pid | tail -n 1)
> }
> 
> trap 'kill -TERM -$parent_pid 2>/dev//null ||:' EXIT # Tear down after a failure.
> 
> echo Scenario 0: '"set -i"' makes a subshell un-ignore SIGINT.
> SubshellWith 'set -i'
> kill -INT $subshell_pid
> ! ps -p $subshell_pid | grep sleep || exit 1
> kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.
> 
> echo Scenario 1: resetting SIGINT handler.
> SubshellWith 'trap - INT'
> kill -INT -$parent_pid # kill the whole process group since that's the my use case
> ! ps -p $subshell_pid | grep sleep || exit 1
> kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.
> 
> echo Scenario 2: ignoring SIGINT.
> SubshellWith 'trap "" INT'
> kill -INT $subshell_pid
> ps -p $subshell_pid | grep sleep || exit 1
> kill -TERM -$parent_pid 2>/dev//null ||: # Tear down.
> 
> }}}
> 
> {{{ Backstory/motivation:
> 
> The Kakoune[1] editor likes to run noninteractive shell commands that
> boil down to
> 
> 	mkfifo /tmp/fifo
> 	(
> 		trap - INT
> 		make
> 	) >/tmp/fifo 2>&1 &
> 
> On Control-C, the editor sends SIGINT to its process group,
> which should terminate the subshell running make[2].
> 
> We experimented with sending SIGTERM instead but found issues,
> specifically if the editor is invoked (without exec) from a wrapper
> script, sending SIGTERM to the whole process group would kill the
> wrapper script, which in turn makes it send SIGTERM to the editor,
> which then terminates.
> 
> [1]: https://kakoune.org/
> [2]: https://lists.sr.ht/~mawww/kakoune/%3C20240307135831.1967826-3-aclopte@gmail.com%3E
> 
> }}}
> ---
>  src/trap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
