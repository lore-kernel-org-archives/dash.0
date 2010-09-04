From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: read() builtin doesn't read integer value /proc files (but
 bash's does)
Date: Sat, 4 Sep 2010 21:35:04 +0200
Message-ID: <20100904193504.GA3357@stack.nl>
References: <AANLkTinTd+29=8EkiTKptoE8nnVphcQ_TW=ezS99LmWw@mail.gmail.com>
 <AANLkTi=ZcNYJKCO_FM0RpJndwAgtzTU_C8J=9BsfmdAk@mail.gmail.com>
 <20100903212504.GA86276@stack.nl>
 <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from relay04.stack.nl ([131.155.140.107]:52833 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752510Ab0IDTfG (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 4 Sep 2010 15:35:06 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=d_13RCDhJHE_23BXN5Tf2RY_2e3rED7JwtFOK@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Steve Schnepp <steve.schnepp@gmail.com>
Cc: dash@vger.kernel.org, 595063@bugs.debian.org

On Sat, Sep 04, 2010 at 08:20:33PM +0200, Steve Schnepp wrote:
> 2010/9/3 Jilles Tjoelker <jilles@stack.nl>:
> > This patch assumes that the file descriptor is discarded afterwards=
 (its
> > position does not matter). Therefore the very common construct
> > =A0while read x; do
> > =A0 =A0...
> > =A0done
> > stops working.

> Ohh.. thanks for that, I didn't see it.

> Actually "while read x" continues to work.
> But "reopening the file" doesn't as in :

> read a b < datafile
> echo ${a} ${b}
> read a b < datafile
> echo ${a} ${b}

You're right, it's even stranger than I expected.

> I attached an updated patch that corrects this pb by discarding the
> buffer when opening a new file.

This discarding is still bad as it throws away valid data if the open
file description is shared. This happens if stdin is redirected inside =
a
while read... loop.

=46urthermore, I think constructions like
  read x; cat
and
  read x; (read y); read z
should keep working. This requires that the input's file position be
synced whenever another process may see it (fork/exit). Due to the
highly dynamic character of the shell and the common use of fd 0, this
probably means that you can't do better than syncing after each read
builtin. (For example, 'read' could be overridden with a function after
the third line.)

Another thought:
  exec 3<&0; read x; read y <&3
or even
  sh -c 'read x; read y <&3' 3<&0
Different file descriptors may refer to the same open file description
and the shell may not know this.

--=20
Jilles Tjoelker
