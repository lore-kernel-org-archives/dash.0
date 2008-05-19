From: Oleg Verych <olecom@flower.upol.cz>
Subject: cmd modifiers options: CPU affinity, ASLR, lightweight exec...
Date: Tue, 20 May 2008 01:08:26 +0200
Message-ID: <E1JyET0-0004Zw-0H@flower>
References: <8499950a0804301800x3577741ex3646035f8350e399@mail.gmail.com>
Return-path: <dash-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:33549 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755157AbYESWrE (ORCPT <rfc822;dash@vger.kernel.org>);
	Mon, 19 May 2008 18:47:04 -0400
Received: from flower (flower.upol.cz [158.194.64.22])
	by barikada.upol.cz (Spam Firewall) with ESMTP id E089014A7CB
	for <dash@vger.kernel.org>; Tue, 20 May 2008 00:46:42 +0200 (CEST)
Received: from flower (flower.upol.cz [158.194.64.22]) by barikada.upol.cz with ESMTP id yyQN2dvMlOKQAM1d for <dash@vger.kernel.org>; Tue, 20 May 2008 00:46:42 +0200 (CEST)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1JyET0-0004Zw-0H
	for dash@vger.kernel.org; Tue, 20 May 2008 01:08:30 +0200
In-Reply-To: <8499950a0804301800x3577741ex3646035f8350e399@mail.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash list <dash@vger.kernel.org>

> Subject: command modifiers (Re: Changes with provided user's source code transform (Size and performance efficient rewriting of the `dash.test` built-in))
> Date: Thu, 1 May 2008 02:00:41 +0100

>> `expr, "$1" * "$2"` -- don't expand shell patterns; or just
>> `expr:, $1 * $2 `; options may be included e.g.
>>> `test,n "$file" -nt arch/avr32/*` -- don't leave unexpanded patterns
>>> `test:,b $file -nt [^a].*` -- pattern is BRE, (ERE, etc, what libc provides)
> (examples are using -nt proposition, but `make` with file-name patterns can
> there as well) etc. (still collecting input)
>
>>`/bin/chroot! .`-- don't copy environment

After today's exercises i'd like to add:

`sed,c` -- set CPU affinity; maybe some free CPU choice is needed also:
`sed,c[0]` stick to CPU 0
`sed,c[1]` to CPU 1, another form
`sed,cpu[1]`


If one day address space randomization will be freely available, thus
adding useful security feature, but adding burden of random number
generation, good (i.e. slower) random number generation, obviously
flexible run-time configuration of this stuff on exec time will be
needed.

`sed,rnd[-]`
`sed,r[+]`

set +r -- switch off ASLR
set -r -- switch on ASLR

more common extended format:

set -F[r], set +F[rnd], set +F[asr]

Of course if any execve() kind with this, "light-weight process" or
any other performance/size options will be implemented by cool kernel
kids, then shell will be ready to exploit it fully.


But flexible configurability run-time or build-time seems not a key here
(everywhere?).



I mean it, not even going into config/build. Now i face with user
interface, that is absolutely dumb and frost-bitten. One must do, type,
repeat, wait for so many stupid things without a hint from UI for help
(command lines, text editors, pagers, browsers)...
-- 
sed 'sed && sh + olecom = love' << ''
-o--=O`C
 #oo'L O
<___=E M
