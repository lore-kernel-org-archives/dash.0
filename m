From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH v2] builtin: Fix handling of trailing IFS white spaces
Date: Mon, 6 Jun 2016 22:43:39 +0200
Message-ID: <5755E07B.6090300@gigawatt.nl>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:41732
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752830AbcFFUoN (ORCPT
	<rfc822;dash@vger.kernel.org>); Mon, 6 Jun 2016 16:44:13 -0400
In-Reply-To: <20160606084805.GA20946@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On 06/06/16 10:48, Herbert Xu wrote:
> On Fri, Dec 04, 2015 at 08:51:19PM +0100, Harald van Dijk wrote:
>>
>> Here it is. Attached is an updated patch that ignores the complete
>> terminator if only a single field remains, otherwise ignores only
>> trailing IFS whitespace.
>
> There is a little bug in the patch if you happened to start with
> an escaped IFS, otherwise I think it's good.

Thanks. If starting with an escaped IFS, the CTLESC should already have 
been skipped before the if (maxargs == 1) check gets executed. That's 
done at the start of the outer loop, but is not visible in the patch 
because it's unmodified from the original code. Or did I misunderstand 
you here?

> However, I think this loop is getting too deep so I've reworked
> it to have just one loop over the string instead of three (two
> nested loops).

> Please test this.

With the link sent by Martijn Dekker earlier in this thread:

 
<http://web.archive.org/web/20050414022354/http://www.research.att.com/~gsf/public/ifs.sh>

it gives a lot of failures:

# tests 6856 passed 1844 failed 5012

I'll look into it in more detail later, if no one beats me to it.

Cheers,
Harald van Dijk
