From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 22:00:24 +0100
Message-ID: <56CCC868.8040900@gigawatt.nl>
References: <56CCA25E.5020809@openmailbox.org> <56CCA879.1070208@gigawatt.nl>
 <56CCABD6.40001@redhat.com> <56CCB121.60808@gigawatt.nl>
 <56CCB3F7.8090301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:43610
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755407AbcBWVAa (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 23 Feb 2016 16:00:30 -0500
In-Reply-To: <56CCB3F7.8090301@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

On 23/02/2016 20:33, Eric Blake wrote:
> exit - fuzzy.  exit is a special built-in (unlike getopts); and XCU 2.14
> states:
>
>   "Some of the special built-ins are described as conforming to XBD
> Utility Syntax Guidelines. For those that are not, the requirement in
> Utility Description Defaults that "--" be recognized as a first argument
> to be discarded does not apply and a conforming application shall not
> use that argument. "
>
> Conforming apps cannot expect 'exit -1' to work, and therefore, cannot
> also expect 'exit -- -1' to work, since the only standards-defined
> values for an argument to exit is a non-negative decimal integer less
> than 256.  Of course, if you want to fix it along with all the others,
> that's fine; I'm just pointing out that 'exit' isn't broken as-is.

I was under the impression that the intent from the dash side was to 
handle all commands the same, and that impression was based on the fact 
that the . command has received additional code to handle -- even though 
there's no requirement for that. However, looking into the original bug 
report that prompted that change in more detail I see that the standard 
will very likely require support for -- in the . command in the future, 
so that doesn't hold up.

If that intent isn't there (I'm not saying it's not; I'm unsure now), 
the list of utilities that should be extended is far smaller, if I'm not 
overlooking anything:
- alias
- getopts
- type
- exec?
- local?

exec is like .: there's currently no requirement to support --, but that 
requirement is likely to come in the future.

local is currently non-standard and it's hard to guess whether it will 
require support for -- if standardised.

Cheers,
Harald van Dijk
