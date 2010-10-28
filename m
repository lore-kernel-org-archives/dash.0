From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: bug with <&- under ulimit -n
Date: Wed, 27 Oct 2010 22:11:36 -0400
Message-ID: <20101028021136.GA26347@gondor.apana.org.au>
References: <20101027225048.GC72761@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from helcar.apana.org.au ([209.40.204.226]:38995 "EHLO
	fornost.hengli.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602Ab0J1CLn (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 27 Oct 2010 22:11:43 -0400
Content-Disposition: inline
In-Reply-To: <20101027225048.GC72761@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: eblake@redhat.com, dash@vger.kernel.org

Jilles Tjoelker <jilles@stack.nl> wrote:
> On Wed, Oct 27, 2010 at 03:33:41PM -0600, Eric Blake wrote:
>> Dash does not behave well when under artificial fd pressure due to
>> ulimit -n.  It insists on copying a to-be-closed fd to another fd
>> greater than 10, then complains when the dup fails, rather than just
>> flat-out closing the fd in the first place.  Compare this with ksh93
> 
>> $ ksh -c 'ulimit -n 10; : <&-'; echo $?
>> 0
>> $ dash -c 'ulimit -n 11; : <&-'; echo $?
>> 0
>> $ dash -c 'ulimit -n 10; : <&-'; echo $?
>> dash: 0: Invalid argument
>> 2
> 
>> See this thread on the bug-tar list for more details:
>> http://thread.gmane.org/gmane.comp.gnu.tar.bugs/4010/focus=4020
> 
> Summary: use 'exec' to close the file descriptors before setting ulimit
> -n ridiculously low instead of relying on redirections to work in such a
> restricted environment.

Thanks for the excellent analysis Jilles! I agree with you on
all counts :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
