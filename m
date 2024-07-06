Received: from norbury.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77681211C
	for <dash@vger.kernel.org>; Sat,  6 Jul 2024 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720230324; cv=none; b=lpgTVca0W52dkNdRlHNP6EezB58g1BSaa4hhJXPWG+y/ky/55xH45NFD/cRCkhsE/GaYpiPxSRw2H+njl5HevJ5OEBWhKzpriI9dSLeGhW/B8Aw+nXxKzjO3uYSA4Buh8iR6l7KAYnOM04lHn1VU5+o/2JQrwV/CjxX5ksm+qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720230324; c=relaxed/simple;
	bh=hGt0/s1Q2jiKwqNyUSUEOTtZBmVhI3KjqduYe3mFXA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YrZJuHnVFtKlvBZmyoq0j/w2IqjiNpd+2G6jMg1+l2SAcmXyG3zo3l8mR+sPR6Q3ir0T5bIui9bq/19aPxJQNcSi3YbIkXNgkmyZkOr03W4FRiKE1KZwb4RF8QreIGQi7pGLfN0C3mqjhF7WIzTjDq/rd8A6XImnvm7FN5XuyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sPuUI-006hbU-1b;
	Sat, 06 Jul 2024 11:45:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 06 Jul 2024 11:45:05 +1000
Date: Sat, 6 Jul 2024 11:45:05 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: martijn@inlv.org, dash@vger.kernel.org
Subject: Re: [BUG] reading from FIFO broken
Message-ID: <Zoihoen16PgPn3tx@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoUs+i4iBAOdYmwI@gondor.apana.org.au>
X-Newsgroups: apana.lists.os.linux.dash

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Martijn Dekker <martijn@inlv.org> wrote:
>>
>> ...reading from a FIFO is broken, at least on macOS 12.7.5. It seems like the 
>> 'read' command can no longer read anything from a FIFO.
>> 
>> Reproducer:
>> 
>> $ dash -c 'trap "rm fifo" 0; mkfifo fifo;
>>        echo OK >fifo & read r <fifo; echo "${#r}:$r"'
>> 0:
>> 
>> Expected output:
>> 
>> 2:OK
> 
> I can't reproduce this under Linux.  Could you please run it under
> strace for me?

I even tried stubbing out the tee call and replacing it with

	err = -1;

and it still worked with your test case.  This is what I see through
strace on Linux with a stubbed out tee call:

395516 <... close resumed>)             = 0
395516 ioctl(0, TCGETS <unfinished ...>
395517 <... write resumed>)             = 3
395516 <... ioctl resumed>, 0x7ffcf5136a50) = -1 ENOTTY (Inappropriate ioctl for device)
395517 dup2(10, 1 <unfinished ...>
395516 lseek(0, 0, SEEK_CUR <unfinished ...>
395517 <... dup2 resumed>)              = 1
395516 <... lseek resumed>)             = -1 ESPIPE (Illegal seek)
395517 close(10 <unfinished ...>
395516 pipe2( <unfinished ...>
395517 <... close resumed>)             = 0
395516 <... pipe2 resumed>[3, 4], 0)    = 0
395517 exit_group(0 <unfinished ...>
395516 fcntl(3, F_DUPFD_CLOEXEC, 10 <unfinished ...>
395517 <... exit_group resumed>)        = ?
395516 <... fcntl resumed>)             = 11
395516 close(3)                         = 0
395516 fcntl(4, F_DUPFD_CLOEXEC, 10)    = 12
395517 +++ exited with 0 +++
395516 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=395517, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
395516 rt_sigreturn({mask=[]})          = 12
395516 close(4)                         = 0
395516 read(0, "O", 1)                  = 1
395516 read(0, "K", 1)                  = 1
395516 read(0, "\n", 1)                 = 1
395516 wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 395517
395516 wait4(-1, 0x7ffcf5136b3c, WNOHANG, NULL) = -1 ECHILD (No child processes)
395516 dup2(10, 0)                      = 0
395516 close(10)                        = 0
395516 write(1, "2:OK\n", 5)            = 5
395516 exit_group(0)                    = ?
395516 +++ exited with 0 +++

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
