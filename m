From: Adam Endrodi <adam.endrodi@nokia.com>
Subject: "case" bug in dash
Date: Wed, 2 Mar 2016 22:09:14 +0100
Message-ID: <20160302210914.GC1056@timmy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <dash-owner@vger.kernel.org>
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:57445 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbcCBVMw convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Wed, 2 Mar 2016 16:12:52 -0500
Received: from muvmp319.nsn-intra.net ([10.159.32.166])
	by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u22LCncp027815
	(version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <dash@vger.kernel.org>; Wed, 2 Mar 2016 21:12:49 GMT
Received: from madam.europe.nsn-net.net ([10.156.137.69])
	by muvmp319.nsn-intra.net (8.14.3/8.14.3) with ESMTP id u22LCnR1026775
	for <dash@vger.kernel.org>; Wed, 2 Mar 2016 21:12:49 GMT
Content-Disposition: inline
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org



Hi,


The following program prints "boo" incorrectly (I'm trying to match
non-numbers):

"""
#!/bin/dash

case "111" in
*[^0-9]*)
	echo boo;;
esac
"""

File expansion seems to be affected too:

/tmp/dash/src $ touch 111
/tmp/dash/src $ ./dash -c 'echo *[^0-9]*'
111 dash.1
/tmp/dash/src $ bash -c 'echo *[^0-9]*' 
alias.c alias.h alias.o arith_yacc.c arith_yacc.h arith_yacc.o arith_yylex.c arith_yylex.o bltin builtins.c builtins.def builtins.def.in builtins.h builtins.o cd.c cd.h cd.o dash dash.1 error.c error.h error.o eval.c eval.h eval.o exec.c exec.h exec.o expand.c expand.h expand.o funcs histedit.c histedit.o init.c init.h init.o input.c input.h input.o jobs.c jobs.h jobs.o machdep.h mail.c mail.h mail.o main.c main.h main.o Makefile Makefile.am Makefile.in memalloc.c memalloc.h memalloc.o miscbltin.c miscbltin.h miscbltin.o mkbuiltins mkinit mkinit.c mknodes mknodes.c mksignames mksignames.c mksyntax mksyntax.c mktokens myhistedit.h mystring.c mystring.h mystring.o nodes.c nodes.c.pat nodes.h nodes.o nodetypes options.c options.h options.o output.c output.h output.o parser.c parser.h parser.o
  printf.o redir.c redir.h redir.o shell.h show.c show.h show.o signames.c signames.o syntax.c syntax.h syntax.o system.c system.h system.o test.o times.o token.h token_vars.h TOUR trap.c trap.h trap.o var.c var.h var.o

Tried with 2e5842258bd5b252ffdaa630db09c9a19a9717ca (current git master)
both with --enable-glob and --disable-glob.

-- 
adam
