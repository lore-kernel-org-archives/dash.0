From: Harald van Dijk <harald@gigawatt.nl>
Subject: Re: Quoted closing brace in variable default expansion
Date: Sat, 20 Nov 2010 01:42:33 +0059
Message-ID: <4CE71991.3020108@gigawatt.nl>
References: <20101119135406.GA24391@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <dash-owner@vger.kernel.org>
Received: from hosting12.csv-networks.nl ([84.244.151.141]:57427 "EHLO
	hosting12.csv-networks.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0KTUnm (ORCPT <rfc822;dash@vger.kernel.org>);
	Sat, 20 Nov 2010 15:43:42 -0500
In-Reply-To: <20101119135406.GA24391@gondor.apana.org.au>
Sender: dash-owner@vger.kernel.org
List-Id: dash@vger.kernel.org
To: dash@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, jrnieder@gmail.com

On 19/11/10 14:53, Herbert Xu wrote:
> Harald van Dijk<harald@gigawatt.nl>  wrote:
>>    sh -c 'echo "${x:-\}}"'
>
> If you need to print anything involving a backspace you should
> use printf and not echo.

It's true that backslashes should not be passed to echo, but assuming 
unset or empty x, "${x:-\}}" should expand to "}", and that is all echo 
should see.

Cheers,
Harald
