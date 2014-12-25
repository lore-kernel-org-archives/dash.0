From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Possibly wrong handling of $_?
Date: Thu, 25 Dec 2014 23:05:24 +0100
Message-ID: <549C8A24.1060309@gigawatt.nl>
References: <E1Y3Y2d-000276-SL@smtp.tt-solutions.com> <5499F8E5.205@gigawatt.nl> <E1Y3YxI-0004Qg-GA@smtp.tt-solutions.com> <20141225143226.GA27266@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:39435 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751431AbaLYWF2 (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 25 Dec 2014 17:05:28 -0500
In-Reply-To: <20141225143226.GA27266@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>, Vadim Zeitlin <vz-dash@zeitlins.org>
Cc: dash@vger.kernel.org

On 25/12/2014 15:32, Jilles Tjoelker wrote:
> On Wed, Dec 24, 2014 at 12:33:32AM +0100, Vadim Zeitlin wrote:
>> On Wed, 24 Dec 2014 00:21:09 +0100 Harald van Dijk <harald@gigawatt.nl> wrote:
>> HvD> On 23/12/2014 23:34, Vadim Zeitlin wrote:
>> HvD> >   Hello,
>> HvD> >
>> HvD> >   I'm not exactly sure if this is a bug because I didn't find any
>> HvD> > specification about how is this supposed to behave (to my surprise it
>> HvD> > turned out that $_ was not in POSIX), but please consider this:
>> HvD> >
>> HvD> > 	% zsh -c 'echo -n foo && echo $_'
>> HvD> > 	foofoo
>> HvD> > 	% bash -c 'echo -n foo && echo $_'
>> HvD> > 	foofoo
>> HvD> > 	% dash -c 'echo -n foo && echo $_'
>> HvD> > 	foo/usr/bin/dash
>> HvD>
>> HvD> This does come across as somewhat confusing, but $_ is really not a
>> HvD> special variable at all in dash.
>
>>   Ah, this does explain it, thanks!
>
> Dash does implement $_, but only in interactive mode.

Ah, apologies. In interactive mode, it indeed implements it, but 
differently from bash. In dash, only commands that specify a command 
name cause $_ to be set. For example,

   dash -ic 'if a=b; then c=d; else e=f; fi; echo $_'

still prints

   /usr/bin/dash

(or wherever dash is installed), because if statements, and variable 
assignments, have no effect on $_. In bash, this prints a blank line, 
because the prior value of $_ has not survived those variable assignments.

Cheers,
Harald van Dijk
