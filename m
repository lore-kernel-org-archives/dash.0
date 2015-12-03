From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: dash: read does not ignore trailing spaces
Date: Thu, 3 Dec 2015 23:26:46 +0100
Message-ID: <5660C1A6.1010902@gigawatt.nl>
References: <n3nrqu$mj2$1@ger.gmane.org> <5660ADD6.4020308@gigawatt.nl>
 <20151203211748.GC9581@chaz.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:56498
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751004AbbLCW0q (ORCPT
	<rfc822;dash@vger.kernel.org>); Thu, 3 Dec 2015 17:26:46 -0500
In-Reply-To: <20151203211748.GC9581@chaz.gmail.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: Gioele Barabucci <gioele@svario.it>, dash@vger.kernel.org

On 03/12/2015 22:17, Stephane Chazelas wrote:
> 2015-12-03 22:02:14 +0100, Harald van Dijk:
> [....]
>>    $ for shell in bash mksh posh zsh; do printf %s: "$shell"; $shell
>> -c 'IFS=,; echo a, | { read v; echo "<$v>"; }'; done
>>    bash:<a>
>>    mksh:<a>
>>    posh:<a,>
>>    zsh:<a,>
>>
>> As far as I can tell, the posh/zsh behaviour is the correct
>> behaviour, but I'm not convinced yet my interpretation is correct.
> [...]
>
> No, that would be the same as for:
>
> v=a:b:
> IFS=:
> set -f
>
> set -- $v
>
> It's meant to split into "a" and "b", not "a", "b" and "". As
> ":" is meant to be treated as a *delimiter* or *terminator*.
>
> That has been discussed a few times on the austin group mailing
> list.
>
> zsh and pdksh (and other descendants of the Forsyth shell) treat it as
> separator (and are not compliant), mksh (derived from pdksh)
> changed it recently. posh (also based on pdksh) still hasn't changed it.

zsh indeed expands this into "a", "b" and "". The same version of posh 
that gives <a,> for my test gives just "a" and "b" for yours though.

I do see your point. Thanks for the clear example, I think I agree with 
you, the description of field splitting mentions that delimiters are 
used as terminators:

   "The shell shall treat each character of the IFS as a delimiter and 
use the delimiters as field terminators to [...]"

It should not be much of a problem to extend the patch I posted to cover 
the rules as you describe them, I will make an attempt at this later.

Cheers,
Harald van Dijk
