From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: [PATCH] [BUILTIN] Allow SIG* signal names.
Date: Tue, 3 Jul 2012 22:13:34 +0200
Message-ID: <20120703201334.GA66099@stack.nl>
References: <4ff0274f.c54fb40a.47e2.6814@mx.google.com>
 <4FF1A76F.6020307@redhat.com>
 <2D2FC58C-ACD5-4113-9A1D-C53A854C3CD7@aim.com>
 <4FF1AE9C.7040307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from relay02.stack.nl ([131.155.140.104]:56147 "EHLO mx1.stack.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933425Ab2GCUNh (ORCPT <rfc822;dash@vger.kernel.org>);
	Tue, 3 Jul 2012 16:13:37 -0400
Content-Disposition: inline
In-Reply-To: <4FF1AE9C.7040307@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: Paul Gilmartin <PaulGBoulder@aim.com>, dash <dash@vger.kernel.org>

On Mon, Jul 02, 2012 at 08:22:20AM -0600, Eric Blake wrote:
> On 07/02/2012 08:11 AM, Paul Gilmartin wrote:
> > On Jul 2, 2012, at 07:51, Eric Blake wrote:

> >> ... non-required bloat ...

> > The key phrase.  And one value of a shell lacking such
> > extensions is that it provides an excellent test bed for
> > code intended to be portable within the POSIX spec.

> That argues that we should drop our strcasecmp() for the much simpler
> strcmp(), in order to remove the bloat we already have.

Such a change would be at odds with the goal of dash to be a usable
shell. It is not good to break existing scripts, even if those scripts
are not strictly POSIX-compliant, and particularly so if the scripts
relied on designed behaviour. Such changes can waste a lot of time.

Leaving the behaviour unchanged (keeping case-insensitivity but not
adding support for the SIG prefix) would strike a balance between
usability and avoiding bloat.

Moreover, dash has many other extensions to POSIX, such as:

* A particular behaviour for "export" without parameters.

* The "local" builtin.

* The XSI "type" builtin (depending on whether you want to allow XSI or
  not).

* XSI-style signal numbers in the "trap" special builtin, and more of
  them than required.

* The XSI "ulimit" builtin, with many more options than the required -f.

* Function definitions consisting of a simple command, like
    f() echo hi

* A particular (probably useful) behaviour for double-quotes within
  backticks within double-quotes, like
    echo "`echo "hi there"`"

* A particular behaviour for double-quotes within Bourne-style parameter
  substitutions within double-quotes, like
    echo "${IFS+"*"}"

* Arithmetic expansion with a larger range than signed long (even though
  POSIX "encourages" this in non-normative text, it is not required).

Although dash is fairly minimalistic and may be useful in testing
scripts (also because it detects certain syntax errors sooner), its
usability goal makes that it has many non-mandatory features. You may
like posh which attempts to comply to Debian policy only, even at the
cost of usability.

-- 
Jilles Tjoelker
