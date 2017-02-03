From: Jilles Tjoelker <jilles@stack.nl>
Subject: Re: why does dash save, dup, and restore redirected descriptor in
 the parent, rather than redirect in the child?
Date: Fri, 3 Feb 2017 23:37:55 +0100
Message-ID: <20170203223755.GA69960@stack.nl>
References: <2132582962.805179.1485892834849.ref@mail.yahoo.com>
 <2132582962.805179.1485892834849@mail.yahoo.com>
 <CAPxz1+au53RAak7Goisz7QKrzUSvtZidLFZ4b7sgV1QR_JeK5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mailout05.stack.nl ([131.155.140.202]:38016 "EHLO
        mailout.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752527AbdBCWp1 (ORCPT <rfc822;dash@vger.kernel.org>);
        Fri, 3 Feb 2017 17:45:27 -0500
Content-Disposition: inline
In-Reply-To: <CAPxz1+au53RAak7Goisz7QKrzUSvtZidLFZ4b7sgV1QR_JeK5Q@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Parke <parke.nexus@gmail.com>
Cc: "dash@vger.kernel.org" <dash@vger.kernel.org>

On Tue, Jan 31, 2017 at 06:27:00PM -0800, Parke wrote:
> On Tue, Jan 31, 2017 at 12:00 PM, Mark Galeck <mark_galeck@pacbell.net> wrote:
> > This is strange. Why save, dup and dup again to restore, descriptors
> > in the parent, when it would be much simpler to just dup in the
> > child, and not have to save and restore. This is simpler and I
> > checked it works the same:

> > I am sure there must be a good reason and I am not understanding
> > something deeper. What is it?

> I am not a dash developer, but one reason to make system calls in the
> parent is that it is much simpler to handle errors in the parent.

> In your example:

> > if (!fork()) {
> >     fd = open64("foobar.txt", O_WRONLY|O_CREAT);
> >     dup2(fd, 1);
> >     execl("/bin/date", "date", (char *)NULL);
> > }

> What happens if open64 fails?  How should the child inform the parent
> of this specific error?

In general, you are right, but in the shell's case there is no
difficulty. The error is reported via an error message to stderr and a
non-zero exit status of the command, and the child process can easily do
those things.

-- 
Jilles Tjoelker
