From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: [PATCH v4] builtin: Fix handling of trailing IFS white spaces
Date: Mon, 20 Jun 2016 00:01:16 +0200
Message-ID: <5767162C.5020709@gigawatt.nl>
References: <5661EEB7.8080908@gigawatt.nl>
 <20160606084805.GA20946@gondor.apana.org.au> <5755E07B.6090300@gigawatt.nl>
 <20160607092539.GA30397@gondor.apana.org.au> <575D3AE3.1080700@gigawatt.nl>
 <20160612110643.GA927@gondor.apana.org.au> <575D4381.2080903@gigawatt.nl>
 <20160612121748.GA1270@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from mailfilter1-k0683s008.csv-networks.nl ([92.48.231.157]:49335
	"EHLO mailfilter1-k0683s008.csv-networks.nl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbcFSWC7 (ORCPT
	<rfc822;dash@vger.kernel.org>); Sun, 19 Jun 2016 18:02:59 -0400
In-Reply-To: <20160612121748.GA1270@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>, dash@vger.kernel.org
Cc: Stephane Chazelas <stephane.chazelas@gmail.com>, Gioele Barabucci <gioele@svario.it>

On 12/06/16 14:17, Herbert Xu wrote:
> Tricky :) OK here is a new version that should fix this bug.

FWIW, I've been testing this along with your eval patch, haven't spotted 
any more issues, either from code inspection or from actual use, and 
don't expect to spot any more issues. Very nice.

Cheers,
Harald van Dijk
