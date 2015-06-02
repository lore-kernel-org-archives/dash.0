From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Tue, 02 Jun 2015 02:21:07 +0200
Message-ID: <556CF6F3.7050307@gigawatt.nl>
References: <20150529025809.GA16240@gondor.apana.org.au> <5567FE11.8060103@gigawatt.nl> <20150601062905.GB10460@gondor.apana.org.au> <556C96C6.5030600@gigawatt.nl> <20150601221046.GA95455@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:36758 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754703AbbFBAVR (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 1 Jun 2015 20:21:17 -0400
In-Reply-To: <20150601221046.GA95455@stack.nl>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Jilles Tjoelker <jilles@stack.nl>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, martijn@inlv.org, dash@vger.kernel.org

On 02/06/2015 00:10, Jilles Tjoelker wrote:
> On Mon, Jun 01, 2015 at 07:30:46PM +0200, Harald van Dijk wrote:
>> On 01/06/2015 08:29, Herbert Xu wrote:
>>> On Fri, May 29, 2015 at 07:50:09AM +0200, Harald van Dijk wrote:
>
>>>> But the test script in this thread does invoke getopts with
>>>> parameters that are the same in all invocations, and without
>>>> modifying OPTIND. I don't see anything else in the normative
>>>> sections that would make the result undefined or unspecified either.
>>>> I do think the script is valid, and the results in dash should match
>>>> those of other shells.
>
>>> The bash behaviour makes it impossible to call shell functions
>>> that invoke getopts while in the middle of an getopts loop.
>
>>> IMHO the dash behaviour makes a lot more sense since a function
>>> always brings with it a new set of parameters.  That plus the
>>> fact that this behaviour has been there since day one makes me
>>> reluctant to change it since the POSIX wording is not all that
>>> clear.
>
>> True. Given that almost no shell supports that anyway, there can't be
>> too many scripts that rely on it, but I did warn about the risk of
>> breaking another type of existing scripts as well, I agree that's a real
>> concern.
>
> FreeBSD sh inherits similar code from ash and likewise has per-function
> getopts state. Various shell scripts in the FreeBSD base system use
> getopts in functions without setting OPTIND=1.

Yikes. That's an unfortunate effect of writing scripts that only get run 
on a single shell: things like that don't even show up as a possible 
problem. It's similar to how many bashisms sneak into supposedly 
portable shell scripts.

>> One thing that doesn't really make sense, though: if the getopts
>> internal state is local to a function, then OPTIND and OPTARG really
>> should be too. Because they aren't, nested getopts loops already don't
>> really work in a useful way in dash, because the inner loop overwrites
>> the OPTIND and OPTARG variables. While OPTARG will typically be checked
>> right at the start of the loop, before any inner loop executes, OPTIND
>> is typically used at the end of the loop, in combination with the shift
>> command. The current behaviour makes the OPTIND value in that case
>> unreliable.
>
> First, note that the OPTARG and OPTIND shell variables are not an input
> to getopts, except for an assignment OPTIND=1 (restoring an OPTIND local
> at function return does not reset getopts), and that getopts writes
> OPTIND no matter whether getopts's internal optind changed in this
> invocation.
>
> With that, the value of OPTIND generally used in scripts is not
> unreliable. OPTIND is generally only checked after getopts returned
> false (end of options), in the sequence
>    while getopts ...; do
>      ...
>    done
>    shift "$((OPTIND - 1))"

Ah, you're right, I missed that there will usually be another execution 
of getopts before OPTIND is used. Thanks for clearing that up. In that 
case, I agree, the situations in which the values of OPTIND and OPTARG 
are unreliable are only situations in which scripts usually don't bother 
checking their values.

>> So either way, I think something should change. But if you prefer to get
>> clarification first about the intended meaning of the POSIX wording,
>> that certainly seems reasonable to me.
>
> I think the POSIX wording is clear enough, but it may not be desirable
> to change getopts to work that way.

It was Herbert Xu who felt the POSIX wording was unclear, and he is the 
dash maintainer, so his opinion on whether the wording is clear is the 
one that matters.

If it is clear or clarified what POSIX requires, and that POSIX allows 
the current implementation, then I see no need either to change the dash 
behaviour. It could still be useful to make OPTIND and OPTARG local, but 
you've convinced at least me that it's only a minor problem.

If it is clear or clarified what POSIX requires, and that POSIX 
disallows the current implementation, and the current implementation is 
deemed too desirable to drop, then it might make sense to support both 
alternatives, with an option at configure time to switch between them. 
As far as I know, dash does still aim to conform to POSIX, so even if a 
conscious decision is made to deviate from POSIX by default, I think an 
option to conform to it would be nice for those who care about it. I 
would be happy to create a patch, if this approach would be more agreeable.

Cheers,
Harald van Dijk
