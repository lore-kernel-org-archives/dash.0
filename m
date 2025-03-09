Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057AECF
	for <dash@vger.kernel.org>; Sun,  9 Mar 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509076; cv=none; b=FXbjRR86BI5m616h9XPICxVTg0F/uTmulyNx4cshSXalFXAJURfSlkSlkpkKhrbincxGKtOB28L2cBq/T5rpHnIpTqNyQsCGCRiL8r4u27EKGTy7AakqCSzvSWI3iQQcaM/jmYBpmSCSNF2Tfg2r2liuHZv+4IQgagNikbR8vew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509076; c=relaxed/simple;
	bh=DSt09hfS1xbkSJJJJXyPsuA5Fpb9aK/SxnSADaeBOt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAZvMQtXAnvxlLqtHeGy2UPm6I+FNOh94uDzkNXNTM+LFDFxpsDfsbwI8XCfrmsKffPeU5VSmS0UkvHzlIl3dOtIEBrYC20smYQ9kEupVfItfqUa/nP9NV+gAY1Vr3EdB0qeQPL2fJG7+bc1XH67HJr922Q1WZ6mDw7Xd2mZKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=T6ivbm+M; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="T6ivbm+M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=81ajiIcVs02Q9006XGgr2OH5PbIwzLPM+v9q0lR1c7s=; b=T6ivbm+MSY/opWxptgM1aD6/Gs
	GqVMSt6Y5/XmN9U9SU9exx+EUKnDvbiI3dygF8CFO1lcH0Q8EUob3I/GoEbaJY6wg+C5nlST8kIgW
	7PcZdRpjSG5RCIWCKUJXw3anKnk7ULZZDApOuPbQdp968kAE1HFH0cIdC5Fb90MV1lSGOL3kb5ThV
	Evu+T3Kg9gy0vzkP55m0xzG4bJyUiSdbRe/yiP5aR9aiu30FK4kHtSmRf5akuB7d974zgwb86EgOx
	UDzvqDTuZPa5j78OvzOFGB2nCJTK0W6OBWP+8Jj9N5pUwbxwnvqWAt9zVHcFQPOA2OExOG75ckLd8
	1bbcKpug==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1trC3x-005246-0f;
	Sun, 09 Mar 2025 16:31:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 09 Mar 2025 16:31:09 +0800
Date: Sun, 9 Mar 2025 16:31:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Alain Knaff <alain@knaff.lu>
Cc: dash@vger.kernel.org
Subject: Re: [PATCH] Portability of dash to legacy systems, such as AT&T Unix
 PC : 11-simplify-wait-loop
Message-ID: <Z81RzYEZ5D_N0biT@gondor.apana.org.au>
References: <aa0e9215-622a-17e0-327b-f0233ed32ad8@knaff.lu>
 <6ea7da38-204f-54bf-7156-085a1589c40b@knaff.lu>
 <6cacf608-326e-211a-7d37-164041710980@knaff.lu>
 <ZhDq9L88eTrLxlWW@gondor.apana.org.au>
 <2c7200c8-c356-4a13-9314-e97989c4c148@knaff.lu>
Precedence: bulk
X-Mailing-List: dash@vger.kernel.org
List-Id: <dash.vger.kernel.org>
List-Subscribe: <mailto:dash+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dash+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7200c8-c356-4a13-9314-e97989c4c148@knaff.lu>

On Tue, Nov 12, 2024 at 11:44:12PM +0100, Alain Knaff wrote:
> 
> Currently, the "wait" shell builtin is implemented by calling wait3
> non-blockingly, and relying on a subsequent sigsuspend to do the
> actual waiting.
> 
> This is needlessly complex, wait3 can do the job just fine on its
> own. Wait_cmd can still be interrupted by a ctrl-c signal. Indeed,
> that's what EINTR is for... just test for !pending_sig, like done
> elsewhere in dash.
> 
> Return of 0 for DOWAIT_WAITCMD is now done using an explicit test
> before return of the function.

This code was added because wait3 is racy:

commit 3800d4934391b144fd261a7957aea72ced7d47ea
Author: Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sun Feb 22 18:10:01 2009 +0800

    [JOBS] Fix dowait signal race

    This test program by Alexey Gladkov can cause dash to enter an
    infinite loop in waitcmd.

    #!/bin/dash
    trap "echo TRAP" USR1
    stub() {
    echo ">>> STUB $1" >&2
    sleep $1
    echo "<<< STUB $1" >&2
    kill -USR1 $$
    }
    stub 3 &
    stub 2 &
    until { echo "###"; wait; } do
    echo "*** $?"
    done

    The problem is that if we get a signal after the wait3 system
    call has returned but before we get to INTON in dowait, then
    we can jump back up to the top and lose the exit status.  So
    if we then wait for the job that has just exited, then it'll
    stay there forever.

    I made the original change that caused this bug to fix pretty
    much the same bug but in the opposite direction.  That is, if
    we get a signal after we enter wait3 but before we hit the kernel
    then it too can cause the wait to go on forever (assuming the
    child doesn't exit).

    In fact this is pretty much exactly the scenario that you'll
    find in glibc's documentation on pause().  The solution is given
    there too, in the form of sigsuspend, which is the only way to
    do the check and wait atomically.

    So this patch fixes Alexey's race without reintroducing the old
    bug by converting the blocking wait3 to a sigsuspend.

    In order to do this we need to set a signal handler for SIGCHLD,
    so the code has been modified to always do that.

    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
