From: Bruce Korb <bkorb@gnu.org>
Subject: Re: '>;' redirection operator [was: [1003.1(2008)/Issue 7 0000530]:
 Support in-place editing in sed  (-iEXTENSION)]
Date: Thu, 22 Dec 2011 14:09:30 -0800
Message-ID: <4EF3AA9A.9070009@gnu.org>
References: <201112221539.pBMFdlaj011933@penguin.research.att.com> <4EF39B1E.80709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:33954 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab1LVWJh (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 22 Dec 2011 17:09:37 -0500
In-Reply-To: <4EF39B1E.80709@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: David Korn <dgk@research.att.com>, austin-group-l@opengroup.org, Bash - Bug <bug-bash@gnu.org>, zsh-workers@zsh.org, dash <dash@vger.kernel.org>, miros-discuss@mirbsd.org

On 12/22/11 13:03, Eric Blake wrote:
> I assume on the ksh implementation that the temp file is discarded if
> the command (simple or compound) feeding the redirection failed?

One would hope!

>  If the
> redirection is used on a simple command, is there any shorthand for
> specifying that the destination name on success also be fed as an
> argument to the command, to avoid the redundancy of having to type
> 'file' both before and after the'>;' operator?

Doesn't the shell already have enough hieroglyphs?  It is what
intimidates many folks from figuring it out.

>  I assume that this is
> like any other redirection operator, where an optional fd number can be
> prepended, as in '2>; file' to collect stderr and overwrite file on
> success?

When the exact opposite is the useful variation?  I.e. keep-on-failure.
"-i" for sed is simple, understandable and implemented a lot.
Please don't add another glyph to the standardized shell.  Let us not
slide on slippery slopes.  Shells can always add some useful builtins:

    sh_move_if_changed
    sh_save_on_success
    sh_save_on_failure

to cope with this stuff.  Or you can write your own such library for
your own use.  ">;" is not an answer for sed-as-a-batch-editor anyway,
which is what "-i" really is.
