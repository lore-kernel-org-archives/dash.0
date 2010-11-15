From: Cedric Blancher <cedric.blancher@googlemail.com>
Subject: Re: static vs. dynamic scoping
Date: Mon, 15 Nov 2010 22:11:24 +0100
Message-ID: <AANLkTinMbDZdL0LEt4Xq1SbFT_xWHoKJt9QNhw6Yk+u_@mail.gmail.com>
References: <4CD9C280.60007@redhat.com>
	<4CDA6301.1010703@gmail.com>
	<4CDAB6AB.5080004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dash-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57959 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0KOVL0 convert rfc822-to-8bit (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 15 Nov 2010 16:11:26 -0500
Received: by gxk23 with SMTP id 23so3229580gxk.19
        for <dash@vger.kernel.org>; Mon, 15 Nov 2010 13:11:25 -0800 (PST)
In-Reply-To: <4CDAB6AB.5080004@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>
Cc: dash@vger.kernel.org

On 10 November 2010 16:13, Eric Blake <eblake@redhat.com> wrote:
> [redirecting back to the list, so others can benefit]
>
> On 11/10/2010 02:16 AM, Marc Herbert wrote:
>> Le 09/11/2010 21:52, Eric Blake a =E9crit :
>>> I'm trying to standardize the notion of local variables for the nex=
t
>>> revision of POSIX, but before I can do so, I need some feedback on =
two
>>> general aspects:
>>> [...]
>>> Here's a sample shell script that illustrates the difference betwee=
n the
>>> two scoping methods.
>>
>> Hi Eric,
>>
>>   I found your sample script quite confusing. To make your point, do=
es
>> this script really need to:
>> - use unquoted language keywords as string values?
>
> No; I could have used other strings.
>
>> - use deprecated "typeset" instead of declare?
>
> Yes - the current Austin Group thoughts are to standardize 'typeset' =
and
> NOT 'local', since 'typeset' can be used with arguments outside of
> functions, and more existing shells provide 'typeset' than 'local' (d=
ash
> being the odd one out) or 'declare'.  Shells can continue to provide
> 'local' as a synonym for the most basic use of typeset.
>
>> - use the not (or less?) standard "function" keyword?
>
> Yes - ksh93 ONLY supports function-local scoping when using the funct=
ion
> keyword, rather than when using POSIX functions (although David Korn
> agreed that if POSIX standardizes function-local scoping, he'd make t=
he
> next build of ksh support it in POSIX functions).
>
> So, here's the example again, with those points addressed:
>
> # Demonstrate ksh local scoping is static - requires ksh's 'function'
>
> $ ksh -c 'function f1 { typeset a=3Dtemp; f2; echo "in f1: $a"; };
> function f2 { echo "in f2: $a"; a=3Dchanged; }; a=3Dglobal; f1; echo =
"top
> level: $a"'
> in f2: global
> in f1: temp
> top level: changed
>
> # Demonstrate that with POSIX functions, ksh has global scoping
>
> $ ksh -c 'f1 () { typeset a=3Dtemp; f2; echo "in f1: $a"; }; f2 () { =
echo
> "in f2: $a"; a=3Dchanged; }; a=3Dglobal; f1; echo "top level: $a"'in =
f2: temp
> in f1: changed
> top level: changed
>
> # Demonstrate that dash local scoping is currently dynamic
>
> $ dash -c 'f1 () { local a=3Dtemp; f2; echo "in f1: $a"; }; f2 () { e=
cho
> "in f2: $a"; a=3Dchanged; }; a=3Dglobal; f1; echo "top level: $a"'
> in f2: temp
> in f1: changed
> top level: global

Why is the debate static-vs-dynamic scoping coming up again? People
like Ken Thompson, who wrote the very first UNIX shell, Douglas
McIlroy, inventor of the UNIX pipelines and many others of the fathers
of UNIX have criticized the concept of dynamic scoping in ksh88
loudly, in USENIX meetings and elsewhere. Even David Korn admitted
that it was a grave design error and corrected it for the next major
version of the korn shell, which became ksh93.

With this background I doubt any proposal for dynamic scoping will
make it into the next POSIX standard. It's simply not considered a
sane design for a modern computer language anymore and bash's
emulation of ksh88's dynamic scoping can hardly be used as precedent
in Austin Group proposals after ksh88 itself was abandoned in 1992.

Ced
--=20
Cedric Blancher <cedric.blancher@googlemail.com>
Institute Pasteur
