From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] [BUILTIN] Require leading '0' on octal escapes in echo
Date: Sat, 1 Nov 2014 18:39:37 +0000
Message-ID: <20141101183937.GK5168@serenity.lan>
References: <53785239c041de620223d4a7beba523e1627b65a.1414861984.git.john@keeping.me.uk>
 <54551F57.6090708@gigawatt.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dash-owner@vger.kernel.org>
Received: from jackal.aluminati.org ([72.9.247.210]:58856 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760068AbaKASjr (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 1 Nov 2014 14:39:47 -0400
Content-Disposition: inline
In-Reply-To: <54551F57.6090708@gigawatt.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Harald van Dijk <harald@gigawatt.nl>
Cc: dash@vger.kernel.org

On Sat, Nov 01, 2014 at 06:58:47PM +0100, Harald van Dijk wrote:
> On 11/1/2014 6:14 PM, John Keeping wrote:
> > printf(1) supports octal escape sequences in its format argument which
> > are specified as (from POSIX):
> >
> > 	"\ddd", where ddd is a one, two, or three-digit octal number
> >
> > But the argument to the "%b" format specifier allows:
> >
> > 	"\0ddd", where ddd is a zero, one, two, or three-digit octal
> > 	number
> >
> > which is similar to the wording for echo(1) (for XSI-conformant
> > systems):
> >
> > 	\0num	Write an 8-bit value that is the zero, one, two, or
> > 		three-digit octal number num.
> >
> > Because conv_escape() handles the first case, applying the second
> > behaviour in conv_escape_str() must also catch the characters '1'-'7' so
> > that they are not converted as octal numbers.
> 
> Your patch seems to have addressed the clear bugs of the patch in that 
> other thread. Let me attempt to summarise the status:
> 
> - POSIX does not specify the behaviour of \1 in echo and in printf %b.
> 
> POSIX does not define the behaviour of escape sequences other than the 
> ones it explicitly specifies. It does not require \1 to be handled as 
> \\1. It allows it, but it allows the current dash behaviour too.
> 
> To quote from the echo specification: "if any of the operands contain a 
> backslash ( '\' ) character, the results are implementation-defined", 
> and the bit about XSI doesn't include an exception for \1.
> 
> To quote from the printf %b specification: "The interpretation of a 
> backslash followed by any other sequence of characters is unspecified."
> 
> - bash treats \1 as \\1 in echo, but as \01 in printf %b.
> 
> - dash treats \1 as \01 in both echo and in printf %b.
> 
> - Your patch makes dash treat \1 as \01 in both echo and printf %b.
> 
> - The aim of the patch in the other thread was to make dash be more like 
> bash.
> 
> If that is your aim too, if you want dash to behave like bash, in order 
> to achieve that the code must no longer be shared between echo and 
> printf %b. Here is a simple test you can run, where dash is without your 
> patch, and ./src/dash is with your patch:
> 
> $ bash -c 'printf "%b" "\1"' | cat -v
> ^A
> $ dash -c 'printf "%b" "\1"' | cat -v
> ^A
> $ ./src/dash -c 'printf "%b" "\1"' | cat -v
> \1
> 
> If that isn't your aim, if your aim is only to make dash meet POSIX 
> requirements, then don't worry, it already does so.

My primary aim is to get the previous patch removed from Gentoo (since
it breaks `printf '%b' '\0204'`) and I thought I might have more success
if upstream included a patch that fixed the original use case [1] ;-)

OTOH, it appears that the original issue was also fixed in
autoconf-archive (by you, in fact!) [2] so I hope Gentoo will just drop
the broken patch.

In fact, it appears that bash does treat \1 as \01 in echo if you pass
"-e" (as does coreutils), so the main difference between bash and dash
is whether or not backslash escapes are handled by default.  POSIX
indicates that no options shall be supported by echo(1) and XSI says
that backslash escapes should be interpreted, so I agree with dash's
behaviour here.

I agree that dash is conformant in all cases, so I withdraw the patch.

[1] https://bugs.gentoo.org/show_bug.cgi?id=337329
[2] http://git.savannah.gnu.org/cgit/autoconf-archive.git/commit/m4/ax_prefix_config_h.m4?id=c9d670b1d7f3d30780996f8ec1bdad2dd98b8592
