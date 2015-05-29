From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: getopts doesn't properly update OPTIND when called from function
Date: Fri, 29 May 2015 07:50:09 +0200
Message-ID: <5567FE11.8060103@gigawatt.nl>
References: <20150529025809.GA16240@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.217]:45943 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752789AbbE2FuT (ORCPT
	<rfc822;dash@vger.kernel.org>); Fri, 29 May 2015 01:50:19 -0400
In-Reply-To: <20150529025809.GA16240@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: martijn@inlv.org, dash@vger.kernel.org

On 29/05/2015 04:58, Herbert Xu wrote:
> Harald van Dijk <harald@gigawatt.nl> wrote:
>> That isn't the problem, not exactly anyway. The problem is that getopts
>> is required to keep internal state separately from the OPTIND variable
>> (a single integer is insufficient to track the progress when multiple
>> options are combined in a single word), and that internal state is
>> stored along with the positional parameters. The positional parameters
>> are saved just before a function call, and restored when the function
>> returns. The internal state of getopts should not be saved the same way.
>> It should probably just be global to dash.
>
> I think the current behaviour is fine as far as POSIX is concerned.
> It says:
>
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/getopts.html
>
> : APPLICATION USAGE
>
> ...
>
> : Note that shell functions share OPTIND with the calling shell
> : even though the positional parameters are changed. If the calling
> : shell and any of its functions uses getopts to parse arguments,
> : the results are unspecified.

The Application usage sections are informative and aren't worded as 
precisely as the other sections. If a script uses getopts at the global 
level, and it calls a shell function that too uses getopts, then it is 
very easy to be covered by

 > Any other attempt to invoke getopts multiple times in a single shell 
execution environment with parameters (positional parameters or arg 
operands) that are not the same in all invocations, or with an OPTIND 
value modified to be a value other than 1, produces unspecified results.

But the test script in this thread does invoke getopts with parameters 
that are the same in all invocations, and without modifying OPTIND. I 
don't see anything else in the normative sections that would make the 
result undefined or unspecified either. I do think the script is valid, 
and the results in dash should match those of other shells.

Cheers,
Harald van Dijk
