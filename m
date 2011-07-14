From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug: temporary assignments vs shell function
Date: Thu, 14 Jul 2011 04:26:16 -0500
Message-ID: <20110714092615.GA15476@elie>
References: <20110714083455.GA25362@div0.qc.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35210 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1GNJ0d (ORCPT <rfc822;dash@vger.kernel.org>);
	Thu, 14 Jul 2011 05:26:33 -0400
Received: by iwn6 with SMTP id 6so28602iwn.19
        for <dash@vger.kernel.org>; Thu, 14 Jul 2011 02:26:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110714083455.GA25362@div0.qc.to>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Rudolf Polzer <divverent@xonotic.org>
Cc: dash@vger.kernel.org

Hi,

Rudolf Polzer wrote:

> foo=bar func
> echo "foo is now $foo"
>
> will export foo=bar in global scope (i.e. it affects the execution environment
> after the function call).
[...]
> A shell function however isn't a "special built-in" and also counts as a
> "command name", thus the last echo line really should output "foo is now foo",
> which it does in e.g. bash and the FreeBSD /bin/sh.

From XCU 2.9.5:

| When a function is executed, it shall have the syntax-error and
| variable-assignment properties described for special built-in
| utilities in the enumerated list at the beginning of Section 2.14.

This seems to be one of those odd cases where "bash -o posix" behaves
differently from bash.  Based on this test:

	$sh -c 'func () { :; }; foo=bar func; echo $foo'

dash, ksh93, bash -o posix, pdksh and its derivatives, zsh with
"emulate sh", and busybox sh implement the specified behavior.  I'm
surprised to hear your copy of FreeBSD sh behaves differently.

Meanwhile I agree with you that this could be made clearer in POSIX
without too many changes (for example by adding a reference back to
section 2.9.5 in section 2.14).  If you are interested in fixing that,
the kind people in the Austin group at <http://austingroupbugs.net>
would probably be interested.

Thanks for writing and hope that helps.

Regards,
Jonathan
