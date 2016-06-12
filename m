From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH v3] builtin: Fix handling of trailing IFS white spaces
Date: Sun, 12 Jun 2016 13:12:01 +0200
Message-ID: <575D4381.2080903@gigawatt.nl>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au> <5755E07B.6090300@gigawatt.nl>
 <20160607092539.GA30397@gondor.apana.org.au> <575D3AE3.1080700@gigawatt.nl>
 <20160612110643.GA927@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:37565
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753448AbcFLLME (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 12 Jun 2016 07:12:04 -0400
In-Reply-To: <20160612110643.GA927@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On 12/06/16 13:06, Herbert Xu wrote:
> On Sun, Jun 12, 2016 at 12:35:15PM +0200, Harald van Dijk wrote:
>>
>> The results are a lot better now, but I did spot a problem:
>>
>> src/dash -c 'X="x  "; echo $X'
>>
>> This is supposed to print "x\n", but the IFS breakup of $X generates
>> two words, one "x", one " ", meaning "x  \n" gets printed instead. I
>> think this is intended to get fixed up in the if (ifsspc) block, but
>> that block doesn't get executed when there are no more characters
>> after the spaces.
>
> Weird, I can't reproduce this at all:
>
> $ src/dash -c 'X="x "; echo $X' | cat -A
> x$
> $
>
> What am I doing wrong?

It needs two spaces after the "x", not just one. With a single space, it 
does work right.

Cheers,
Harald van Dijk
