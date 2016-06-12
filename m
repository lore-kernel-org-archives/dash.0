From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH v3] builtin: Fix handling of trailing IFS white spaces
Date: Sun, 12 Jun 2016 12:35:15 +0200
Message-ID: <575D3AE3.1080700@gigawatt.nl>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au> <5755E07B.6090300@gigawatt.nl>
 <20160607092539.GA30397@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:32915
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbcFLKfg (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 12 Jun 2016 06:35:36 -0400
In-Reply-To: <20160607092539.GA30397@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On 07/06/16 11:25, Herbert Xu wrote:
> If the very first character later gets zeroed, you'd be zeroing
> the character after the CTLESC, leaving the CTLESC in the value
> to be assigned to the last variable of read.

Ah, I see. Thanks for the explanation. While trying to make it misbehave 
I found that rmescapes removes trailing CTLESC, and readcmd_handle_line 
calls rmescapes before the trailing CTLESC gets a chance to cause 
problems. I was now still only able to see the problem when adding some 
extra debugging statements.

> If you got rid of the very first q=p assignment it should just work.

There is a later q=p assignment too that gets performed after CTLESC has 
been skipped. That one also isn't going to cause problems in practice, 
since it only gets executed when a character is both IFS and IFS 
whitespace, but when called from readcmd_handle_line, there's never 
going to be escaped IFS whitespace.

> Thanks.  I've fixed up the buglet causing the failures:

The results are a lot better now, but I did spot a problem:

src/dash -c 'X="x  "; echo $X'

This is supposed to print "x\n", but the IFS breakup of $X generates two 
words, one "x", one " ", meaning "x  \n" gets printed instead. I think 
this is intended to get fixed up in the if (ifsspc) block, but that 
block doesn't get executed when there are no more characters after the 
spaces.

Cheers,
Harald van Dijk
