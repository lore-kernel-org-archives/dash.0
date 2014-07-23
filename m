From: jca+dash@wxcvbn.org (=?utf-8?Q?J=C3=A9r=C3=A9mie_Courr=C3=A8ges-Angl?=
	=?utf-8?Q?as?=)
Subject: Re: [PATCH] \e in "echo" and "printf" builtins
Date: Wed, 23 Jul 2014 12:26:05 +0200
Message-ID: <87fvhstlqa.fsf@ritchie.wxcvbn.org>
References: <20140628045653.GA5097@angband.pl> <53AEF2E3.5080205@gigawatt.nl>
	<20140628172722.GA13451@angband.pl>
	<20140723091117.GA30150@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dash-owner@vger.kernel.org>
Received: from chomsky.autogeree.net ([91.216.110.36]:52269 "EHLO
	chomsky.autogeree.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbaGWKig (ORCPT <rfc822;dash@vger.kernel.org>);
	Wed, 23 Jul 2014 06:38:36 -0400
In-Reply-To: <20140723091117.GA30150@angband.pl> (Adam Borowski's message of
	"Wed, 23 Jul 2014 11:11:17 +0200")
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: dash@vger.kernel.org

Adam Borowski <kilobyte@angband.pl> writes:

> On Sat, Jun 28, 2014 at 07:27:22PM +0200, Adam Borowski wrote:
>> On Sat, Jun 28, 2014 at 06:52:51PM +0200, Harald van Dijk wrote:
>> > On 28/06/14 06:56, Adam Borowski wrote:
>> > > I'm not sure what's your policy towards extensions, but \e as \033 is
>> > > something ubiquitous in the Unix world.  C compilers (gcc, clang, icc and
>> > > tcc -- but not MSVC), perl, shells (bash and zsh -- but not dash), etc.
>> > 
>> > No comment on whether dash itself should accept \e, but [...]
>
> So... can I has an answer whether dash should indeed accept \e ?
> Being told "no" or "go away, we hate you" is fine, I just dislike having
> patches rot forever.  And not having this shorthand is annoying if you
> like using colour for highlights -- it works in perl and bash, then
> suddenly Oops! not in /bin/sh = dash.

I agree with Erik Blake, IMO there is no reason for dash to support \e
unless POSIX standardizes it first.  Except if you want to encourage
unportable scripts, of course.  /bin/sh is not necessarily bash or dash.

$ /bin/sh
$ type echo
echo is a shell builtin
$ echo '\033[1m hello \033[0m'
 hello # (bold)
$ /bin/echo '\033[1m hello \033[0m'
\033[1m hello \033[0m
$ echo '\e[1m hello \e[0m'
\e[1m hello \e[0m
$ /bin/echo  '\e[1m hello \e[0m'
\e[1m hello \e[0m
$

-- 
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE
