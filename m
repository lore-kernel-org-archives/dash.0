From: Jim Pryor <dubiousjim@gmail.com>
Subject: Re: local var=$(cat) only reads one line
Date: Mon, 09 Apr 2012 12:23:00 -0400
Message-ID: <1333988580.17858.140661060105101.2C9776B2@webmail.messagingengine.com>
References: <1333922946.15345.140661059835993.31129B93@webmail.messagingengine.com>
 <1333933963.12672.140661059876041.485D9C2C@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46268 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757437Ab2DIQXA (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 9 Apr 2012 12:23:00 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9694321670
	for <dash@vger.kernel.org>; Mon,  9 Apr 2012 12:23:00 -0400 (EDT)
In-Reply-To: <1333933963.12672.140661059876041.485D9C2C@webmail.messagingengine.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org

Hi Jilles, thanks for your reply. Indeed now I remember having read
somewhere that you couldn't portably rely on assignments after "local"
to suppress word expansion in the same way that ordinary assignments do.
I had forgotten that. I hope shell implementations evolve towards more
consistency about this. In the meantime, it's easy enough to get
portable behavior if you remember the issue.

On another note, I was reading in this mailing list about dash's
treatment of:
    FOO=value shell_function $args
    printf "%s\n" "$FOO" # prints 'value'

The other discussion points out that this surprising behavior is in fact
mandated by POSIX.

I notice however in the dash.1 manpage distributed with finnix 103, the
following:

     When a shell function is executed, all of the shell positional
     parameters
     (except $0, which remains unchanged) are set to the arguments of
     the
     shell function.  The variables which are explicitly placed in the
     envi-
     ronment of the command (by placing assignments to them before the
     func-
     tion name) ***are made local to the function and are set to the
     values
     given.***  Then the command given in the function definition is
     executed.
     The positional parameters are restored to their original values
     when the
     command completes.  This all occurs within the current shell.

Presumably this manpage should be updated to track the current behavior
of dash. I'm not sure whether it comes from the dash source distro, or
was added in by the finnix maintainers.

-- 
dubiousjim@gmail.com

