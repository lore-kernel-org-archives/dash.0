Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF15211C
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 01:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720230436; cv=none; b=UDT9JqNVQFA1U66D1O4aUqdY40JIAc609vZEVT967EAFv8tg5jlZmArxD7w4WSvFIe7f+uQ54mcggR1y4mMTldmIN/BswDlIxdc3JmcQ3aMrDHYYZ+p4vJ96OjIG6mfN5DGKanL4p3WtE28Xfp2vHoeQtrKqOdppmCZl6UwBGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720230436; c=relaxed/simple;
	bh=RBpa0g2CgLUMaMIkbBW1MWLWQ4vh7msF6FuZ3qNtMhc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R2KfVdLU261xqtSaxWI6MNKnkMuCOgmN6XIpUvLnGwj0Tr2FUi0pO59PMVkO7X5Rv2VGCYYnHZgX5xaUXgk/X05Td8fK1JJ7v8c9xDPfE7Iim+q4fUZIo2m2brRhe1+rgFgVpEyZv3MZ095YrH3wZu6UY3Rkfb4puvuaJsE8R7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sPuW8-006hey-0D;
	Sat, 06 Jul 2024 11:47:13 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Jul 2024 11:46:59 +1000
Date: Sat, 6 Jul 2024 11:46:59 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: martijn@inlv.org, dash@vger.kernel.org
Subject: Re: [BUG] reading from FIFO broken
Message-ID: <ZoiiE00rt95pkYYj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoihoen16PgPn3tx@gondor.apana.org.au>
X-Newsgroups: apana.lists.os.linux.dash

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> and it still worked with your test case.  This is what I see through
> strace on Linux with a stubbed out tee call:

For comparison this is with a working tee call:

395566 <... fcntl resumed>)             = 10
395565 <... fcntl resumed>)             = 10
395566 close(1 <unfinished ...>
395565 close(0 <unfinished ...>
395566 <... close resumed>)             = 0
395565 <... close resumed>)             = 0
395566 dup2(3, 1 <unfinished ...>
395565 dup2(3, 0 <unfinished ...>
395566 <... dup2 resumed>)              = 1
395565 <... dup2 resumed>)              = 0
395566 close(3 <unfinished ...>
395565 close(3 <unfinished ...>
395566 <... close resumed>)             = 0
395565 <... close resumed>)             = 0
395565 ioctl(0, TCGETS <unfinished ...>
395566 write(1, "OK\n", 3 <unfinished ...>
395565 <... ioctl resumed>, 0x7ffef74e9c00) = -1 ENOTTY (Inappropriate ioctl for device)
395565 lseek(0, 0, SEEK_CUR <unfinished ...>
395566 <... write resumed>)             = 3
395565 <... lseek resumed>)             = -1 ESPIPE (Illegal seek)
395566 dup2(10, 1 <unfinished ...>
395565 pipe2( <unfinished ...>
395566 <... dup2 resumed>)              = 1
395565 <... pipe2 resumed>[3, 4], 0)    = 0
395566 close(10 <unfinished ...>
395565 fcntl(3, F_DUPFD_CLOEXEC, 10 <unfinished ...>
395566 <... close resumed>)             = 0
395565 <... fcntl resumed>)             = 11
395565 close(3 <unfinished ...>
395566 exit_group(0 <unfinished ...>
395565 <... close resumed>)             = 0
395566 <... exit_group resumed>)        = ?
395565 fcntl(4, F_DUPFD_CLOEXEC, 10)    = 12
395565 close(4)                         = 0
395565 tee(0, 12, 8192, 0 <unfinished ...>
395566 +++ exited with 0 +++
395565 <... tee resumed>)               = 3
395565 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=395566, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
395565 rt_sigreturn({mask=[]})          = 3
395565 read(11, "OK\n", 3)              = 3
395565 wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 395566
395565 wait4(-1, 0x7ffef74e9cec, WNOHANG, NULL) = -1 ECHILD (No child processes)
395565 read(0, "OK\n", 3)               = 3
395565 dup2(10, 0)                      = 0
395565 close(10)                        = 0
395565 write(1, "2:OK\n", 5)            = 5
395565 exit_group(0)                    = ?
395565 +++ exited with 0 +++

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
