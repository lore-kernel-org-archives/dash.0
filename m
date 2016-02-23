From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [BUG] Illegal function names are accepted after being used as
 aliases
Date: Tue, 23 Feb 2016 20:21:05 +0100
Message-ID: <56CCB121.60808@gigawatt.nl>
References: <56CCA25E.5020809@openmailbox.org> <56CCA879.1070208@gigawatt.nl>
 <56CCABD6.40001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008-2.csv-networks.nl ([92.48.231.158]:40791
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754453AbcBWTVL (ORCPT
	<rfc822;dash@vger.kernel.org>); Tue, 23 Feb 2016 14:21:11 -0500
In-Reply-To: <56CCABD6.40001@redhat.com>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Eric Blake <eblake@redhat.com>, Jan Verbeek <ring@openmailbox.org>, dash@vger.kernel.org

On 23/02/2016 19:58, Eric Blake wrote:
> On 02/23/2016 11:44 AM, Harald van Dijk wrote:
>
>> This matches bash's behaviour, aside from bash requiring -- to prevent
>> detection of invalid flags to the alias command:
>>
>> bash-4.3$ alias -- -=true
>
> Then dash DOES have a bug:

Indeed, I wasn't trying to suggest otherwise, my apologies if it came 
across that way. It's not limited to the alias command though, I spotted 
at least the exit and getopts commands having the same problem, and it 
should probably be fixed for all of them at once.

Cheers,
Harald van Dijk
