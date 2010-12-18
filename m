From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: read() builtin doesnt read integer value /proc files (but bashs
 does)
Date: Sat, 18 Dec 2010 23:23:44 +0100
Message-ID: <20101218222344.GB50651@stack.nl>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
 <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com>
 <20100903212504.GA86276@stack.nl>
 <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com>
 <20100904193504.GA3357@stack.nl>
 <20101128084219.GC8818@gondor.apana.org.au>
 <1012151034250.15865@somehost>
 <20101215185551.GA22905@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:63027 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752559Ab0LRWYu (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 18 Dec 2010 17:24:50 -0500
Content-Disposition: inline
In-Reply-To: <20101215185551.GA22905@burratino>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Cristian Ionescu-Idbohrn <cristian.ionescu-idbohrn@axis.com>, Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org, 595063@bugs.debian.org

On Wed, Dec 15, 2010 at 12:55:51PM -0600, Jonathan Nieder wrote:
> Cristian Ionescu-Idbohrn wrote:
> > On Sun, 28 Nov 2010, Herbert Xu wrote:
> > > On Sat, Sep 04, 2010 at 07:35:04PM +0000, Jilles Tjoelker wrote:

> >>> This discarding is still bad as it throws away valid data if the open
> >>> file description is shared. This happens if stdin is redirected inside a

> >> I'm with Jilles on this.  I also don't particularly feel like
> >> bloating dash just because of the borked /proc interface when
> >> there is a perfectly adequate work-around in "cat".

> >> 	value=$(cat /proc/file)

> > I wouldn't call that "a perfectly adequate work-around", but a painful and
> > unadequate work-around.

> For what it's worth, here's what bash does (based on strace):

> 1. Determine whether the file is seekable.  That is, seek using
> SEEK_CUR with offset 0.

> 2. If seekable, read a nice big chunk and then seek back to put the
> file offset back in the right place.  If not seekable, read one byte
> at a time.

> This works in /proc because files in /proc are seekable.

> That said, I don't think borked /proc is a great reason to do this
> (it's a better reason to fix /proc).  Speeding up the read builtin
> might be a good reason.

The optimization is of limited benefit (still way more syscalls than
strictly necessary) and does not apply to the common use case of reading
from a pipe. Generally, if 'read' is too slow, it is better to spend a
fork on a tool like grep, sed or awk which processes large amounts of
text much more efficiently.

As for value=$(cat /proc/file), there are at least two ways to make this
faster. The traditional ksh way is the extension value=$(</proc/file)
which is permitted but not required by POSIX. I do not really like this
as it makes the scripts not POSIX compliant. In recent mksh I noticed
another way: by making cat(1) a builtin under certain circumstances.
These circumstances include the absence of options (other than "--") and
should probably also exclude foreground commands in interactive job
control shells (as builtins cannot be suspended). To avoid needing to
implement extensions like FreeBSD cat's ability to read from Unix domain
sockets, named files could also be excluded, requiring value=$(cat
</proc/file).

-- 
Jilles Tjoelker
