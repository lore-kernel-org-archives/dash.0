From: David Korn <dgk@research.att.com>
Subject: Re: '>;' redirection operator [was: [1003.1(2008)/Issue 7 0000530]: Support  in-place editing in sed  (-iEXTENSION)]
Date: Thu, 22 Dec 2011 17:06:51 -0500
Message-ID: <201112222206.pBMM6pRc001416@penguin.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-pink.research.att.com ([192.20.225.111]:50747 "EHLO
	mail-pink.research.att.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753138Ab1LVW1l (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 22 Dec 2011 17:27:41 -0500
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: austin-group-l-request@opengroup.org, bug-bash@gnu.org, dash@vger.kernel.org, eblake@redhat.com, miros-discuss@mirbsd.org

cc: eblake@redhat.com bug-bash@gnu.org dash@vger.kernel.org miros-discuss@mirbsd.org
Subject: Re: '>;' redirection operator [was: [1003.1(2008)/Issue 7 0000530]: Support  in-place editing in sed  (-iEXTENSION)]
--------

> On 12/22/2011 08:39 AM, David Korn wrote:
> > Subject: Re: Re: [1003.1(2008)/Issue 7 0000530]: Support in-place editi=
> ng in sed  (-iEXTENSION)
> > --------
> >=20
> > There are many commands other than sed that want the output to replace
> > an input file.  That is why I added the >; redirection operator to ksh9=
> 3.
> >=20
> > With >; you can do
> > 	sed -e s/foo/bar/ file >; file
> > to do in place sed.  The >; operator generates the output in a temporar=
> y file
> > and moves the file to the original file only if the command terminates
> > with 0 exit status.
> 
> On 12/22/2011 16:04 AM,Eric Blake  wrote:
> I agree that engineering a single fix into the shell that can apply to
> multiple situations, rather than chasing down a set of applications to
> add an in-place editing option to each, is a much more flexible and
> powerful approach.  Can we get buy-in from other shell developers to
> support '>;' as an atomic temp-file replacement-on-success idiom, if
> POSIX were to standardize the existing practice of ksh93 as the basis?
> 
> I assume on the ksh implementation that the temp file is discarded if
> the command (simple or compound) feeding the redirection failed?  If the
Yes.
> redirection is used on a simple command, is there any shorthand for
> specifying that the destination name on success also be fed as an
> argument to the command, to avoid the redundancy of having to type
> 'file' both before and after the '>;' operator?  I assume that this is
> like any other redirection operator, where an optional fd number can be
> prepended, as in '2>; file' to collect stderr and overwrite file on
> success?  What happens if there is more than one '>;' redirection in the
> same command, and both target the same end file (whether or not by the
> same file name)?  What happens if the command succeeds, but the rename
> of the temp file to the destination fails?  Are there clobber ('>|') or
> append ('>>') variants?
No, it only works if the file specified with >; is a regular file.
How could it know which command argument to use for the name, for example
	cat foo bar >; /dev/fd/2
how would it know whether to use foo or bar?

If there is more than one >; command, then ksh will create a temporary file
for each of these but will only the last one will get standard out.
Thus the first one will be replaced by and empty file and the second one
will get the output if successful.  Thus
	command ... >; f1 >; f2
is equivalent to
	command ... > f1 >; f2


There is no clobber or append variants.  Append doesn't wipe anything out so
it is not needed.

I also added the operator <>; which is the same as <> except that the file
is truncated on close.  Thus,
	tail -s 1000000 file <>; file
will remove the first 1000000 lines of a file and will not require extra
temporary disk space.
> 

David Korn
dgk@research.att.com
