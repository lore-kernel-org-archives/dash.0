From: Matthew Burgess <matthew@linuxfromscratch.org>
Subject: Re: Allow dash to build with i18n version of Coreutils
Date: Tue, 1 Sep 2009 14:27:04 -0600
Message-ID: <c0670a2697cad20e7e616e7dba2ed2a0@quantum.linuxfromscratch.org>
References: <20090901031557.GA17361@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <dash-owner@vger.kernel.org>
Received: from quantum.linuxfromscratch.org ([216.171.237.234]:55881 "EHLO
	quantum.linuxfromscratch.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752055AbZIAU10 (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 1 Sep 2009 16:27:26 -0400
In-Reply-To: <20090901031557.GA17361@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dash@vger.kernel.org

On Tue, 1 Sep 2009 13:15:57 +1000, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Aug 31, 2009 at 08:19:24AM -0600, Matthew Burgess wrote:
> 
> Oh I see what's going on.  In fact it's sed that's not working for
> you, not sort.  Let me find a way around that.

Ah, well spotted.  The following is enough to get the correct output from sed(1):

sed 's/\t-[a-z]*//' $temp2

This is with sed-4.2.1 compiled against Glibc-2.10.1.

Running through 'nl -v 0', I end up with:

     0	.	dotcmd
     1	:	truecmd
     2	[	testcmd
     3	alias	aliascmd
     4	bg	bgcmd
     5	break	breakcmd
     6	cd	cdcmd
     7	chdir	cdcmd
     8	command	commandcmd
     9	continue	breakcmd
    10	echo	echocmd
    11	eval	evalcmd
    12	exec	execcmd
    13	exit	exitcmd
    14	export	exportcmd
    15	false	falsecmd
    16	fg	fgcmd
    17	getopts	getoptscmd
    18	hash	hashcmd
    19	jobs	jobscmd
    20	kill	killcmd
    21	local	localcmd
    22	printf	printfcmd
    23	pwd	pwdcmd
    24	read	readcmd
    25	readonly	exportcmd
    26	return	returncmd
    27	set	setcmd
    28	shift	shiftcmd
    29	test	testcmd
    30	times	timescmd
    31	trap	trapcmd
    32	true	truecmd
    33	type	typecmd
    34	ulimit	ulimitcmd
    35	umask	umaskcmd
    36	unalias	unaliascmd
    37	unset	unsetcmd
    38	wait	waitcmd

That still doesn't help with the sort(1) output though (from coreutils-7.5), which
still doesn't appear to be honouring LC_COLLATE!  I suspect a bug in our i18n patch
for Coreutils, which I'll try to take a look at over the next few days.

Thanks,

Matt.

